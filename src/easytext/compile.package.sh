mkdir -p out
mkdir -p mods

# one
javac -d out/easytext \
      src/easytext/foo/easytext/Main.java \
      src/easytext/module-info.java

jar -cfe mods/easytext.jar foo.easytext.Main \
    -C out/easytext .

# two
#javac -d out/easytext.two --module-source-path src -m easytext.cli,easytext.analysis
# or
javac -d out/easytext.two --module-source-path src -m easytext.cli

jar -cfe mods/easytext.cli.jar foo.easytext.cli.Main \
    -C out/easytext.two/easytext.cli .
jar -cf mods/easytext.analysis.jar \
    -C out/easytext.two/easytext.analysis .

# three
javac -d out/easytext.three --module-source-path src -m easytext.gui,easytext.cli

# same as easytext.two
# jar -cfe mods/easytext.cli.jar foo.easytext.cli.Main \
#     -C out/easytext.three/easytext.cli .
# jar -cf mods/easytext.analysis.jar \
#     -C out/easytext.three/easytext.analysis .
jar -cfe mods/easytext.gui.jar foo.easytext.gui.Main \
    -C out/easytext.three/easytext.gui .
