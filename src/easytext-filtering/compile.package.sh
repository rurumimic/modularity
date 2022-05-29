mkdir -p out
mkdir -p mods

javac -d out \
      --module-source-path src \
      -m easytext.analysis.api,easytext.analysis.coleman,easytext.analysis.kincaid,easytext.filtering

jar -cf mods/easytext.analysis.api.jar -C out/easytext.analysis.api .
jar -cf mods/easytext.analysis.coleman.jar -C out/easytext.analysis.coleman .
jar -cf mods/easytext.analysis.kincaid.jar -C out/easytext.analysis.kincaid .
jar -cfe mods/easytext.filtering.jar foo.easytext.filtering.Main -C out/easytext.filtering .

