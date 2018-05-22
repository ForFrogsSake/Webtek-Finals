<?php include 'database.php'; ?>

<?php

$first = $_POST['fname'];
$last = $_POST['lname'];
$em = $_POST['email'];
$uname = $_POST['username'];
$pwd = $_POST['password'];

$db =mysqli_select_db("truck_rentals", $conn);

if(isset($_POST['submit'])){
$query = mysqli_query("SELECT username FROM client WHERE username=$uname");
$query1 = mysqli_query("SELECT email FROM client WHERE email=$em");
	 if (mysql_num_rows($query) != 0)
  {
      header("Location: register.html");
  }

  else if (mysqli_num_rows($query1) != 0 )
  {

      header("Location:register.html");
  }
}
?>