# Hello World

```bash
helloworld
└── src
    └── helloworld # == Module Name (Module Directory Root)
        ├── com
        │   └── javamodularity
        │       └── helloworld
        │           └── HelloWorld.java
        └── module-info.java # Module Descriptor
```

## Compile

### ~ Java 8

```bash
javac -d out/helloworld \
      src/helloworld/com/javamodularity/helloworld/HelloWorld.java
```

### Java 9+

1. 클래스 파일을 생성할 디렉터리 이름은 모듈 이름과 동일하게 설정한다.
2. 컴파일할 소스 파일에 `module-info.java`를 추가한다.

```bash
javac --help

Usage: javac <options> <source files>
-d <directory>    Specify where to place generated class files
```

```bash
javac -d out/helloworld \
      src/helloworld/com/javamodularity/helloworld/HelloWorld.java \
      src/helloworld/module-info.java
```

### Exploded Module, 분해 모듈

```bash
helloworld
├── out
│   └── helloworld
│       ├── com
│       │   └── javamodularity
│       │       └── helloworld
│       │           └── HelloWorld.class
│       └── module-info.class
└── src/
```

## Package

JAR 이름은 원하는 대로 지정 가능.

```bash
jar --help

사용법: jar [OPTION...] [ [--release VERSION] [-C dir] 파일] ...
jar --create --file classes.jar Foo.class Bar.class
jar --create --file classes.jar --manifest mymanifest -C foo/ .
jar --create --file foo.jar --main-class com.foo.Main --module-version 1.0 -C foo/ classes resources
```

```bash
mkdir -p mods

jar -c -f mods/helloworld.jar \
    -e com.javamodularity.helloworld.HelloWorld \
    -C out/helloworld .
```

- `-cf`: 아카이브 `helloworld.jar` 생성
  - `-c`, `--create`: Creates a new archive file named jarfile (if f is specified) or to standard output (if f and jarfile are omitted).
  - `-f`, `--file=FILE`: Specifies the file jarfile to be created (c), updated (u), extracted (x), indexed (i), or viewed (t).
- `-e`, `--main-class=CLASSNAME`: 진입점 `HelloWorld` 클래스 지정.
- `-C`: `out/helloworld` 디렉터리 아래 컴파일된 모든 파일을 JAR 파일에 넣는다.

### JAR

```bash
helloworld
├── mods
│   └── helloworld.jar
├── out/
└── src/
```

```bash
jar -tf mods/helloworld.jar
```

분해 모듈 구성 + `MANIFEST.MF`:

```bash
helloworld.jar
├── META-INF
│   └── MANIFEST.MF
├── com
│   └── javamodularity
│       └── helloworld
│           └── HelloWorld.class
└── module-info.class # Java 9+
```

### MANIFEST.MF

```bash
unzip -p mods/helloworld.jar META-INF/MANIFEST.MF
```

```txt
Manifest-Version: 1.0
Created-By: 9.0.4 (Oracle Corporation)
Main-Class: com.javamodularity.helloworld.HelloWorld
```

## Run a module

### Run a class

```bash
java -cp out/helloworld com.javamodularity.helloworld.HelloWorld
```

### Run a Exploded Module: Java 9+

`java -p 위치 -m 모듈이름/실행할클래스`

```bash
java --module-path out --module helloworld/com.javamodularity.helloworld.HelloWorld
java -p out -m helloworld/com.javamodularity.helloworld.HelloWorld
```

```bash
Hello, World!
```

### Run a JAR

`java -p 위치 -m 모듈이름`: JAR 파일을 만들 때, `MANIFEST.MF`에 `Main-Class`를 지정했었음.

```bash
java --module-path mods --module helloworld
java -p mods -m helloworld
```

```bash
Hello, World!
```

### Resolution

`--limit-modules`: 서비스 바인딩 방지

```bash
java --show-module-resolution \
     --limit-modules java.base \
     --module-path mods --module helloworld
```

```bash
root helloworld file:///.../src/helloworld/mods/helloworld.jar
Hello, World!
```

## Module Path

`out/:myexplodedmodule/:mypackagedmodule.jar`

### Link: Runtime Image: Java 9+

```bash
jlink --module-path mods/:$JAVA_HOME/jmods \
      --add-modules helloworld \
      --launcher hello=helloworld \
      --output helloworld-image
```

- module path: `out`, `$JAVA_HOME/jmods`
- add modules: Runtime Root Module = `helloworld`
- launcher: Entry point = `helloworld`
- output: Image directory name

#### output

```bash
helloworld-image
├── bin
│   ├── hello # Run Script 131B
│   ├── java # Java Runtime 70K
│   └── keytool # 키 및 인증서 관리 70K
├── conf/
├── include/
├── legal/
├── lib/
└── release
```

#### List modules

```bash
helloworld-image/bin/java --list-modules
 
helloworld
java.base@9.0.4
```

#### File Size

```bash
du -sh helloworld-image

35M helloworld-image
```

```bash
du -shL $JAVA_HOME

505M ~/.jenv/versions/9
```

#### IllegalStateException

add modules에서 빠진 경우:

```bash
java.lang.IllegalStateException: SyllableCounter not found.
```
