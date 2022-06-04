mkdir -p out

javac -d out \
      --module-source-path src \
      -m framework,fastjsonlib

# run a Exploded Module
java -p out -m framework/framework.MainBad

java -p out -m framework/framework.Main
java -p out --add-modules fastjsonlib -m framework/framework.Main
