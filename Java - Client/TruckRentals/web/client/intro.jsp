<%-- 
    Document   : intro
    Created on : 05 21, 18, 10:11:04 AM
    Author     : HP
--%>
<%  String adminlink = "http://rentals.com";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://192.168.5.81/truck_rentals";%>

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

        String username = request.getParameter("username");
        query = "select * from trucks inner join users on provider_id=user_id where users.status ='enabled';";
        rs = stm.executeQuery(query);

    
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Truck Rentals</title>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="../pics/favicon.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../css/style.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
        <script src="../script/transactions.js"></script>
        <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.0.0/css/bootstrap.css"></script>
	
        
    </head>
<!--
1. screenshots para sa user instructions
2. ung sa modal footer para dito.. nakaindicate "login first" lam mo na gagawen
-->
    <body style="background-color: beige">
        <nav class="navbar navbar-expand-md bg-dark navbar-dark fixed-top">
            <a class="navbar-brand" href="../client/intro.jsp">Truck Rentals <img src="../pics/truck.png" width="25px" height="25px"></a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="collapsibleNavbar">
 
              <ul class="nav-item navbar-nav ml-auto justify-content-end">
                <li class="nav-item active">
                        <a class="nav-link" id="signup" style="cursor: pointer" href="../client/signup.jsp">Sign Up</a>
                </li>
                <li >
                        <a class="nav-link" >or</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" id="signin" style="cursor: pointer" href="<% out.print(adminlink); %>">Sign In</a>
                </li>
              </ul>
            </div>
        </nav>
                
<% 
   // if ( request.getParameter("logout").equals("successfully")){
%>      
      
       <div class="jumbotron text-center" style="background-image: url(../pics/cityscape.png); background-position: center; background-size: cover; background-repeat: no-repeat; background-color: #ffffff; margin-top: 40px;">
        <h2 id="username"></h2>
        <h4 class="font-italic">A simple way to help your loaded life!</h4>
        </div>        
        <div class="container-fluid lead" style="padding: 0px 120px; ">
                    
            <div class="row">
                <div class="col-md-7 ">
            <div class="card" style="padding: 10px;">
            <h4 class="display-7 text-center text-secondary card-title">IT'S EASY!</h4>
            <!--user instructions-->        
           <ul class="nav nav-tabs nav-justified text-dark" role="tablist">
            <li class="nav-item">
                <a class="nav-link active text-success" data-toggle="tab" href="#first"><h6 class="kakanan">1. Choose a Truck</h6></a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-success" data-toggle="tab" href="#second"><h6 class="kakanan">2. Fill Requirements</h6></a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-success" data-toggle="tab" href="#third"><h6 class="kakanan">3. Request Accepted!</h6></a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-success" data-toggle="tab" href="#fourth"><h6 class="kakanan">4. Rent Again!</h6></a>
            </li>
          </ul>

          <!-- Tab panes -->
          <div class="tab-content bg-none ">
            <div id="first" class="container tab-pane active"><br>
              <h5>You can see details for each truck!</h5>
              
            </div>
            <div id="second" class="container tab-pane fade"><br>
              <h5>Fill up needed information!</h5>
              
            </div>
            <div id="third" class="container tab-pane fade"><br>
              <h5>Wait until the Service Provider Accepts your Request..</h5>
              
            </div>
            <div id="fourth" class="container tab-pane fade"><br>
              <h5>Rent Another Truck!</h5>
              
            </div>
          </div>
            
            
        </div>
            </div>
            
            
                <!--SEARCH-->
                <div class="col-md-5">
                    <div class="card" id="intro" style="padding: 10px;overflow: scroll;">
  
                     <div  class="lead" style=" margin: 10px">
                  
                      <br>
                      
                      <table id="myTable" class="table table-bordered table-hover">
                        <thead>
                          <tr>
                            <th><center>ID</center></th>
                            <th>Type</th>
                            <th>Category</th>
                            <th>Cost per day</th>
                            <th>Provider</th>
                            <th class="lastcol"></th>
                          </tr>
                        </thead>
                        <tbody>
                          <% while (rs.next()){ %>
                            
                                <tr href="#demo" data-toggle="collapse">
                                    <td align="center" id="truck"><strong><%out.print(rs.getString("truck_id"));%></strong></td> 
                                    <td><%out.print(rs.getString("name"));%></td>
                                    <td><%out.print(rs.getString("category"));%></td>
                                    <td><%out.print(rs.getString("cost"));%> </td>
                                    <td class="provider"><%out.print(rs.getString("fname") + " " + (rs.getString("lname")));%> </td>
                                    <td class="lastcol" ><button id="rentbtn" type="button" class="rentbtn btn btn-success" data-toggle="modal" data-target="#requestModal">
                                Rent
                        </button></td> 
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
                        <h4 class="text-secondary" id="displaytruckid">Kindly login first. </h4>
                    <form action="<% out.print(adminlink); %>" method="post" target="_self">
                       
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                   <input name="submit" type="submit" class="btn btn-success" value="Login"/>
                   </form>
                  <button type="button" class="btn btn-warning text-light" data-dismiss="modal">Close</button>
                    </div>

                  </div>
                </div>
              </div>
            <!--end modal-->
                </div>                       
                        


                </div>
            
                </div></div>
            

    

        </div>
 
<%
    //}
%>   

    <script>
        
    $(function(){
       $(".rentbtn").on("click", function() {
           var x = $(this).parent().parent().find("strong").text();
           
           $("#truckidnito").attr('value',x);
       });
    });
        
    $(document).ready(function(){
      $("#myInput").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#myTable tr").filter(function() {
          $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
        
      });
    });
        
    </script>
    <script>
    $(document).ready(function() {
    $('#myTable').DataTable({
	"searching":true,
	"pagingType": "numbers"
	});
    } );
    </script>
    
    
    
    </body>
</html>



