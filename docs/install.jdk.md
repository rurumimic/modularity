# Install JDK 9 with [jenv](https://github.com/jenv/jenv)

- Oracle Java SE 9 Development Kit 9.0.4: [Download](https://www.oracle.com/java/technologies/javase/javase9-archive-downloads.html)
- AdoptOpenJDK 11 (LTS) HotSpot: [Download](https://adoptopenjdk.net/index.html?variant=openjdk11&jvmVariant=hotspot)

### Add JDK

JDK path on _macOS_:

```bash
ls -1 /Library/Java/JavaVirtualMachines

jdk-9.0.4.jdk
```

Add JDK:

```bash
jenv add /Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home

oracle64-9.0.4 added
9.0.4 added
9.0 added
9 added
```

### Set Java version in a project directory

```bash
cd /<project-path>
jenv local 9
```

This will create a `.java-version` file.

### Current Java version

```bash
java -version

java version "9.0.4"
Java(TM) SE Runtime Environment (build 9.0.4+11)
Java HotSpot(TM) 64-Bit Server VM (build 9.0.4+11, mixed mode)
```

### JAVA_HOME

```bash
jenv enable-plugin export
```
