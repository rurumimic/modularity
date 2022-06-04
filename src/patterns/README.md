# Patterns

- 레벨: 디자인, 아키텍처
- 관점: 장기적
- 개선: 유지 보수성, 유연성, 재사용성

## 모듈 바운더리

- Research by David Lorge. Parnas
  - On the Criteria to be Used in Decomposing Systems into Modules

> "모듈화"의 효과는 시스템을 모듈로 나눌 때 어떤 기준을 적용하는가에 달려있다.

### 트레이드 오프

- **이해도**: 사전 지식 없이 바로 파악해야 한다. 가이드 역할
- **변경 용이성**: 변경될 가능성이 있는 로직을 캡슐화한다.
- **재사용성**: 모듈은 최대한 작게, 독립적으로
  - _유닉스 철학_: 한 가지 일만 잘하는
  - _의존성 최소화_: 전이 의존성 부담 ↓
- **팀워크**: 명확한 작업 영역 구분

## Lean 모듈

### 모듈 크기 측정

- public 영역의 크기: 단순화, 최소화
  1.  이해하기 쉽다.
  2.  관리자 책임이 줄어든다.
- 내부 구현 영역의 크기: 독립적, 의존성 ↓

## API 모듈

### 안정적인 API 디자인

- 단일 모듈
  - 하나의 인터페이스 제공
  - ServiceLoader를 통한 공개
- 다양한 구현
  - Default 구현과 함께 제공
- 독립적인 인터페이스 설계
  - 타입: java.base가 제공/ 같은 모듈이 제공
  - 제공: type, exception, extned, enum, annotation 등
- 혹은 묵시적 가독성

### 묵시적 가독성

[implied readability](implied_readability/README.md)

`client` - - > `repository.api` - - > `domain.api`

- `requires transitive`
- `javac -Xlint`
- `Custom Type Interface`
