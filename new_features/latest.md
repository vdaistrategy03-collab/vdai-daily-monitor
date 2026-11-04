# 일간 TV 모니터링 리포트

- 실행일: 2026-11-05
- 실행 시각: 2026-11-05 07:00 KST
- 실행 방식: 자동(Codex)
- 기준 시각: 2026-11-05 07:00 KST
- 검색 구간: 2026-11-04 07:00 KST ~ 2026-11-05 07:00 KST

## 요약

- Google·민관 파트너의 X.CPE 사전탑재 Android TV 셋톱박스 봇넷 공동 차단, 공급망·사전탑재 앱 검증 중요성 재확인

## 신규 발표 확인 사항

1. **Google: X.CPE 사전탑재 Android TV 셋톱박스 봇넷 공동 차단**
   - 상태: **공식 확인**
   - 발표 시점: 2026-11-02
   - 분류: 규제/인증
   - 내용
     - Google Threat Intelligence Group·일본 경찰청·보안/통신 파트너의 X.CPE 봇넷 차단 공지
     - 판매 전 펌웨어에 삽입된 악성 구성요소가 탑재된 Android TV 셋톱박스 130만 대 이상, 200여 개국 영향으로 발표
     - 원격 명령 실행·화면 캡처·계정/기기 정보 유출·추가 앱 설치 등 분석 결과와 IOC 공개
     - 책임 OEM 및 향후 계열사의 Google 앱 사전탑재 금지, 특정 TV 제조사·모델은 비공개
   - 관련성: 중 (거실 스트리밍 기기 공급망 보안)
   - 중요도: 중 (대규모 사전탑재 악성코드 차단)
   - 인사이트
     - 의미: 이번 사건은 사용자의 설치 행위가 아니라 출하 전 펌웨어·사전탑재 앱 경로가 거실 화면 기기의 원격 제어와 개인정보 노출로 이어질 수 있음을 공식 분석으로 보여준다. Samsung TV 자체가 영향 대상이라는 근거는 없지만, TV·셋톱박스 생태계에서 공급망 심사와 배포 후 이상 징후 탐지가 신뢰 경쟁의 조건이 될 가능성 있음.
     - 참고할 점: 공개 자료는 Android TV 셋톱박스와 X.CPE 패키지의 침해 행위를 다루며 제조사명·모델·유통 채널 및 Samsung 제품 관련성은 밝히지 않는다. 차단은 명령제어서버와 Google 앱 사전탑재 제재를 포함하지만 감염 기기 전량의 정리·소비자 통지 범위는 공개되지 않아, 후속 리콜·패치·파트너 공지를 확인할 필요.
     - 제안: Tizen TV와 연동 기기·외부 스트리밍 장치의 사전탑재 소프트웨어 심사에서 서명 검증, 원격 설치 권한, 화면 캡처·명령 실행 권한, 공급망 SBOM 제출 여부를 같은 기준으로 점검할 것을 제안한다. Google 공개 IOC와 내부 텔레메트리의 교집합, 협력 OEM의 패치·차단 증빙을 수집한 뒤 고위험 공급사 재인증 필요성을 판단.
   - 출처
     - [Google Cloud Threat Intelligence: X.CPE 봇넷 차단](https://cloud.google.com/blog/topics/threat-intelligence/shutting-the-door-on-the-xcpe-botnet/)
     - [Trend Micro 보도자료: 공동 차단 및 영향 범위](https://newsroom.trendmicro.com/2026-11-02-Industry-Takedown-of-Botnet-Hidden-in-More-Than-1-3-Million-TV-Set-Top-Boxes-across-200-Countries)

## 간접 서비스

해당 없음

## AI 규제 동향

해당 없음

## 기타 항목

해당 없음

## 확인했으나 업데이트가 없었던 곳

- Samsung, LG, Sony, TCL, Hisense, Panasonic, Philips/TP Vision, Sharp, Xiaomi, Amazon Fire TV, Google TV/Android TV, Roku, Apple TV를 각각 제품·TV OS/개발자·보안/프라이버시 검색과 공식 또는 `site:` 대체 경로로 확인. X.CPE 외 권위 구간 및 72시간 발견 중첩에서 신규 적격 직접 TV·모니터·프로젝터 변화 없음.
- AppleInsider RSS 및 TV·보안·프라이버시 `site:` 검색, Reuters·Bloomberg·The Verge·Engadget·9to5Google의 RSS와 매체별 검색을 병행. 2026-10-22 보고서에 수록한 Northeastern ACR 연구의 11월 4일 재보도는 새로운 원조사·대상·실험 조건·제조사 답변을 더하지 않아 중복 제외.
- 업체명 없는 TV·디스플레이·프로젝터·OS·OEM/ODM·시장진입 검색과 AWOL Vision, Aurzen, XGIMI, SKYWORTH, CHiQ, Mediasmart, CloudTV 재확인에서 X.CPE 외 수록 기준 충족 신호 없음.
- 영어·한국어·중국어·일본어 일일 검색, 수요일 독일어·프랑스어·이탈리아어·튀르키예어 7일 스윕, 중국 CAC·MIIT·SAMR·국가표준/전문공개·CESI·CAICT 대체 경로를 확인. EU·미국·한국·영국·중국 Tier 1의 T1~T5 및 P0/P1/P2 일일 상태에서 Samsung TV AI 서비스와 구체적으로 연결되는 신규 법령·집행·TV 표준/인증 상태 변화 없음.

## 불확실성 및 검증 공백

- FCC RSS, CAICT, Apple Newsroom RSS, VentureBeat RSS, ZDNet TV RSS, Cord Cutters News RSS, Apple Developer News, Reuters Technology, Bloomberg Technology, FTC 보도자료 RSS의 원래 접근 장애는 사이트·공식 페이지 또는 매체 검색으로 대체 확인했으나 원래 URL 복구는 확인하지 못해 다음 실행으로 이월.
