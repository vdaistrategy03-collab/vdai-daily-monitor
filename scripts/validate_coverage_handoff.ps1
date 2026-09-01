param(
    [Parameter(Mandatory = $true, ParameterSetName = "Path")]
    [string]$Path,

    [Parameter(Mandatory = $true, ParameterSetName = "Content")]
    [string]$Content,

    [Parameter(Mandatory = $true)]
    [ValidatePattern('^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST$')]
    [string]$ExpectedRunEndKst
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Assert-Condition {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Parse-KstTimestamp {
    param(
        [string]$Value,
        [string]$Field
    )

    $parsed = [datetime]::MinValue
    $valid = [datetime]::TryParseExact(
        $Value,
        "yyyy-MM-dd HH:mm 'KST'",
        [System.Globalization.CultureInfo]::InvariantCulture,
        [System.Globalization.DateTimeStyles]::None,
        [ref]$parsed
    )
    Assert-Condition $valid "Invalid KST timestamp for ${Field}: $Value"
    return $parsed
}

function Get-MostRecentDueDate {
    param(
        [datetime]$RunDate,
        [System.DayOfWeek]$DueDay
    )

    $daysBack = (([int]$RunDate.DayOfWeek - [int]$DueDay) + 7) % 7
    return $RunDate.Date.AddDays(-$daysBack)
}

$text = if ($PSCmdlet.ParameterSetName -eq "Path") {
    $resolvedPath = (Resolve-Path -LiteralPath $Path).Path
    Get-Content -Raw -Encoding UTF8 -LiteralPath $resolvedPath
} else {
    $Content
}

$blockPattern = '(?ms)^COVERAGE_HANDOFF_V1\s*\r?\n(?<body>.*?)^END_COVERAGE_HANDOFF\s*$'
$blockMatches = [regex]::Matches($text, $blockPattern)
Assert-Condition ($blockMatches.Count -eq 1) "Expected exactly one complete COVERAGE_HANDOFF_V1 block; found $($blockMatches.Count)."

$body = $blockMatches[0].Groups["body"].Value
$lines = @($body -split '\r?\n' | Where-Object { $_.Trim().Length -gt 0 })

$runEndLines = @($lines | Where-Object { $_ -match '^run_end_kst=' })
Assert-Condition ($runEndLines.Count -eq 1) "Expected exactly one run_end_kst line."
$runEndKst = $runEndLines[0].Substring('run_end_kst='.Length)
Assert-Condition ($runEndKst -eq $ExpectedRunEndKst) "run_end_kst '$runEndKst' does not match expected '$ExpectedRunEndKst'."
$runEnd = Parse-KstTimestamp -Value $runEndKst -Field "run_end_kst"

$requiredBucketIds = @(
    "priority_rss_media",
    "priority_official",
    "emerging_entrants",
    "indirect_ai_services",
    "lang_en_global",
    "lang_ko",
    "lang_zh_cn",
    "lang_ja",
    "lang_mon_in_hi_pt_es",
    "lang_wed_de_fr_it_tr",
    "lang_fri_zh_tw_id_vi_th_ar",
    "ai_tier1_t1_t5",
    "ai_tier2_weekly",
    "ai_p0_daily",
    "ai_p0_full_weekly",
    "ai_p1_daily",
    "ai_p1_full_weekly",
    "ai_p2_signal_daily",
    "ai_p2_full_monthly",
    "failed_fallbacks",
    "event_calendar_monthly",
    "event_active_search"
)

$allowedStatuses = @(
    "PASS",
    "NO_UPDATE",
    "FALLBACK_PASS",
    "STALE",
    "TIMEOUT",
    "PARSE_ERROR",
    "NOT_RUN",
    "NOT_DUE"
)
$completionStatuses = @("PASS", "NO_UPDATE", "FALLBACK_PASS")
$buckets = @{}

foreach ($line in @($lines | Where-Object { $_ -match '^bucket\.' })) {
    $match = [regex]::Match(
        $line,
        '^bucket\.(?<id>[a-z0-9_]+)=(?<status>[A-Z_]+);attempt_window=(?<window>.+?);last_completed_end_kst=(?<last>.+)$'
    )
    Assert-Condition $match.Success "Invalid bucket line: $line"

    $id = $match.Groups["id"].Value
    Assert-Condition ($requiredBucketIds -contains $id) "Unknown coverage bucket ID: $id"
    Assert-Condition (-not $buckets.ContainsKey($id)) "Duplicate coverage bucket ID: $id"

    $status = $match.Groups["status"].Value
    Assert-Condition ($allowedStatuses -contains $status) "Invalid status '$status' for bucket '$id'."

    $buckets[$id] = [pscustomobject]@{
        Id = $id
        Status = $status
        AttemptWindow = $match.Groups["window"].Value
        LastCompletedEndKst = $match.Groups["last"].Value
    }
}

foreach ($id in $requiredBucketIds) {
    Assert-Condition $buckets.ContainsKey($id) "Missing required coverage bucket: $id"
}
Assert-Condition ($buckets.Count -eq $requiredBucketIds.Count) "Coverage bucket count mismatch."

foreach ($bucket in $buckets.Values) {
    if ($bucket.Status -eq "NOT_DUE") {
        Assert-Condition ($bucket.AttemptWindow -eq "none") "NOT_DUE bucket '$($bucket.Id)' must use attempt_window=none."
    }
}

$dailyRequiredBuckets = @(
    "priority_rss_media",
    "priority_official",
    "emerging_entrants",
    "indirect_ai_services",
    "lang_en_global",
    "lang_ko",
    "lang_zh_cn",
    "lang_ja",
    "ai_tier1_t1_t5",
    "ai_p0_daily",
    "ai_p1_daily",
    "ai_p2_signal_daily",
    "failed_fallbacks",
    "event_active_search"
)

foreach ($id in $dailyRequiredBuckets) {
    $bucket = $buckets[$id]
    Assert-Condition ($completionStatuses -contains $bucket.Status) "Mandatory daily bucket '$id' is incomplete with status '$($bucket.Status)'."
    Assert-Condition ($bucket.AttemptWindow -ne "none") "Mandatory daily bucket '$id' must record an attempt window."
    Assert-Condition ($bucket.LastCompletedEndKst -eq $runEndKst) "Mandatory daily bucket '$id' did not advance last_completed_end_kst to '$runEndKst'."

    $windowMatch = [regex]::Match(
        $bucket.AttemptWindow,
        '^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST~(?<end>\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST)$'
    )
    Assert-Condition $windowMatch.Success "Mandatory daily bucket '$id' has an invalid attempt window: '$($bucket.AttemptWindow)'."
    Assert-Condition ($windowMatch.Groups["end"].Value -eq $runEndKst) "Mandatory daily bucket '$id' attempt window does not end at '$runEndKst'."
}

$weeklyDueDays = @{
    "lang_mon_in_hi_pt_es" = [System.DayOfWeek]::Monday
    "lang_wed_de_fr_it_tr" = [System.DayOfWeek]::Wednesday
    "lang_fri_zh_tw_id_vi_th_ar" = [System.DayOfWeek]::Friday
    "ai_tier2_weekly" = [System.DayOfWeek]::Monday
    "ai_p0_full_weekly" = [System.DayOfWeek]::Monday
    "ai_p1_full_weekly" = [System.DayOfWeek]::Monday
}

foreach ($id in $weeklyDueDays.Keys) {
    $dueDate = Get-MostRecentDueDate -RunDate $runEnd -DueDay $weeklyDueDays[$id]
    $lastValue = $buckets[$id].LastCompletedEndKst
    Assert-Condition ($lastValue -ne "none") "Scheduled weekly bucket '$id' has never completed; latest due date is $($dueDate.ToString('yyyy-MM-dd'))."
    $lastCompleted = Parse-KstTimestamp -Value $lastValue -Field "bucket.$id.last_completed_end_kst"
    Assert-Condition ($lastCompleted.Date -ge $dueDate) "Scheduled weekly bucket '$id' is overdue; latest due date is $($dueDate.ToString('yyyy-MM-dd')), last completion is $($lastCompleted.ToString('yyyy-MM-dd'))."
}

$monthStart = [datetime]::new($runEnd.Year, $runEnd.Month, 1)
foreach ($id in @("ai_p2_full_monthly", "event_calendar_monthly")) {
    $lastValue = $buckets[$id].LastCompletedEndKst
    Assert-Condition ($lastValue -ne "none") "Scheduled monthly bucket '$id' has never completed for $($monthStart.ToString('yyyy-MM'))."
    $lastCompleted = Parse-KstTimestamp -Value $lastValue -Field "bucket.$id.last_completed_end_kst"
    Assert-Condition ($lastCompleted.Date -ge $monthStart) "Scheduled monthly bucket '$id' is overdue for $($monthStart.ToString('yyyy-MM')); last completion is $($lastCompleted.ToString('yyyy-MM-dd'))."
}

foreach ($key in @("failed_sources", "emerging_watch", "event_calendar", "active_event_windows")) {
    $matchingLines = @($lines | Where-Object { $_ -match ('^' + [regex]::Escape($key) + '=') })
    Assert-Condition ($matchingLines.Count -eq 1) "Expected exactly one '$key' snapshot line."
}

Write-Host "Coverage handoff validation passed for $runEndKst."
