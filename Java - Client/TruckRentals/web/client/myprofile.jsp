<%-- 
    Document   : myprofile
    Created on : 05 16, 18, 7:31:55 AM
    Author     : HP
--%>
<%  String adminlink = "//localhost/phpfinals";
    String logoutlink = "../client/intro.jsp?logout=successfully";     
    String url = "jdbc:mysql://localhost/truck_rentals";%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import= "java.sql.*" %>
<script>
    
</script>
<% 
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
        String query;
        String username = //(String)session.getAttribute("username");
                "blehli";
        query = "select concat(fname, ' ', lname) as full , username, email, phone_number, password from users where username='"+username+"';";
        rs = stm.executeQuery(query);
        rs.next();


%>
<!DOCTYPE html>
<html>
    <head>
        <title>Truck Rentals | My Profile</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="../pics/favicon.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
        <script src="../script/transactions.js"></script>
        
       
    </head>

    <body style="background-color: beige">
        <nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top">
            <a class="navbar-brand" href="../client/home.jsp">Truck Rentals <img src="../pics/truck.png" width="25px" height="25px"></a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link text-light" href="../client/alltrucks.jsp">all trucks</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-light" href="../client/myprofile.jsp">my profile</a>
                    </li>
                </ul>
              <ul class="nav-item navbar-nav ml-auto justify-content-end">
                <li class="nav-item active">
                    <a class="nav-link" id="logout" style="cursor: pointer" href="<% out.print(logoutlink); %>">Log out</a>
                </li>
              </ul>
            </div>
        </nav>
        
        <div class="container-fluid lead" style="padding: 20px; margin-top: 55px;">
            <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <p id="header" class="text-dark">My Profile</p>
                    </div>
                </div>
                    
                <table class="table table-borderless">
                    <tbody>
                      <tr>
                        <td>Name:</td>
                        <td><% out.println(rs.getString("full")); %></td>
                      </tr>
                      <tr>
                        <td>Username:</td>
                        <td><% out.println(rs.getString("username")); %></td>
                      </tr>
                      <tr>
                        <td>Email address:</td>
                          <td><% out.println(rs.getString("email")); %></td>
                      </tr>
                      <tr>
                        <td>Phone number:</td>
                        <td><% out.println(rs.getString("phone_number")); %></td>
                      </tr>
                    </tbody>
                  </table>
                                <!--edit profile-->
                <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#edit">Change phone number and Password</button>    
                                

                    
                <form action="../client/editProfile.jsp" method="post" target="_self">
                    <div id="edit" class="collapse" style="background-color: #F1FFFF  ;">
 
                <!--edit forms-->
                    <div style="margin:  10px;">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Phone number</label>
                            <input name="newphone" class="form-control" id="exampleInputNumber" type="number" aria-describedby="numberHelp" placeholder="Enter new phone number">
                        </div>
                        <div class="form-group">
                            <div class="form-row">
                    <!--old-->
                                <div class="col-md-4">
                                    <label for="exampleInputPassword1">Current password</label>
                                    <input name="oldpass" class="form-control" id="exampleInputPassword1" type="password" placeholder="Password">
                                </div>
                                <div class="col-md-4">
                                    <label for="exampleConfirmPassword">New password</label>
                                    <input name= "newpass" class="form-control" id="examplenewPassword" type="password" placeholder="New password">
                                </div>
                                <div class="col-md-4">
                                    <label for="exampleConfirmPassword">Confirm password</label>
                                    <input name="repass" class="form-control" id="exampleConfirmPassword" type="password" placeholder="Confirm password">
                                </div>
                            </div>
                        </div>
                        <input type="submit" name="submit" class="btn btn-info" value="save changes">
                    </div>

<!--edit forms end-->        

</div>
                </form>



                    
                </div>
            </div>
    <% }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }%>                 
        
    <script>
    $(document).ready(function(){
      $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#myTable tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
      });
    });
    </script>

    </body>
</html>