<%-- 
    Document   : editProfile
    Created on : 05 16, 18, 9:23:44 AM
    Author     : HP
--%>
<%  String adminlink = "http://rentals.com";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://192.168.5.81/truck_rentals";%>
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
        String username = request.getParameter("username");

           if (newPhone == null){
               query = "UPDATE users SET password='"+ newpass +"' WHERE username='" +username+ "';";
           }else if (!newpass.equals(null)){
               query = "UPDATE users SET phone_number='"+newPhone+"' WHERE username='" +username+ "';";
           } else {
               query = "UPDATE users SET phone_number='"+newPhone+"', password='" +newpass+ "' WHERE username='"+username+"';";
           }
           
           pStatement = con.prepareStatement(query);
           pStatement.executeUpdate();
           
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>TRUCK RENTALS | Request</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="../css/style.css" type="text/css">
  <link rel="icon" href="pics/favicon.png">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
 
</head>

<body style="background-color:beige ; margin-top:20px">

    <!--CARD REGISTER-->
    
    <div class="container col-sm-6 lead">
    <div class="card card-register">
        
        <div class="card-header headimg"><p style="font-size:21px"></p></div>
        <div class="card-body">
            <center><!--inputs-->
            You have successfully created changes in your account information.<br>
		<!--return to login page-->            </center>

        <div class="text-center">
          <a class="d-block small mt-4" href="../client/myprofile.jsp?username=<% out.print(username); %>" >Go Back</a>
        </div>
      </div>
    </div>
    </div>
        
  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
</body>
</html>
<%
           
    }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }
%>