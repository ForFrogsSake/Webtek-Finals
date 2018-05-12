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

$type = "'".$_POST["type"]."'";
$sql = "SELECT username, fname, lname, email, phone_number, house_details, street, barangay, municipality, city, province 
        FROM users JOIN address USING (user_id) WHERE user_type = ".$type." and request_status = 'pending'";
$result = $conn->query($sql);
displayInfo($result);


function displayInfo($result){
    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            echo "<div class=\"row\">
                    <div class=\"col-10\">
                        <p>
                            <strong>". $row["username"] ."</strong> | ". $row["fname"] ." ". $row["lname"] ."
                            <br> <small>". $row["email"] ." | ". $row["phone_number"] ."</small>
                            <br> <small>". $row["house_details"] ." ". $row["street"] ." ". $row["barangay"] ." ". $row["municipality"] ." ". $row["city"] ." ". $row["province"] ."</small>
                        </p>
                    </div>
                    <div class=\"col-1\">
                        <button class=\"button deny\"></button>
                    </div>
                    <div class=\"col-1\">
                        <button class=\"button accept\"></button>
                    </div>
                </div>";
        }
    } else {
        echo "0 results";
    }
}

$conn->close();
?>