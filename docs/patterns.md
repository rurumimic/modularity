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

[implied readability](../src/patterns/implied_readability/README.md)

`client` - - > `repository.api` - - > `domain.api`

- `requires transitive`
- `javac -Xlint`
- `Custom Type Interface`

### Default 구현 제공 모듈

- 장점: 하나의 구현만 존재할 경우
- 단점: 확장성 ↓
  - Default 구현이 어떤 모듈을 의존하는 경우
  - 새로운 구현 모듈에도 전이 의존성이 발생할 수 있음
  - 의존하는 모듈을 모듈 패스에 포함해야 한다.

## 집합 모듈, aggregator

### Facade 패턴

- super-module: 개별 모듈 모음집
- **aggregator module**: 묵시적 가독성 사용
  - `module-info.java` 파일만 존재: 가볍다.
  - 특정 사용자에게 여러 프로파일, 라이브러리 배포판 제공
  - 예: `java.se`, `java.se.ee`
  - 위험: 모든 export 타입에 접근 가능함
    - 모듈 시스템 경고 사라짐
    - **필요한 기본 모듈에 대한 정확한 의존성 지정해야 함.**

```java
module library {
    requires transitive library.one;
    requires transitive library.two;
    requires transitive library.three;
}
```

#### 계층적 집합 패턴

`java.se.ee` → `java.se`

```bash
java --describe-module java.se.ee

java.se.ee@9.0.4
requires java.se transitive
requires java.xml.ws.annotation transitive
requires java.xml.ws transitive
requires java.activation transitive
requires java.transaction transitive
requires java.corba transitive
requires java.base mandated
requires java.xml.bind transitive
```

### 모듈 분리

- 단일 모듈 → 분리 + 확장
  1.  순수한 집합 모듈 + 하위 캡슐 모듈 1, 2 ...
  2.  집합 모듈 + 코어 모듈

집합 모듈 + 코어 모듈

```java
module largelibrary {
    exports largelibrary.part2;
    requires transitive largelibrary.core;
}
```

## 순환 의존성

### 분할 패키지 문제점

```java
module module.one {
    exports splitpackage;
}

module module.two {
    exports splitpackage;
}
```

- **자바 패키지 = 비계층적**
- 하나의 모듈만 패키지 export 가능
  - 모듈 패스에 패키지 export를 하는 모듈이 두 개 이상일 때 JVM 오류 발생
    - 이름이 같은 클래스 충돌 방지
  - `exports 패키지.이름`
- 클래스 패스: 클래스가 중복될 때 하나만 로드
- 모듈 패스: 클래스가 중복될 경우 충돌 발생

해결책: 패키지를 생성하지 않는다.

### 순환 의존성 제거

[cycle](../src/patterns/cycle)

```java
module authors {
    requires books;
}

module books {
    exports books;
}
```

- 기본 전제: 순환 의존성은 Java 모듈화에 좋지 않다.
- 재설계 필요
- **인터페이스**: 순환 의존성 제거 역할
  - **Dependecy inversion**: 의존관계 역전 패턴
- SonarQube 도구 사용

## 선택적 의존성

- 명시적 의존성 그래프: 모둘형 애플리케이션 특성
- 모듈 디스크럽터: 선택적 의존성 표현 불가
  - 선택적 의존성: 클래스 패스에 추가된 JAR가 있고 애플리케이션이 사용하면 클래스를 사용한다.
- 해결 방법
  - 컴파일 시점 의존성
  - 서비스를 이용한 선택적 의존성 구현

### 컴파일 시점 의존성

[Optional Dependency](../src/patterns/optional/README.md)

```java
module framework {
  requries static fastjsonlib;
}
```

- 컴파일러: fastjsonlib 모듈이 없어도 성공
- 런타임: FastJson이 없으므로 런타임 에러

컴파일 시점 의존성을 나타내는 모듈은 책임을 져야 한다.

#### 문제점

- 방어 코드를 추가해야 함
- 지연 로딩: 클래스 로드 오류 위험
- 경고: 클래스의 정적 초기화 블록

단일 최상위 클래스의 인스턴스 생성시 선택적 의존성 방어코드 사용

### 컴파일 시점 전용 어노테이션

[Optional Dependency: Annotations](../src/patterns/optional_annotations/README.md)

- 클래스 어노테이션 역할
  - 컴파일 시점
    - 정적 분석: `@Nullable`, `@NonNull` 검사
    - 코드 생성을 위한 타입 표시
  - 런타임 시점에 없을 때
    - JVM 성능 저하
    - 클래스 로드 예외 발생 안 함
- 컴파일 시점 의존성과 달리, 어노테이션은 방어 코드가 필요 없다.
- JVM이 클래스로딩과 어노테이션에 대한 리플렉션 접근을 하는 시점에 처리하기 때문.

### transitive + static

방어코드 전파 필요

```java
module questionable {
    exports questionable.api;
    requires transitive static fastjsonlib;
}
```

- 같이 사용하지 않는 것이 좋음
- API 사용자가 방어 코드를 추가해야 함
- 활용: 레거시 코드의 모듈화

### 서비스를 이용한 선택적 의존성 구현

[Optional Dependency: Service](../src/patterns/optional_service/README.md)

```java
module framework {
    requries static fastjsonlib;
    uses fastjsonlib.FastJson;
}

module fastjsonlib {
  exports fastjsonlib;
  provides fastjsonlib.FastJson
      with fastjsonlib.FastJson;
}
```

```java
FastJson fastJson = ServiceLoader.load(FastJson.class)
                                 .findFirst()
                                 .orElse(getFallBack());
```
