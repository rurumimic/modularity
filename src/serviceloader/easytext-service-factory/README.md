# EasyText Service Factory

### Interface Static Method: Java 8+

```java
module easytext.analysis.api {
    exports foo.easytext.analysis.api;
    uses foo.easytext.analysis.api.Analyzer;
}
```

```java
public interface Analyzer {
    String getName();
    double analyze(List<List<String>> text);

    static Iterable<Analyzer> getAnalyzers() {
        return ServiceLoader.load(Analyzer.class);
    }
}
```

### Consumer

```java
module easytext.cli {
    requires easytext.analysis.api;
}
```

```java
import foo.easytext.analysis.api.Analyzer;

public class Main {
    public static void main(String... args) throws IOException {
        Iterable<Analyzer> analyzers = Analyzer.getAnalyzers();
        for (Analyzer analyzer: analyzers) {
            analyzer.getName();
            analyzer.analyze(sentences);
        }
    }
}
```

## Image

```bash
image/bin/java --list-modules

easytext.analysis.api
easytext.analysis.coleman
easytext.analysis.kincaid
easytext.cli
easytext.gui
java.base@9.0.4
java.datatransfer@9.0.4
java.desktop@9.0.4
java.prefs@9.0.4
java.xml@9.0.4
javafx.base@9.0.4
javafx.controls@9.0.4
javafx.graphics@9.0.4
jdk.jsobject@9.0.4
```
