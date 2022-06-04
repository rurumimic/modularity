# Optional Dependency: Service

```java
module framework {
    requries static fastjsonlib;
    uses fastjsonlib.FastJson;
}

module fastjsonlib {
  exports fastjsonlib;
  provides fastjsonlib.FastJson
      with fastjsonlib.FastJson;
}
```

## Run

### Found a service

```bash
javac -d out \
      --module-source-path src \
      -m framework

java -p out -m framework/framework.Main
```

```bash
Found a service
```

### Initailization Error

```bash
rm -rf out/fastjsonlib

java -p out -m framework/framework.Main
```

```bash
Error occurred during initialization of boot layer
java.lang.module.ResolutionException: Module framework does not read a module that exports fastjsonlib
```

-> make a interface
