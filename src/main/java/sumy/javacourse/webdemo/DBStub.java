package sumy.javacourse.webdemo;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


/**
 * Warning. Do not use such approach. Just for jdbc stub.
 */
@Deprecated
public final class DBStub {
    private static final String JDBC_URL    = "jdbc:h2:~/test";

    private static final String DROP_COMMENTS = "DROP TABLE if exists comments";
    private static final String SELECT_ALL    = "select author, comment from comments order by created_date";

    private static final String CREATE_COMMENTS =
        "create table comments( " +
        "author varchar2(255)," +
        "email varchar2(255), " +
        "comment varchar2(255), " +
        "created_date date )";

    private static final String INSERT_DATA =
        "INSERT into comments (author, email, comment, created_date) VALUES (?, ?, ?, ?)";


    private DBStub(){}


    public static void initDatabase() throws SQLException, ClassNotFoundException {

        Class.forName("org.h2.Driver");

        try(Connection conn = DriverManager.getConnection(JDBC_URL, "sa", "")) {

            try(PreparedStatement prep = conn.prepareStatement(DROP_COMMENTS)){
                prep.execute();
            }

            try(PreparedStatement prep = conn.prepareStatement(CREATE_COMMENTS)) {
                prep.execute();
            }

            try(PreparedStatement prep = conn.prepareStatement(INSERT_DATA)) {
                prep.setString(1, "Tolian");
                prep.setString(2, "Tolian@mail.ru");
                prep.setString(3, "What? Everybody must die...");
                prep.setDate(4, new Date(System.currentTimeMillis()));
                prep.execute();
            }

            try(PreparedStatement prep = conn.prepareStatement(INSERT_DATA)) {
                prep.setString(1, "Hank");
                prep.setString(2, "hacker@google.com");
                prep.setString(3, "From my point of view it's very simple.");
                prep.setDate(4, new Date(System.currentTimeMillis()));
                prep.execute();
            }

            try(PreparedStatement prep = conn.prepareStatement(INSERT_DATA)) {
                prep.setString(1, "xxxx");
                prep.setString(2, "xxxx@xxxxx.ua");
                prep.setString(3, "Stupid question at all... O_o");
                prep.setDate(4, new Date(System.currentTimeMillis()));
                prep.execute();
            }
            conn.commit();
        }
    }

    public static void add(Comment comment) throws SQLException {
        try(Connection conn = DriverManager.getConnection(JDBC_URL, "sa", "");
            PreparedStatement prep = conn.prepareStatement(INSERT_DATA)) {
            prep.setString(1, comment.getAuthor());
            prep.setString(2, comment.getEmail());
            prep.setString(3, comment.getText());
            prep.setDate(4, new Date(System.currentTimeMillis()));
            prep.execute();
            conn.commit();
        }
    }

    public static Collection<Comment> comments() throws SQLException {
        try(Connection conn = DriverManager.getConnection(JDBC_URL, "sa", "");
            PreparedStatement prep = conn.prepareStatement(SELECT_ALL);
            ResultSet res = prep.executeQuery()) {

            List<Comment> comments = new ArrayList<>();
            while (res.next()) {
                Comment comm = new Comment();
                comm.setAuthor(res.getString("author"));
                comm.setText(res.getString("comment"));
                comments.add(comm);
            }
            return comments;
        }
    }

}