<%-- 
    Document   : home
    Created on : 05 16, 18, 5:27:16 AM
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
        ResultSet rs ;//while (rs.next()){
        String query;
        String username = //(String)session.getAttribute("username");
                "blehli";
        query = "select fname, user_id from users where username='"+username+"';";
        rs = stm.executeQuery(query);
        rs.next();
        int user_id = rs.getInt("user_id");
        String fname = rs.getString("fname");

        query = "select count(transaction_id) as total from transactions where client_id="+user_id+";";
        rs = stm.executeQuery(query);
        rs.next();
        int total = rs.getInt("total");

        query = "select transaction_id, trucks.name , Concat(fname, ' ' ,lname) as provider, transactions.request_status from transactions inner join trucks using(truck_id) inner join users on transactions.provider_id=user_id where client_id="+user_id+";";
        rs = stm.executeQuery(query);

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
        <style>
         .headimg{
            background-image: url(../pics/cityscape.png) ;
            background-size: cover;
            background-position: bottom;
         }
      
        .kakanan {
            font-size: 25px;
            -webkit-transition: padding-left 0.5s; /* For Safari 3.1 to 6.0 */
            transition: padding-left 0.5s;
            transition-timing-function: ease;
        }

        .kakanan:hover {
            padding-left: 15%;
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
                  
                  <!--HI-->
                <div class="col-sm-4">
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        
                    </div>
                </div>
                <div class="card-body">
                        <!--CONTENT-->
                       Total Number of Transactions: <% out.println(total); %> <br>
            </div>
            </div>
            </div>
                  
                  
            <br><br>
                  
            
                <div class="col-sm-8">
                <!--ACCEPTED-->
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <h2 class="text-dark">Accepted Requests</h2>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-sm">
                        <tbody>
                             <thead>
                          <tr>
                            <th>Transaction ID</th>
                            <th>Name of the Truck</th>
                            <th>Service Provider</th>
                          </tr>
                        </thead>
                        <% while (rs.next()){ %>
                            <%if (rs.getString("request_status").equals("accepted")){ %> 
                            <tr>
                              <td><% out.print(rs.getInt("transaction_id")); %></td>
                              <td><% out.print(rs.getString("name")); %></td>
                              <td><% out.print(rs.getString("provider")); %></td>
                            </tr>
                            <% }%>
                        <% }%>
                            
                            
                        </tbody>
                       
                    </table>
                
        
            </div>
            </div>
            
            <br>
                        
                <!--PENDING-->
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <% rs.afterLast(); %>
                        <h2 class="text-dark">Pending Requests</h2>
                 
                    </div>
                </div>
                <div class="card-body">
                                         <table class="table table-striped table-sm">
                    <tbody>
                        <thead>
                          <tr>
                            <th>Transaction ID</th>
                            <th>Name of the Truck</th>
                            <th>Service Provider</th>
                          </tr>
                        </thead>
                        <% while (rs.previous()){ %>
                            <%if (rs.getString("request_status").equals("pending")){ %> 
                            <tr>
                              <td><% out.print(rs.getInt("transaction_id")); %></td>
                              <td><% out.print(rs.getString("name")); %></td>
                              <td><% out.print(rs.getString("provider")); %></td>
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
    <%
           
    }catch (SQLException e){
         out.println(e);
    }catch (Exception e){
         out.println(e);
    }
    %>
    </body>
</html>