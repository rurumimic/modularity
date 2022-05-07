mkdir -p out

javac -d out/helloworld \
         src/helloworld/com/javamodularity/helloworld/HelloWorld.java \
         src/helloworld/module-info.java
