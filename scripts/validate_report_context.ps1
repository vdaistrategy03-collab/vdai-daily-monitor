param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^\d{4}-\d{2}-\d{2}$')]
    [string]$ExpectedDate,

    [Parameter(Mandatory = $true)]
    [string]$DailyReport,

    [Parameter(Mandatory = $true)]
    [string]$LatestReport
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

function Get-MetadataValue {
    param(
        [string]$Text,
        [string]$Field,
        [string]$FilePath
    )

    $pattern = '(?m)^- {0}:\s+(?<value>.+?)\s*$' -f [regex]::Escape($Field)
    $match = [regex]::Match($Text, $pattern)
    Assert-Condition $match.Success "${FilePath}: missing '$Field' metadata."
    return $match.Groups["value"].Value
}

$null = [datetime]::ParseExact(
    $ExpectedDate,
    "yyyy-MM-dd",
    [System.Globalization.CultureInfo]::InvariantCulture
)
$resolvedDailyReport = (Resolve-Path -LiteralPath $DailyReport).Path
$resolvedLatestReport = (Resolve-Path -LiteralPath $LatestReport).Path
$dailyFileName = [System.IO.Path]::GetFileName($resolvedDailyReport)
$executionDateField = -join @([char]0xC2E4, [char]0xD589, [char]0xC77C)
$executionTimeField = -join @([char]0xC2E4, [char]0xD589, [char]0x20, [char]0xC2DC, [char]0xAC01)
$basisTimeField = -join @([char]0xAE30, [char]0xC900, [char]0x20, [char]0xC2DC, [char]0xAC01)
$searchWindowField = -join @([char]0xAC80, [char]0xC0C9, [char]0x20, [char]0xAD6C, [char]0xAC04)

$expectedFilePattern = '^' + [regex]::Escape($ExpectedDate) + '(?:_.+)?\.md$'
Assert-Condition ($dailyFileName -match $expectedFilePattern) `
    "${resolvedDailyReport}: filename does not match expected KST report date $ExpectedDate."

$dailyHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $resolvedDailyReport).Hash
$latestHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $resolvedLatestReport).Hash
Assert-Condition ($dailyHash -eq $latestHash) `
    "${resolvedLatestReport}: latest.md must be an exact copy of $dailyFileName."

foreach ($reportPath in @($resolvedDailyReport, $resolvedLatestReport)) {
    $text = Get-Content -Raw -Encoding UTF8 -LiteralPath $reportPath
    $executionDate = Get-MetadataValue -Text $text -Field $executionDateField -FilePath $reportPath
    Assert-Condition ($executionDate -eq $ExpectedDate) `
        "${reportPath}: execution date '$executionDate' does not match expected KST report date '$ExpectedDate'."

    foreach ($field in @($executionTimeField, $basisTimeField)) {
        $value = Get-MetadataValue -Text $text -Field $field -FilePath $reportPath
        $match = [regex]::Match($value, '^(?<date>\d{4}-\d{2}-\d{2})\s+\d{2}:\d{2}\s+KST$')
        Assert-Condition $match.Success "${reportPath}: '$field' has an invalid KST timestamp: '$value'."
        Assert-Condition ($match.Groups["date"].Value -eq $ExpectedDate) `
            "${reportPath}: '$field' date '$($match.Groups['date'].Value)' does not match expected KST report date '$ExpectedDate'."
    }

    $searchWindow = Get-MetadataValue -Text $text -Field $searchWindowField -FilePath $reportPath
    $searchWindowMatch = [regex]::Match(
        $searchWindow,
        '^\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST\s+~\s+(?<endDate>\d{4}-\d{2}-\d{2})\s+\d{2}:\d{2}\s+KST$'
    )
    Assert-Condition $searchWindowMatch.Success "${reportPath}: search window has an invalid KST range: '$searchWindow'."
    Assert-Condition ($searchWindowMatch.Groups["endDate"].Value -eq $ExpectedDate) `
        "${reportPath}: search window end date '$($searchWindowMatch.Groups['endDate'].Value)' does not match expected KST report date '$ExpectedDate'."
}

Write-Host "Report date/copy validation passed for KST date $ExpectedDate."
