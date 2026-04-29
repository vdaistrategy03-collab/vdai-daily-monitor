# Daily TV Monitor Instructions

## Mission

Produce a daily Korean report about meaningful TV software/hardware announcements, with strategic analysis for Samsung TV competitiveness.

## Working Rules

- Write all report content in Korean.
- Reuse prior reports to avoid duplicate coverage.
- Focus first on official sources and major media, then expand to regional coverage if time allows.
- Exclude rumors and leaks unless they are clearly labeled as unconfirmed and come from highly credible outlets.
- Do not add one combined source list. Put `출처` links under each item.
- Every confirmed direct TV item and every included indirect Google/Amazon item must include:
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

## Output Files

Update both:

- `new_features/YYYY-MM-DD.md`
- `new_features/latest.md`

Use the title `일간 TV 모니터링 리포트`.

## Report Format Contract

All reports must use this exact section order and field naming. Keep section names stable across days.

```md
# 일간 TV 모니터링 리포트

- 실행일: YYYY-MM-DD
- 실행 시각: YYYY-MM-DD HH:mm KST
- 실행 방식: 자동(Codex)
- 기준 시각: YYYY-MM-DD HH:mm KST
- 검색 구간: YYYY-MM-DD HH:mm KST ~ YYYY-MM-DD HH:mm KST

## 요약

[검색 결과와 전략적 함의를 1~3문단으로 요약]

## 신규 발표 확인 사항

1. **[업체/플랫폼: 발표 제목]**
   - 상태: **공식 확인** | **주요 매체 확인** | **미확인**
   - 발표 시점: YYYY-MM-DD
   - 분류: 소프트웨어 | 하드웨어 | 플랫폼 | 콘텐츠 | 커머스 | 스마트홈 | 규제/인증 | 기타
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
   - 상태: **공식 확인** | **주요 매체 확인** | **미확인**
   - 발표 시점: YYYY-MM-DD
   - 분류: 소프트웨어 | 하드웨어 | 플랫폼 | 콘텐츠 | 커머스 | 스마트홈 | 기타
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

## Suggested Run Flow

1. Read the newest files under `new_features/` to avoid duplicate coverage.
2. Identify the **latest report execution time** from the newest report and set search window from that timestamp to now.
   - Do **not** use a fixed 24-hour window.
   - This is to backfill possible misses when a prior run had partial search failures.
3. Investigate direct TV announcements and relevant indirect Google/Amazon items within that dynamic window.
4. Write the report in Korean with explicit source attribution per item.
5. If there are no qualifying items, write `해당 없음` only under `신규 발표 확인 사항`.
6. Stop after updating the local markdown files.
7. Do not commit or push from this repository. Git operations are handled by a separate local process outside this run.
