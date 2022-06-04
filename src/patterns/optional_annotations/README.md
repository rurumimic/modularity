# Optional Dependency: Annotations

```bash
javac -d out \
      --module-source-path src \
      -m application,schemagenerator
```

### Annotation is not loaded

`-ea`: enable run-time assertions in the JVM

```bash
java -ea -p out/application -m application/application.Main

Running without annotation @GenerateSchema present.
```

### Annotation is loaded

```bash
java -ea -p out --add-modules schemagenerator -m application/application.Main

Exception in thread "main" java.lang.AssertionError
    at application/application.Main.main(Main.java:6)
```
