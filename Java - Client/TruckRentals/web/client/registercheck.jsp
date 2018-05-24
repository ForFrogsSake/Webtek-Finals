<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>    
<%  String adminlink = "http://rentals.com";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://192.168.5.81/truck_rentals";%>
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
        String housedetails = request.getParameter("housedetails");
        String street = request.getParameter("street");
        String barangay = request.getParameter("barangay");
        String municipality = request.getParameter("municipality");
        String city = request.getParameter("city");
        String province = request.getParameter("province");
        java.util.Date exp = new SimpleDateFormat("yyyy-mm-dd").parse(expdate);
        java.sql.Date date = new java.sql.Date(exp.getTime());

        try{
            if(pass.equals(repass)){
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, "root", "");
                PreparedStatement pStatement;
                Statement stm = con.createStatement();
                ResultSet rs ;
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
                
                query= "INSERT INTO address (user_id, house_details, street, barangay, municipality, city, province) VALUES (?, ?, ?, ?, ?, ?, ?);";
                pStatement = con.prepareStatement(query);
                pStatement.setInt(1, temp);
                pStatement.setString(2, housedetails);
                pStatement.setString(3, street);
                pStatement.setString(4, barangay);
                pStatement.setString(5, municipality);
                pStatement.setString(6, city);
                pStatement.setString(7, province);
                pStatement.executeUpdate();    
                
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
        
        <div class="card-header headimg"><p style="font-size:21px">Sign-up and rent your first truck!</p></div>
        <div class="card-body">
            <center><!--inputs-->
            Congratulations! <br> Your sign-up request has been sent. <br>
		<!--return to login page-->            </center>

        <div class="text-center">
          <a class="d-block small mt-4" href="<% out.print(logoutlink); %>" >Login Page</a>
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
           }else{
               response.sendRedirect("../client/signup.jsp?password+unmatched");
           }
           
       }catch(SQLException e){
           out.println(e);
       }catch(Exception e){
           out.println(e);
       }
       
   }
%>

