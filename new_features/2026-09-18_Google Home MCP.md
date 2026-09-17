# 일간 TV 모니터링 리포트

- 실행일: 2026-09-18
- 실행 시각: 2026-09-18 07:00 KST
- 실행 방식: 자동(Codex)
- 기준 시각: 2026-09-18 07:00 KST
- 검색 구간: 2026-09-17 08:10 KST ~ 2026-09-18 07:00 KST

## 요약

- Google Home MCP 조기접근 개시, 외부 AI 에이전트의 스마트홈 기기·이력 접근 및 제어 경로 형성
- EU 미성년자 온라인 보호 규정안 공개, AI 동반자·대화형 챗봇의 아동 안전·평가·사후 모니터링 의무 제안

## 신규 발표 확인 사항

해당 없음

## 간접 서비스

1. **Google Home: 외부 AI 에이전트용 Home MCP 조기접근 개시**
   - 상태: **공식 확인**
   - 발표 시점: 2026-09-16
   - 분류: 스마트홈/에이전트
   - TV 관련 이유: 거실 화면·음성 AI가 스마트홈의 상태·이력·실행 권한을 표준 도구로 호출하는 상호작용 모델로, TV를 홈 제어 허브로 확장하는 경쟁 경로
   - 내용
     - Home API MCP 서버가 주택·기기 목록, 현재 상태, 기기 이력 조회와 기기 동작 실행 도구를 제공
     - 외부 MCP 호환 AI 에이전트가 Google Home 생태계 및 Matter 연동 기기에 자연어로 접근하는 조기접근 제공
     - 초기 대상은 미국 Google Home Premium Advanced 가입자이며, Google Cloud 프로젝트·인증 설정이 필요
   - 관련성: 상 (스마트홈 제어·에이전트 UX 직접 경쟁)
   - 중요도: 중 (미국 유료 조기접근·확장성 미정)
   - 인사이트
     - 의미: 개별 음성 명령 중심의 홈 제어가 외부 AI 에이전트가 호출 가능한 표준 도구·이력 기반 오케스트레이션으로 이동하는 신호
     - 참고할 점: 실제 권한 세분화, 민감 기기 제어 제한, Matter 기기별 실행 범위와 미국 외 확대 여부를 확인할 필요
     - 제안: SmartThings·Tizen에서 TV 화면을 포함한 홈 상태 조회·실행 권한을 에이전트 단위로 분리하고, 이력 접근·명령 승인 UX를 MCP 생태계와 비교 설계할 필요
   - 출처
     - [Google Home Developers: MCP Reference](https://developers.home.google.com/reference/home/mcp)
     - [TechCrunch: Google Home MCP 조기접근 보도](https://techcrunch.com/2026/09/16/your-ai-agents-can-now-control-your-google-home-devices/)

## AI 규제 동향

1. **EU: 미성년자 온라인 보호 규정안의 AI 동반자·대화형 챗봇 의무 제안**
   - 상태: **공식 확인**
   - 관할: EU
   - 진행 단계: 입법예고
   - 시행/적용 시점: 미정
   - 영향 범주: 에이전트/OS, 데이터/프라이버시, 안전·보안·책임, 접근성·아동, 플랫폼·상호운용
   - 내용
     - 유럽연합 집행위원회 규정안은 미성년자가 접근 가능한 AI 동반자와 범용 대화형 챗봇에 아동 건강·안전·기본권 보호 조치를 제안
     - 시장 출시 전 및 정기적 시험·평가, 사후 모니터링과 위험 완화 조치를 제시
     - 온라인 플랫폼·동영상 공유·게임·앱 스토어와 AI 시스템을 함께 대상으로 삼아 연령보증 및 기본 안전·프라이버시 설계를 보완
   - 관련성: 중 (TV AI 대화·아동 계정 설계 영향)
   - 중요도: 중 (EU 규정안 단계·향후 의무 기준 신호)
   - 인사이트
     - 의미: TV의 대화형 AI·콘텐츠 질의 기능이 아동 모드와 결합될 경우, 단순 콘텐츠 등급을 넘어 모델 시험·사후 위험 관리까지 요구될 수 있는 방향
     - 참고할 점: 최종 적용 대상에 TV OS 또는 TV 내 AI 기능이 포함되는지, 연령보증·부모 책임 조항의 입법 수정 여부를 추적할 필요
     - 제안: EU 판매 TV의 AI 대화 기능에 아동 계정 분리, 기본 안전 설정, 위험 평가 증적 및 사건 모니터링 체계를 선제적으로 매핑할 필요
   - 출처
     - [EUR-Lex: COM(2026) 681 규정안](https://eur-lex.europa.eu/legal-content/EN/TXT/PDF/?uri=COM%3A2026%3A681%3AFIN)
     - [European Commission: AI Act 집행 체계](https://digital-strategy.ec.europa.eu/en/policies/enforcement-ai-act)

## 기타 항목

해당 없음

## 확인했으나 업데이트가 없었던 곳

- **우선 TV 업체·플랫폼 및 주요 매체**
  - Samsung, LG, Sony, TCL, Hisense, Panasonic, Philips/TP Vision, Sharp, Xiaomi, Amazon Fire TV, Google TV/Android TV, Roku, Apple TV의 제품·플랫폼·보안/프라이버시 개별 공식·`site:` 대체 검색 완료; 권위 구간과 72시간 중첩에서 신규 직접 TV·모니터·프로젝터 적격 사건 미확인
  - Reuters, Bloomberg, The Verge, Engadget, 9to5Google, AppleInsider의 RSS·공개 페이지·매체별 검색 병행; 기존 IFA·IBC 사건은 중복 미산입
  - 출처
    - [Samsung Newsroom](https://news.samsung.com/global/)
    - [Roku Blog](https://blog.roku.com/)
    - [AppleInsider](https://appleinsider.com/)

- **신규 진입자·현지어·IBC 2026 활성 행사 창**
  - 업체명 없는 TV/디스플레이·TV OS·OEM/유통·스트리밍 기기 검색, AWOL Vision·Aurzen·XGIMI·SKYWORTH·CHiQ 재추적 및 영어·한국어·중국어 간체·일본어·중국어 번체·인도네시아어·베트남어·태국어·아랍어 원문 검색 완료; 적격 신규 사건 미확인
  - IBC 2026 활성 행사 창(9월 11~14일) 참가사 원문·업체명 없는 검색 완료; 기존 리포트 반영 사건 외 직접 TV 경쟁력 변경 미확인
  - 출처
    - [IBC 2026 Content Programme](https://show.ibc.org/ibc-content-programme)
    - [XGIMI Newsroom](https://us.xgimi.com/blogs/news)

- **AI 규제 Tier 1 점검**
  - EU·미국·한국·영국·중국의 T1~T5, P0·P1 뉴스·상태·색인과 P2 상태 신호 확인 완료; EU 규정안 외 Samsung TV AI 서비스에 연결되는 신규 법령·집행·TV 전용 인증 변화 미확인
  - CAC·MIIT·SAMR·국가표준 플랫폼·OpenSTD·CESI·CAICT 대조에서 중국 TV·AI 단말의 신규 시행·승인·의견수렴 인증 변화 미확인
  - 출처
    - [EU AI 규제 체계](https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai)
    - [FTC 보도자료](https://www.ftc.gov/news-events/news/press-releases)
    - [한국 법령정보센터 AI 기본법](https://www.law.go.kr/LSW/lsInfoP.do?ancYnChk=&chrClsCd=010202&efYd=20260122&lsiSeq=282791&urlMode=lsInfoP)
    - [중국 MIIT 전자정보](https://www.miit.gov.cn/gyhxxhb/jgsj/dzxxsnew/index.html)

## 불확실성 및 검증 공백

- Apple Newsroom RSS·Apple Developer News 시간 초과, VentureBeat RSS 429, ZDNet RSS 3종 연결 종료, Cord Cutters News RSS 403, Reuters 직접 페이지 401, FCC RSS 403, CAICT 직접 페이지 412 상태 지속. 공식 페이지·매체별 `site:` 검색 및 중국 기관 대체 경로로 보완했으나 RSS·직접 페이지 재시도 필요
