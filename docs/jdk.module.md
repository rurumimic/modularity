# JDK Module

## Java 8 Compact Profiles

- compact1: Java Core, Logging, Scripting API
- compact2: compact1 + XML, JDBC, RMI API
- compact3: compact2 + 보안, 관리 API

## JDK Platform Module's subsets

관찰 가능한 모듈을 나열하고 종료합니다:

```bash
java --list-modules | wc -l

97
```

- 순환 의존성 금지: 컴파일 시점에서 탐지
- 집합 aggregator 모듈: `java.se`, `java.se.ee`
- 인큐베이터 모듈: `jdk.incubator.*`. 실험용 API

## Module Descriptor

`module-info.java`

```java
module java.prefs {
  requires java.xml;
  exports java.util.prefs;
}
```

- `requires`가 가리키는 모듈에 의존성이 있다.
  - `java.base` 묵시적 선언
- `exports`가 가리키는 패키지를 노출한다.
- 모듈은 전역 네임 스페이스에 있다: 고유한 모듈 이름 사용
- 역방향 DNS 표기법: `com.company.project.some`

## Readability

- 가독성이 있다: 특정 모듈을 읽어온다.
- `exports`한 패키지 타입에 접근 가능하다.
- `requires`에 없는 모듈의 패키지를 사용할 때, 컴파일 에러 발생

### 가독성 전이

- `requires`는 전이되지 않는다.
- `requires transitive`: 묵시적 가독성 표현. 전이 가능.

```java
module java.sql {
  requires transitive java.logging;
  requires transitive java.xml;

  exports java.sql;
  exports javax.sql;
  exports javax.transaction.xa;
}
```

`java.sql` 모듈을 읽는 경우, 자동으로 `java.logging`, `java.xml`도 읽어온다.

### 집합 aggregator 모듈

```java
module java.se {
  requires transitive java.desktop;
  requires transitive java.sql;
  requires transitive java.xml;
  // ...
}

module java.se.ee {
  requires transitive java.se;
  requires transitive java.xml.xs;
  requires transitive java.xml.bind;
  // ...
}
```

## 접근성

- 캡슐화 = 접근성 + 가독성

| 접근 제한자 | 클래스 | 패키지 | 하위 클래스 | 제한없음 |
| ----------- | ------ | ------ | ----------- | -------- |
| public      | O      | O      | O           | O        |
| protected   | O      | O      | O           |          |
| (default)   | O      | O      |             |          |
| private     | O      |        |             |          |

질문:

1. 모듈 M1이 모듈 M2를 읽을 수 있는가?
2. 읽을 수 있다면 모듈 M2에서 export된 패키지에는 접근 가능한 타입(public)이 있는가?

## 제한적인 익스포트 Qualified exports

- 일반 애플리케이션에서는 사용 자제
  - 모듈과 Consumer 간의 긴밀한 연결 관계 형성
  - Consumer의 이름이 module descriptor에 포함된다.
- JDK 모듈화에서 사용: 코드 복제 방지

```java
module java.xml {
  exports com.sun.xml.internal.stream.writers to java.xml.ws
}
```

- `java.xml.ws`만 내부 패키지 사용 가능

## 모듈 해석 resolution과 모듈 패스

- 모듈 해석: 의존성 그래프를 이용하여 선택한 루트 모듈이 필요로 하는 최소한의 모듈 세트를 찾는 프로세스
  - 해석된 모듈 세트: 루트 모듈에서 연결할 수 있는 모든 모듈
  - 의존성 그래프에서 전이 폐쇄를 계산하는 것
    - 전이 폐쇄 transitive closure: 집합 X에서 R에 대한 전이 폐쇄는 R을 포함하고 있는 가장 작은 X의 부분 집합
- 추가 검사
  - 같은 이름 가진 모듈 존재하는 경우: 애플리케이션 시작할 때 에러
  - 익스포트된 패키지의 고유성 검사: 모듈 패스 안에서 익스포트 패키지 이름 이름 중복 검사

### 해석 프로세스

1. 단일 루트 모듈로 시작하여 루트 모듈을 해석(resolve) 세트에 추가한다.
2. `module-info.java`에 `requires/requires transitive` 구문으로 선언된 모듈들을 해석 세트에 추가한다.
3. 2단계에서 해석 세트에 추가된 모듈에 대해 2단계를 반복한다.

## Unnamed Module

- 이름 없는 모듈: module descriptor 없이 실행하는 경우
  - 모든 모듈을 읽어올 수 있다.
  - 이름 없는 모듈에서는 캡슐화된 타입 사용하여 컴파일 불가능
    - 이전 버전의 Java에서 컴파일된 코드는 클래스 패스에서 실행할 수 있다.
- 클래스 패스에 추가한 코드도 이름 없는 모듈
- `java.se`는 루트 모듈에 포함된다.
