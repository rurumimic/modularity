package foo.easytext.analysis.coleman;

import foo.easytext.analysis.api.Analyzer;
import foo.easytext.analysis.api.Fast;

import java.util.ArrayList;
import java.util.List;

@Fast
public class Coleman implements Analyzer {

    public static final String NAME = "Coleman-Liau";

    @Override
    public String getName() {
        return NAME;
    }

    @Override
    public double analyze(List<List<String>> sentences) {
        float totalsentences = sentences.size();
        float words = sentences.stream().mapToInt(sentence -> sentence.size()).sum();
        float letters = sentences.stream().flatMapToInt(sentence -> sentence.stream().mapToInt(word -> word.length())).sum();

        return 0.0588 * (letters / (words / 100)) - 0.296 * (totalsentences / (words / 100)) - 15.8;

    }

}
