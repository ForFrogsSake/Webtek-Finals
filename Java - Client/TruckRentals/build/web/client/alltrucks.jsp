<%-- 
    Document   : alltrucks
    Created on : 05 16, 18, 6:57:12 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import ="java.sql.*"%>
<% 
    try {
        Class.forName("com.mysql.jdbc.Driver");
           Connection con = DriverManager.getConnection("jdbc:mysql://localhost/truck_rentals", "root", "");
           PreparedStatement pStatement;
           Statement stm = con.createStatement();
           ResultSet rs ;//while (rs.next()){
           String query;
       
           query = "select * from trucks;";
           rs = stm.executeQuery(query);
           
    
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Truck Rentals | All trucks</title>
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
        
        <style>
         .headimg{
            background-image: url(../pics/cityscape.png);
            background-attachment: fixed;
            background-position: 50px 190px; 
         }
      
        .kakanan {
            font-size: 30px;
            -webkit-transition: padding-left 2s; /* For Safari 3.1 to 6.0 */
            transition: padding-left 2s;
            transition-timing-function: ease-in;
        }

        .kakanan:hover {
            padding-left: 60%;
        }
        
        </style>
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
                        <a class="nav-link" href="../client/alltrucks.jsp">all trucks</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../client/myprofile.jsp">my profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="../client/about.jsp">about</a>
                    </li> 
                </ul>
              <ul class="nav-item navbar-nav ml-auto justify-content-end">
                <li class="nav-item active">
                        <a class="nav-link" id="logout" style="cursor: pointer">Log out</a>
                </li>
              </ul>
            </div>
        </nav>
        
        <div class="container-fluid" style="padding: 20px; margin-top: 55px;">
            <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <h2 class="text-dark">Find a Truck</h2>
                    </div>
                </div>
                    
                    
                    
                    <div  class="lead" style=" margin: 10px">
                      <input class="form-control" id="myInput" type="text" placeholder="search a truck name, type, or availability">
                      <br>
                      <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th>Type</th>
                            <th>Category</th>
                            <th>Capacity</th>
                            <th>Cost per day</th>
                            <td></td>
                          </tr>
                        </thead>
                        <tbody id="myTable">
                        <% while (rs.next()){ %>   
                          <tr>
                            <td><%out.print(rs.getString("name"));%></td>
                            <td><%out.print(rs.getString("category"));%></td>
                            <td><%out.print(rs.getString("capacity"));%></td>
                            <td><%out.print(rs.getString("cost"));%></td>
                            <td></td> 
                          </tr>
                        <% }%>
                        </tbody>
                      </table>
                </div>
    <% }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }%>                
                         
                    
                </div>
            </div>
        
        
    <script>
    $(document).ready(function(){
      $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#myTable tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
      });
    });
    </script>

    </body>
</html>