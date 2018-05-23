<%-- 
    Document   : home
    Created on : 05 16, 18, 5:27:16 AM
    Author     : HP
--%>

<%  String adminlink = "//logout/phpfinals";
    String logoutlink = "../client/intro.jsp?logout=successfully";
    String url = "jdbc:mysql://localhost/truck_rentals";%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import ="java.sql.*"
        import ="java.util.*"
        import= "java.text.SimpleDateFormat" %>
      
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, "root", "");
        PreparedStatement pStatement;
        Statement stm = con.createStatement();
        ResultSet rs ;
        String query;
        String username = request.getParameter("username");
        query = "select fname, user_id from users where username='"+username+"';";
        rs = stm.executeQuery(query);
        rs.next();
        int user_id = rs.getInt("user_id");
        String fname = rs.getString("fname");

        query = "select count(transaction_id) as total from transactions where client_id="+user_id+";";
        rs = stm.executeQuery(query);
        rs.next();
        int total = rs.getInt("total");

        query = "select transaction_id, trucks.name , Concat(fname, ' ' ,lname) as provider, transactions.request_status, rent_start_day, rent_end_day,number_of_days,cost from transactions inner join trucks using(truck_id) inner join users on transactions.provider_id=user_id where client_id="+user_id+";";
        rs = stm.executeQuery(query);
        
        Calendar current = Calendar.getInstance();
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date current1 = current.getTime();
       String date1 = format1.format(current1);            
       java.util.Date currentdate = new SimpleDateFormat("yyyy-mm-dd").parse(date1);
       
       java.sql.Date date = new java.sql.Date(currentdate.getTime());
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Truck Rentals</title>
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
            <a class="navbar-brand" href="../client/home.jsp?username=<% out.print(username); %>">Truck Rentals <img src="../pics/truck.png" width="25px" height="25px"></a>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="collapsibleNavbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link text-light" href="../client/alltrucks.jsp?username=<% out.print(username); %>">all trucks</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-light" href="../client/myprofile.jsp?username=<% out.print(username); %>">my profile</a>
                    </li>
                </ul>
              <ul class="nav-item navbar-nav ml-auto justify-content-end">
                <li class="nav-item active">
                        <a class="nav-link" >Hi, <% out.println(fname); %> !<a>
                </li>  
                <li class="nav-item active">
                        <a class="nav-link" id="logout" style="cursor: pointer" href="<% out.print(logoutlink); %>">Log out</a>
                </li>
              </ul>
            </div>
        </nav>
        
        <div class="container-fluid lead" style="padding: 20px; margin-top: 55px;">
              <div class="row">
                  
            
                <div class="col-sm-6">
                <!--ACCEPTED-->
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <p id="header" class="text-dark" >Accepted Requests</p>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-sm">
                        <tbody>
                        <thead>
                          <tr>
                            <th class="w3-third">ID</th>
                            <th>Truck Name</th>
                            <th>Provider</th>
                            <th>Start of Rent</th>
                            <th>End of Rent</th>
                            <th>Total Cost</th>
                            <th></th>
                          </tr>
                        </thead>
                        <% while (rs.next()){ %>
                            <%if ((rs.getString("request_status").equals("accepted"))){ %> 
                            
                            <tr>
                              <td><strong><% out.print(rs.getInt("transaction_id")); %></strong></td>
                              <td><% out.print(rs.getString("name")); %></td>
                              <td><% out.print(rs.getString("provider")); %></td>
                              <td id="start"><% out.print(rs.getDate("rent_start_day")); %></td>
                              <td id="end"><% out.print(rs.getDate("rent_end_day")); %></td>
                              <td><% out.print(rs.getInt("cost")*rs.getInt("number_of_days")); %></td>
                              <td class="lastcol" ><button id="rentbtn" type="button" class="rentbtn btn btn-danger btn-sm" data-toggle="modal" data-target="#cancelModal">
                                cancel
                        </button></td>
                            </tr>
                            <% }%>
                        <% }%>
                            
                            
                        </tbody>
                       
                    </table>
                
        
            </div>
            </div>                  
            </div>
                        
                 <div class="col-sm-6">       
                <!--PENDING-->
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <% rs.afterLast(); %>
                        <p id="header" class="text-dark">Pending Requests</p>
                 
                    </div>
                </div>
                <div class="card-body">
                                         <table class="table table-striped table-sm">
                    <tbody>
                        <thead>
                          <tr>
                            <th class="w3-third">ID</th>
                            <th>Name of the Truck</th>
                            <th>Service Provider</th>
                            <th>Start of Rent</th>
                            <th>End of Rent</th>
                            <th>Total Cost</th>
                            <th></th>
                          </tr>
                        </thead>
                        <% while (rs.previous()){ %>
                            <%if (rs.getString("request_status").equals("pending")){ %> 
                            <tr>
                                <td><strong><% out.print(rs.getInt("transaction_id")); %></strong></td>
                              <td><% out.print(rs.getString("name")); %></td>
                              <td><% out.print(rs.getString("provider")); %></td>
                              <td id="start"><% out.print(rs.getDate("rent_start_day")); %></td>
                              <td id="end"><% out.print(rs.getDate("rent_end_day")); %></td>
                              <td><% out.print(rs.getInt("cost")*rs.getInt("number_of_days")); %></td>
                              <td class="lastcol" ><button id="rentbtn" type="button" class="rentbtn btn btn-danger btn-sm" data-toggle="modal" data-target="#cancelModal" >
                                cancel
                        </button></td>
                            </tr>
                            <% }%>
                        <% }%>
                    </tbody>
                  </table>
                
        
            </div>
            </div>
              </div>
                    
            </div>

        </div>
          <!-- REQUEST Modal -->
              <div class="modal fade" id="cancelModal">
                  
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header headimg">
                      <h5 class="modal-title">Cancellation of Request</h5>
                      <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">
                        <h5 class="text-secondary" id="displaytruckid">Transaction no. </h5>
                        <form action="../client/cancellation.jsp?username=<% out.print(username); %>" method="post" target="_self">
                        <input name="transacid" type="hidden" id="transacidnito" value="" >
                        <p id="content"></p>
                        <h5 class="text-secondary" >Reason of Rent </h5>
                        <input style="height:150px;width: 400px;" name="reason" type="text" id="transacidnito" />
                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                   <input name="submit" type="submit" class="btn btn-success" value="Send"/>
                   </form>
                  <button type="button" class="btn btn-warning text-light" data-dismiss="modal">Cancel</button>
                    </div>

                  </div>
                </div>
              </div>
            <!--end modal-->
               
                    
                    
                    
    <%
           
    }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }
    %>
    
    <script>
        $(function(){
           $(".rentbtn").on("click", function() {
               var x = $(this).parent().parent().find("strong").text();
               $("#displaytruckid").html("Transaction no. "+x );
               $("#transacidnito").attr('value',x);
           });
           $(".rentbtn").on("click", function() {
               var y = $(this).parent().parent().find("#start").text();
               var z = $(this).parent().parent().find("#end").text();
               $("#content").html("Starting day of rent is " +y+ "<br> Ending day of rent is " +z);
           });
           
        });
    </script>
    </body>
</html>