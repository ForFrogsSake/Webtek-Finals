<%-- 
    Document   : home
    Created on : 05 16, 18, 5:27:16 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Truck Rentals</title>
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
            padding-left: 50%;
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
        
        <div class="container-fluid lead" style="padding: 20px; margin-top: 55px;">
              <div class="row">
                  
                
                    <!--others-->
                    <div class="col-sm-7">
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                    <div>
                        <h2 class="text-dark">Hi, Delfin!</h2>
                    </div>
                </div>
                <div class="card-body">
                        Total Trucks Rented: 69<br>
                        Trucks Currently Renting:<br>
                    
                    
                     <table class="table table-striped table-sm">
                    <tbody>
                        <thead>
                          <tr>
                            <th>Truck</th>
                            <th>Service Provider</th>
                          </tr>
                        </thead>
                      <tr>
                        <td>Broom broom</td>
                        <td>Nikki</td>
                      </tr>
                      <tr>
                        <td>elf</td>
                        <td>louel</td>
                      </tr>

                    </tbody>
                  </table>
                    
                    
                </div>
            </div>
                    </div>
                  <!--CATEGORIES-->
                <div class="col-sm-5">
                <div class="card" style="box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.25);">
                <div class="card-header headimg">
                        <h2 class="text-dark">Choose a Category</h2>
                </div>
                <div class="card-body">
                  <table class="table table-hover">
                    <tbody>
                      <tr>
                          <td class="kakanan" >Construction &#62;</td>
                      </tr>
                      <tr>
                        <td class="kakanan">Delivery &#62;</td>
                      </tr>
                      <tr>
                        <td class="kakanan">Personal &#62;</td>
                      </tr>
                    </tbody>
                  </table>
                </div>
            </div>
                    </div>
                   
                  </div>

        </div>
    </body>
</html>