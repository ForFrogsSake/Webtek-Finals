<?php
$servername = "localhost";
$user = "root"
$pass = "";
$dbname = "truck_rentals";

mysql_connect($servername, $user, $pass);
mysql_select_db($db);

if(isset($_POST['username'])){
    $uname=$_POST['username'];
    $passwd=$_POST['password'];

    $sql="select * from truck_rentals where username='".$uname."'AND password='".$passwd."'
    limit 1";

    $result=mysql_query($sql);

    if(mysql_num_rows($result)==1){
        echo " You have Succesfully Logged In";
        exit();

    }
    else{
        echo " You have entered the incorrect details";
        exit();
    }
}

?>