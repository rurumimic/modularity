# Maven, OSGi

- JVM, Java 기반 동작
- 하지만, 제어는 하지 않음

## Maven: 컴파일 타임

- Wiki: [Apache Maven](https://en.wikipedia.org/wiki/Apache_Maven)
- [Apache Maven](https://maven.apache.org/)

a software project management and comprehension tool.

- POM: a project object model
   - JAR 간의 의존성을 POM 파일에 정의
   - 컴파일 시점의 의존성 관리 문제 해결
- from a central piece of information
   - Maven Central 공식 저장소 제공

## OSGi: 런타임

- Wiki: [OSGi](https://en.wikipedia.org/wiki/OSGi)

Open Services Gateway initiative:  
OSGi is a Java framework for developing and deploying modular software programs and libraries.  
Each bundle is a tightly coupled, dynamically loadable collection of classes, jars, and configuration files that explicitly declare their external dependencies (if any).

- 번들: import된 패키지를 JAR에 메타데이터로 나열한다.
   - 번들 외부 노출 패키지: 명시적으로 정의
- 애플리케이션 실행 시점 검사
  - 대상: 모든 번들
  - import된 모든 번들을 외부에 노출해야 하는 번들과 연결할 수 있는지 검사
- Maven을 사용하는 곳에서는 OSGi 지원이 부족함
