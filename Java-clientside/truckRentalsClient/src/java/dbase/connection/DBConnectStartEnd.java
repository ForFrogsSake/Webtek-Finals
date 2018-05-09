package dbase.connection;

import java.sql.SQLException;

public class DBConnectStartEnd {
    private static DBConnect connector;
    
    public static void main(String[]args){
        connector = new DBConnect();
        try {
            String url= "jdbc:mysql://localhost/truck_rental?useSSL=false";
            connector.dbaseConnect(url, "root", "");
        } catch (SQLException e) {
            System.err.println("error: " + e.getClass() + "\n" + e.getMessage());
        } catch (Exception e) {
            System.err.println("error: " + e.getClass() + "\n" + e.getMessage());
        } finally{
            
        }
        
    }
}
