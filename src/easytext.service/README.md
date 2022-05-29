# EasyText Service

- easytext.analysis.kincaid → **provides** Analyzer → Module system
- easytext.analysis.coleman → **provides** Analyzer → Module system
- easytext.cli → **uses** Analyzer → Module system

## CLI & Options

```bash
javac --help

-d <directory>                               Specify where to place generated class files
--module-source-path <module-source-path>    Specify where to find input source files for multiple modules
--module <module-name>, -m <module-name>     Compile only the specified module, check timestamps
```

```bash
jar --help

-c, --create                  아카이브를 생성합니다.
-f, --file=FILE               아카이브 파일 이름입니다. 생략할 경우 작업에 따라 stdin 또는 stdout이 사용됩니다.
-e, --main-class=CLASSNAME    모듈형 또는 실행형 jar 아카이브에 번들로 제공된 독립형 애플리케이션의 애플리케이션 시작 지점입니다.
-C DIR                        지정된 디렉토리로 변경하고 다음 파일을 포함합니다.
```

## Code

### module-info.java

#### cli.module-info

```java
module easytext.cli {
    requires easytext.analysis.api;
    uses foo.easytext.analysis.api.Analyzer;
}
```

#### kincaid.module-info

```java
module easytext.analysis.kincaid {
    requires easytext.analysis.api;
    provides foo.easytext.analysis.api.Analyzer
        with foo.easytext.analysis.kincaid.FleschKincaid;
}
```

#### api.module-info

```java
module easytext.analysis.api {
    exports foo.easytext.analysis.api;
}
```

### ServiceLoader

#### cli.Main

```java
import java.util.ServiceLoader;

import foo.easytext.analysis.api.Analyzer;

public class Main {
    List<List<String>> sentences;

    public static void main(String... args) {
        Iterable<Analyzer> analyzers = ServiceLoader.load(Analyzer.class);

        for (Analyzer analyzer: analyzers) {
            analyzer.getName();
            analyzer.analyze(sentences);
        }
        
        analyzers.reload(); // hashCode updated
    }
}
```

- ServiceLoader = lazy loading
- 반복문: Analyzer 구현 클래스 → 인스턴스화
- Provider 클래스의 인스턴스를 캐싱

## Service Provider Method



