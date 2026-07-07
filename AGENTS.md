# Daily TV Monitor Instructions

## Mission

Produce a daily Korean report about meaningful TV software/hardware announcements, with strategic analysis for Samsung TV competitiveness. TV remains the primary focus, but include meaningful monitor and projector announcements when they affect adjacent display competition or Samsung's broader screen strategy.

Additionally, monitor newly emerging AI regulation, policy, and enforcement across the markets where Samsung TVs are sold, and report items that could affect Samsung TV AI services. Treat this as a dedicated `AI 규제 동향` category alongside the product announcements.

## Working Rules

- Write all report content in Korean.
- Reuse prior reports to avoid duplicate coverage.
- Focus first on official sources and major media, then expand to regional coverage if time allows. Major tech media to prioritize: The Verge, TechCrunch, Ars Technica, CNET, Engadget, Android Central, 9to5Google, MacRumors, Reuters, Bloomberg. For TV-specific trade coverage also check FlatpanelsHD, Display Daily, TV Answer Man.
- Exclude rumors and leaks unless they are clearly labeled as unconfirmed and come from highly credible outlets.
- Do not add one combined source list. Put `출처` links under each item.
- Every confirmed direct TV/monitor/projector item and every included indirect Google/Amazon item must include:
  - `관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)`
  - `중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)`
  - `인사이트` with exactly these bullets:
    - `의미:`
    - `참고할 점:`
    - `제안:`
- If both `관련성` and `중요도` are `상`, add a separate `전략적 의도` field immediately before `인사이트`. Keep it to 1-3 short scenario bullets based on additional history/context research; omit it for all other grade combinations.
- Exception: if a discovered item has `관련성: 하` or `중요도: 하`, do not place it in the main `신규 발표 확인 사항`, `간접 서비스`, or `AI 규제 동향` sections. Put it under `기타 항목` with only title, one-line summary, and source links.

## Source Discovery and RSS

Use RSS feeds as a first-pass discovery layer, but do not rely on RSS alone. Continue to run normal web searches, official-site checks, and topic/jurisdiction searches within the dynamic search window.

RSS operating rules:

- Treat RSS as a signal source, not a complete source list. If an RSS feed is unavailable, stale, too broad, or noisy, use `site:` searches and official newsroom/developer/regulator pages instead.
- Verify RSS discoveries against the original source page, official announcement, or a major credible media source before including them in the report.
- Exclude duplicate rewrites, affiliate-driven shopping posts, routine promotions, commodity spec refreshes, and rumors unless they satisfy the report's existing inclusion rules.
- Use the existing dynamic search window from the latest report execution time to the current 기준 시각. For Monday AI regulation Tier 2 sweeps, use the required 7-day window even if RSS has older or newer items.
- Mention RSS access failures in `불확실성 및 검증 공백` only when they materially limit coverage.

Priority official/product/platform sources:

- Samsung Newsroom: https://news.samsung.com/global/feed
- LG Newsroom: https://www.lg.com/global/newsroom/news/
- Sony Press: https://www.sony.com/en/SonyInfo/News/Press/
- Roku Blog: https://blog.roku.com/feed
- Roku Developer Blog: https://blog.roku.com/developer/feed
- Amazon Developer / Fire TV / Appstore: https://developer.amazon.com/apps-and-games/blogs
- Android Developers Blog: https://android-developers.googleblog.com/feeds/posts/default?alt=rss
- Apple Developer News: https://developer.apple.com/news/
- Apple Newsroom: https://www.apple.com/newsroom/rss-feed.rss
- Tizen Developers: https://developer.samsung.com/tizen
- webOS TV Developer: https://webostv.developer.lge.com/

Priority media and trade sources:

- The Verge: https://www.theverge.com/rss/index.xml
- TechCrunch: https://techcrunch.com/feed/
- Ars Technica: https://feeds.arstechnica.com/arstechnica/index
- CNET: https://www.cnet.com/rss/news/
- Engadget: https://www.engadget.com/rss.xml
- Reuters Technology: https://www.reuters.com/technology/
- Bloomberg Technology: https://feeds.bloomberg.com/technology/news.rss
- FlatpanelsHD: https://www.flatpanelshd.com/rss/news.xml
- Display Daily: https://displaydaily.com/
- TV Answer Man: https://tvanswerman.com/feed/
- 9to5Google: https://9to5google.com/feed/
- Android Central: https://www.androidcentral.com/feed
- MacRumors: https://feeds.macrumors.com/MacRumors-All
- 9to5Mac Apple TV: https://9to5mac.com/guides/apple-tv/feed/
- Wired Gear: https://www.wired.com/feed/category/gear/latest/rss
- Pandaily: https://pandaily.com/feed/
- Gizmochina: https://www.gizmochina.com/feed/
- AI Times: https://www.aitimes.com/rss/allArticle.xml
- VentureBeat: https://venturebeat.com/feed
- EE Times: https://www.eetimes.com/feed/
- ZDNet TV: https://www.zdnet.com/topic/tvs/rss.xml
- ZDNet Smart Home: https://www.zdnet.com/topic/smart-home/rss.xml
- ZDNet AI: https://www.zdnet.com/topic/artificial-intelligence/rss.xml
- Cord Cutters News: https://cordcuttersnews.com/feed/

Priority AI regulation and policy sources:

- European Commission Digital Strategy: https://digital-strategy.ec.europa.eu/en
- EU AI Office: https://digital-strategy.ec.europa.eu/en/policies/ai-office
- FTC Press Releases: https://www.ftc.gov/feeds/press-release.xml
- FTC Consumer Protection: https://www.ftc.gov/feeds/press-release-consumer-protection.xml
- FTC Business Blog: https://www.ftc.gov/feeds/business-blog-gd.xml
- FCC RSS / updates: https://www.fcc.gov/news-events/rss-feeds-and-email-updates-fcc
- California Privacy Protection Agency: https://cppa.ca.gov/announcements/
- UK ICO News: https://ico.org.uk/about-the-ico/media-centre/news-and-blogs/
- UK DSIT: https://www.gov.uk/government/organisations/department-for-science-innovation-and-technology.atom
- Korea MSIT: https://www.msit.go.kr/
- Korea PIPC: https://www.pipc.go.kr/
- KISA Notices: https://kisa.or.kr/rss/401
- KISA Press Releases: https://kisa.or.kr/rss/402
- China CAC: https://www.cac.gov.cn/

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

Also include indirect but relevant Google/Amazon launches when they could extend to TV, living-room commerce/media, or smart-home control. Smart-home hub devices such as Google Home Speaker and Amazon Echo are qualifying indirect items when they introduce new AI capabilities (e.g. Gemini integration, on-device reasoning, multi-step commands) that extend to TV voice control or smart-home orchestration competing with Samsung SmartThings and Tizen-based integrations.

Broaden Google/Amazon AI tracking beyond TV-branded announcements. Core consumer-facing Gemini or Alexa AI capabilities qualify as indirect-service candidates when there is a plausible path to TV, living-room, smart-home, media, personalization, or commerce use cases, even if the article does not explicitly mention Google TV, Android TV, Fire TV, or Echo Show. Examples include persistent user memory/preferences, multimodal voice/vision understanding, image/video generation or editing, content summarization/translation, media search and recommendation, multi-step AI agent actions, on-device or edge AI, smart-home orchestration, and shopping/advertising personalization. If the TV/living-room path is explicit or strategically strong, place the item under `간접 서비스`; if the path is plausible but weak, place it under `기타 항목` with `관련성: 하` or `중요도: 하`; if it is enterprise/API/model-benchmark/coding/workspace-only news with no consumer assistant or living-room path, exclude it.

For all prioritized TV makers and TV platforms, include major platform, UX, ecosystem, and developer-facing updates when they materially affect TV competitiveness, even if they are not consumer hardware launches. Treat these as `신규 발표 확인 사항` when they are directly about a TV platform, TV OS, TV device family, TV app ecosystem, or TV usage model. This includes updates from official developer blogs, partner blogs, SDK documentation, app distribution guidance, major trade media, and product support channels when the impact is strategically meaningful.

Examples of qualifying platform/UX updates include TV OS or home-screen changes, app discovery surfaces, search/recommendation systems, FAST/content rows, advertising or commerce surfaces, account/profile changes, remote-control input, pointer or motion input, D-pad/focus model changes, voice/AI assistant behavior, gaming/cloud gaming hubs, casting/second-screen flows, accessibility features, security/privacy requirements, app certification requirements, SDK/API changes, app store or distribution policy changes, entitlement/resume/watch-next/recommendation APIs, and smart-home control surfaces. Do not limit this rule to Google TV; apply the same judgment to Tizen, webOS, Roku OS, Fire TV, tvOS/Apple TV, Android TV/Google TV, VIDAA, TiVo/Sharp/Philips/TP Vision platforms, and other strategically relevant TV software layers.

TV is still the highest-priority category. If meaningful monitor or projector software/hardware announcements appear from the prioritized companies or other strategically relevant display players, include them in `신규 발표 확인 사항` rather than creating a separate category. Do not dilute the report with routine monitor/projector retail promotions, minor availability notices, or commodity spec refreshes unless they have clear competitive relevance for Samsung TVs, premium displays, gaming screens, home cinema, AI UX, content services, or smart-home/living-room strategy.

## Relevance and Importance Calibration

Use strict grading. Do not inflate `관련성` or `중요도` merely because a priority brand is mentioned.

- `관련성: 상`: Directly affects Samsung TV competitiveness, TV OS/platform UX, app ecosystem, smart-home control, premium TV hardware, content discovery, advertising/commerce surfaces, or TV AI services.
- `관련성: 중`: Connected to TV/display strategy, sales channels, adjacent monitor/projector competition, or living-room services, but not a direct product/platform/AI service change.
- `관련성: 하`: Only loosely connected to Samsung TV strategy, such as mobile-only platform policy, broad company news, awards, interviews, generic retail activity, or AI policy with weak TV-service linkage.
- `중요도: 상`: Requires near-term executive attention because it changes a major product, platform, developer rule, regulatory obligation, competitive capability, or large-market availability.
- `중요도: 중`: Worth tracking for strategy or follow-up, but does not immediately change Samsung TV product/platform/regulatory priorities.
- `중요도: 하`: Low-actionability signal such as retail PR, campaign/marketing posts, minor availability, awards, interviews, small catalog additions, support-page wording changes, or routine promotional/affiliate coverage.
- Best Buy-like retailer-led announcements about store displays, comparison demos, sales campaigns, or "exclusive national retailer" positioning should generally be `중요도: 하` unless they disclose genuinely new product specs, pricing, launch timing, or materially exclusive market access.

Items with either `관련성: 하` or `중요도: 하` still belong in the report when they are credible and mildly relevant, but they must be placed only in `기타 항목` and summarized briefly.

## Strategic Intent for Top Items

For items graded both `관련성: 상` and `중요도: 상`, do one additional focused research pass before writing the final item. Check prior reports, official announcements, major-media/trade coverage, platform/developer history, rollout sequence, pricing/availability signals, partner ecosystem moves, monetization surfaces, and regulatory or competitive context that can explain why the company is making the move now.

Add `전략적 의도` immediately after `중요도` and before `인사이트`.

- Use 1-3 scenario bullets only. Each bullet should use the form `[시나리오명]: [근거 기반 의도 해석]`.
- Make each scenario easy to understand without external context: briefly connect the observed fact, likely intent, and competitive implication in one fuller bullet. One or two short sentences on the same bullet line are acceptable when needed for clarity.
- Treat the scenarios as grounded inference, not certainty. Avoid overclaiming; indicate uncertainty through wording such as `가능성`, `의도 가능`, or `방어/확장 시나리오`.
- Reflect this analysis in the existing `인사이트` bullets so `의미`, `참고할 점`, and `제안` become deeper and more action-oriented, while staying brief.
- Do not add `전략적 의도` to `관련성: 상` + `중요도: 중`, `관련성: 중` + `중요도: 상`, or any item routed to `기타 항목`.

## AI Regulation Scope

In addition to product/platform announcements, track newly emerging AI regulation, policy, guidance, and enforcement that could affect Samsung TV AI services. Report these under the dedicated `AI 규제 동향` section.

### Samsung TV AI service categories (relevance checklist)

A regulation item qualifies only if it could plausibly affect at least one of these Samsung TV AI service categories. Tag each included item with the affected category names in `영향 범주`.

- 콘텐츠/UI: 콘텐츠 추천, 생성형 UI, 개인화 UI, 콘텐츠 생성, 요약, 번역
- 미디어 처리: 화질/음질 개선, 장면 인식, 콘텐츠 관련 질의응답
- 에이전트/OS: AI 에이전트 작업 수행, 사용자 컨텍스트 이해, 음성 및 멀티모달 인터랙션, on-device AI, AI OS
- 비즈니스: 광고, 커머스

If a regulation has no plausible link to any of the categories above, exclude it. Do not include general AI policy news that does not touch consumer devices, media platforms, recommendation/advertising, voice/biometric, or generative content.

### Search themes (map service terms to legal terms)

Regulators do not use product words like "생성형 UI" or "화질 개선". Search the legal/regulatory vocabulary below and let the relevance checklist decide inclusion. Run these as separate theme queries and merge results rather than one giant query.

- T1 생성형·투명성 (콘텐츠 생성/요약/번역/생성형 UI/생성형 업스케일): `generative AI`, `transparency`, `watermark`, `content labeling`, `synthetic content`, `copyright`, `deepfake`
- T2 데이터·알고리즘 (추천/개인화/광고/커머스/장면 인식/컨텍스트): `recommendation algorithm`, `profiling`, `targeted advertising`, `ACR`, `automatic content recognition`, `privacy`, `children's data`
- T3 음성·생체·플랫폼 (음성/멀티모달/AI 에이전트/AI OS/질의응답): `voice assistant`, `biometric data`, `AI agent`, `gatekeeper`, `interoperability`, `DMA`
- T4 온디바이스·안전성 (on-device AI): `on-device AI`, `edge AI`, `AI safety`, `general-purpose AI model`

### Jurisdiction tiers (control noise across all selling markets)

Samsung TVs sell worldwide, but daily full-scans of every country are noisy. Use tiers:

- Tier 1 (check every run): EU (AI Act, DMA), United States (federal + key states such as California, Colorado, Texas), South Korea (AI 기본법), United Kingdom, China.
- Tier 2 (mandatory weekly sweep every Monday): India, Brazil, Japan, Canada, Australia, Middle East, Southeast Asia, and other selling markets — search the preceding 7 days ending at the report 기준 시각, regardless of the normal dynamic report search window, and surface only clear new legislation, enforcement, or guidance signals.
- Always include relevant global/industry standards (e.g. watermarking, content provenance) regardless of tier.
- On Monday reports, explicitly note the Tier 2 weekly sweep result with the label `AI 규제 Tier 2` and the 7-day search window. If no Tier 2 item qualifies for `AI 규제 동향`, record the sweep under `확인했으나 업데이트가 없었던 곳`.

Prefer official sources (regulator/government sites, official journals, agency press) and major legal/policy media. Exclude speculation; mark credible-but-unconfirmed items as 미확인.

## Output Files

Update both:

- `new_features/YYYY-MM-DD.md` or `new_features/YYYY-MM-DD_요약.md`
- `new_features/latest.md`

Use the title `일간 TV 모니터링 리포트`.

Filename rule:

- If `신규 발표 확인 사항`, `간접 서비스`, and `AI 규제 동향` all contain only `해당 없음`, use `new_features/YYYY-MM-DD.md` even when `기타 항목` contains low-priority items.
- If any of `신규 발표 확인 사항`, `간접 서비스`, or `AI 규제 동향` contains one or more items, append a short Korean summary of the single most important item after the date: `new_features/YYYY-MM-DD_요약.md`.
- The summary suffix must be 20 Korean characters or fewer, excluding the date, underscore, and `.md`.
- Keep official brand and platform names in their original English form in the suffix, such as `Fire TV`, `Roku`, `Google TV`, and `Apple TV`; do not transliterate them into Korean.
- Use only filename-safe characters in the suffix. Korean letters/numbers and spaces are allowed for readability; remove slashes, colons, pipes, quotes, brackets, and other unsafe filename characters.
- Keep `new_features/latest.md` as an exact copy of the generated daily report content.

## Report Format Contract

All reports must use this exact section order and field naming. Keep section names stable across days.

Summary rule:

- Write `## 요약` as a short bullet list of 2-3 concise Korean summaries. Prefer shortened forms such as `라인업 공개`, `경쟁 구도 확인`, and `영향 가능` over full sentence endings such as `공개했다` or `보여준다`.
- Include only discovered qualifying items and their strategic meaning.
- Do not include `기타 항목` items in `## 요약` unless there are no qualifying items in `신규 발표 확인 사항`, `간접 서비스`, or `AI 규제 동향`; in that case, write one concise bullet noting no major qualifying update and that low-priority signals are listed separately.
- Do not include Samsung recommendations, action proposals, or phrases such as `삼성은 ... 필요가 있다` in `## 요약`; keep recommendations only in each item's `인사이트` / `제안`.
- Do not describe where there were no updates, which sources were checked, or the search process in `## 요약`; reserve that detail for `## 확인했으나 업데이트가 없었던 곳` and `## 불확실성 및 검증 공백`.
- If there are no qualifying items, write one concise bullet saying that no qualifying announcements were found in the search window.

Content style rule:

- Write every `내용` field as a list block, not as one long sentence. Use `- 내용` followed by 2-4 short bullets.
- Prefer concise noun-style or headline-style endings such as `판매 시작`, `무료 업그레이드 적용`, `미국·영국 확인`, `하반기 업데이트 예고`.
- Avoid connected prose and full sentence endings such as `판매를 시작했다`, `적용하기 시작했다`, `확인됐다`, or `예고했다` unless needed for clarity.
- Keep each bullet focused on one fact: source/basis, core change, model/market scope, rollout or follow-up condition.

Insight style rule:

- Write `인사이트` values as short scenario sentences, not over-compressed noun phrases and not long explanatory paragraphs.
- Keep the labels exactly as `의미:`, `참고할 점:`, and `제안:`, but make the text after each label readable as one brief action-oriented sentence fragment.
- End each `인사이트` line with report-style nominal wording such as `가능성 있음`, `변수로 보임`, `추적 필요`, `점검 필요`, or `비교 필요`.
- Avoid full sentence endings such as `있다`, `한다`, `보인다`, `필요가 있다`, or `확인해야 한다`.
- Keep each insight focused on one strategic point: implication, watch point, and recommended follow-up. Avoid packing multiple unrelated actions into one bullet.

Image rule:

- For each actual included announcement, try to add a visible `대표 이미지` immediately under the numbered item title.
- Use a source-page representative image such as `og:image` or `twitter:image` from the official source or a cited major-media source, formatted as Markdown image syntax so it renders inline. Prefer `og:image`/`twitter:image`; if those are unavailable or unsuitable, use the largest candidate from `srcset`/`data-srcset` (preferably 1200px or wider). Never use explicit thumbnail, low-resolution, or placeholder URLs such as `width-100`, `width-200`, `width-300`, `w=300`, `thumbnail`, `thumb`, or `small`; omit the representative image if no suitable high-resolution image is available.
- Do not use generic logos, icons, tracking pixels, author photos, social-share/meta cards, or unrelated stock images. If no suitable representative image is available, omit `대표 이미지`.
- Before finishing the report, recheck every `대표 이미지` with `scripts/validate_report_images.ps1` and treat warnings as blockers unless you have visually inspected the image and confirmed it is a relevant product, UI, feature, device, or content image. Replace or omit any image that returns 404/non-image content, looks like a logo/branding card, or cannot be verified.
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
   - 내용
     - [핵심 변화: 명사형/요약형으로 작성]
     - [대상·범위: 모델, 지역, 사용자, 플랫폼 등]
     - [후속 조건: 업데이트, 일정, 검증 포인트 등]
   - 관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 전략적 의도
     - [관련성·중요도 모두 상인 경우에만 1-3개 시나리오 작성. 그 외에는 이 필드 생략]
   - 인사이트
     - 의미: [삼성 TV 경쟁력 관점의 명사형 의미 요약]
     - 참고할 점: [비교/검증/리스크/추적 포인트 명사형 요약]
     - 제안: [실행 가능한 대응 제안 명사형 요약]
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
   - 내용
     - [핵심 변화: 명사형/요약형으로 작성]
     - [TV 확장 경로: 거실, 미디어, 스마트홈, 커머스 등]
     - [대상·범위 또는 후속 조건]
   - 관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 전략적 의도
     - [관련성·중요도 모두 상인 경우에만 1-3개 시나리오 작성. 그 외에는 이 필드 생략]
   - 인사이트
     - 의미: [삼성 TV 경쟁력 관점의 명사형 의미 요약]
     - 참고할 점: [비교/검증/리스크/추적 포인트 명사형 요약]
     - 제안: [실행 가능한 대응 제안 명사형 요약]
   - 출처
     - [출처명](URL)
     - [출처명](URL)

## AI 규제 동향

1. **[관할: 규제/정책명]**
   - 상태: **공식 확인** | **주요 매체 확인** | **미확인**
   - 관할: EU | 미국(연방) | 미국(주) | 한국 | 중국 | 영국 | 기타
   - 진행 단계: 입법예고 | 통과 | 시행 | 가이드라인 | 집행/제재
   - 시행/적용 시점: YYYY-MM-DD | 미정
   - 영향 범주: [콘텐츠 추천 / 생성형 UI / 광고 / 음성·멀티모달 등 영향받는 삼성 TV AI 서비스 범주를 태그]
   - 내용
     - [규제 핵심: 명사형/요약형으로 작성]
     - [적용 대상·범위]
     - [시행 일정·리스크 또는 후속 확인점]
   - 관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 전략적 의도
     - [관련성·중요도 모두 상인 경우에만 1-3개 시나리오 작성. 그 외에는 이 필드 생략]
   - 인사이트
     - 의미: [삼성 TV AI 서비스 관점의 명사형 의미 요약]
     - 참고할 점: [비교/검증/리스크/추적 포인트 명사형 요약]
     - 제안: [실행 가능한 대응 제안 명사형 요약]
   - 출처
     - [출처명](URL)
     - [출처명](URL)

## 기타 항목

1. **[업체/플랫폼: 발표 제목]**
   - 요약: 관련성 상|중|하·중요도 상|중|하 - [저우선순위 이유를 포함해 1줄로 작성]
   - 출처: [출처명](URL), [출처명](URL)

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
- If there are no qualifying AI regulation items, write only `해당 없음` under `## AI 규제 동향`.
- If there are no low-priority items, write only `해당 없음` under `## 기타 항목`.
- Place every credible item with either `관련성: 하` or `중요도: 하` under `## 기타 항목`, not under the three main item sections.
- Keep `## 기타 항목` intentionally brief: each item must contain only the numbered title, a single `요약` line, and one `출처` line with links. Do not add representative images, status, date, classification, long analysis, or `인사이트` bullets there.
- Do not rename, reorder, or omit the seven required top-level sections.
- Do not add a combined source list anywhere in the report.
- Put item sources under that item only, using the `출처` field.
- Use numbered items only for actual included announcements.
- Use `- 해당 없음` for empty non-announcement sections.
- Keep `인사이트` bullets exactly as `의미:`, `참고할 점:`, and `제안:`. Put top-item scenario analysis only in the separate `전략적 의도` field, not as an extra `인사이트` bullet.

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
4. Investigate meaningful monitor/projector announcements, relevant indirect Google/Amazon items, and core consumer-facing Gemini/Alexa AI capability launches that could plausibly extend to TV, living-room media, smart-home control, personalization, or commerce within that dynamic window.
5. Investigate AI regulation per the `AI Regulation Scope` section: run the four search themes (T1–T4) against Tier 1 jurisdictions every run. Every Monday, also run the Tier 2 sweep across the preceding 7 days ending at the report 기준 시각, even if the normal report search window is shorter or longer. Keep only items that pass the Samsung TV AI service relevance checklist and tag each with `영향 범주`.
6. Grade relevance and importance strictly. If either score is `하`, route the item to `기타 항목` with only title, one-line summary, and source links.
7. For any item graded both `관련성: 상` and `중요도: 상`, perform the `Strategic Intent for Top Items` research pass, add `전략적 의도`, and deepen the `인사이트` bullets accordingly.
8. Write the report in Korean with explicit source attribution per item.
9. If there are no qualifying items in a section, write `해당 없음` only under that section.
10. Run `scripts/validate_report_format.ps1` and `scripts/validate_report_images.ps1 -TreatWarningsAsErrors` against the generated daily report and `new_features/latest.md`; fix every format error, broken image URL, low-resolution URL, and suspicious logo/social-card warning before stopping. If a warned image is actually appropriate after visual inspection, prefer replacing it with a clearer source image; keep it only when no better source-page image exists.
11. Stop after updating and validating the local markdown files.
12. Do not commit or push from this repository. Git operations are handled by a separate local process outside this run.
