mkdir -p out
mkdir -p mods

javac -d out \
      --module-source-path src \
      -m easytext.client,easytext.repository.api,easytext.domain.api

jar -cf mods/easytext.domain.api.jar -C out/easytext.domain.api .
jar -cf mods/easytext.repository.api.jar -C out/easytext.repository.api .
jar -cfe mods/easytext.client.jar easytext.client.Client -C out/easytext.client .

# implements
javac -d out \
      --module-source-path src \
      -m easytext.repository.example

jar -cf mods/easytext.repository.example.jar -C out/easytext.repository.example .

# Image
jlink --module-path mods/:$JAVA_HOME/jmods \
      --add-modules easytext.client \
      --launcher cli=easytext.client
      --output image
