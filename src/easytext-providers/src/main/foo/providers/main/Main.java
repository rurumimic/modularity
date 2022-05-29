package foo.providers.main;

import java.util.List;
import foo.easytext.analysis.api.Analyzer;
import java.util.ServiceLoader;

public class Main {
    public static void main(String[] args) {
        Iterable<Analyzer> analyzers = ServiceLoader.load(Analyzer.class);

        for (Analyzer analyzer : analyzers) {
            System.out.println(analyzer.getName());
        }
    }
}
