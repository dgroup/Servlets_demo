package sumy.javacourse.webdemo.model;

public class Comment {
    private String author;
    private String email;
    private String text;

    public Comment(){
        this("","","");
    }

    public Comment(String author, String email, String text) {
        setAuthor(author);
        setEmail(email);
        setText(text);
    }


    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "author='" + author + '\'' +
                ", email='" + email + '\'' +
                ", text='" + text + '\'' +
                '}';
    }
}
