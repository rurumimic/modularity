mkdir -p out
mkdir -p mods

javac -d out \
      --module-source-path src \
      -m authors,books

jar -cf mods/authors.jar -C out/authors .
jar -cf mods/books.jar -C out/books .
