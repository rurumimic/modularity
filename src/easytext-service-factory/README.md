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
