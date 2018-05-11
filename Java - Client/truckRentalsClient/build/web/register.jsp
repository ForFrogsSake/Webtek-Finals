<%-- 
    Document   : register
    Created on : 05 12, 18, 12:30:33 AM
    Author     : HP
--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Sign-up | Truck Rentals </title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>

<body style="background-color:#F8F9F9">
  <div class="container">
    <div class="card card-register mx-auto mt-4">
	  <!--card header-->
      
      
      <div class="card-header" style="background-color:#FDEBD0" >Register an Account</div>
      <div class="card-body">
	    <!--inputs-->
        <form action="/truckRentalsClient/registerRequest.jsp" method="post" target="_self">
          <div class="form-group">
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
            <input name="username"class="form-control" id="exampleInputUserName" type="username" aria-describedby="nameHelp" placeholder="Enter username">
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
                <input name="password" class="form-control" id="exampleInputPassword1" type="password" placeholder="Password">
              </div>
              <div class="col-md-6">
                <label for="exampleConfirmPassword">Confirm password</label>
                <input name="repass" class="form-control" id="exampleConfirmPassword" type="password" placeholder="Confirm password">
              </div>
            </div>
          </div>
		  <!--register button-->
          <input type="submit" class="btn btn-warning btn-block" value="Register">
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

