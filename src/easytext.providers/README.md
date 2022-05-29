# EasyText Provider Method

### Provider Method

```java
module provider.method.example {
    requires easytext.analysis.api;

    provides foo.easytext.analysis.api.Analyzer
        with foo.providers.method.ExampleProviderMethod;
}
```

```java
public class ExampleProviderMethod implements Analyzer {
    ExampleProviderMethod(String name) {
        this.name = name;
    }
    
    public static ExampleProviderMethod provider() {
        return new ExampleProviderMethod("Analyzer created by static method");
    }
}
```

### Provider Factory

```java
module provider.factory.example {
    requires easytext.analysis.api;

    provides foo.easytext.analysis.api.Analyzer
        with foo.providers.factory.ExampleProviderFactory;
}
```

```java
public class ExampleProviderFactory {
    public static ExampleProvider provider() {
        return new ExampleProvider("Analyzer created by factory");
    }
}
```

```java
class ExampleProvider implements Analyzer {
    public ExampleProvider(String name) {
        this.name = name;
    }
}
```
