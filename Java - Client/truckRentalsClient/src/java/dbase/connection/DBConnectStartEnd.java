package dbase.connection;

import java.sql.SQLException;

public class DBConnectStartEnd {
    private static DBConnect connector;
    
    public static void main(String[]args){
        String start = "yes"; // remember to refer sa login part
        connector = new DBConnect();
        try {
            if (start.equals("yes")){
                String url= "jdbc:mysql://localhost/truck_rentals?useSSL=false";
                connector.dbaseConnect(url, "root", "");
            } else {
                connector.close();
            }
        } catch (SQLException e) {
            System.err.println("error: " + e.getClass() + "\n" + e.getMessage());
        } catch (Exception e) {
            System.err.println("error: " + e.getClass() + "\n" + e.getMessage());
        } finally{
            connector.close();
        }
        
    }
}
