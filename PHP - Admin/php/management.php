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
    case "check":
        $sql = "SELECT type FROM admin INNER JOIN users ON user_id = admin_id WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "check");
        break;
    case "email":
        $sql = "SELECT email FROM users WHERE email = '".$_POST["email"]."'";
        $result = $conn->query($sql);
        returnValue($result, "email");
        break;
    case "number":
        $sql = "SELECT phone_number FROM users WHERE phone_number = '".$_POST["number"]."'";
        $result = $conn->query($sql);
        returnValue($result, "number");
        break;
    case "username":
        $sql = "SELECT username FROM users WHERE username = '".$_POST["username"]."'";
        $result = $conn->query($sql);
        returnValue($result, "username");
        break;
    case "insert":
        $fname = $_POST["fname"];
        $mname = $_POST["mname"];
        $lname = $_POST["lname"];
        $email = $_POST["email"];
        $number = $_POST["number"];
        $date = date('Y-m-d');
        $username = $_POST["username"];
        $password = $_POST["password"];
        $type = "admin";
        $status = "enabled";
        $request_status = "accepted";
        $sql = "INSERT INTO users (fname, mname, lname, email, phone_number, date_registered, username, password, user_type, status, request_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sssssssssss", $fname, $mname, $lname, $email, $number, $date, $username, $password, $type, $status, $request_status);
        $stmt->execute();
        
        
        $sql = "SELECT user_id FROM users WHERE username = '".$username."'";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $user_id = $row["user_id"];
            $details = $_POST["details"];
            $street = $_POST["street"];
            $barangay = $_POST["barangay"];
            $municipality = $_POST["municipality"];
            $city = $_POST["city"];
            $province= $_POST["province"];
            
            $sql = "INSERT INTO address (user_id, house_details, street, barangay, municipality, city, province) VALUES (?, ?, ?, ?, ?, ?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("sssssss", $user_id, $details, $street, $barangay, $municipality, $city, $province);
            $stmt->execute();
            
            $regular = "regular";
            $sql = "INSERT INTO admin (admin_id, type) VALUES (?, ?)";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ss", $user_id, $regular);
            $stmt->execute();
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
                case "check": 
                    echo $row["type"];
                    break;
                case "email": 
                    echo $row["email"];
                    break;
                case "number": 
                    echo $row["phone_number"];
                    break;
                case "username": 
                    echo $row["username"];
                    break;
            }
        }
    } else {
        echo "";
    }
}

$conn->close();
?>