<%-- 
    Document   : signupcheckquery
    Created on : 05 21, 18, 8:53:46 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import ="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost/truck_rentals";
    String username = "root";
    String password = "";
    String sqlQuery ="";
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, username, password);
    Statement stm = con.createStatement();
    ResultSet rs;
    String query = request.getParameter("query");
    String result = "";
    
    switch (query){
        case "username":
            String user = request.getParameter("username");
            sqlQuery = "select username from users where username='"+user+"';";
            rs = stm.executeQuery(query);
            rs.next();
            result = rs.getString("username");
            //return result;
            //break;
        
    }
    %>