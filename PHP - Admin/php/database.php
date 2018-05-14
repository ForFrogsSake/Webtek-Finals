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

switch ($_POST["function"]) {
    case "requests":
        $type = "'".$_POST["type"]."'";
        $sql = "SELECT username, fname, lname, email, phone_number, house_details, street, barangay, municipality, city, province FROM users JOIN address USING (user_id) WHERE user_type = ".$type." and request_status = 'pending' ORDER BY users.date_registered";
        $result = $conn->query($sql);
        displayRequests($result);
        break;
    case "transactions":
        $sql = "SELECT transaction_id, name, c.username client, p.username provider, transactions.request_status, number_of_days, rent_start_day, rent_end_day, cost FROM transactions INNER JOIN users c ON client_id = c.user_id INNER JOIN users p ON provider_id = p.user_id INNER JOIN trucks USING (truck_id);";
        $result = $conn->query($sql);
        displayTransactions($result);
        break;
    case "management":
        $sql = "SELECT user_id, username, fname, lname, email, date_registered, status, request_status, user_type FROM users WHERE request_status <> 'pending'";
        $result = $conn->query($sql);
        displayUsers($result);
        break;
    case "deny":
        $username = "'".$_POST["username"]."'";
        $sql = "UPDATE users SET request_status = 'denied' WHERE username = ".$username;
        $conn->query($sql);
        break;
    case "accept":
        $username = "'".$_POST["username"]."'";
        $sql = "UPDATE users SET request_status = 'accepted', status = 'enabled' WHERE username = ".$username;
        $conn->query($sql);
        break;
    case "enable":
        $user = "'".$_POST["user_id"]."'";
        $sql = "UPDATE users SET request_status = 'accepted', status = 'enabled' WHERE user_id = ".$user;
        $conn->query($sql);
        $sql = "SELECT status FROM users WHERE user_id = ".$user;
        $result = $conn->query($sql);
        toggle($result);
        break;
    case "disable":
        $user = "'".$_POST["user_id"]."'";
        $sql = "UPDATE users SET status = 'disabled' WHERE user_id = ".$user;
        $conn->query($sql);
        $sql = "SELECT status FROM users WHERE user_id = ".$user;
        $result = $conn->query($sql);
        toggle($result);
        break;
}




function displayRequests($result){
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
        echo "<small>There are no account requests</small>";
    }
}

function toggle($result){
    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            echo $row["status"];
        }
    } else {
        echo "error";
    }
}

function displayTransactions($result){
    if ($result->num_rows > 0) {
        // output data of each row
        echo "<small id=\"none\" style=\"margin-left: 20px; display: none\">There are no transactions of this type</small>";
        while($row = $result->fetch_assoc()) {
            switch($row["request_status"]){
                case "accepted":
                    $status = "success";
                    display($row, $status);
                    break;
                case "pending":
                    $status = "warning";
                    display($row, $status);
                    break;
                case "denied":
                    $status = "danger";
                    display($row, $status);
                    break;
            }
        }
    } else {
        echo "<small>There are no account requests</small>";
    }
}

function display($row, $status){
    echo "<div class=\"col-md-6\">
            <div class=\"content\">
                <p>
                    <strong>ID: ". $row["transaction_id"] ."</strong> |
                    <span class=\"text-info\">". $row["name"] ."</span>
                    <span class=\"text-success\">(&#x20b1;". $row["cost"] ."/day)</span> <br> 
                    <small>
                        <span class=\"text-secondary\">leased by </span> 
                        <span class=\"text-warning\">". $row["provider"] ."</span>
                        <span class=\"text-secondary\">rented by </span> 
                        <span class=\"text-primary\">". $row["client"] ."</span> 
                        <span  class=\"text-secondary\">for: </span>". $row["number_of_days"] ." days <br>
                        <span class=\"text-secondary\">from </span> ". $row["rent_start_day"] ." 
                        <span class=\"text-secondary\">to</span> ". $row["rent_end_day"] ." <br>
                        <span  class=\"text-secondary\">with a total cost of </span> <span class=\"text-success\">&#x20b1;". $row["number_of_days"] * $row["cost"] ."</span>
                    </small> <br> 
                    <small>
                        <span class=\"text-secondary\">Request Status: </span> 
                        <span class=\"badge badge-". $status ."\">". $row["request_status"] ."</span>
                    </small> 
                </p>
            </div>
        </div>";
}

function displayUsers($result){
    if ($result->num_rows > 0) {
        // output data of each row
        while($row = $result->fetch_assoc()) {
            $status = $row["status"];
            $request = $row["request_status"];
            $type = $row["user_type"];
            $button = $row["status"];
            $determiner = $row["status"];
            switch($status){
                case "disabled":
                    $status = "danger";
                    break;
                case "enabled":
                    $status = "success";
            }
            switch($request){
                case "accepted":
                    $request = "success";
                    break;
                case "denied":
                    $request = "danger";
                    break;
                case "pending":
                    $request = "warning";
                    break;
            }
            switch($type){
                case "client":
                    $type = "primary";
                    break;
                case "provider":
                    $type = "warning";
                    break;
            }
            switch($button){
                case "disabled":
                    $button = "Enable";
                    break;
                case "enabled":
                    $button = "Disable";
                    break;
            }
            switch($determiner){
                case "disabled":
                    $determiner = "success";
                    break;
                case "enabled":
                    $determiner = "danger";
            }
            echo "<tr>
                        <td><strong>". $row["user_id"] ."</strong></td>
                        <td>". $row["username"] ."</td>
                        <td>". $row["fname"] ."</td>
                        <td>". $row["lname"] ."</td>
                        <td>". $row["email"] ."</td>
                        <td>". $row["date_registered"] ."</td>
                        <td><div class=\"status badge badge-". $status ."\">". $row["status"] ."</div></td>
                        <td><div class=\"request badge badge-". $request ."\">". $row["request_status"] ."</div></td>
                        <td><div class=\"type text-". $type ."\">". $row["user_type"] ."</div></td>
                        <td><button class=\"btn btn-sm btn-". $determiner ."\" style=\"padding: 3px 8px 3px 8px; font-size:12px\">". $button ."</button></td>
                </tr>";
        }
    }
}

$conn->close();
?>