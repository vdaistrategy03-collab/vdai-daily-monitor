# Daily TV SW/HW Monitor

This repository is set up for a local daily Codex run that generates report markdown files and then publishes the updated report files to GitHub.

## Mission

Investigate meaningful TV software and hardware announcements with strategic analysis for Samsung TV competitiveness. TV remains the primary focus, but strategically relevant monitor and projector announcements are also included as adjacent display signals. The monitor also tracks AI regulation, policy, guidance, and enforcement that could affect Samsung TV AI services.

Depth-priority scope (not an allowlist):

- Samsung
- LG
- Sony
- TCL
- Hisense
- Panasonic
- Philips / TP Vision
- Sharp
- Xiaomi
- Amazon Fire TV
- Google TV / Android TV
- Roku
- Apple TV

Every run also performs brand-agnostic discovery for emerging and regional TV/display makers, operator or private-label TVs, OEM/ODM partnerships, independent TV operating systems, streaming devices, and adjacent screen platforms. A small company or single-market launch is verified and graded by the same criteria instead of being excluded during discovery.

Indirect consumer AI and service monitoring is provider-neutral. It covers consumer capabilities from Google, Amazon, Apple, Microsoft, OpenAI, Meta, Anthropic, Perplexity, xAI, major Chinese and Korean providers, and newly discovered assistants when they could extend to TV, living-room media, smart-home control, accessibility, advertising, or commerce.

Monitor and projector announcements are included in the same `신규 발표 확인 사항` section when they have clear relevance to Samsung's TV, premium display, gaming, home cinema, AI UX, or smart-home strategy. Routine promotions and minor retail availability updates stay out of scope.

AI regulation items are reported in `AI 규제 동향` only when they plausibly affect a Samsung TV device or service. The relevance tags cover functional areas such as content/UI personalization, media processing, agents/OS, advertising, and commerce, plus cross-cutting legal dimensions for data/privacy, safety/security/liability, accessibility/children, and platform/interoperability.

Tier 1 AI regulation jurisdictions and the five search themes, including AI terminal/TV standards and certification, are checked every run. Tier 2 AI regulation markets use a normal seven-day Monday window. A delayed catch-up starts at that bucket's preserved `last_completed_end_kst`, which failed attempts cannot advance, so outages do not create an unsearched gap.

Regional product and service discovery follows the local-language cadence in [`docs/discovery_search_matrix.md`](docs/discovery_search_matrix.md). Chinese product, platform, standard, and certification sources are searched in Chinese every day rather than relying on translated or English coverage.

## Output

Each run updates:

- `new_features/YYYY-MM-DD.md` or `new_features/YYYY-MM-DD_요약.md`
- `new_features/latest.md`

All report content must be in Korean and follow the format rules in `AGENTS.md`.

## Run Policy

- Use the wrapper-provided timestamp from the latest report published on the configured remote branch (`origin/main` by default) as the authoritative search-window start. Unpublished local or failed-run artifacts are not a valid baseline.
- Do not use a fixed 24-hour window.
- Add a rolling 72-hour discovery overlap to catch delayed indexing, RSS/parser failures, timezone errors, and late publication; deduplicate it against prior reports.
- Complete the source, topic, provider-neutral AI, emerging-entrant, and due local-language buckets in [`docs/discovery_search_matrix.md`](docs/discovery_search_matrix.md).
- Read [`docs/ai_regulatory_source_catalog.md`](docs/ai_regulatory_source_catalog.md) on every run and follow its P0/P1/P2 cadence.
- Read the latest valid `COVERAGE_HANDOFF_V1` from `logs/cron/` to carry attempt windows, last successful bucket completion, failed sources, temporary and permanent emerging-company entries, future event dates, and active event windows into the next run. A handoff is valid only when its matching run succeeded, passed validation, and published or had no report changes.
- Carry mandatory source failures and missed weekly sweeps into the next successful run. If no valid handoff exists, reconstruct the 90-day emerging watch from published reports and recover scheduled sweeps from the earlier of the authoritative start or the previous 14 days. Only successfully completed sources may be described as checked.
- Reuse prior reports to avoid duplicate coverage.
- Let Codex handle report generation only.
- After Codex finishes and validators pass, the local wrapper publishes only `new_features/*.md`.

## Local Automation

The Windows runner used by Task Scheduler is:

- `scripts/run_daily_report.ps1`
- `scripts/run_daily_report_retry.ps1`

The main runner refreshes the configured remote branch before calculating the published report basis, calls Codex non-interactively with web search enabled, validates the coverage handoff, date, copy, format, and representative images, then publishes from an isolated temporary worktree. The coverage validator rejects missing or incomplete daily discovery buckets and overdue weekly/monthly sweeps, so recording a gap can no longer turn a mandatory `NOT_RUN` bucket into a successful publish. The retry runner starts the main runner only when no coverage-validated and published run exists for the current KST date. Logs are written under `logs/cron/`.

### macOS LaunchAgent (Legacy)

The repository also includes a legacy launchd-friendly runner:

- `scripts/run_daily_report.sh`

It calls Codex non-interactively with web search enabled, updates the report files locally, then commits and pushes `new_features/*.md`. Run logs are written under `logs/cron/`, with launchd stdout/stderr under `logs/launchd/`. It does not currently inject the authoritative published-report context or run the full format/context validation used by the Windows runner, so it must not be treated as the authoritative scheduled path for the current coverage-handoff contract.

Before publishing, the runner validates representative image links so broken URLs, obvious thumbnails, tracking pixels, generic logos, and suspicious social/meta-card images can be caught instead of being shipped in the daily report.

Installed LaunchAgent:

```bash
~/Library/LaunchAgents/com.doramilab.daily-tv-monitor.plist
```

It is scheduled with `StartCalendarInterval` for 07:00 local time. To improve reliability while the Mac is asleep, configure a daily wake event shortly before the job:

```bash
sudo pmset repeat wakeorpoweron MTWRFSU 06:59:00
```

LaunchAgents and scheduled wake events do not guarantee execution while a MacBook is fully asleep with the lid closed; behavior depends on power, Power Nap, and clamshell conditions.

## Instruction Sources

The non-interactive runner uses these documents:

- `AGENTS.md`
- `docs/codex_cron_daily_tv_monitor.md`
- `docs/discovery_search_matrix.md`
- `docs/ai_regulatory_source_catalog.md`
