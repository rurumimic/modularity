# EasyText Filtering

### 캡슐화 vs java.lang.Class

- 구현 클래스에 대해 java.lang.Class 표현을 얻을 수 있음.
- 하지만, 패키지는 exports 되지 않았다.
- 구현 클래스에 대해 설명하지만, 그 이상의 기능은 제공하지 않는다.
- 리플렉션 `provider.type().newInstance()`를 사용하면, `IllegalAccessException`이 발생한다.
- 따라서, Class 객체를 가져도 반드시 모듈에서 인스턴스화 할 수 있는 것은 아니다.

```bash
java.lang.IllegalAccessException: 
class foo.easytext.filtering.Main (in module easytext.filtering) 
    cannot access class foo.easytext.analysis.coleman.Coleman (in module easytext.analysis.coleman) 
    because module easytext.analysis.coleman does not export foo.easytext.analysis.coleman 
    to module easytext.filtering
```


### Provider

```java
import foo.easytext.analysis.api.Fast;

@Fast
public class Coleman implements Analyzer {
}
```

### Consumer

- `provider.type()` → `java.lang.Class` → `Class<?> clazz`

```java
public class Main {
    public static void main(String args[]) {
        ServiceLoader<Analyzer> analyzers = ServiceLoader.load(Analyzer.class);

        analyzers.stream()
            .filter(provider -> isFast(provider.type()))
            .map(ServiceLoader.Provider::get)
            .forEach(analyzer -> System.out.println(analyzer.getName()));
    }

    private static boolean isFast(Class<?> clazz) {
        return clazz.isAnnotationPresent(Fast.class)
            && clazz.getAnnotation(Fast.class).value() == true;

    }
}
```
