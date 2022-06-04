# Optional Dependency

```java
module framework {
    requires static fastjsonlib;
}
```

## NoClassDefFoundError

```bash
javac -d out \
      --module-source-path src \
      -m framework

java -p out -m framework/framework.MainBad
```

```bash
Exception in thread "main" java.lang.NoClassDefFoundError: fastjsonlib/FastJson
	at framework/framework.MainBad.main(MainBad.java:7)
Caused by: java.lang.ClassNotFoundException: fastjsonlib.FastJson
	at java.base/jdk.internal.loader.BuiltinClassLoader.loadClass(BuiltinClassLoader.java:582)
	at java.base/jdk.internal.loader.ClassLoaders$AppClassLoader.loadClass(ClassLoaders.java:185)
	at java.base/java.lang.ClassLoader.loadClass(ClassLoader.java:496)
	... 1 more
```

## Optional

```java
import fastjsonlib.FastJson;

try {
    Class<?> clazz = Class.forName("fastjsonlib.FastJson");
    FastJson instance = (FastJson) clazz.getConstructor().newInstance();
    System.out.println("Using FastJson");
} catch (ReflectiveOperationException e) {
    System.out.println("Oops, we need a fallback!");
}
```

## Run

```bash
javac -d out \
      --module-source-path src \
      -m framework,fastjsonlib
```

```bash
java -p out -m framework/framework.Main

Oops, we need a fallback!
```

```bash
java -p out --add-modules fastjsonlib -m framework/framework.Main

Using FastJson
```
