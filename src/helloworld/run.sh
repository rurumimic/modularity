# Run a class
java -cp out/helloworld com.javamodularity.helloworld.HelloWorld;

# Run a Exploded Module: Java 9+
java -p out -m helloworld/com.javamodularity.helloworld.HelloWorld;

# Run a JAR
java -p mods -m helloworld;

# Resolution
java --show-module-resolution \
     --limit-modules java.base \
     --module-path mods --module helloworld;
