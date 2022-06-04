mkdir -p out

javac -d out \
      --module-source-path src \
      -m application,schemagenerator

# -ea: enable run-time assertions in the JVM

# Exclude myannotations module from the run-time classpath
java -ea -p out/application -m application/application.Main
#### Running without annotation @GenerateSchema present.

# Include myannotations module, expected: AssertionError
java -ea -p out --add-modules schemagenerator -m application/application.Main
#### Exception in thread "main" java.lang.AssertionError
######## at application/application.Main.main(Main.java:6)
