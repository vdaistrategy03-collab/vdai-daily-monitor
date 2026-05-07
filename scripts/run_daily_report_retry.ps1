Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Resolve-Path (Join-Path $scriptDir "..")
$repoRoot = $repoRoot.Path
$logDir = if ($env:CODEX_LOG_DIR) { $env:CODEX_LOG_DIR } else { Join-Path $repoRoot "logs\cron" }
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$retryLog = Join-Path $logDir "retry_$timestamp.log"
$mainScript = Join-Path $scriptDir "run_daily_report.ps1"
$lockFile = Join-Path ([System.IO.Path]::GetTempPath()) "vdai-daily-monitor-cron.lock"

New-Item -ItemType Directory -Force -Path $logDir | Out-Null

function Write-RetryLog {
    param([string]$Message)
    $Message | Tee-Object -FilePath $retryLog -Append | Out-Null
}

function Test-TodaysRunSucceeded {
    $todayPrefix = "run_{0}_" -f (Get-Date -Format "yyyy-MM-dd")
    $todayLogs = Get-ChildItem -Path $logDir -Filter "$todayPrefix*.log" -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending

    foreach ($log in $todayLogs) {
        $text = Get-Content -Raw -Encoding UTF8 -Path $log.FullName
        $codexSucceeded = $text -match "Finished with exit code 0"
        $validated = $text -match "Report format validation passed"
        $published = $text -match "Publish completed\." -or $text -match "No report changes to publish\."
        if ($codexSucceeded -and $validated -and $published) {
            Write-RetryLog ("[{0}] Found successful run: {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"), $log.Name)
            return $true
        }
    }

    return $false
}

function Test-ReportRunProcessActive {
    $processes = Get-CimInstance Win32_Process -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -and $_.CommandLine -match [regex]::Escape($mainScript) }
    return [bool]$processes
}

try {
    Write-RetryLog ("[{0}] Starting retry probe." -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"))

    if (Test-TodaysRunSucceeded) {
        Write-RetryLog ("[{0}] Daily report already succeeded today. Exiting." -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"))
        exit 0
    }

    if ((Test-Path $lockFile) -and -not (Test-ReportRunProcessActive)) {
        Write-RetryLog ("[{0}] Removing stale lock before retry: {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"), $lockFile)
        Remove-Item -Path $lockFile -Force -ErrorAction SilentlyContinue
    }

    Write-RetryLog ("[{0}] No successful run found today. Starting retry." -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"))
    & powershell -NoProfile -ExecutionPolicy Bypass -File $mainScript
    $exitCode = if ($LASTEXITCODE -ne $null) { $LASTEXITCODE } else { 0 }
    Write-RetryLog ("[{0}] Retry finished with exit code {1}." -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"), $exitCode)
    exit $exitCode
} catch {
    Write-RetryLog ("[{0}] Retry failed: {1}" -f (Get-Date -Format "yyyy-MM-dd HH:mm:ss K"), $_.Exception.Message)
    exit 1
}
