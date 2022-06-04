package authors;

import books.Book;
import books.Named;

import java.util.List;
import java.util.ArrayList;

public class Author implements Named { // public class Author {
    private String name;
    private List<Book> books = new ArrayList<>();

    public Author(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void writeBook(String title, String text) {
        this.books.add(new Book(this, title, text));
    }

}
