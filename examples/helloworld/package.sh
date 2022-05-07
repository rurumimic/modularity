mkdir -p mods

jar -cfe mods/helloworld.jar com.javamodularity.helloworld.HelloWorld \
    -C out/helloworld .
