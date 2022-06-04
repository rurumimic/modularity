# one
# run  a Exploded Module
java -p out -m easytext/foo.easytext.Main lorem.ipsum.txt
# run a JAR
java -p mods -m easytext lorem.ipsum.txt

# two
# run  a Exploded Module
java -p out/easytext.two -m easytext.cli/foo.easytext.cli.Main lorem.ipsum.txt
# run a JAR
java -p mods -m easytext.cli lorem.ipsum.txt

# three
# run  a Exploded Module
java -p out/easytext.three -m easytext.gui/foo.easytext.gui.Main lorem.ipsum.txt
# run a JAR
java -p mods -m easytext.gui lorem.ipsum.txt

# Run Image
image/bin/java -m easytext.cli lorem.ipsum.txt
image/bin/java -m easytext.gui
