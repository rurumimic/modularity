mkdir -p mods;

# Build a Jar
jar -cfe mods/helloworld.jar com.javamodularity.helloworld.HelloWorld \
    -C out/helloworld .;
# or
# jar -c -f mods/helloworld.jar \
#     -e com.javamodularity.helloworld.HelloWorld \
#     -C out/helloworld .;

# Build a image
jlink --module-path mods/:$JAVA_HOME/jmods \
      --add-modules helloworld \
      --launcher hello=helloworld \
      --output helloworld-image;
