<%  String adminlink = "http://rentals.com";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://192.168.5.81/truck_rentals";%>

<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date"
         import= "java.util.Calendar" %>

<% 
       String username = request.getParameter("username");
       int trucknum =Integer.parseInt(request.getParameter("truckid"));
       int daynum =Integer.parseInt(request.getParameter("daynum"));  
       String startdate = request.getParameter("startdate");
       String[] splitdate = startdate.split("\\-");
       java.util.Date date = new SimpleDateFormat("yyyy-mm-dd").parse(startdate);
       
       java.sql.Date start = new java.sql.Date(date.getTime());
       
       Calendar temp = Calendar.getInstance();
       temp.set(Integer.parseInt(splitdate[0]), Integer.parseInt(splitdate[1])-1, Integer.parseInt(splitdate[2]));
       temp.add(Calendar.DATE, daynum);
       SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
       java.util.Date temp2 = temp.getTime();
       String date1 = format1.format(temp2);            
       java.util.Date enddate = new SimpleDateFormat("yyyy-mm-dd").parse(date1);
       
       java.sql.Date end = new java.sql.Date(enddate.getTime());
       
     try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
        String query;

        query = "select user_id from users inner join trucks on user_id=provider_id where truck_id='"+ trucknum +"';";
        rs = stm.executeQuery(query);
        rs.next();
        int provider = rs.getInt("user_id");
   
        query = "select user_id from users where username='"+ username +"';";
        rs = stm.executeQuery(query);
        rs.next();
        int client = rs.getInt("user_id");
   

        query = "INSERT INTO transactions ( truck_id, provider_id, client_id, request_status, number_of_days, rent_start_day, rent_end_day) VALUES (?, ?, ?, 'pending', ?, ?, ?);";
        pStatement = con.prepareStatement(query);
        pStatement.setInt(1, trucknum);
        pStatement.setInt(2, provider);
        pStatement.setInt(3, client);
        pStatement.setInt(4, daynum);
        pStatement.setDate(5, start);
        pStatement.setDate(6, end);
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
            Congratulations! <br> Your rent request has been sent. <br>
		<!--return to login page-->            </center>

        <div class="text-center">
          <a class="d-block small mt-4" href="../client/alltrucks.jsp?username=<% out.print(username); %>" >Go Back</a>
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

                        