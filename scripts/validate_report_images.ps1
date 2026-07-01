param(
    [switch]$TreatWarningsAsErrors,
    [int]$TimeoutSec = 20,
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path,
    [Parameter(Position = 1, ValueFromRemainingArguments = $true)]
    [string[]]$AdditionalPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$lowResolutionImageUrlPatterns = @(
    "(?i)(?:^|[._/-])width[-_=](?:[1-5]?\d{1,2})(?:[._/-]|$)",
    "(?i)[?&](?:w|width|resize|size)=(?:[1-5]?\d{1,2})(?:\D|$)",
    "(?i)(?:^|[._/-])(?:thumb|thumbnail|small|lowres|placeholder)(?:[._/-]|$)"
)

$blockedGenericImageUrlPatterns = @(
    "(?i)(?:^|[._/-])(?:favicon|logo|icon|avatar|author|headshot|profile|tracking|pixel|spacer)(?:[._/-]|$)"
)

$warningGenericImageUrlPatterns = @(
    "(?i)(?:^|[._/-])(?:meta|social|share|default|brand|card|og)(?:[._/-]|$)"
)

function Get-ReportImageEntries {
    param(
        [string]$FilePath,
        [string]$Text
    )

    $entries = @()
    $matches = [regex]::Matches($Text, "(?m)^\s*-\s+[^:\r\n]+:\s+!\[[^\]]+\]\((?<url>https?://[^)\s]+)\)")
    foreach ($match in $matches) {
        $prefix = $Text.Substring(0, $match.Index)
        $titleMatches = [regex]::Matches($prefix, "(?m)^\d+\.\s+\*\*(?<title>.+?)\*\*")
        $title = if ($titleMatches.Count -gt 0) {
            $titleMatches[$titleMatches.Count - 1].Groups["title"].Value
        } else {
            "unknown item"
        }

        $lineNumber = ($prefix -split "\r?\n").Count
        $entries += [pscustomobject]@{
            FilePath = $FilePath
            Line = $lineNumber
            Title = $title
            Url = $match.Groups["url"].Value
        }
    }
    return $entries
}

function Test-UrlPattern {
    param(
        [string]$Url,
        [string[]]$Patterns
    )

    foreach ($pattern in $Patterns) {
        if ($Url -match $pattern) {
            return $true
        }
    }
    return $false
}

function Invoke-ImageRequest {
    param([string]$Url)

    try {
        return Invoke-WebRequest -Uri $Url -Method Head -UseBasicParsing -TimeoutSec $TimeoutSec -MaximumRedirection 5
    } catch {
        try {
            return Invoke-WebRequest -Uri $Url -Method Get -UseBasicParsing -TimeoutSec $TimeoutSec -MaximumRedirection 5
        } catch {
            throw $_
        }
    }
}

$failures = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]
$imageCount = 0
$inputPaths = @($Path) + @($AdditionalPath)

foreach ($inputPath in $inputPaths) {
    $resolvedPath = Resolve-Path $inputPath
    $text = Get-Content -Raw -Encoding UTF8 -Path $resolvedPath
    $entries = @(Get-ReportImageEntries -FilePath $resolvedPath -Text $text)

    foreach ($entry in $entries) {
        $imageCount++
        $context = "{0}:{1} ({2})" -f $entry.FilePath, $entry.Line, $entry.Title
        $url = $entry.Url

        if (Test-UrlPattern -Url $url -Patterns $lowResolutionImageUrlPatterns) {
            $failures.Add("${context}: likely low-resolution or thumbnail representative image URL: $url")
            continue
        }

        if (Test-UrlPattern -Url $url -Patterns $blockedGenericImageUrlPatterns) {
            $failures.Add("${context}: likely generic logo/icon/tracking representative image URL: $url")
            continue
        }

        if (Test-UrlPattern -Url $url -Patterns $warningGenericImageUrlPatterns) {
            $warnings.Add("${context}: URL looks like a social/meta/default image; visually recheck or replace if it is a logo/branding card: $url")
        }

        try {
            $response = Invoke-ImageRequest -Url $url
            $statusCode = [int]$response.StatusCode
            if ($statusCode -lt 200 -or $statusCode -ge 400) {
                $failures.Add("${context}: representative image URL returned HTTP ${statusCode}: $url")
                continue
            }

            $contentType = $response.Headers["Content-Type"]
            if (-not $contentType -or $contentType -notmatch "(?i)^image/") {
                $failures.Add("${context}: representative image URL is not an image Content-Type ('$contentType'): $url")
            }

            $contentLength = $response.Headers["Content-Length"]
            if ($contentLength -and [long]$contentLength -lt 1024) {
                $failures.Add("${context}: representative image is too small and may be a tracking pixel/icon (${contentLength} bytes): $url")
            } elseif ($contentLength -and [long]$contentLength -lt 60000) {
                $warnings.Add("${context}: image payload is small (${contentLength} bytes); visually recheck that it is not a logo/simple branding image: $url")
            }
        } catch {
            $failures.Add("${context}: representative image URL could not be fetched: $url :: $($_.Exception.Message)")
        }
    }
}

foreach ($warning in $warnings) {
    Write-Warning $warning
}

if ($warnings.Count -gt 0 -and $TreatWarningsAsErrors) {
    foreach ($warning in $warnings) {
        $failures.Add($warning)
    }
}

if ($failures.Count -gt 0) {
    foreach ($failure in $failures) {
        Write-Error -Message $failure -ErrorAction Continue
    }
    throw "Report image validation failed with $($failures.Count) issue(s)."
}

if ($imageCount -eq 0) {
    Write-Host "Report image validation passed. No representative image entries found."
} else {
    Write-Host "Report image validation passed for $imageCount representative image entr$(if ($imageCount -eq 1) { 'y' } else { 'ies' })."
}
