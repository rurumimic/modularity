mkdir -p out

javac -d out \
      --module-source-path src \
      -m framework

# Found a service
java -p out -m framework/framework.Main
