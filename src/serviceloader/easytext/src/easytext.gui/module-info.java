module easytext.gui {
    exports foo.easytext.gui to javafx.graphics;
    requires javafx.graphics;
    requires javafx.controls;
    requires easytext.analysis;
}
