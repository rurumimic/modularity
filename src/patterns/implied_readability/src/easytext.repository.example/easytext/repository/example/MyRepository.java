package easytext.repository.example;

import easytext.repository.api.TextRepository;
import easytext.domain.api.Text;

public class MyRepository implements TextRepository {
    @Override
    public Text findText(String id) {
        return new Text();
    }
}
