# Daily TV Monitor Instructions

## Mission

Produce a daily Korean report about meaningful TV software/hardware announcements, with strategic analysis for Samsung TV competitiveness. TV remains the primary focus, but include meaningful monitor and projector announcements when they affect adjacent display competition or Samsung's broader screen strategy.

Additionally, monitor newly emerging AI regulation, policy, and enforcement across the markets where Samsung TVs are sold, and report items that could affect Samsung TV AI services. Treat this as a dedicated `AI 규제 동향` category alongside the product announcements.

## Working Rules

- Write all report content in Korean.
- Reuse prior reports to avoid duplicate coverage.
- Focus first on official sources and major media, then complete the regional and local-language coverage due for that run. Regional coverage is scheduled work, not optional work to attempt only if time allows. Major tech media to prioritize: The Verge, TechCrunch, Ars Technica, CNET, Engadget, Android Central, 9to5Google, MacRumors, Reuters, Bloomberg. For TV-specific trade coverage also check FlatpanelsHD, Display Daily, TV Answer Man.
- Exclude rumors and leaks unless they are clearly labeled as unconfirmed and come from highly credible outlets.
- Do not add one combined source list. Put `출처` links under each item.
- Every confirmed direct TV/monitor/projector item and every included indirect service item must include:
  - `관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)`
  - `중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)`
  - `인사이트` with these bullets for non-Samsung items:
    - `의미:`
    - `참고할 점:`
    - `제안:`
- Exception: for direct Samsung Electronics / Samsung TV items, do not infer `전략적 의도` even when both `관련성` and `중요도` are `상`. Under `인사이트`, write only `의미:` and omit `참고할 점:` and `제안:`.
- If both `관련성` and `중요도` are `상` for a non-Samsung, non-regulation product/platform/service item, add a separate `전략적 의도` field immediately before `인사이트`. Keep it to 1-3 short scenario bullets based on additional history/context research; omit it for all other grade combinations, direct Samsung Electronics / Samsung TV items, and all `AI 규제 동향` items.
- Exception: if a discovered item has `관련성: 하` or `중요도: 하`, do not place it in the main `신규 발표 확인 사항`, `간접 서비스`, or `AI 규제 동향` sections. Put it under `기타 항목` with only title, one-line summary, and source links.

## Source Discovery and RSS

Use RSS feeds as a first-pass discovery layer, but do not rely on RSS alone. Continue to run normal web searches, official-site checks, and topic/jurisdiction searches within the dynamic search window.

RSS operating rules:

- Treat RSS as a signal source, not a complete source list. If an RSS feed is unavailable, stale, too broad, or noisy, use `site:` searches and official newsroom/developer/regulator pages instead.
- Verify RSS discoveries against the original source page, official announcement, or a major credible media source before including them in the report.
- Exclude duplicate rewrites, affiliate-driven shopping posts, routine promotions, commodity spec refreshes, and rumors unless they satisfy the report's existing inclusion rules.
- Use the existing dynamic search window from the latest published report execution time to the current 기준 시각 as the authoritative report window. In addition, use a rolling 72-hour discovery overlap for RSS, official pages, web search, and local-language search to catch delayed indexing, feed/parser failures, and late publication. Deduplicate overlap results against prior reports by canonical URL and event substance; include an older item only when it was genuinely missed or has a material new development.
- Parse every RSS/Atom entry that falls within the authoritative window or 72-hour discovery overlap before applying item-count limits. Do not use `First N` or an English-title keyword filter before date filtering. Evaluate normalized title, summary/description, category, publication/update time, and canonical link.
- Record success, no-update, fallback, stale, timeout, parse-error, not-run, and not-due status for each source or stable coverage bucket in the execution log. A failed source is not "checked". Complete an official-page or `site:` fallback before declaring that source or coverage bucket has no update.
- Carry failed mandatory sources and any missed scheduled weekly sweep into the next successful run. Catch-up must begin at the bucket's preserved `last_completed_end_kst` and continue to the current 기준 시각; a failed attempt never advances that timestamp. Never replace a missed or delayed sweep with a new fixed 7-day window that leaves an earlier gap.
- Mention RSS access failures in `불확실성 및 검증 공백` only when they materially limit coverage.

### Discovery recall contract

- Discovery and reporting are separate gates. During discovery, do not discard a candidate because the company is small, absent from the priority list, active in only one market, or expected to have low current relevance. Verify the original source first, then grade and route it.
- Read `docs/discovery_search_matrix.md` on every run and complete the query families and language groups due for that day. The matrix is a minimum, not an allowlist.
- Run both brand-specific checks and brand-agnostic topic searches. A run is incomplete if it checks only the named priority companies.
- Check every priority TV maker and platform with its own brand query and official-domain or official-page fallback; a single multi-brand `OR` query never satisfies a brand-specific check. Split hardware terms such as `TV`, `OLED`, `Mini LED`, and `projector` from platform terms such as `OS`, `home screen`, `developer`, `advertising`, and `AI` so search-result limits cannot hide a major launch.
- Build the emerging-company watch set from non-priority companies and platforms appearing in the previous 90 days of published reports. Do not seed it from unpublished local or failed-run artifacts. Recheck first-seen names daily for 30 days and in the Monday 7-day sweep through day 90, as specified in the discovery matrix.
- Promote a watched entity to the handoff's durable `permanent` tier when it meets the discovery matrix criteria. Recheck permanent entities every run and do not expire them merely because they fall outside the rolling 90-day report window.
- Preserve every credible, mildly relevant new signal in `기타 항목` when either grade is `하`. The only hard exclusions at discovery time are duplicate rewrites with no new fact, pure promotion with no product/service/market change, unsupported rumors, and enterprise/API/coding/benchmark news with no plausible consumer, media, home, or TV path.
- Before writing the report, complete and log these coverage buckets: priority RSS/media, priority official brands/platforms, brand-agnostic emerging entrants, indirect consumer AI/services, due local-language groups, Tier 1 AI regulation, due Tier 2/catch-up sweeps, and failed-source fallbacks.
- In `확인했으나 업데이트가 없었던 곳`, claim only sources and buckets actually completed in the current run. Put incomplete buckets and material source failures in `불확실성 및 검증 공백`; do not describe them as checked.

### Execution state handoff

- Before discovery, read the most recent valid `COVERAGE_HANDOFF_V1` block from `logs/cron/last_message_*.txt`, including attempt-suffixed Windows files, and its matching `run_*.log`. Trust it only when that run log contains `Finished with exit code 0`, `Coverage handoff validation passed`, successful report-format validation, and either `Publish completed.` or `No report changes to publish.`
- Use the handoff to carry forward each bucket's attempt window and last successful completion, failed source URLs and retry starts, 90-day `watch` and durable `permanent` company tiers, the future event calendar, and active event windows. It supplements but never replaces or narrows the wrapper-provided authoritative report window.
- If no valid handoff exists, rebuild the emerging-company set from the previous 90 days of published reports, retry failures named in the latest published report, and catch up scheduled sweeps from the earlier of the authoritative window start and 14 days before the current 기준 시각.
- At the end of every automated run, include the exact line-oriented handoff format and every stable bucket ID defined in `docs/discovery_search_matrix.md` in the final response so the wrapper log can preserve a complete state snapshot for the next run. Preserve `last_completed_end_kst` for failed and `NOT_DUE` buckets, and retain future events and `permanent` entities until explicitly superseded.

Priority official/product/platform sources:

- Samsung Newsroom: https://news.samsung.com/global/feed
- LG Newsroom: https://www.lg.com/global/newsroom/news/
- Sony Press: https://www.sony.com/en/SonyInfo/News/Press/
- TCL Global News: https://www.tcl.com/global/en/news
- Hisense International News: https://www.hisense.com/global/newsroom.html
- Panasonic Newsroom Global: https://news.panasonic.com/global/
- TP Vision News Releases: https://www.tpvision.com/news-releases/
- Sharp Press Releases: https://global.sharp/corporate/news/
- Xiaomi Newsroom: https://www.mi.com/global/discover/newsroom/
- Roku Blog: https://blog.roku.com/feed
- Roku Developer Blog: https://blog.roku.com/developer/feed
- Amazon Developer / Fire TV / Appstore: https://developer.amazon.com/apps-and-games/blogs
- Android Developers Blog: https://android-developers.googleblog.com/feeds/posts/default?alt=rss
- Apple Developer News: https://developer.apple.com/news/
- Apple Newsroom: https://www.apple.com/newsroom/rss-feed.rss
- Tizen Developers: https://developer.samsung.com/tizen
- webOS TV Developer: https://webostv.developer.lge.com/
- Titan OS: https://www.titanos.tv/
- Whale TV Press Releases: https://www.whaletv.com/news-category/press-releases
- Xumo TV: https://www.xumo.com/products/xumo-tv
- TiVo OS Developer: https://developers.tivo.com/smart-tv/intro

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
- China MIIT Electronic Information / Standards: https://www.miit.gov.cn/gyhxxhb/jgsj/dzxxsnew/bzgf/
- China SAMR: https://www.samr.gov.cn/
- China National Standards Public Service Platform: https://std.samr.gov.cn/
- China Open National Standards: https://openstd.samr.gov.cn/
- China CESI: https://www.cesi.cn/
- China CAICT: https://www.caict.ac.cn/

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

The priority list is a depth-of-coverage list, not an allowlist. Every run must also perform brand-agnostic discovery for new TV/display makers, regional brands, operator/private-label TVs, ODM/OEM partnerships, independent TV operating systems, streaming devices, projectors, and adjacent screen platforms. Discoveries from companies outside the priority list are graded by the same strategic criteria and must not be excluded merely because the company is small or unfamiliar.

Track indirect but relevant consumer AI and service launches regardless of provider. Seed providers include Google/Gemini, Amazon/Alexa, Apple/Siri, Microsoft/Copilot/Xbox, OpenAI, Meta AI, Anthropic, Perplexity, xAI, Baidu, Alibaba/Qwen, ByteDance/Doubao, Tencent, Naver, Kakao, and newly discovered consumer assistants. This is a discovery seed list, not an allowlist.

Core consumer-facing capabilities qualify as indirect-service candidates when there is a plausible path to TV, living-room, smart-home, media, personalization, accessibility, or commerce, even if the announcement does not explicitly mention a TV product. Examples include persistent memory/preferences, multimodal voice/vision or screen understanding, real-time translation/dubbing, image/video generation or editing, content summarization, media search and recommendation, multi-step agent actions, on-device or edge AI, smart-home orchestration, identity/family controls, and shopping/advertising personalization. Smart speakers, displays, phones, wearables, vehicles, and browsers qualify when they establish an interaction model or ecosystem capability that could move to the household screen.

If the TV/living-room path is explicit or strategically strong, place the item under `간접 서비스`; if the path is plausible but weak or early, place it under `기타 항목` with `관련성: 하` or `중요도: 하`. Exclude enterprise/API/model-benchmark/coding/workspace-only news only when it has no consumer product, media, device-partner, smart-home, or living-room path.

Also monitor strategically relevant ecosystem providers when their changes can reshape TV competition: independent TV OS licensors (including Titan OS, Whale TV, Xumo, TiVo OS, and newly discovered platforms), major streaming/media services, FAST and CTV advertising/commerce platforms, cloud-gaming services, TV silicon and display-panel suppliers, and cross-industry standards such as Matter, C2PA, HDMI, HbbTV, ATSC, DVB, AOMedia, HDR, and immersive audio. Routine upstream corporate news remains excluded unless it changes a TV capability, cost/availability constraint, developer requirement, or competitive route to market.

For all prioritized or newly discovered TV makers and TV platforms, include major platform, UX, ecosystem, and developer-facing updates when they materially affect TV competitiveness, even if they are not consumer hardware launches. Treat these as `신규 발표 확인 사항` when they are directly about a TV platform, TV OS, TV device family, TV app ecosystem, or TV usage model. This includes updates from official developer blogs, partner blogs, SDK documentation, app distribution guidance, major trade media, and product support channels when the impact is strategically meaningful.

Examples of qualifying platform/UX updates include TV OS or home-screen changes, app discovery surfaces, search/recommendation systems, FAST/content rows, advertising or commerce surfaces, account/profile changes, remote-control input, pointer or motion input, D-pad/focus model changes, voice/AI assistant behavior, gaming/cloud gaming hubs, casting/second-screen flows, accessibility features, security/privacy requirements, app certification requirements, SDK/API changes, app store or distribution policy changes, entitlement/resume/watch-next/recommendation APIs, and smart-home control surfaces. Do not limit this rule to Google TV; apply the same judgment to Tizen, webOS, Roku OS, Fire TV, tvOS/Apple TV, Android TV/Google TV, VIDAA, TiVo/Sharp/Philips/TP Vision platforms, and other strategically relevant TV software layers.

TV is still the highest-priority category. If meaningful monitor or projector software/hardware announcements appear from the prioritized companies or other strategically relevant display players, include them in `신규 발표 확인 사항` rather than creating a separate category. Do not dilute the report with routine monitor/projector retail promotions, minor availability notices, or commodity spec refreshes unless they have clear competitive relevance for Samsung TVs, premium displays, gaming screens, home cinema, AI UX, content services, or smart-home/living-room strategy. A first product, first market entry, first major retail/OEM/OS partnership, or first distinctive AI/UX model from an emerging company is not a routine commodity refresh and must be evaluated as a new entrant signal.

## Relevance and Importance Calibration

Use strict grading. Do not inflate `관련성` or `중요도` merely because a priority brand is mentioned.

Apply grading only after discovery and source verification. Being absent from the priority list, having low current market share, or launching in a single region is not by itself a reason to assign `하`. For an emerging company, explicitly consider novelty, first-market entry, OS/OEM/retail partnership, differentiated AI/UX, business model, and potential to establish a pattern larger competitors can copy.

- `관련성: 상`: Directly affects Samsung TV competitiveness, TV OS/platform UX, app ecosystem, smart-home control, premium TV hardware, content discovery, advertising/commerce surfaces, or TV AI services.
- `관련성: 중`: Connected to TV/display strategy, sales channels, adjacent monitor/projector competition, or living-room services, but not a direct product/platform/AI service change.
- `관련성: 하`: Only loosely connected to Samsung TV strategy, such as mobile-only platform policy, broad company news, awards, interviews, generic retail activity, or AI policy with weak TV-service linkage.
- `중요도: 상`: Requires near-term executive attention because it changes a major product, platform, developer rule, regulatory obligation, competitive capability, or large-market availability.
- `중요도: 중`: Worth tracking for strategy or follow-up, but does not immediately change Samsung TV product/platform/regulatory priorities.
- `중요도: 하`: Low-actionability signal such as retail PR, campaign/marketing posts, minor availability, awards, interviews, small catalog additions, support-page wording changes, or routine promotional/affiliate coverage.
- Best Buy-like retailer-led announcements about store displays, comparison demos, sales campaigns, or "exclusive national retailer" positioning should generally be `중요도: 하` unless they disclose genuinely new product specs, pricing, launch timing, or materially exclusive market access.

Items with either `관련성: 하` or `중요도: 하` still belong in the report when they are credible and mildly relevant, but they must be placed only in `기타 항목` and summarized briefly.

There is no fixed numerical cap on `기타 항목`. Preserve credible emerging-company, local-market, indirect-AI, standards/certification, and ecosystem signals there when their TV path is plausible but not yet strong enough for a main section. Concision comes from the one-line format, not from silently dropping candidates.

## Strategic Intent for Top Items

For items graded both `관련성: 상` and `중요도: 상`, do one additional focused research pass before writing the final item. Check prior reports, official announcements, major-media/trade coverage, platform/developer history, rollout sequence, pricing/availability signals, partner ecosystem moves, monetization surfaces, and regulatory or competitive context that can explain why the company is making the move now.

Samsung Electronics exception: do not add `전략적 의도` to direct Samsung Electronics / Samsung TV items, even when both `관련성` and `중요도` are `상`. Treat these as internal-company updates; avoid speculative intent framing and write only the `인사이트` / `의미:` line.

AI regulation exception: do not add `전략적 의도` to `AI 규제 동향` items, even when both `관련성` and `중요도` are `상`. Regulations should be analyzed through obligations, risks, and response implications in `인사이트`, not inferred regulator intent.

Add `전략적 의도` immediately after `중요도` and before `인사이트`.

- Use 1-3 scenario bullets only. Each bullet should use the form `[시나리오명]: [근거 기반 의도 해석]`.
- Make each scenario easy to understand without external context: briefly connect the observed fact, likely intent, and competitive implication in one fuller bullet. One or two short sentences on the same bullet line are acceptable when needed for clarity.
- Treat the scenarios as grounded inference, not certainty. Avoid overclaiming; indicate uncertainty through wording such as `가능성`, `의도 가능`, or `방어/확장 시나리오`.
- Reflect this analysis in the existing `인사이트` bullets so `의미`, `참고할 점`, and `제안` become deeper and more action-oriented, while staying brief.
- Do not add `전략적 의도` to `관련성: 상` + `중요도: 중`, `관련성: 중` + `중요도: 상`, or any item routed to `기타 항목`.
- Do not add `전략적 의도` to direct Samsung Electronics / Samsung TV items; use only `인사이트` / `의미:` for those items.
- Do not add `전략적 의도` to `AI 규제 동향` items; use `인사이트` to explain obligation, risk, and response meaning.

## AI Regulation Scope

In addition to product/platform announcements, track newly emerging AI regulation, policy, guidance, and enforcement that could affect Samsung TV AI services. Report these under the dedicated `AI 규제 동향` section.

### Samsung TV AI service categories (relevance checklist)

A regulation item qualifies only if it could plausibly affect at least one functional category or one cross-cutting legal dimension below as applied to a Samsung TV device, AI feature, media/platform service, account, advertising surface, or connected-home function. Tag each included item with every affected functional category and legal dimension in `영향 범주`.

- 콘텐츠/UI: 콘텐츠 추천, 생성형 UI, 개인화 UI, 콘텐츠 생성, 요약, 번역
- 미디어 처리: 화질/음질 개선, 장면 인식, 콘텐츠 관련 질의응답
- 에이전트/OS: AI 에이전트 작업 수행, 사용자 컨텍스트 이해, 음성 및 멀티모달 인터랙션, on-device AI, AI OS
- 비즈니스: 광고, 커머스
- 데이터/프라이버시: 시청 이력, ACR, 음성·영상·생체·계정 데이터, 프로파일링, 아동 데이터, 국외 이전
- 안전·보안·책임: 제품·사이버 보안, AI 안전성, 취약점·사고 보고, 제품책임, 적합성평가
- 접근성·아동: 자막·음성 안내·메뉴 접근성, 연령 확인, 아동보호, 유해 콘텐츠·상호작용
- 플랫폼·상호운용: gatekeeper, 앱·OS 배포, 기본값·선택권, 데이터 이동성, API·스마트홈 상호운용

If a regulation has no plausible Samsung TV device, service, media, account, advertising, or connected-home link, exclude it. Do not include a broad privacy, cybersecurity, accessibility, child-safety, product-safety, or platform rule solely because it mentions AI or consumer technology.

### Search themes (map service terms to legal terms)

Regulators do not use product words like "생성형 UI" or "화질 개선". Search the legal/regulatory vocabulary below and let the relevance checklist decide inclusion. Run these as separate theme queries and merge results rather than one giant query. Read `docs/ai_regulatory_source_catalog.md` on every run: monitor P0 news/status URLs daily and review the full official text, version metadata, and change history every Monday; monitor P1 news, status, and index pages daily and perform the same full-source review on Monday; monitor P2 status-change signals daily and perform the full status pass on the first successful run of each calendar month. Perform a content diff only when a trusted earlier snapshot or fingerprint actually exists; otherwise record a baseline/metadata review and do not call it a diff. Carry missed checks forward from `last_completed_end_kst`. For China, run separate Chinese-language queries using the Chinese terms below; an English query or translated search result is not a substitute.

- T1 생성형·투명성 (콘텐츠 생성/요약/번역/생성형 UI/생성형 업스케일): `generative AI`, `transparency`, `watermark`, `content labeling`, `synthetic content`, `copyright`, `deepfake`; China: `生成式人工智能`, `生成内容`, `合成内容`, `内容标识`, `水印`, `深度合成`, `著作权`
- T2 데이터·알고리즘 (추천/개인화/광고/커머스/장면 인식/컨텍스트): `recommendation algorithm`, `profiling`, `targeted advertising`, `ACR`, `automatic content recognition`, `privacy`, `data protection`, `cross-border transfer`, `children's data`, `age assurance`, `child safety`; China: `推荐算法`, `算法推荐`, `用户画像`, `定向广告`, `自动内容识别`, `个人信息保护`, `数据出境`, `儿童个人信息`, `年龄核验`, `未成年人保护`
- T3 음성·생체·플랫폼 (음성/멀티모달/AI 에이전트/AI OS/질의응답): `voice assistant`, `biometric data`, `AI agent`, `gatekeeper`, `interoperability`, `DMA`, `accessibility`, `closed caption`, `audio description`, `accessible interface`; China: `语音助手`, `生物识别信息`, `人工智能体`, `智能体`, `互操作`, `平台治理`, `无障碍`, `字幕`, `音频描述`
- T4 온디바이스·안전성 (on-device AI): `on-device AI`, `edge AI`, `AI safety`, `general-purpose AI model`, `cybersecurity`, `product safety`, `product liability`, `connected product`, `vulnerability reporting`; China: `端侧人工智能`, `边缘人工智能`, `人工智能安全`, `通用人工智能模型`, `网络安全`, `产品安全`, `产品责任`, `联网产品`, `漏洞报告`
- T5 AI 단말·TV 표준/인증: `AI terminal`, `smart TV standard`, `intelligence grading`, `certification`, `conformity assessment`, `testing`, `effective date`; China: combine (`电视`, `电视接收机`, `智能电视`, `AI电视`, `人工智能电视`) with (`人工智能终端`, `智能化分级`, `智能化等级`, `国家标准`, `行业标准`, `标准发布`, `实施`, `认证`, `检测`, `符合性评价`). Check the standards, certification, testing, assurance, and product-safety authorities for every Tier 1 jurisdiction even when no RSS or major-media result exists; the jurisdiction-specific minimum source table in `docs/discovery_search_matrix.md` is mandatory.

Chinese-language source handling:

- Search Chinese official pages and Chinese-language media in the original language on every run. Do not rely only on English-language coverage, machine-translated titles, or broad international RSS feeds.
- Verify Chinese standards by checking status fields such as `现行`, `正在批准`, `征求意见`, `发布日期`, and `实施日期`; distinguish a framework launch, a draft/approval-stage product part, and an enforceable or active certification scheme.
- Route TV/device-specific technical standards, grading specifications, certification programs, and conformity-assessment changes to `신규 발표 확인 사항` with `분류: 규제/인증`. Route broader AI laws, service rules, policy guidance, and enforcement affecting Samsung TV AI services to `AI 규제 동향`.

### Jurisdiction tiers (control noise across all selling markets)

Samsung TVs sell worldwide, but daily full-scans of every country are noisy. Use tiers:

- Tier 1 (check every run): EU (AI Act, DMA), United States (federal + key states such as California, Colorado, Texas), South Korea (AI 기본법), United Kingdom, China.
- Tier 2 (mandatory weekly sweep every Monday): India, Brazil, Japan, Canada, Australia, Middle East, Southeast Asia, and other selling markets — search the preceding 7 days ending at the report 기준 시각, regardless of the normal dynamic report search window, and surface only clear new legislation, enforcement, or guidance signals.
- Always include relevant global/industry standards (e.g. watermarking, content provenance) regardless of tier.
- On Monday reports, explicitly note the Tier 2 weekly sweep result with the label `AI 규제 Tier 2` and the normal 7-day search window. If no Tier 2 item qualifies for `AI 규제 동향`, record the sweep under `확인했으나 업데이트가 없었던 곳`.
- If the last successful run missed a Monday or another scheduled sweep day, the next successful run must perform and label catch-up from that bucket's `last_completed_end_kst` through the current 기준 시각. If completion state is unavailable, start at the earlier of the authoritative search-window start and 14 days before the current 기준 시각. A delayed run must not leave the first part of the missed period unsearched.

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
- Prioritize qualifying items and their strategic meaning. As one of the maximum three bullets, `관찰 신호:` may summarize at most one credible `기타 항목` item when it is an emerging company's first product or market entry, a first major OEM/OS/distribution partnership, or an early TV/AI standard or certification status change.
- If there are no qualifying items, write one concise bullet noting no major qualifying update and, when the exception above applies, one separate `관찰 신호:` bullet. Do not promote routine low-priority items into the summary.
- Do not include Samsung recommendations, action proposals, or phrases such as `삼성은 ... 필요가 있다` in `## 요약`; keep recommendations only in each item's `인사이트` / `제안`.
- Do not describe where there were no updates, which sources were checked, or the search process in `## 요약`; reserve that detail for `## 확인했으나 업데이트가 없었던 곳` and `## 불확실성 및 검증 공백`.

Content style rule:

- Write every `내용` field as a list block, not as one long sentence. Use `- 내용` followed by 2-4 short bullets.
- Prefer concise noun-style or headline-style endings such as `판매 시작`, `무료 업그레이드 적용`, `미국·영국 확인`, `하반기 업데이트 예고`.
- Avoid connected prose and full sentence endings such as `판매를 시작했다`, `적용하기 시작했다`, `확인됐다`, or `예고했다` unless needed for clarity.
- Keep each bullet focused on one fact: source/basis, core change, model/market scope, rollout or follow-up condition.

Insight style rule:

- Write `인사이트` values as short scenario sentences, not over-compressed noun phrases and not long explanatory paragraphs.
- Keep the labels exactly as `의미:`, `참고할 점:`, and `제안:` for non-Samsung items, but make the text after each label readable as one brief action-oriented sentence fragment.
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
   - 영향 범주: [콘텐츠/UI / 미디어 처리 / 에이전트/OS / 비즈니스 / 데이터/프라이버시 / 안전·보안·책임 / 접근성·아동 / 플랫폼·상호운용 중 적용 태그]
   - 내용
     - [규제 핵심: 명사형/요약형으로 작성]
     - [적용 대상·범위]
     - [시행 일정·리스크 또는 후속 확인점]
   - 관련성: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
   - 중요도: 상|중|하 (등급 근거를 문장형보다 짧은 축약형으로 작성)
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
- If there are no qualifying indirect consumer AI, media, smart-home, commerce, or adjacent service items, write only `해당 없음` under `## 간접 서비스`.
- If there are no qualifying AI regulation items, write only `해당 없음` under `## AI 규제 동향`.
- If there are no low-priority items, write only `해당 없음` under `## 기타 항목`.
- Place every credible item with either `관련성: 하` or `중요도: 하` under `## 기타 항목`, not under the three main item sections.
- Keep `## 기타 항목` intentionally brief: each item must contain only the numbered title, a single `요약` line, and one `출처` line with links. Do not add representative images, status, date, classification, long analysis, or `인사이트` bullets there.
- Do not omit a credible emerging-company, regional-market, indirect-AI, standards/certification, or ecosystem signal merely to keep `기타 항목` short. Use the required one-line format to control length.
- Do not rename, reorder, or omit the seven required top-level sections.
- Do not add a combined source list anywhere in the report.
- Put item sources under that item only, using the `출처` field.
- Use numbered items only for actual included announcements.
- Use `- 해당 없음` for empty non-announcement sections.
- Under `확인했으나 업데이트가 없었던 곳`, list only sources and coverage buckets successfully checked in that execution. Never use a grouped brand/jurisdiction claim when one or more members were not actually checked; move material gaps to `불확실성 및 검증 공백`.
- For non-Samsung items, keep `인사이트` bullets exactly as `의미:`, `참고할 점:`, and `제안:`. Put top-item scenario analysis only in the separate `전략적 의도` field, not as an extra `인사이트` bullet.
- For direct Samsung Electronics / Samsung TV items, keep only `인사이트` / `의미:` and omit `참고할 점:` and `제안:`.

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

1. Read `docs/discovery_search_matrix.md`, `docs/ai_regulatory_source_catalog.md`, the newest published reports under `new_features/`, and the latest valid execution-state handoff before discovery. Use prior reports to deduplicate events, not to narrow the allowed company or topic scope.
2. Use the wrapper-provided **latest published report basis** as the authoritative search-window start and the wrapper KST time as the end. Do not use a fixed 24-hour window or an unpublished local report as the baseline.
3. Add the rolling 72-hour discovery overlap. An older candidate found in the overlap may be included when prior reports missed it or when it contains a material new rollout, market, partner, requirement, price, or availability fact.
4. Process all priority RSS/Atom sources and required official pages. Filter by time before applying item limits, inspect title plus description/category, and perform fallbacks for failures.
5. Investigate direct TV, monitor, projector, streaming-device, platform, developer, content, advertising/commerce, gaming, standards, silicon, and display announcements from priority and previously discovered companies.
6. Complete the brand-agnostic emerging-entrant and independent-platform query families in `docs/discovery_search_matrix.md`. Verify an unfamiliar company with an official product/partner source or two independent credible major, trade, or regional outlets. Use `주요 매체 확인` when only the two-source route succeeds and keep searching for the official source.
7. Complete the provider-neutral indirect consumer AI/service capability queries. Cover voice/vision, memory, agents, media intelligence, generation/editing, translation/dubbing, smart home, on-device AI, accessibility, advertising, shopping, and payments where a TV/living-room path is plausible.
8. Complete the local-language groups and event-window searches due for the day, including every catch-up window since the last successful completion. Local-language product/platform/service discovery is separate from local-language regulation discovery.
9. Investigate AI regulation per `AI Regulation Scope`: run T1–T5 against Tier 1 jurisdictions every run, use the regulatory source catalog's daily/weekly/monthly layers, and perform the Monday Tier 2 sweep or any gap-free catch-up. Keep only items that pass the expanded Samsung TV AI relevance checklist and tag each functional and legal `영향 범주`.
10. Check the coverage buckets in the `Discovery recall contract`. Do not claim completion for a failed or skipped bucket; record material gaps and retry obligations.
11. After source verification, grade relevance and importance. Route any item with either score `하` to `기타 항목`; do not silently discard credible mild signals.
12. For any non-Samsung, non-regulation product/platform/service item graded both `관련성: 상` and `중요도: 상`, perform the `Strategic Intent for Top Items` research pass. Keep the Samsung and AI-regulation exceptions unchanged.
13. Write the report in Korean with item-level sources. Use `해당 없음` only after the corresponding discovery bucket was completed.
14. Run `scripts/validate_report_format.ps1` and `scripts/validate_report_images.ps1 -TreatWarningsAsErrors` against the generated daily report and `new_features/latest.md`; fix every format error, broken image URL, low-resolution URL, and suspicious logo/social-card warning before stopping.
15. In the final automated response, emit the `COVERAGE_HANDOFF_V1` block with every stable bucket's attempt window and `last_completed_end_kst`, failures, `watch` and `permanent` entities, the future event calendar, and active event windows. A missing sentinel, required stable ID, or closing line means the automated task is incomplete and must be corrected before finalizing. Stop after updating and validating local markdown files; do not commit or push because Git operations are handled by the wrapper.
