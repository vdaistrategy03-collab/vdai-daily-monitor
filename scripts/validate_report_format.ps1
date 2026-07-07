param(
    [Parameter(Mandatory = $true, ValueFromRemainingArguments = $true)]
    [string[]]$Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$requiredSections = @(
    "## 요약",
    "## 신규 발표 확인 사항",
    "## 간접 서비스",
    "## AI 규제 동향",
    "## 기타 항목",
    "## 확인했으나 업데이트가 없었던 곳",
    "## 불확실성 및 검증 공백"
)

$imageQualityEnforcementDate = [datetime]::ParseExact("2026-06-27", "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
$strategicIntentEnforcementDate = [datetime]::ParseExact("2026-07-02", "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
$contentListEnforcementDate = [datetime]::ParseExact("2026-07-07", "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
$lowResolutionImageUrlPatterns = @(
    "(?i)(?:^|[._/-])width[-_=](?:[1-5]?\d{1,2})(?:[._/-]|$)",
    "(?i)[?&](?:w|width|resize|size)=(?:[1-5]?\d{1,2})(?:\D|$)",
    "(?i)(?:^|[._/-])(?:thumb|thumbnail|small|lowres|placeholder)(?:[._/-]|$)"
)

function Get-SectionBody {
    param(
        [string]$Text,
        [string]$Section
    )

    $pattern = "(?ms)^$([regex]::Escape($Section))\s*\r?\n(?<body>.*?)(?=^## |\z)"
    $match = [regex]::Match($Text, $pattern)
    if (-not $match.Success) {
        return $null
    }
    return $match.Groups["body"].Value.Trim()
}

function Assert-Condition {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Test-EmptyAnnouncementBody {
    param([string]$Body)

    $emptyBody = $Body.Trim()
    return $emptyBody -eq "해당 없음" -or $emptyBody -eq "- 해당 없음"
}

function Test-LowResolutionImageUrl {
    param([string]$Url)

    foreach ($pattern in $lowResolutionImageUrlPatterns) {
        if ($Url -match $pattern) {
            return $true
        }
    }
    return $false
}

function Assert-StrategicIntent {
    param(
        [string]$FilePath,
        [string]$FirstLine,
        [string]$Item,
        [string]$RelevanceGrade,
        [string]$ImportanceGrade,
        [bool]$EnforceStrategicIntent
    )

    $isTopItem = $RelevanceGrade -eq "상" -and $ImportanceGrade -eq "상"
    $hasStrategicIntent = $Item -match "(?m)^\s*-\s+전략적 의도\s*$"

    if (-not $isTopItem) {
        Assert-Condition (-not $hasStrategicIntent) "${FilePath}: $FirstLine has 전략적 의도 but it is only allowed when 관련성 and 중요도 are both 상."
        return
    }

    if (-not $hasStrategicIntent) {
        Assert-Condition (-not $EnforceStrategicIntent) "${FilePath}: $FirstLine is 관련성 상 and 중요도 상, so it must include 전략적 의도 before 인사이트."
        return
    }

    $blockMatch = [regex]::Match($Item, "(?ms)^\s*-\s+전략적 의도\s*\r?\n(?<body>.*?)(?=^\s*-\s+인사이트\s*$)")
    Assert-Condition ($blockMatch.Success) "${FilePath}: $FirstLine must place 전략적 의도 immediately before 인사이트."

    $bodyLines = @(($blockMatch.Groups["body"].Value -split "\r?\n") | Where-Object { $_.Trim().Length -gt 0 })
    $scenarioMatches = [regex]::Matches($blockMatch.Groups["body"].Value, "(?m)^\s{5,}-\s+[^:\r\n]+:\s+\S.+$")
    Assert-Condition ($scenarioMatches.Count -ge 1 -and $scenarioMatches.Count -le 3 -and $scenarioMatches.Count -eq $bodyLines.Count) "${FilePath}: $FirstLine 전략적 의도 must contain only 1-3 scenario bullets in '[시나리오명]: ...' form."
}

function Assert-ContentField {
    param(
        [string]$FilePath,
        [string]$FirstLine,
        [string]$Item,
        [bool]$EnforceContentList
    )

    if (-not $EnforceContentList) {
        Assert-Condition ($Item -match "(?m)^\s*-\s+내용(?::\s+\S.+|\s*$)") "${FilePath}: $FirstLine is missing 내용."
        return
    }

    $contentBlockMatch = [regex]::Match($Item, "(?ms)^\s*-\s+내용\s*\r?\n(?<body>.*?)(?=^\s*-\s+관련성:)")
    Assert-Condition ($contentBlockMatch.Success) "${FilePath}: $FirstLine must use '- 내용' followed by concise bullet lines, not one inline 내용 sentence."

    $contentBullets = [regex]::Matches($contentBlockMatch.Groups["body"].Value, "(?m)^\s{5,}-\s+\S.+$")
    Assert-Condition ($contentBullets.Count -ge 1) "${FilePath}: $FirstLine 내용 must contain at least one nested bullet."
}

function Test-AnnouncementSection {
    param(
        [string]$FilePath,
        [string]$SectionName,
        [string]$Body,
        [bool]$RequiresTvReason,
        [bool]$EnforceImageQuality,
        [bool]$EnforceStrategicIntent,
        [bool]$EnforceContentList
    )

    if (Test-EmptyAnnouncementBody -Body $Body) {
        return
    }

    Assert-Condition ($Body -match "(?m)^1\.\s+\*\*.+\*\*") "${FilePath}: '$SectionName' must use numbered announcement items or '해당 없음'."

    $matches = [regex]::Matches($Body, "(?ms)^\d+\.\s+\*\*.*?(?=^\d+\.\s+\*\*|\z)")
    Assert-Condition ($matches.Count -gt 0) "${FilePath}: '$SectionName' has no parseable announcement items."

    foreach ($match in $matches) {
        $item = $match.Value
        $firstLine = (($item -split "\r?\n") | Select-Object -First 1).Trim()

        if ($item -match "(?m)^\s*-\s+대표 이미지:") {
            $imageMatch = [regex]::Match($item, "(?m)^\s*-\s+대표 이미지:\s+!\[[^\]]+\]\((?<url>https?://[^)\s]+)\)")
            Assert-Condition ($imageMatch.Success) "${FilePath}: $firstLine has 대표 이미지 but it is not a valid Markdown image URL."
            if ($EnforceImageQuality) {
                $imageUrl = $imageMatch.Groups["url"].Value
                Assert-Condition (-not (Test-LowResolutionImageUrl -Url $imageUrl)) "${FilePath}: $firstLine uses a likely thumbnail/low-resolution 대표 이미지 URL: $imageUrl"
            }
        }
        Assert-Condition ($item -match "(?m)^\s*-\s+상태:\s+\*\*(공식 확인|주요 매체 확인|미확인)\*\*") "${FilePath}: $firstLine is missing a valid 상태 field."
        Assert-Condition ($item -match "(?m)^\s*-\s+발표 시점:\s+\d{4}-\d{2}-\d{2}") "${FilePath}: $firstLine is missing 발표 시점."
        Assert-Condition ($item -match "(?m)^\s*-\s+분류:\s+") "${FilePath}: $firstLine is missing 분류."
        if ($RequiresTvReason) {
            Assert-Condition ($item -match "(?m)^\s*-\s+TV 관련 이유:\s+") "${FilePath}: $firstLine is missing TV 관련 이유."
        }
        Assert-ContentField -FilePath $FilePath -FirstLine $firstLine -Item $item -EnforceContentList $EnforceContentList
        $relevanceMatch = [regex]::Match($item, "(?m)^\s*-\s+관련성:\s+(?<grade>상|중|하)\s+\([^)]+\)\s*$")
        $importanceMatch = [regex]::Match($item, "(?m)^\s*-\s+중요도:\s+(?<grade>상|중|하)\s+\([^)]+\)\s*$")
        Assert-Condition ($relevanceMatch.Success) "${FilePath}: $firstLine is missing a valid 관련성 with a brief parenthetical rationale."
        Assert-Condition ($importanceMatch.Success) "${FilePath}: $firstLine is missing a valid 중요도 with a brief parenthetical rationale."
        Assert-StrategicIntent -FilePath $FilePath -FirstLine $firstLine -Item $item -RelevanceGrade $relevanceMatch.Groups["grade"].Value -ImportanceGrade $importanceMatch.Groups["grade"].Value -EnforceStrategicIntent $EnforceStrategicIntent
        Assert-Condition ($item -match "(?m)^\s*-\s+인사이트\s*$") "${FilePath}: $firstLine is missing 인사이트."
        Assert-Condition ($item -match "(?m)^\s*-\s+의미:\s+") "${FilePath}: $firstLine is missing 인사이트/의미."
        Assert-Condition ($item -match "(?m)^\s*-\s+참고할 점:\s+") "${FilePath}: $firstLine is missing 인사이트/참고할 점."
        Assert-Condition ($item -match "(?m)^\s*-\s+제안:\s+") "${FilePath}: $firstLine is missing 인사이트/제안."
        Assert-Condition ($item -match "(?m)^\s*-\s+출처\s*$") "${FilePath}: $firstLine is missing 출처."
        Assert-Condition ($item -match "(?m)^\s*-\s+\[.+\]\(https?://.+\)") "${FilePath}: $firstLine must include at least one source link under 출처."
    }
}

function Test-AiRegulationSection {
    param(
        [string]$FilePath,
        [string]$Body,
        [bool]$EnforceStrategicIntent,
        [bool]$EnforceContentList
    )

    if (Test-EmptyAnnouncementBody -Body $Body) {
        return
    }

    Assert-Condition ($Body -match "(?m)^1\.\s+\*\*.+\*\*") "${FilePath}: 'AI 규제 동향' must use numbered items or '해당 없음'."

    $matches = [regex]::Matches($Body, "(?ms)^\d+\.\s+\*\*.*?(?=^\d+\.\s+\*\*|\z)")
    Assert-Condition ($matches.Count -gt 0) "${FilePath}: 'AI 규제 동향' has no parseable items."

    foreach ($match in $matches) {
        $item = $match.Value
        $firstLine = (($item -split "\r?\n") | Select-Object -First 1).Trim()

        Assert-Condition ($item -match "(?m)^\s*-\s+상태:\s+\*\*(공식 확인|주요 매체 확인|미확인)\*\*") "${FilePath}: $firstLine is missing a valid 상태 field."
        Assert-Condition ($item -match "(?m)^\s*-\s+관할:\s+(EU|미국\([^)]+\)|한국|중국|영국|기타)\s*$") "${FilePath}: $firstLine is missing a valid 관할 field."
        Assert-Condition ($item -match "(?m)^\s*-\s+진행 단계:\s+(입법예고|통과|시행|가이드라인|집행/제재)\s*$") "${FilePath}: $firstLine is missing a valid 진행 단계 field."
        Assert-Condition ($item -match "(?m)^\s*-\s+시행/적용 시점:\s+(\d{4}-\d{2}-\d{2}|미정)\s*$") "${FilePath}: $firstLine is missing a valid 시행/적용 시점."
        Assert-Condition ($item -match "(?m)^\s*-\s+영향 범주:\s+") "${FilePath}: $firstLine is missing 영향 범주."
        Assert-ContentField -FilePath $FilePath -FirstLine $firstLine -Item $item -EnforceContentList $EnforceContentList
        $relevanceMatch = [regex]::Match($item, "(?m)^\s*-\s+관련성:\s+(?<grade>상|중|하)\s+\([^)]+\)\s*$")
        $importanceMatch = [regex]::Match($item, "(?m)^\s*-\s+중요도:\s+(?<grade>상|중|하)\s+\([^)]+\)\s*$")
        Assert-Condition ($relevanceMatch.Success) "${FilePath}: $firstLine is missing a valid 관련성 with a brief parenthetical rationale."
        Assert-Condition ($importanceMatch.Success) "${FilePath}: $firstLine is missing a valid 중요도 with a brief parenthetical rationale."
        Assert-StrategicIntent -FilePath $FilePath -FirstLine $firstLine -Item $item -RelevanceGrade $relevanceMatch.Groups["grade"].Value -ImportanceGrade $importanceMatch.Groups["grade"].Value -EnforceStrategicIntent $EnforceStrategicIntent
        Assert-Condition ($item -match "(?m)^\s*-\s+인사이트\s*$") "${FilePath}: $firstLine is missing 인사이트."
        Assert-Condition ($item -match "(?m)^\s*-\s+의미:\s+") "${FilePath}: $firstLine is missing 인사이트/의미."
        Assert-Condition ($item -match "(?m)^\s*-\s+참고할 점:\s+") "${FilePath}: $firstLine is missing 인사이트/참고할 점."
        Assert-Condition ($item -match "(?m)^\s*-\s+제안:\s+") "${FilePath}: $firstLine is missing 인사이트/제안."
        Assert-Condition ($item -match "(?m)^\s*-\s+출처\s*$") "${FilePath}: $firstLine is missing 출처."
        Assert-Condition ($item -match "(?m)^\s*-\s+\[.+\]\(https?://.+\)") "${FilePath}: $firstLine must include at least one source link under 출처."
    }
}

function Test-OtherSection {
    param(
        [string]$FilePath,
        [string]$Body
    )

    if (Test-EmptyAnnouncementBody -Body $Body) {
        return
    }

    Assert-Condition ($Body -match "(?m)^1\.\s+\*\*.+\*\*") "${FilePath}: '기타 항목' must use numbered items or '해당 없음'."

    $matches = [regex]::Matches($Body, "(?ms)^\d+\.\s+\*\*.*?(?=^\d+\.\s+\*\*|\z)")
    Assert-Condition ($matches.Count -gt 0) "${FilePath}: '기타 항목' has no parseable items."

    foreach ($match in $matches) {
        $item = $match.Value
        $firstLine = (($item -split "\r?\n") | Select-Object -First 1).Trim()
        $nonEmptyLines = @(($item -split "\r?\n") | Where-Object { $_.Trim().Length -gt 0 })

        Assert-Condition ($nonEmptyLines.Count -eq 3) "${FilePath}: $firstLine in '기타 항목' must contain only title, 요약, and 출처."
        Assert-Condition ($item -match "(?m)^\s*-\s+요약:\s+관련성\s+(상|중|하)·중요도\s+(상|중|하)\s+-\s+.+$") "${FilePath}: $firstLine is missing 기타 항목 요약 with relevance/importance grades."
        Assert-Condition ($item -match "(?m)^\s*-\s+출처:\s+.*\[.+\]\(https?://.+\)") "${FilePath}: $firstLine must include source links on one 출처 line."
        Assert-Condition ($item -notmatch "(?m)^\s*-\s+(대표 이미지|상태|발표 시점|분류|내용|TV 관련 이유|전략적 의도|인사이트)\s*:?\s*") "${FilePath}: $firstLine in '기타 항목' contains fields reserved for main items."
    }
}

foreach ($inputPath in $Path) {
    $resolvedPath = Resolve-Path $inputPath
    $text = Get-Content -Raw -Encoding UTF8 -Path $resolvedPath

    Assert-Condition ($text.StartsWith("# 일간 TV 모니터링 리포트")) "${resolvedPath}: title must be '# 일간 TV 모니터링 리포트'."
    Assert-Condition ($text -match "(?m)^- 실행일:\s+\d{4}-\d{2}-\d{2}\s*$") "${resolvedPath}: missing 실행일 metadata."
    Assert-Condition ($text -match "(?m)^- 실행 시각:\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST\s*$") "${resolvedPath}: missing 실행 시각 metadata."
    Assert-Condition ($text -match "(?m)^- 실행 방식:\s+자동\(Codex\)\s*$") "${resolvedPath}: missing 실행 방식 metadata."
    Assert-Condition ($text -match "(?m)^- 기준 시각:\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST\s*$") "${resolvedPath}: missing 기준 시각 metadata."
    Assert-Condition ($text -match "(?m)^- 검색 구간:\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST\s+~\s+\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}\s+KST\s*$") "${resolvedPath}: missing 검색 구간 metadata."
    Assert-Condition ($text -notmatch "(?m)^##\s+출처") "${resolvedPath}: do not add a combined source section."

    $executionDateMatchForRules = [regex]::Match($text, "(?m)^- 실행일:\s+(?<date>\d{4}-\d{2}-\d{2})\s*$")
    $executionDateForRules = [datetime]::ParseExact($executionDateMatchForRules.Groups["date"].Value, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
    $enforceImageQuality = $executionDateForRules -ge $imageQualityEnforcementDate
    $enforceStrategicIntent = $executionDateForRules -ge $strategicIntentEnforcementDate
    $enforceContentList = $executionDateForRules -ge $contentListEnforcementDate
    if ($executionDateForRules.DayOfWeek -eq [System.DayOfWeek]::Monday) {
        Assert-Condition ($text -match "AI 규제 Tier 2") "${resolvedPath}: Monday reports must explicitly note the AI 규제 Tier 2 weekly sweep."
        Assert-Condition ($text -match "7일") "${resolvedPath}: Monday AI 규제 Tier 2 sweep must mention the 7-day search window."
    }

    $lastIndex = -1
    foreach ($section in $requiredSections) {
        $index = $text.IndexOf($section)
        Assert-Condition ($index -ge 0) "${resolvedPath}: missing required section '$section'."
        Assert-Condition ($index -gt $lastIndex) "${resolvedPath}: required sections are out of order."
        $lastIndex = $index
    }

    $directBody = Get-SectionBody -Text $text -Section "## 신규 발표 확인 사항"
    Assert-Condition ($null -ne $directBody) "${resolvedPath}: unable to parse 신규 발표 확인 사항."
    Test-AnnouncementSection -FilePath $resolvedPath -SectionName "신규 발표 확인 사항" -Body $directBody -RequiresTvReason $false -EnforceImageQuality $enforceImageQuality -EnforceStrategicIntent $enforceStrategicIntent -EnforceContentList $enforceContentList

    $indirectBody = Get-SectionBody -Text $text -Section "## 간접 서비스"
    Assert-Condition ($null -ne $indirectBody) "${resolvedPath}: unable to parse 간접 서비스."
    Test-AnnouncementSection -FilePath $resolvedPath -SectionName "간접 서비스" -Body $indirectBody -RequiresTvReason $true -EnforceImageQuality $enforceImageQuality -EnforceStrategicIntent $enforceStrategicIntent -EnforceContentList $enforceContentList

    $aiRegulationBody = Get-SectionBody -Text $text -Section "## AI 규제 동향"
    Assert-Condition ($null -ne $aiRegulationBody) "${resolvedPath}: unable to parse AI 규제 동향."
    Test-AiRegulationSection -FilePath $resolvedPath -Body $aiRegulationBody -EnforceStrategicIntent $enforceStrategicIntent -EnforceContentList $enforceContentList

    $otherBody = Get-SectionBody -Text $text -Section "## 기타 항목"
    Assert-Condition ($null -ne $otherBody) "${resolvedPath}: unable to parse 기타 항목."
    Test-OtherSection -FilePath $resolvedPath -Body $otherBody

    $fileName = [System.IO.Path]::GetFileName($resolvedPath)
    if ($fileName -ne "latest.md") {
        $executionDateMatch = [regex]::Match($text, "(?m)^- 실행일:\s+(?<date>\d{4}-\d{2}-\d{2})\s*$")
        $executionDate = $executionDateMatch.Groups["date"].Value
        $hasAnnouncement = -not (Test-EmptyAnnouncementBody -Body $directBody)
        $hasIndirect = -not (Test-EmptyAnnouncementBody -Body $indirectBody)
        $hasAiRegulation = -not (Test-EmptyAnnouncementBody -Body $aiRegulationBody)
        if ($hasAnnouncement -or $hasIndirect -or $hasAiRegulation) {
            Assert-Condition ($fileName -match "^$([regex]::Escape($executionDate))_.{1,20}\.md$") "${resolvedPath}: report filename must be '${executionDate}_요약.md' with a 1-20 character suffix when report items exist."
            Assert-Condition ($fileName -notmatch '[\\/:*?""<>|]') "${resolvedPath}: report filename suffix contains unsafe characters."
        } else {
            Assert-Condition ($fileName -eq "$executionDate.md") "${resolvedPath}: report filename must be '${executionDate}.md' when no announcements exist."
        }
    }
}

Write-Host "Report format validation passed."



