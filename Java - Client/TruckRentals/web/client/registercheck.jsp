<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>

<% 
   String action=request.getParameter("action");
   if (action.equals("Register")){
       String fname=request.getParameter("fname");
       String lname = request.getParameter("lname");
       String username = request.getParameter("uname");
       String email = request.getParameter("email");
       String phone = request.getParameter("phone");
       String pass = request.getParameter("pass");
       String repass = request.getParameter("repass");
       String cardtype = request.getParameter("cardtype");
       String cardnum = request.getParameter("cardnum");
       String expdate = request.getParameter("exp");
       String cvv = request.getParameter("cvv"); 
       java.util.Date exp = new SimpleDateFormat("yyyy-mm-dd").parse(expdate);
       java.sql.Date date = new java.sql.Date(exp.getTime());
       
       if(pass != repass){
           response.setHeader("Location", "../client/register.jsp?password+unmatched");
       }
       try{
           Class.forName("com.mysql.jdbc.Driver");
           Connection con = DriverManager.getConnection("jdbc:mysql://localhost/truck_rentals", "root", "");
           PreparedStatement pStatement;
           Statement stm = con.createStatement();
           ResultSet rs ;//while (rs.next()){
           String query= "INSERT INTO users (fname, lname, date_registered, email, phone_number, username, password, user_type, status, request_status) VALUES (?, ?, CURRENT_DATE(), ?, ?, ?, ?, 'client', 'disabled', 'pending') ;";
           pStatement = con.prepareStatement(query);
           pStatement.setString(1, fname);
           pStatement.setString(2, lname);
           pStatement.setString(3, email);
           pStatement.setString(4, phone);
           pStatement.setString(5, username);
           pStatement.setString(6, pass);
           pStatement.executeUpdate();
           
           query= "select user_id from users where username = '"+username+"' ;";
           rs = stm.executeQuery(query);
           rs.next();
           int temp = rs.getInt("user_id");
           
           query= "INSERT INTO client (client_id, card_number, card_type, card_expiration_date, card_cvv2) VALUES (?,?,?,?,?);";
           pStatement = con.prepareStatement(query);
           pStatement.setInt(1, temp);
           pStatement.setString(2, cardnum);
           pStatement.setString(3, cardtype);
           pStatement.setDate(4, date);
           pStatement.setString(5, cvv);
           pStatement.executeUpdate();
           
           //REDIRECT TO SIGN UP PAGE
           ///???response.sendRedirect("truckrentals.com/admin/");
           
       }catch(SQLException e){
           out.println(e);
       }catch(Exception e){
           out.println(e);
       }
       
   }
%>


<%-- 
    Document   : register
    Created on : 05 14, 18, 9:57:32 PM
    Author     : HP
--%>
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
  <link rel="icon" href="pics/favicon.png">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
  <style>
      #headimg{
        width: 100%;
      }
      .headimg{
            background-image: url(../pics/cityscape.png);
            background-attachment: fixed;
            background-position: 50px 150px; 
      }
    </style>
</head>

<body style="background-color:beige ; margin-top:20px">

    <!--CARD REGISTER-->
    
    <div class="container col-sm-6 lead">
    <div class="card card-register">
        
        <div class="card-header headimg"><p style="font-size:21px">Sign-up and rent your first truck!</p></div>
        <div class="card-body">
	    <!--inputs-->
            Congratulations! <br> Your sign-up request has been sent. <br>
		<!--return to login page-->
        <div class="text-center">
          <a class="d-block small mt-4" href="truckrentals.com/admin">Login Page</a>
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


