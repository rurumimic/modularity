mkdir -p out
mkdir -p mods

javac -d out \
      --module-source-path src \
      -m easytext.analysis.api,provider.factory.example,provider.method.example,main

jar -cf mods/easytext.analysis.api.jar -C out/easytext.analysis.api .
jar -cf mods/provider.factory.jar -C out/provider.factory.example .
jar -cf mods/provider.method.jar -C out/provider.method.example .
jar -cfe mods/main.jar foo.providers.main.Main -C out/main .
