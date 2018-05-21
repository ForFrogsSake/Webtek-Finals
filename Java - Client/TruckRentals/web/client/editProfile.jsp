<%-- 
    Document   : editProfile
    Created on : 05 16, 18, 9:23:44 AM
    Author     : HP
--%>
<%  String adminlink = "//localhost/phpfinals";
    String logoutlink = "../client/intro.jsp?logout=successfully"; 
    String url = "jdbc:mysql://localhost/truck_rentals";%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.*" %>
<%
   String newPhone = request.getParameter("newphone");
   String oldpass = request.getParameter("oldpass");
   String newpass = request.getParameter("newpass");
   String repass = request.getParameter("repass");
   
   if ( !newpass.equals(repass)){
       response.setHeader("Location","../client/myprofile.jsp");
   }
   try {
 %>
 <%
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
        String query;
        String username = (String)session.getAttribute("username");

           if (newPhone == null){
               query = "UPDATE users SET password='"+newpass+"' WHERE username='"+username+"';";
           }else if (!newpass.equals(null)){
               query = "UPDATE users SET phone_num='"+newPhone+"' WHERE username='"+username+"';";
           } else {
               query = "UPDATE users SET phone_number='"+newPhone+"', password='"+newpass+"' WHERE username='"+username+"';";
           }
           
           rs = stm.executeQuery(query);
           
%>
<%
           
    }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }
%>