<%  String adminlink = "http://rentals.com";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://192.168.5.81/truck_rentals";%>

<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date"
         import= "java.util.Calendar" %>

<% 
       String username = request.getParameter("username");
       int transacid =Integer.parseInt(request.getParameter("transacid"));
       String reason =request.getParameter("reason");  
       
     try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
        String query;

        query = "UPDATE transactions SET request_status='cancelled', reason_of_cancellation='"+reason+"' WHERE transaction_id='"+transacid+"';";
        pStatement = con.prepareStatement(query);
        pStatement.executeUpdate();

%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import="java.io.File"%>
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
            You have successfully cancelled your transaction.<br>
		<!--return to login page-->            </center>

        <div class="text-center">
          <a class="d-block small mt-4" href="../client/home.jsp?username=<% out.print(username); %>" >Go Back</a>
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

<% }catch (SQLException e){
        out.println(e);
   }catch (Exception e){
        out.println(e);
}%>                

                        