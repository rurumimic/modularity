# run a Exploded Module
java -p out -m easytext.cli/foo.easytext.cli.Main lorem.ipsum.txt
java -p out -m easytext.gui/foo.easytext.gui.Main

# run a JAR
java -p mods -m easytext.cli lorem.ipsum.txt
java -p mods -m easytext.gui

# Run Image
image/bin/cli lorem.ipsum.txt
image/bin/java -m easytext.cli lorem.ipsum.txt
image/bin/java -m easytext.gui
