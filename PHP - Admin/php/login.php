<?php
$servername = "192.168.5.81";
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
    case "email":
        $sql = "SELECT email FROM users WHERE email = '".$_POST["email"]."'";
        $result = $conn->query($sql);
        returnValue($result, "email");
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
    case "user_id":
        $sql = "SELECT user_id FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "user_id");
        break;
    case "change":
        $sql = "UPDATE users SET password = '".$_POST["password"]."' WHERE username = '".$_POST["username"]."'";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "failed";
        }
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
                case "email": 
                    echo $row["email"];
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
                case "user_id": 
                    echo $row["user_id"];
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