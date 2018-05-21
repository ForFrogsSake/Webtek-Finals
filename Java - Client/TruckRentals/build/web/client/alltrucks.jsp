<%-- 
    Document   : alltrucks
    Created on : 05 16, 18, 6:57:12 AM
    Author     : HP
--%>
<%  String adminlink = "//localhost/phpfinals";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://localhost/truck_rentals";%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import ="java.sql.*"%>
<% 
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
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
            background-image: url(../pics/cityscape.png) ;
            background-size: cover;
            background-position: bottom;
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
                        <a class="nav-link" id="logout" style="cursor: pointer" href="<% out.print(logoutlink); %>">Log out</a>
                </li>
              </ul>
            </div>
        </nav>
        
        <div class="container-fluid" style="padding: 20px; margin-top: 55px;">
            
            <!--INSTRUCTIONS-->
            <div class="alert alert-success alert-dismissible fade show">
                <button type="button" class="close" data-dismiss="alert">&times;</button>
                Select an item to <strong>view more details</strong>.
            </div>
            
            <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <h2 class="text-dark">Find a Truck</h2>
                    </div>
                </div>
                   
                    <div  class="lead" style=" margin: 10px">
                      <div class="input-group">
                      <input class="form-control" id="myInput" type="text" placeholder="search a truck name, type, or availability">
                
                      <button type="button" class="btn btn-outline-primary btn-lg input-group-addon" data-toggle="modal" data-target="#requestModal">
                                Rent
                        </button>
                     </div>
                      <br>
                      <table class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th><center>Truck Number</center></th>
                            <th>Type</th>
                            <th>Category</th>
                            <th>Capacity</th>
                            <th>Cost per day</th>
                            
                          </tr>
                        </thead>
                        <tbody id="myTable">
                          <% while (rs.next()){ %>   
                            <tr href="#demo" data-toggle="collapse">
                                <td width="3vw"><center><%out.print(rs.getString("truck_id"));%></center></td> 
                                <td><%out.print(rs.getString("name"));%></td>
                                <td><%out.print(rs.getString("category"));%></td>
                                <td><%out.print(rs.getString("capacity"));%></td>
                                <td><%out.print(rs.getString("cost"));%> </td>
                                
                            </tr>
                           <% }%>
                        </tbody>
                      </table>
                        
                <% }catch (SQLException e){
                        out.println(e);
                   }catch (Exception e){
                        out.println(e);
                   }%>                

                        
                        
                        
                <!-- REQUEST Modal -->
              <div class="modal fade" id="requestModal">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header headimg">
                      <h4 class="modal-title">Rent Request</h4>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                    <h4 class="text-secondary">TRUCK NAME - SERVICE PROVIDER</h4>
                    <form action="../requestTruck.jsp" method="post" target="_self">
                    Truck Number
                      <input name="trucknum" class="form-control" id="exampleInputNumber" type="number" aria-describedby="numberHelp" placeholder="XXXXX">
                        
                        Number of days to rent:
                      <input name="daynum" class="form-control" id="exampleInputNumber" type="number" aria-describedby="numberHelp" placeholder="Enter number of days">
                        
                        Starting day of use:
                      <input name="startdate" class="form-control" id="exampleInputNumber" type="date" aria-describedby="numberHelp" placeholder="Enter starting date">
                        
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                   <input name="submit" type="button" class="btn btn-success" value="Send Request"/>
                   </form>
                  <button type="button" class="btn btn-warning text-light" data-dismiss="modal">Close</button>
                    </div>

                  </div>
                </div>
              </div>
            <!--end modal-->
                </div>
                    
                         
                    
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
    });
    </script>

    </body>
</html>