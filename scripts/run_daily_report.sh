#!/usr/bin/env bash
set -euo pipefail

export TZ="${TZ:-Asia/Seoul}"
export HOME="${HOME:-/Users/luna}"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"

codex_bin="${CODEX_BIN:-/Applications/Codex.app/Contents/Resources/codex}"
prompt_file="${CODEX_PROMPT_FILE:-${repo_root}/docs/codex_cron_daily_tv_monitor.md}"
validate_report_images_script="${repo_root}/scripts/validate_report_images.ps1"
model="${CODEX_MODEL:-gpt-5.6-terra}"
codex_sandbox="${CODEX_SANDBOX_MODE:-workspace-write}"
log_dir="${CODEX_LOG_DIR:-${repo_root}/logs/cron}"
lock_dir="${TMPDIR:-/tmp}/vdai-daily-monitor-cron.lock"
timestamp="$(date '+%Y-%m-%d_%H-%M-%S')"
run_log="${log_dir}/run_${timestamp}.log"
last_message="${log_dir}/last_message_${timestamp}.txt"
remote_url="${REMOTE_URL:-https://github.com/vdaistrategy03-collab/vdai-daily-monitor.git}"
branch="${BRANCH:-main}"
instance_default="$(date +%s)-$$"
git_dir="${TV_AI_DAILY_GIT_DIR:-/tmp/tv-ai-daily-git-${TV_AI_DAILY_INSTANCE:-$instance_default}}"
work_dir="${TV_AI_DAILY_WORK_DIR:-/tmp/tv-ai-daily-worktree-${TV_AI_DAILY_INSTANCE:-$instance_default}}"
auth_file="${GITHUB_AUTH_FILE:-${repo_root}/.github-auth.local}"
askpass_script=""

mkdir -p "${log_dir}"

cleanup() {
  rm -rf "${git_dir}" "${work_dir}"
  if [[ -n "${askpass_script}" ]]; then
    rm -f "${askpass_script}"
  fi
  rmdir "${lock_dir}" >/dev/null 2>&1 || true
}

is_transient_network_error() {
  local output
  output="$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')"
  [[ "$output" == *"could not resolve host"* ]] ||
    [[ "$output" == *"failed to connect"* ]] ||
    [[ "$output" == *"operation timed out"* ]] ||
    [[ "$output" == *"connection timed out"* ]] ||
    [[ "$output" == *"connection reset"* ]] ||
    [[ "$output" == *"the remote end hung up unexpectedly"* ]] ||
    [[ "$output" == *"http 5"* ]]
}

run_with_retry() {
  local label="$1"
  shift

  local delays=(0 5 15 45 90)
  local attempt=1
  local output=""
  local cmd_status=0

  for delay in "${delays[@]}"; do
    if (( delay > 0 )); then
      sleep "${delay}"
    fi

    set +e
    output="$("$@" 2>&1)"
    cmd_status=$?
    set -e

    if (( cmd_status == 0 )); then
      if [[ -n "${output}" ]]; then
        printf '%s\n' "${output}" | tee -a "${run_log}"
      fi
      return 0
    fi

    printf '%s attempt %d failed: %s\n' "${label}" "${attempt}" "${output}" | tee -a "${run_log}" >&2
    if ! is_transient_network_error "${output}"; then
      return "${cmd_status}"
    fi

    attempt=$((attempt + 1))
  done

  return "${cmd_status}"
}

configure_github_auth() {
  local github_id=""
  local github_pat=""

  if [[ ! -f "${auth_file}" ]]; then
    return 0
  fi

  # shellcheck disable=SC1090
  source "${auth_file}"

  github_id="${GITHUB_ID:-${GITHUB_USER:-${GITHUB_USERNAME:-}}}"
  github_pat="${GITHUB_PAT:-${GITHUB_TOKEN:-}}"

  if [[ -z "${github_pat}" ]]; then
    printf 'GitHub auth file exists but no token was found in %s\n' "${auth_file}" | tee -a "${run_log}" >&2
    return 0
  fi

  if [[ -z "${github_id}" ]]; then
    github_id="x-access-token"
  fi

  export GITHUB_ID="${github_id}"
  export GITHUB_PAT="${github_pat}"

  askpass_script="$(mktemp "/tmp/tv-ai-daily-askpass.XXXXXX")"
  chmod 700 "${askpass_script}"
  cat > "${askpass_script}" <<'EOF'
#!/usr/bin/env bash
case "$1" in
  *Username*) printf '%s\n' "${GITHUB_ID:-${GITHUB_USER:-${GITHUB_USERNAME:-}}}" ;;
  *Password*) printf '%s\n' "${GITHUB_PAT:-${GITHUB_TOKEN:-}}" ;;
  *) printf '\n' ;;
esac
EOF

  export GIT_ASKPASS="${askpass_script}"
}

validate_report_images_with_curl() {
  local -a files=("$@")
  local file url headers content_type content_length
  local failures=0
  local urls

  for file in "${files[@]}"; do
    urls="$(sed -nE 's/^[[:space:]]*-[[:space:]]*[^:]+:[[:space:]]+!\[[^]]+\]\((https?:\/\/[^)[:space:]]+)\).*/\1/p' "${file}")"
    while IFS= read -r url; do
      [[ -z "${url}" ]] && continue

      if printf '%s' "${url}" | grep -Eiq '(^|[._/-])width[-_=]([1-5]?[0-9]{1,2})([._/-]|$)|[?&](w|width|resize|size)=([1-5]?[0-9]{1,2})([^0-9]|$)|(^|[._/-])(thumb|thumbnail|small|lowres|placeholder)([._/-]|$)'; then
        printf 'Report image validation failed: likely low-resolution or thumbnail URL in %s: %s\n' "${file}" "${url}" | tee -a "${run_log}" >&2
        failures=$((failures + 1))
        continue
      fi

      if printf '%s' "${url}" | grep -Eiq '(^|[._/-])(favicon|logo|icon|avatar|author|headshot|profile|tracking|pixel|spacer|meta|social|share|default|brand|card|og)([._/-]|$)'; then
        printf 'Report image validation failed: visually recheck suspicious generic/social image URL in %s: %s\n' "${file}" "${url}" | tee -a "${run_log}" >&2
        failures=$((failures + 1))
        continue
      fi

      if ! headers="$(curl -fsSIL --max-time 20 -L "${url}" 2>&1)"; then
        printf 'Report image validation failed: could not fetch image URL in %s: %s\n%s\n' "${file}" "${url}" "${headers}" | tee -a "${run_log}" >&2
        failures=$((failures + 1))
        continue
      fi

      content_type="$(printf '%s\n' "${headers}" | awk -F': ' 'tolower($1)=="content-type"{v=$2} END{gsub("\r","",v); print v}')"
      if [[ "${content_type}" != image/* ]]; then
        printf 'Report image validation failed: non-image Content-Type in %s: %s (%s)\n' "${file}" "${url}" "${content_type:-none}" | tee -a "${run_log}" >&2
        failures=$((failures + 1))
      fi

      content_length="$(printf '%s\n' "${headers}" | awk -F': ' 'tolower($1)=="content-length"{v=$2} END{gsub("\r","",v); print v}')"
      if [[ "${content_length}" =~ ^[0-9]+$ ]]; then
        if (( content_length < 1024 )); then
          printf 'Report image validation failed: image is too small in %s: %s (%s bytes)\n' "${file}" "${url}" "${content_length}" | tee -a "${run_log}" >&2
          failures=$((failures + 1))
        elif (( content_length < 60000 )); then
          printf 'Report image validation failed: image payload is small; visually recheck in %s: %s (%s bytes)\n' "${file}" "${url}" "${content_length}" | tee -a "${run_log}" >&2
          failures=$((failures + 1))
        fi
      fi
    done <<< "${urls}"
  done

  return "${failures}"
}

validate_report_images() {
  local today latest report ps_bin
  local -a today_reports

  today="$(date +%F)"
  latest="${repo_root}/new_features/latest.md"

  shopt -s nullglob
  today_reports=("${repo_root}/new_features/${today}"*.md)
  shopt -u nullglob

  if (( ${#today_reports[@]} == 0 )); then
    printf 'Expected report file not found: %s/new_features/%s*.md\n' "${repo_root}" "${today}" | tee -a "${run_log}" >&2
    return 1
  fi

  report="$(ls -t "${today_reports[@]}" | head -n 1)"
  if [[ ! -f "${latest}" ]]; then
    printf 'Expected latest report file not found: %s\n' "${latest}" | tee -a "${run_log}" >&2
    return 1
  fi

  printf '[%s] Validating report images.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
  if [[ -f "${validate_report_images_script}" ]]; then
    if [[ -n "${POWERSHELL_BIN:-}" ]]; then
      ps_bin="${POWERSHELL_BIN}"
    elif command -v pwsh >/dev/null 2>&1; then
      ps_bin="$(command -v pwsh)"
    elif command -v powershell >/dev/null 2>&1; then
      ps_bin="$(command -v powershell)"
    else
      ps_bin=""
    fi

    if [[ -n "${ps_bin}" ]]; then
      "${ps_bin}" -NoProfile -ExecutionPolicy Bypass -File "${validate_report_images_script}" -TreatWarningsAsErrors -Path "${report}" "${latest}" 2>&1 | tee -a "${run_log}"
      return "${PIPESTATUS[0]}"
    fi
  fi

  validate_report_images_with_curl "${report}" "${latest}"
}

publish_reports() {
  local commit_message="Daily TV monitor: $(date +%F)"
  local -a git_bare=(git "--git-dir=${git_dir}")
  local -a git_common=(git "--git-dir=${git_dir}" "--work-tree=${work_dir}")
  local -a report_files

  mkdir -p "${git_dir}" "${work_dir}"
  export GIT_TERMINAL_PROMPT=0
  export GCM_INTERACTIVE=Never
  configure_github_auth

  if [[ ! -f "${git_dir}/HEAD" ]]; then
    "${git_bare[@]}" init -q
  fi

  if ! "${git_bare[@]}" remote get-url origin >/dev/null 2>&1; then
    "${git_bare[@]}" remote add origin "${remote_url}"
  else
    "${git_bare[@]}" remote set-url origin "${remote_url}"
  fi

  if ! "${git_bare[@]}" config user.name >/dev/null 2>&1; then
    "${git_bare[@]}" config user.name "codex-automation"
  fi
  if ! "${git_bare[@]}" config user.email >/dev/null 2>&1; then
    "${git_bare[@]}" config user.email "codex-automation@users.noreply.github.com"
  fi
  "${git_bare[@]}" config credential.helper ""

  printf '[%s] Publishing updated reports.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
  run_with_retry "git fetch" "${git_bare[@]}" fetch origin "${branch}" -q

  "${git_bare[@]}" update-ref "refs/heads/${branch}" "refs/remotes/origin/${branch}"
  "${git_bare[@]}" symbolic-ref HEAD "refs/heads/${branch}"
  "${git_common[@]}" reset --hard "origin/${branch}" -q

  mkdir -p "${work_dir}/new_features"
  shopt -s nullglob
  report_files=("${repo_root}"/new_features/*.md)
  shopt -u nullglob

  if (( ${#report_files[@]} == 0 )); then
    printf 'No report files found under %s/new_features.\n' "${repo_root}" | tee -a "${run_log}" >&2
    return 1
  fi

  cp "${report_files[@]}" "${work_dir}/new_features/"

  (
    cd "${work_dir}"
    "${git_common[@]}" add new_features/*.md
  )

  if "${git_common[@]}" diff --cached --quiet; then
    printf '[%s] No report changes to publish.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
    return 0
  fi

  "${git_common[@]}" commit -m "${commit_message}" -q
  run_with_retry "git push" "${git_common[@]}" push origin "${branch}"
  printf '[%s] Publish completed.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
}

sync_local_checkout_if_only_reports_changed() {
  local current_branch=""
  local has_non_report_change=0
  local line path

  if ! git -C "${repo_root}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return 0
  fi

  current_branch="$(git -C "${repo_root}" branch --show-current 2>/dev/null || true)"
  if [[ "${current_branch}" != "${branch}" ]]; then
    printf '[%s] Skipping local checkout sync; current branch is %s, expected %s.\n' \
      "$(date '+%Y-%m-%d %H:%M:%S %Z')" "${current_branch:-detached}" "${branch}" | tee -a "${run_log}"
    return 0
  fi

  while IFS= read -r line; do
    [[ -z "${line}" ]] && continue
    path="${line:3}"
    if [[ "${path}" != new_features/* ]]; then
      has_non_report_change=1
      break
    fi
  done < <(git -C "${repo_root}" status --porcelain=v1 --untracked-files=all)

  if (( has_non_report_change )); then
    printf '[%s] Skipping local checkout sync; non-report changes are present.\n' \
      "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
    return 0
  fi

  if git -C "${repo_root}" diff --quiet && git -C "${repo_root}" diff --cached --quiet &&
    [[ -z "$(git -C "${repo_root}" ls-files --others --exclude-standard -- new_features)" ]]; then
    return 0
  fi

  printf '[%s] Syncing local checkout after report publish.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
  run_with_retry "local git fetch" git -C "${repo_root}" fetch origin "${branch}" -q

  if ! git -C "${repo_root}" merge-base --is-ancestor HEAD "origin/${branch}"; then
    printf '[%s] Skipping local checkout sync; local HEAD is not an ancestor of origin/%s.\n' \
      "$(date '+%Y-%m-%d %H:%M:%S %Z')" "${branch}" | tee -a "${run_log}"
    return 0
  fi

  git -C "${repo_root}" clean -fd -- new_features | tee -a "${run_log}"
  git -C "${repo_root}" reset --hard "origin/${branch}" -q
  printf '[%s] Local checkout synced to origin/%s.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" "${branch}" | tee -a "${run_log}"
}

if ! mkdir "${lock_dir}" 2>/dev/null; then
  printf '[%s] Another run is already in progress. Exiting.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
  exit 0
fi

trap cleanup EXIT

if [[ ! -x "${codex_bin}" ]]; then
  printf 'Codex binary not found or not executable: %s\n' "${codex_bin}" | tee -a "${run_log}" >&2
  exit 1
fi

if [[ ! -f "${prompt_file}" ]]; then
  printf 'Prompt file not found: %s\n' "${prompt_file}" | tee -a "${run_log}" >&2
  exit 1
fi

if [[ ! -w "${repo_root}/new_features" ]]; then
  printf 'Report output directory is not writable: %s\n' "${repo_root}/new_features" | tee -a "${run_log}" >&2
  exit 1
fi

printf '[%s] Starting daily TV monitor run.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" | tee -a "${run_log}"
printf 'repo_root=%s\nprompt_file=%s\nmodel=%s\nsandbox=%s\n' "${repo_root}" "${prompt_file}" "${model}" "${codex_sandbox}" | tee -a "${run_log}"

set +e
"${codex_bin}" --search --ask-for-approval never --sandbox "${codex_sandbox}" exec \
  -C "${repo_root}" \
  -m "${model}" \
  --color never \
  -o "${last_message}" \
  - < "${prompt_file}" 2>&1 | tee -a "${run_log}"
cmd_status=${PIPESTATUS[0]}
set -e

printf '[%s] Finished with exit code %s.\n' "$(date '+%Y-%m-%d %H:%M:%S %Z')" "${cmd_status}" | tee -a "${run_log}"

if (( cmd_status != 0 )); then
  exit "${cmd_status}"
fi

validate_report_images
publish_reports
sync_local_checkout_if_only_reports_changed

exit "${cmd_status}"
