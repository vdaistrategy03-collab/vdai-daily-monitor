# TV 모니터링 검색 매트릭스

## 목적

이 문서는 일간 리포트의 최소 발견 범위를 정의한다. `AGENTS.md`의 우선 업체 목록을 보완하며, 검색어·업체·언어 목록은 모두 출발점일 뿐 허용 목록이 아니다. 발견 단계에서는 업체 규모나 예상 등급으로 후보를 버리지 않고 원문 확인 후 관련성·중요도를 평가한다.

## 시간 범위

- `권위 검색 구간`: wrapper가 제공한 직전 게시 리포트 기준 시각부터 현재 기준 시각까지
- `발견 중첩 구간`: 현재 기준 시각 직전 72시간. RSS 장애, 늦은 색인, 시차 표기, 후속 보도 누락 보완용
- 중첩 구간 후보는 canonical URL과 사건 내용으로 이전 리포트와 중복 제거
- 이전 리포트에서 빠진 발표 또는 시장·가격·파트너·시행일·지원 범위가 실질적으로 추가된 후속 발표만 반영
- 검색 결과 수 제한은 날짜 필터와 제목·요약·분류·링크 확인 뒤 적용

## 실행 주기

| 주기 | 필수 검색 언어·지역 | 범위 |
|---|---|---|
| 매일 | 영어 글로벌, 한국어, 중국어 간체, 일본어 | 권위 검색 구간 + 72시간 중첩 |
| 월요일 | 인도 영어·힌디어, 브라질 포르투갈어, 중남미 스페인어 | 직전 7일 |
| 수요일 | 독일어, 프랑스어, 이탈리아어, 튀르키예어 | 직전 7일 |
| 금요일 | 중국어 번체, 인도네시아어, 베트남어, 태국어, 아랍어 | 직전 7일 |
| 행사 기간 | CES, AWE, IFA, CEDIA Expo, InfoComm, Display Week, NAB Show 등 개최국 언어와 참가사 원문 | 행사 시작 7일 전부터 종료 7일 후 |

- 정상 예정일 스윕은 직전 7일을 사용한다. 예정일을 놓친 catch-up은 고정 7일로 다시 자르지 않고, handoff에 기록된 해당 버킷의 `last_completed_end_kst`부터 현재 기준 시각까지 수행해 공백을 남기지 않는다.
- 유효한 handoff가 없으면 권위 검색 구간 시작과 현재 기준 시각 직전 14일 중 더 이른 시각부터 catch-up한다. 직전 게시 리포트의 `불확실성 및 검증 공백`에 남은 실패 소스도 함께 재확인한다.
- 현지 원문 검색과 AI 규제 관할 검색은 별도 작업으로 모두 수행

### 행사 창 판정

- 매월 첫 성공 실행에서 [CES](https://www.ces.tech/), [AWE](https://www.awe.com.cn/), [IFA](https://www.ifa-berlin.com/), [CEDIA Expo](https://cediaexpo.com/), [InfoComm](https://www.infocommshow.org/), [Display Week](https://www.displayweek.org/), [NAB Show](https://www.nabshow.com/) 공식 사이트의 당해 연도 개최일·개최지를 확인하고, 아직 시작하지 않은 일정도 `event_calendar`에 저장한다.
- 매 실행 `event_calendar`의 모든 일정을 현재 KST 날짜와 대조한다. 시작일 7일 전부터 종료일 7일 후 사이면 행사 창을 활성화하고 개최국 언어, 참가사 newsroom, 행사 보도자료, 업체명 없는 제품·플랫폼 검색을 모두 확대한다.
- 시작 30일 이내인 일정은 마지막 공식 확인 후 7일이 지났으면 다시 확인한다. 공식 일정이 바뀌거나 새 대형 TV·디스플레이·미디어 행사가 발견되면 `event_calendar`를 갱신하고 활성 결과를 `active_event_windows`에 기록한다.

## 공통 검색군

각 언어의 아래 용어군을 `제품/플랫폼 명사 × 변화 동사`로 나눠 검색한다. 한 개의 거대한 OR 검색문으로 합치지 않는다.

### 1. TV·인접 화면 제품

- 제품: TV, smart TV, AI TV, smart display, OLED, Mini LED, RGB LED, MicroLED, art TV, transparent TV, streaming device, set-top box, monitor, projector, laser TV, UST projector
- 변화: announce, launch, unveil, release, introduce, debut, enter market, first product, availability, certification, partnership, licensing
- 확인 포인트: 첫 제품, 첫 국가 진출, 새 가격대, 신규 폼팩터, AI/UX 차별화, 유통 독점, OEM·ODM·통신사·호텔 파트너십

### 2. TV 플랫폼·사용 경험

- TV OS, home screen, launcher, search, recommendation, personalization, voice assistant, AI agent, app store, developer, SDK, API, certification, remote, pointer, casting, second screen, accessibility, security, privacy
- FAST, streaming, sports, gaming, cloud gaming, advertising, CTV, shoppable TV, commerce, payment, subscription, identity, profile, parental control, smart home
- 독립 OS 또는 신규 플랫폼이 제조사·통신사·유통사와 맺은 탑재 계약도 직접 TV 후보로 수집

### 3. 신규 진입자·지역 업체

- `new TV brand`, `first smart TV`, `TV market entry`, `regional TV brand`, `operator TV`, `private-label TV`, `retailer TV`, `OEM TV`, `ODM TV`, `TV OS licensing`, `smart TV partnership`의 현지어 조합
- 낯선 업체는 공식 사이트·실제 제품 페이지·공식 파트너 발표 중 하나로 확인하거나, 서로 독립적인 신뢰도 높은 주요·전문·지역 매체 2곳으로 실체와 발표 사실을 교차 확인한다. 후자의 경우 `주요 매체 확인`으로 유지하고 공식 원문을 후속 추적한다.
- 단일 국가 출시라도 첫 진입, 차별적 AI/UX, 공격적 사업모델, 대형 유통·OS·콘텐츠 파트너가 있으면 유지

### 4. 생태계·표준

- TV 영향이 명확한 panel, display engine, TV SoC, NPU, codec, HDR, immersive audio, broadcast, connectivity, content provenance, smart-home 표준
- 추적 시드: BOE, TCL CSOT, HKC, AUO, Innolux, MediaTek, Amlogic, Realtek, HDMI, HbbTV, ATSC, DVB, Matter, C2PA, AOMedia, Wi-Fi Alliance, Bluetooth SIG
- 일반 기업 실적이나 부품 홍보는 제외하되 TV 기능, 원가·공급, 인증, 개발 요건, 출시 가능성을 바꾸면 후보 유지

## 업체·플랫폼 발견 시드

아래 목록은 우선 업체 외 발견을 시작하기 위한 시드이며 매 실행 결과에서 새 업체를 확장한다.

- 지역 TV·화면: Skyworth/Coocaa, Changhong, Konka, Huawei Vision, Haier/Leader, FFALCON/Thunderbird, Vestel, Metz, Loewe, Thomson, REGZA, Vizio, Onn, Lumio, Vu, Telly, Displace, TechniSat
- 독립 TV OS·CTV 플랫폼: Titan OS, Whale TV, Xumo, TiVo OS/Xperi, Coolita, VIDAA, Roku TV, Fire TV Edition, Google TV 파트너
- 프로젝터·홈시네마: XGIMI, JMGO, Dangbei, Formovie, AWOL Vision, Valerion, Nebula, BenQ, Epson, Optoma, Leica Cine
- 사업자·유통 주도 화면: Sky Glass, Comcast/Charter, 통신사 셋톱·TV, 호텔 TV, retailer/private-label TV

### 우선 업체·플랫폼별 최소 검색

- Samsung, LG, Sony, TCL, Hisense, Panasonic, Philips/TP Vision, Sharp, Xiaomi, Amazon Fire TV, Google TV/Android TV, Roku, Apple TV를 각각 독립 검색한다. 여러 업체를 한 개의 `OR` 문으로 묶은 검색은 업체별 완료로 인정하지 않는다.
- 업체마다 최소 두 검색군을 수행한다.
  - 제품군: `[업체명] (TV | OLED | Mini LED | RGB LED | monitor | projector | streaming device) (announce | launch | unveil | release | availability | price)`
  - 플랫폼군: `[업체명] (TV OS | home screen | search | recommendation | developer | SDK | advertising | commerce | gaming | AI) (update | launch | requirement | partnership)`
- 각 업체의 공식 newsroom·제품·개발자 도메인을 직접 확인하거나 동일 검색군의 `site:` fallback을 수행한다. 공식 RSS가 성공했더라도 제한된 entry 수로 오래된 당일 기사가 밀릴 수 있으므로, 권위 구간과 72시간 중첩에 대해 업체별 웹 검색을 생략하지 않는다.
- Bloomberg, Reuters, The Verge, Engadget, 9to5Google 등 우선 매체는 매체별 RSS와 함께 `site:` 검색을 수행한다. 주요 발표가 여러 매체에 동시 게재될 때 하나의 피드 실패나 검색 순위로 후보 전체가 사라지지 않도록 제목·업체·제품군을 교차 확인한다.

### 동적 재추적

- 이전 90일 게시 리포트의 `신규 발표 확인 사항`과 `기타 항목`에서 우선 목록 밖 업체·플랫폼 이름을 추출하며, 미게시 로컬 파일과 실패 실행 산출물은 제외
- 최초 발견 후 30일까지 공식 채널과 업체명 검색을 매일 수행하고, 31~90일은 월요일 7일 스윕에서 수행
- 신뢰 가능한 새 제품·시장·기능·파트너 신호가 확인될 때만 `last_signal_date`를 갱신하고, 업데이트 없는 정기 확인은 `last_checked_kst`만 갱신
- 90일 안에 의미 있는 발표 2건, 복수 국가 진출, 주요 OS·OEM·유통·콘텐츠 제휴 중 하나가 확인되면 handoff의 `permanent` tier로 승격하고 매일 공식 채널·업체명 검색 대상에 포함
- `last_signal_date` 이후 90일 동안 새 신호가 없으면 `watch` tier의 능동 재추적만 종료하되 업체명 없는 공통 검색군에서는 계속 발견 가능. `permanent` tier는 이 규칙으로 만료하지 않음

## 간접 소비자 AI·서비스

업체명 검색과 별도로 아래 역량을 provider-neutral 검색어로 확인한다. 공식 제품·소비자 서비스·기기 파트너 경로가 있고 TV, 거실, 미디어, 스마트홈, 접근성, 광고 또는 커머스로 확장될 개연성이 있으면 후보로 유지한다.

- 공급자 시드: Google/Gemini, Amazon/Alexa, Apple/Siri, Microsoft/Copilot/Xbox, OpenAI, Meta AI, Anthropic, Perplexity, xAI, Baidu, Alibaba/Qwen, ByteDance/Doubao, Tencent, Naver, Kakao
- 미디어·거실 서비스 시드: Netflix, Disney, YouTube, Spotify, TikTok, 주요 지역 스트리밍·FAST·스포츠 서비스와 새 CTV 광고·커머스 플랫폼
- 역량 검색: persistent memory, preferences, multimodal voice/vision, screen understanding, real-time translation, dubbing, image/video generation or editing, summarization, media search, recommendation, multi-step agent, on-device AI, smart-home orchestration, accessibility, family identity, advertising, shopping, payment
- 확장 표면 검색: smart speaker, smart display, phone, wearable, vehicle, browser, streaming service, creator/media tool, device partnership
- TV 경로가 강하면 `간접 서비스`, 약하거나 초기 신호면 `기타 항목`, 소비자·미디어·기기 경로가 없는 enterprise/API/coding/benchmark 전용 발표만 제외

## 현지어 핵심어

각 행에서 제품어, 변화어, 플랫폼·AI어를 별도 조합한다. 공식 기관·업체 도메인의 `site:` 검색과 일반 웹 검색을 함께 사용한다.

| 언어 | 제품어 | 변화어 | 플랫폼·AI·인증어 |
|---|---|---|---|
| 한국어 | `TV`, `스마트 TV`, `AI TV`, `프로젝터`, `셋톱박스` | `발표`, `출시`, `공개`, `진출`, `제휴` | `TV OS`, `홈 화면`, `추천`, `음성 비서`, `AI 에이전트`, `인증`, `시행` |
| 중국어 간체 | `电视`, `智能电视`, `AI电视`, `智慧屏`, `大屏`, `激光电视`, `投影仪`, `机顶盒` | `发布`, `推出`, `上市`, `开售`, `首发`, `新品`, `入局`, `进入`, `合作`, `更新`, `升级` | `电视系统`, `操作系统`, `固件升级`, `投屏`, `推荐`, `语音助手`, `家庭中枢`, `智能体`, `大模型`, `智能化分级`, `认证`, `符合性评价` |
| 일본어 | `テレビ`, `スマートテレビ`, `AIテレビ`, `プロジェクター`, `配信端末` | `発表`, `発売`, `参入`, `提携`, `アップデート` | `テレビOS`, `ホーム画面`, `レコメンド`, `音声アシスタント`, `AIエージェント`, `認証`, `施行` |
| 포르투갈어 | `TV`, `smart TV`, `TV com IA`, `projetor`, `streaming device` | `anuncia`, `lança`, `estreia`, `entra no mercado`, `parceria` | `sistema operacional`, `recomendação`, `assistente de voz`, `agente de IA`, `certificação` |
| 스페인어 | `televisor`, `smart TV`, `TV con IA`, `proyector`, `dispositivo de streaming` | `anuncia`, `lanza`, `debuta`, `entra al mercado`, `alianza` | `sistema operativo`, `recomendación`, `asistente de voz`, `agente de IA`, `certificación` |
| 독일어 | `Fernseher`, `Smart-TV`, `KI-Fernseher`, `Projektor`, `Streaming-Gerät` | `kündigt an`, `startet`, `Markteintritt`, `Partnerschaft` | `TV-Betriebssystem`, `Empfehlung`, `Sprachassistent`, `KI-Agent`, `Zertifizierung` |
| 프랑스어 | `téléviseur`, `TV connectée`, `TV IA`, `projecteur`, `boîtier streaming` | `annonce`, `lance`, `arrivée sur le marché`, `partenariat` | `système TV`, `recommandation`, `assistant vocal`, `agent IA`, `certification` |
| 이탈리아어 | `televisore`, `smart TV`, `TV AI`, `proiettore`, `dispositivo streaming` | `annuncia`, `lancia`, `debutta`, `partnership` | `sistema operativo TV`, `raccomandazione`, `assistente vocale`, `agente AI`, `certificazione` |
| 튀르키예어 | `televizyon`, `akıllı TV`, `yapay zekalı TV`, `projektör` | `duyurdu`, `piyasaya sürdü`, `pazara girdi`, `iş birliği` | `TV işletim sistemi`, `öneri`, `sesli asistan`, `yapay zeka ajanı`, `sertifika` |
| 중국어 번체 | `電視`, `智慧電視`, `AI電視`, `投影機`, `機上盒` | `發表`, `推出`, `上市`, `首發`, `合作` | `電視系統`, `推薦`, `語音助理`, `智慧代理`, `認證`, `符合性評估` |
| 인도네시아어 | `televisi`, `smart TV`, `TV AI`, `proyektor` | `mengumumkan`, `meluncurkan`, `masuk pasar`, `kemitraan` | `sistem operasi TV`, `rekomendasi`, `asisten suara`, `agen AI`, `sertifikasi` |
| 베트남어 | `tivi`, `TV thông minh`, `TV AI`, `máy chiếu` | `công bố`, `ra mắt`, `gia nhập thị trường`, `hợp tác` | `hệ điều hành TV`, `đề xuất`, `trợ lý giọng nói`, `tác nhân AI`, `chứng nhận` |
| 태국어 | `โทรทัศน์`, `สมาร์ททีวี`, `ทีวี AI`, `โปรเจคเตอร์` | `ประกาศ`, `เปิดตัว`, `เข้าสู่ตลาด`, `ร่วมมือ` | `ระบบปฏิบัติการทีวี`, `ระบบแนะนำ`, `ผู้ช่วยเสียง`, `เอเจนต์ AI`, `การรับรอง` |
| 아랍어 | `تلفزيون`, `تلفزيون ذكي`, `تلفزيون بالذكاء الاصطناعي`, `جهاز عرض` | `أعلن`, `أطلق`, `دخول السوق`, `شراكة` | `نظام تشغيل التلفزيون`, `التوصية`, `مساعد صوتي`, `وكيل ذكاء اصطناعي`, `اعتماد` |
| 힌디어 | `टीवी`, `स्मार्ट टीवी`, `एआई टीवी`, `प्रोजेक्टर` | `घोषणा`, `लॉन्च`, `बाजार में प्रवेश`, `साझेदारी` | `टीवी ऑपरेटिंग सिस्टम`, `सिफारिश`, `वॉयस असिस्टेंट`, `एआई एजेंट`, `प्रमाणन` |

## T5 관할별 최소 소스

T5는 중국에 한정하지 않는다. 아래 공식 소스와 현지어 검색어를 최소 확인하고, TV·기기 전용 표준·인증은 `신규 발표 확인 사항`, 광범위한 AI 법률·서비스 규칙은 `AI 규제 동향` 후보로 전달한다.

| 관할 | 최소 공식 소스 | 핵심 검색어 |
|---|---|---|
| EU | [EC AI Act 표준화](https://digital-strategy.ec.europa.eu/en/policies/ai-act-standardisation), [CEN-CENELEC JTC 21](https://www.cencenelec.eu/areas-of-work/cen-cenelec-topics/artificial-intelligence/) | `harmonised standard`, `conformity assessment`, `testing`, `AI Act Article 40`, `product safety`, `smart TV` |
| 미국 | [NIST AI Standards](https://www.nist.gov/artificial-intelligence/ai-standards), [FCC RSS](https://www.fcc.gov/news-events/rss-feeds-and-email-updates-fcc), [FCC IoT Cybersecurity Labeling Order·PS Docket 23-239](https://docs.fcc.gov/public/attachments/FCC-24-26A1.pdf) | `AI standard`, `TEVV`, `conformity`, `certification`, `connected device label`, `smart TV` |
| 한국 | [국가기술표준원](https://www.kats.go.kr/), [e나라표준인증](https://www.standard.go.kr/KSCI/portalindex.do), [TTA](https://www.tta.or.kr/) | `AI 단말`, `스마트 TV`, `지능화 등급`, `국가표준`, `단체표준`, `시험·인증`, `적합성평가` |
| 영국 | [AI Standards Hub](https://aistandardshub.org/), [OPSS](https://www.gov.uk/government/organisations/office-for-product-safety-and-standards/about) | `AI assurance`, `product safety`, `conformity assessment`, `certification`, `consumer connected product`, `smart TV` |
| 중국 | [MIIT](https://www.miit.gov.cn/), [SAMR 국가표준정보공공서비스플랫폼](https://std.samr.gov.cn/), [국가표준전문공개시스템](https://openstd.samr.gov.cn/), [CESI](https://www.cesi.cn/), [CAICT](https://www.caict.ac.cn/) | `人工智能终端`, `电视接收机`, `智能电视`, `智能化分级`, `国家标准`, `行业标准`, `认证`, `检测`, `符合性评价` |
| 글로벌 | [ISO/IEC JTC 1/SC 42](https://www.iso.org/committee/6794475.html), [ISO/CASCO](https://www.iso.org/committee/54998.html), [IEC TC 100 공식 전략계획](https://assets.iec.ch/further_informations/1297/SMB-8443A-SBP-2025.pdf?0423T00=), [C2PA](https://c2pa.org/) 등 관련 표준기관 | `AI conformity assessment`, `AI terminal`, `device certification`, `multimedia system`, `content provenance` |

## 실행 상태 이월

- 발견 시작 전에 `logs/cron/run_*.log`에서 가장 최근의 성공 실행을 찾고, 같은 timestamp의 `last_message_*.txt` 또는 성공 attempt가 붙은 `last_message_*_attempt_*.txt`에 있는 handoff를 읽는다. 성공 실행은 `Finished with exit code 0`, `Coverage handoff validation passed`, 리포트 형식 검증 통과, `Publish completed.` 또는 `No report changes to publish.`가 모두 기록된 경우만 인정한다.
- 자동 실행의 최종 응답은 아래 기계 판독 블록을 포함한다. `attempt_window`는 이번 실행에서 실제 시도한 KST 범위, `last_completed_end_kst`는 해당 버킷이 마지막으로 `PASS`, `NO_UPDATE`, `FALLBACK_PASS`가 된 종료 시각이다. 실패와 `NOT_DUE`에서는 이전 `last_completed_end_kst`를 유지한다.
- 모든 stable ID를 매번 출력한다. 이번 실행에 주기가 오지 않은 버킷은 `NOT_DUE;attempt_window=none`으로 기록하고, 직전 handoff의 `last_completed_end_kst`를 그대로 이월한다.
- 필수 stable ID: `priority_rss_media`, `priority_official`, `emerging_entrants`, `indirect_ai_services`, `lang_en_global`, `lang_ko`, `lang_zh_cn`, `lang_ja`, `lang_mon_in_hi_pt_es`, `lang_wed_de_fr_it_tr`, `lang_fri_zh_tw_id_vi_th_ar`, `ai_tier1_t1_t5`, `ai_tier2_weekly`, `ai_p0_daily`, `ai_p0_full_weekly`, `ai_p1_daily`, `ai_p1_full_weekly`, `ai_p2_signal_daily`, `ai_p2_full_monthly`, `failed_fallbacks`, `event_calendar_monthly`, `event_active_search`.

```text
COVERAGE_HANDOFF_V1
run_end_kst=YYYY-MM-DD HH:mm KST
bucket.<stable_id>=<status>;attempt_window=<range_or_none>;last_completed_end_kst=<timestamp_or_none>
failed_sources=<URL>|<status>|<retry_start_kst>;...
emerging_watch=<name>|<tier>|<first_seen_date>|<last_signal_date>|<last_checked_kst>|<official_url_or_none>|<primary_language>;...
event_calendar=<event>|<start_date>|<end_date>|<official_url>|<last_verified_kst>;...
active_event_windows=<event>|<start_date>|<end_date>|<last_verified_kst>;...
END_COVERAGE_HANDOFF
```

- `<status>`는 `PASS`, `NO_UPDATE`, `FALLBACK_PASS`, `STALE`, `TIMEOUT`, `PARSE_ERROR`, `NOT_RUN`, `NOT_DUE` 중 하나, `<tier>`는 `watch` 또는 `permanent`, `<range_or_none>`은 `YYYY-MM-DD HH:mm KST~YYYY-MM-DD HH:mm KST` 또는 `none`을 사용한다.
- 목록 값이 비어 있으면 생략하지 말고 `failed_sources=none`, `emerging_watch=none`, `event_calendar=none`, `active_event_windows=none`으로 기록한다. 새 handoff는 직전 handoff의 미해결 실패, 유효한 `watch` 항목, 모든 `permanent` 항목, 미래 행사 일정을 병합한 전체 스냅샷이어야 한다.
- `COVERAGE_HANDOFF_V1`, `END_COVERAGE_HANDOFF`, 필수 stable ID 전체 중 하나라도 없거나 같은 ID가 중복되면 자동 작업을 완료 처리하지 않는다. 다음 실행은 그런 handoff를 무효로 보고 안전한 재구성·catch-up 경로를 사용한다.
- 자동 wrapper는 일일 필수 버킷이 `PASS`, `NO_UPDATE`, `FALLBACK_PASS`가 아니거나, 주간·월간 버킷의 최근 예정일 이후 완료 기록이 없으면 게시를 차단한다. 보고서에 공백을 적는 것은 상태 이월에는 필요하지만 필수 발견 작업을 생략한 채 성공 처리하는 근거가 되지 않는다.
- 유효한 handoff가 없으면 이전 90일 게시 리포트에서 emerging watch를 재구성하고, 권위 검색 구간 시작과 현재 직전 14일 중 더 이른 시각부터 예정 스윕을 복구하며, 최신 게시 리포트의 검증 공백에 적힌 실패 소스를 재확인한다.
- handoff는 검색 범위와 재시도 의무를 이월하는 보조 상태다. 게시된 리포트의 기준 시각을 대체하거나 권위 검색 구간을 축소하는 근거로 사용하지 않는다.

## 완료 판정과 기록

실행 로그에 각 범위를 `PASS`, `NO_UPDATE`, `FALLBACK_PASS`, `STALE`, `TIMEOUT`, `PARSE_ERROR`, `NOT_RUN`, `NOT_DUE` 중 하나로 기록한다. `NOT_DUE`는 예정 주기가 아닌 버킷에만 사용하며 확인 완료를 뜻하지 않는다.

| 완료 버킷 | 완료 조건 |
|---|---|
| 우선 RSS·주요 매체 | 시간 범위 내 모든 entry 확인, 실패 feed의 공식 페이지 또는 `site:` 대체 검색 완료 |
| 우선 공식 업체·플랫폼 | 각 업체의 공식 발표/개발자/지원 채널 확인 또는 성공한 대체 검색 기록 |
| 신규 진입자 | 제품, 플랫폼, 시장 진입 검색군을 업체명 없이 수행하고 원문 후보 검증 |
| 간접 AI·서비스 | 공급자 시드와 provider-neutral 역량 검색을 모두 수행 |
| 현지어 | 해당 일자의 모든 언어 그룹을 원문으로 수행, 미실행 예정분은 catch-up 처리 |
| AI 규제 | T1~T5 Tier 1과 P0 매일 확인, P0·P1 공식 원문·버전·변경이력 월요일 전체 검토, 월요일 Tier 2 또는 무공백 이월 스윕, P2 신호 페이지 매일 확인 및 매월 첫 성공 실행의 전체 상태 확인 완료. 실제 이전 snapshot이 없으면 diff 완료로 표기하지 않음 |
| 실패 대체 | 필수 소스별 fallback 성공 또는 보고서의 검증 공백과 다음 실행 이월 기록 |
| 행사 일정 | 매월 첫 성공 실행의 공식 일정 확인과 활성 행사 창 검색 완료 또는 이월 기록 |

- `PASS`, `NO_UPDATE`, `FALLBACK_PASS`만 `확인했으나 업데이트가 없었던 곳`의 확인 근거로 사용
- `STALE`, `TIMEOUT`, `PARSE_ERROR`, `NOT_RUN`은 확인 완료로 표현하지 않고, 중대한 공백이면 보고서에 명시하며 다음 실행에 이월. `NOT_DUE`는 직전 완료 구간을 보존하되 보고서의 확인 근거로 사용하지 않음
- 최종 등급과 섹션 배치는 원문 검증 뒤 수행하며 `기타 항목` 개수 제한을 두지 않음
