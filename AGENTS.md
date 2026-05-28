# Daily TV Monitor Instructions

## Mission

Produce a daily Korean report about meaningful TV software/hardware announcements, with strategic analysis for Samsung TV competitiveness. TV remains the primary focus, but include meaningful monitor and projector announcements when they affect adjacent display competition or Samsung's broader screen strategy.

## Working Rules

- Write all report content in Korean.
- Reuse prior reports to avoid duplicate coverage.
- Focus first on official sources and major media, then expand to regional coverage if time allows.
- Exclude rumors and leaks unless they are clearly labeled as unconfirmed and come from highly credible outlets.
- Do not add one combined source list. Put `출처` links under each item.
- Every confirmed direct TV/monitor/projector item and every included indirect Google/Amazon item must include:
  - `관련성: 상|중|하`
  - `중요도: 상|중|하`
  - `인사이트` with exactly these bullets:
    - `의미:`
    - `참고할 점:`
    - `제안:`

## Scope

Prioritize:

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

Also include indirect but relevant Google/Amazon launches when they could extend to TV, living-room commerce/media, or smart-home control.

For all prioritized TV makers and TV platforms, include major platform, UX, ecosystem, and developer-facing updates when they materially affect TV competitiveness, even if they are not consumer hardware launches. Treat these as `신규 발표 확인 사항` when they are directly about a TV platform, TV OS, TV device family, TV app ecosystem, or TV usage model. This includes updates from official developer blogs, partner blogs, SDK documentation, app distribution guidance, major trade media, and product support channels when the impact is strategically meaningful.

Examples of qualifying platform/UX updates include TV OS or home-screen changes, app discovery surfaces, search/recommendation systems, FAST/content rows, advertising or commerce surfaces, account/profile changes, remote-control input, pointer or motion input, D-pad/focus model changes, voice/AI assistant behavior, gaming/cloud gaming hubs, casting/second-screen flows, accessibility features, security/privacy requirements, app certification requirements, SDK/API changes, app store or distribution policy changes, entitlement/resume/watch-next/recommendation APIs, and smart-home control surfaces. Do not limit this rule to Google TV; apply the same judgment to Tizen, webOS, Roku OS, Fire TV, tvOS/Apple TV, Android TV/Google TV, VIDAA, TiVo/Sharp/Philips/TP Vision platforms, and other strategically relevant TV software layers.

TV is still the highest-priority category. If meaningful monitor or projector software/hardware announcements appear from the prioritized companies or other strategically relevant display players, include them in `신규 발표 확인 사항` rather than creating a separate category. Do not dilute the report with routine monitor/projector retail promotions, minor availability notices, or commodity spec refreshes unless they have clear competitive relevance for Samsung TVs, premium displays, gaming screens, home cinema, AI UX, content services, or smart-home/living-room strategy.

## Output Files

Update both:

- `new_features/YYYY-MM-DD.md` or `new_features/YYYY-MM-DD_요약.md`
- `new_features/latest.md`

Use the title `일간 TV 모니터링 리포트`.

Filename rule:

- If `신규 발표 확인 사항` and `간접 서비스` both contain only `해당 없음`, use `new_features/YYYY-MM-DD.md`.
- If either `신규 발표 확인 사항` or `간접 서비스` contains one or more items, append a short Korean summary of the single most important item after the date: `new_features/YYYY-MM-DD_요약.md`.
- The summary suffix must be 20 Korean characters or fewer, excluding the date, underscore, and `.md`.
- Keep official brand and platform names in their original English form in the suffix, such as `Fire TV`, `Roku`, `Google TV`, and `Apple TV`; do not transliterate them into Korean.
- Use only filename-safe characters in the suffix. Korean letters/numbers and spaces are allowed for readability; remove slashes, colons, pipes, quotes, brackets, and other unsafe filename characters.
- Keep `new_features/latest.md` as an exact copy of the generated daily report content.

## Report Format Contract

All reports must use this exact section order and field naming. Keep section names stable across days.

Summary rule:

- Write `## 요약` as a short bullet list of 2-3 concise Korean sentences.
- Include only discovered qualifying items and their strategic meaning.
- Do not include Samsung recommendations, action proposals, or phrases such as `삼성은 ... 필요가 있다` in `## 요약`; keep recommendations only in each item's `인사이트` / `제안`.
- Do not describe where there were no updates, which sources were checked, or the search process in `## 요약`; reserve that detail for `## 확인했으나 업데이트가 없었던 곳` and `## 불확실성 및 검증 공백`.
- If there are no qualifying items, write one concise bullet saying that no qualifying announcements were found in the search window.

Image rule:

- For each actual included announcement, try to add a visible `대표 이미지` immediately under the numbered item title.
- Use a source-page representative image such as `og:image` or `twitter:image` from the official source or a cited major-media source, formatted as Markdown image syntax so it renders inline.
- Do not use generic logos, icons, tracking pixels, author photos, or unrelated stock images. If no suitable representative image is available, omit `대표 이미지`.
- Do not download, transform, or store third-party images in this repository; link to the original image URL.

```md
# 일간 TV 모니터링 리포트

- 실행일: YYYY-MM-DD
- 실행 시각: YYYY-MM-DD HH:mm KST
- 실행 방식: 자동(Codex)
- 기준 시각: YYYY-MM-DD HH:mm KST
- 검색 구간: YYYY-MM-DD HH:mm KST ~ YYYY-MM-DD HH:mm KST

## 요약

- [발견된 주요 발표와 전략적 의미를 간략히 작성]
- [필요 시 두 번째 발견 내용 또는 대응 포인트 작성]

## 신규 발표 확인 사항

1. **[업체/플랫폼: 발표 제목]**
   - 대표 이미지: ![[발표 제목] 대표 이미지](이미지 URL)
   - 상태: **공식 확인** | **주요 매체 확인** | **미확인**
   - 발표 시점: YYYY-MM-DD
   - 분류: 소프트웨어 | 하드웨어 | TV 플랫폼/UX | 콘텐츠 | 커머스 | 스마트홈 | 규제/인증 | 기타
   - 내용: [발표 내용 요약]
   - 관련성: 상|중|하
   - 중요도: 상|중|하
   - 인사이트
     - 의미: [삼성 TV 경쟁력 관점의 의미]
     - 참고할 점: [비교/검증/리스크/추적 포인트]
     - 제안: [실행 가능한 대응 제안]
   - 출처
     - [출처명](URL)
     - [출처명](URL)

## 간접 서비스

1. **[업체/플랫폼: 발표 제목]**
   - 대표 이미지: ![[발표 제목] 대표 이미지](이미지 URL)
   - 상태: **공식 확인** | **주요 매체 확인** | **미확인**
   - 발표 시점: YYYY-MM-DD
   - 분류: 소프트웨어 | 하드웨어 | TV 플랫폼/UX | 콘텐츠 | 커머스 | 스마트홈 | 기타
   - TV 관련 이유: [TV 화면 경험, 거실 미디어/커머스, 스마트홈 제어와의 연결성]
   - 내용: [발표 내용 요약]
   - 관련성: 상|중|하
   - 중요도: 상|중|하
   - 인사이트
     - 의미: [삼성 TV 경쟁력 관점의 의미]
     - 참고할 점: [비교/검증/리스크/추적 포인트]
     - 제안: [실행 가능한 대응 제안]
   - 출처
     - [출처명](URL)
     - [출처명](URL)

## 확인했으나 업데이트가 없었던 곳

- **[업체/플랫폼]**
  - [확인 내용]
  - 출처
     - [출처명](URL)
     - [출처명](URL)

## 불확실성 및 검증 공백

- [네트워크 이슈, 확인 한계, 다음 실행에서 재확인할 사항]
```

Format rules:

- If there are no qualifying items, write only `해당 없음` under `## 신규 발표 확인 사항`.
- If there are no qualifying indirect Google/Amazon items, write only `해당 없음` under `## 간접 서비스`.
- Do not rename, reorder, or omit the five required top-level sections.
- Do not add a combined source list anywhere in the report.
- Put item sources under that item only, using the `출처` field.
- Use numbered items only for actual included announcements.
- Use `- 해당 없음` for empty non-announcement sections.
- Keep `인사이트` bullets exactly as `의미:`, `참고할 점:`, and `제안:`.

Classification guide:

- `소프트웨어`: TV/모니터/프로젝터 또는 관련 앱의 기능 업데이트, 펌웨어, 앱 기능 개선.
- `하드웨어`: TV 세트, 모니터, 프로젝터, 패널, 리모컨, 사운드바, 스트리밍 기기 등 물리 제품.
- `TV 플랫폼/UX`: TV OS, 홈 화면, 검색/추천, 계정, 앱 배포, 음성/AI 어시스턴트처럼 TV 사용 경험의 기반 계층. 모니터/프로젝터의 AI UX, 스마트 플랫폼, 게이밍 허브, 홈시네마 UX가 TV 경쟁과 연결되면 이 분류를 사용할 수 있다.
- `콘텐츠`: FAST 채널, 스트리밍 콘텐츠, 스포츠/광고 상품 등 시청 콘텐츠와 편성.
- `커머스`: TV 화면 기반 쇼핑, 광고 거래, 구독/결제, 리테일 연동.
- `스마트홈`: TV와 IoT, Matter, 홈 제어, 보안, 에너지 관리 연동.
- `규제/인증`: 에너지, 접근성, 보안, 친환경, 지역 규제 또는 제3자 인증.
- `기타`: 위 범주에 깔끔하게 들어가지 않지만 모니터링 가치가 있는 발표.

## Suggested Run Flow

1. Read the newest files under `new_features/` to avoid duplicate coverage.
2. Identify the **latest report execution time** from the newest report and set search window from that timestamp to now.
   - Do **not** use a fixed 24-hour window.
   - This is to backfill possible misses when a prior run had partial search failures.
3. Investigate direct TV announcements first, including platform, developer, input/navigation, discovery/recommendation, AI assistant, app ecosystem, and TV OS updates from all prioritized TV makers and platforms when they affect the TV experience.
4. Investigate meaningful monitor/projector announcements, and relevant indirect Google/Amazon items within that dynamic window.
5. Write the report in Korean with explicit source attribution per item.
6. If there are no qualifying items, write `해당 없음` only under `신규 발표 확인 사항`.
7. Stop after updating the local markdown files.
8. Do not commit or push from this repository. Git operations are handled by a separate local process outside this run.
