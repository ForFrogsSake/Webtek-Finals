<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "truck_rentals";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 

switch ($_POST["query"]) {
    case "username":
        $sql = "SELECT username FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "username");
        break;
    case "request_status":
        $sql = "SELECT request_status FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "request_status");
        break;
    case "status":
        $sql = "SELECT status FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "status");
        break;
    case "password":
        $sql = "SELECT password FROM users WHERE password = '".$_POST["password"]."'";
        $result = $conn->query($sql);
        returnValue($result, "password");
        break;
    case "type":
        $sql = "SELECT user_type FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnType($result);
        break;
}

function returnValue($result, $type){
    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            switch ($type){
                case "username": 
                    echo $row["username"];
                    break;
                case "request_status": 
                    echo $row["request_status"];
                    break;
                case "status": 
                    echo $row["status"];
                    break;
                case "password": 
                    echo $row["password"];
                    break;
            }
        }
    } else {
        echo "";
    }
}

function returnType($result){
    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            echo $row["user_type"];
        }
    } else {
        echo "";
    }
}

$conn->close();
?>