# Implied Readability

## Before: transitive

```java
module easytext.repository.api {
    exports easytext.repository.api;
    requires easytext.domain.api;
}
```

### Compile

```bash
javac -d out --module-source-path src -m easytext.client,

src/easytext.client/easytext/client/Client.java:12: error: Text.wordcount() in package easytext.domain.api is not accessible
        repository.findText("HHGTTG").wordcount();
                                     ^
  (package easytext.domain.api is declared in module easytext.domain.api, but module easytext.client does not read it)
1 error
```

### Xlint

```bash
javac -Xlint:exports \
-d out --module-source-path src \
-m easytext.client,easytext.repository.api,easytext.domain.api
```

```bash
src/easytext.repository.api/easytext/repository/api/TextRepository.java:6: warning: [exports] class Text in module easytext.domain.api is not indirectly exported using requires transitive
    Text findText(String id);
    ^
src/easytext.client/easytext/client/Client.java:12: error: Text.wordcount() in package easytext.domain.api is not accessible
        repository.findText("HHGTTG").wordcount();
                                     ^
  (package easytext.domain.api is declared in module easytext.domain.api, but module easytext.client does not read it)
1 error
1 warning
```

## After: transitive

`easytext.repository.api/module-info.java`

```java
module easytext.repository.api {
    exports easytext.repository.api;
    requires transitive easytext.domain.api;
}
```

## Before: Implements

```bash
javac -d out --module-source-path src -m easytext.client,easytext.repository.api,easytext.domain.api
java -p out -m easytext.client/easytext.client.Client

Exception in thread "main" java.util.NoSuchElementException
	at java.base/java.util.ServiceLoader$2.next(ServiceLoader.java:1303)
	at java.base/java.util.ServiceLoader$2.next(ServiceLoader.java:1291)
	at java.base/java.util.ServiceLoader$3.next(ServiceLoader.java:1389)
	at easytext.client/easytext.client.Client.main(Client.java:10)
```

## After: Implements

```bash
javac -d out --module-source-path src -m easytext.repository.example
java -p out -m easytext.client/easytext.client.Client

42
```

---

## JAR

### Build

```bash
jar -cf mods/easytext.domain.api.jar -C out/easytext.domain.api .
jar -cf mods/easytext.repository.api.jar -C out/easytext.repository.api .
jar -cf mods/easytext.repository.example.jar -C out/easytext.repository.example .
jar -cfe mods/easytext.client.jar easytext.client.Client -C out/easytext.client .
```

### Run

```bash
java -p mods -m easytext.client

42
```

---

## Image

### Build

```bash
jlink --module-path mods/:$JAVA_HOME/jmods \
      --add-modules easytext.client \
      --add-modules easytext.repository.example \
      --launcher cli=easytext.client \
      --output image
```

### Run

```bash
image/bin/cli # 42
image/bin/java -m easytext.client # 42
```
