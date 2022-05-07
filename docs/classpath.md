# Classpath

- Semipublic API: public이지만 internal 클래스
- JAR에는 의존성에 대한 정보가 없다.

```bash
java -classpath lib/guava-19.0.jar:\
                lib/hivernate-validator-5.3.1.jar:\
                lib/jboss-logging-3.3.0Final.jar:\
                lib/classmate-1.3.1.jar:\
                lib/validation-api-1.1.0.Final.jar \
     -jar MyApplication.jar
```

- 클래스 패스를 사용자가 직접 지정해야 한다.
- 클래스 패스: Java 런타임에서 클래스를 찾기 위해 사용한다.
- Main 클래스에서 직접/간접 참조하는 모든 클래스 로딩.

```bash
java.lang.Object
java.lang.String
...
sun.misc.BASE64Encoder # rt.jar
sun.misc.Unsafe
...
javax.crypto.Cypher
javax.crypto.SecretKey
...
com.myapp.Main
...
com..google.common.base.Joiner
...
```

- 클래스 리스트에는 JAR 또는 **논리적 그룹화에 대한 개념**이 들어가 있지 않다.
- `-classpath` 옵션에 의해 **정의된 순서대로** 나열된다.
- JVM이 클래스를 로드하려고 할 때 클래스 패스를 **순차적으로** 체크한다.
- 클래스가 발견되면 검색을 중지하고 클래스를 로딩한다.
- 클래스 패스에서 **클래스를 찾을 수 없을 때**, 런타임 오류 발생
- 클래스 지연 로딩: **런타임 도중 로딩**될 수 있음
- 중복 클래스 (동일한 라이브러리의 두 가지 버전) 있는 경우,
  - **처음 설정된 버전으로 로드**
  - 로딩되지 않은 버전에 의존성이 있는 경우, 런타임 오류
