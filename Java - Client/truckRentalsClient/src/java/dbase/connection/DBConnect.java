package dbase.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class DBConnect {
    private Connection connection;
    private Statement statement;
    private PreparedStatement preparedStatement;
    private ResultSet resultSet;
    private String query;
    
    
    public void dbaseConnect(String url, String user, String pass) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, pass);
    }
    
    public void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.err.println("error: " + e.getClass() + "\n" + e.getMessage());
        }
    }
  /**  
    public void createUser(String email, String fname, String lname, String mname, String password, String username){
        Calendar date = Calendar.getInstance(getDate());
	System.out.println(dateFormat.format(cal));
        query = "insert into user values(?);";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, dname);
        preparedStatement.executeUpdate();
    }
*/    
    public ResultSet getTrucks() throws SQLException {
        statement= connection.createStatement();
        query="select * from trucks";
        return statement.executeQuery(query);
    }
}
