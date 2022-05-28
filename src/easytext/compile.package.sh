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
javac -d out/easytext.two --module-source-path src -m easytext.cli

# three
javac -d out/easytext.three --module-source-path src -m easytext.gui,easytext.cli
