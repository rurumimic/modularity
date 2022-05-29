package foo.easytext.analysis.factory;

import java.util.List;
import java.util.stream.Collectors;

import foo.easytext.analysis.api.Analyzer;
import foo.easytext.analysis.kincaid.FleschKincaid;
import foo.easytext.analysis.coleman.Coleman;

public class AnalyzerFactory {

    public static List<String> getSupportedAnalyses() {
        return List.of(FleschKincaid.NAME, Coleman.NAME);
    }

    public static Analyzer getAnalyzer(String name) {
        switch (name) {
            case FleschKincaid.NAME: return new FleschKincaid();
            case Coleman.NAME: return new Coleman();
            default: throw new IllegalArgumentException("No such analyzer!");
        }
    }

}
