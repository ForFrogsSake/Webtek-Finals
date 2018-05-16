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
  <title>TRUCK RENTALS | register</title>
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
            background-position: bottom;
            background-size: cover; 
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
        <form action="client/registercheck.jsp" method="post" target="_self">
          <div class="form-group">
              <div class="text-left text-secondary" style="font-size:25px">Personal Information</div>
            <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputName">First name</label>
                <input name="fname" class="form-control" id="exampleInputName" type="text" aria-describedby="nameHelp" placeholder="Enter first name">
              </div>
              <div class="col-md-6">
                <label for="exampleInputLastName">Last name</label>
                <input name="lname" class="form-control" id="exampleInputLastName" type="text" aria-describedby="nameHelp" placeholder="Enter last name">
              </div>
            </div>
          </div>
		  <div class="form-group">
            <label for="exampleInputEmail1">User name</label>
            <input name="uname" class="form-control" id="exampleInputUserName" type="username" aria-describedby="nameHelp" placeholder="Enter username">
          </div>
          <div class="form-group">
            <label for="exampleInputEmail1">Email address</label>
            <input name="email" class="form-control" id="exampleInputEmail1" type="email" aria-describedby="emailHelp" placeholder="Enter email">
          </div>
		  <div class="form-group">
            <label for="exampleInputEmail1">Phone number</label>
            <input name="phone" class="form-control" id="exampleInputNumber" type="number" aria-describedby="numberHelp" placeholder="Enter phone number">
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputPassword1">Password</label>
                <input name="pass" class="form-control" id="exampleInputPassword1" type="password" placeholder="Password">
              </div>
              <div class="col-md-6">
                <label for="exampleConfirmPassword">Confirm password</label>
                <input name="repass" class="form-control" id="exampleConfirmPassword" type="password" placeholder="Confirm password">
              </div>
            </div>
          </div>
            
          <div class="form-group">
              <div class="text-left text-secondary" style="font-size:25px">Bank Account Information</div>
            <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputPassword1">Type of card</label>
                <input name="cardtype" class="form-control" id="exampleInputPassword1" type="text" placeholder="Card type">
              </div>
              <div class="col-md-6">
                <label for="exampleConfirmPassword">Card number</label>
                <input name="cardnum" class="form-control" id="exampleConfirmPassword" type="text" placeholder="xxxxxxxxxxxxx">
              </div>
            </div>
              <div class="form-row">
              <div class="col-md-6">
                <label for="exampleInputPassword1">Expiration date</label>
                <input name="exp" class="form-control" id="exampleInputPassword1" type="date" placeholder="YYYY-MM-DD">
              </div>
              <div class="col-md-6">
                <label for="exampleConfirmPassword">Card cvv2</label>
                <input name="cvv" class="form-control" id="exampleConfirmPassword" type="text" placeholder="ccv2">
              </div>
            </div>
          </div>
            
		  <!--register button-->
            
          <input type="submit" name="action" class="btn btn-outline-info btn-block" value="Register"/>
            
        </form>
		<!--return to login page-->
        <div class="text-center">
          <a class="d-block small mt-4" href="login.html">Login Page</a>
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
