$(document).ready(function(){
    $("#password").keypress(function(event) {
        if (event.keyCode == 13) {
            $("#prompt").fadeOut("fast", function(){
                query();
            });
         }
    });
    
    $("#signin").click(function(){
        $("#prompt").fadeOut("fast", function(){
            query();
        });
    });
    
    function query(){
        $.post("../php/login.php",
        {
            query: "username",
            username: $("#username").val()
        },
        function(data){
            var name = data;
            if(data.toUpperCase() !== $("#username").val().toUpperCase() || $("#username").val() == ""){
                $("#prompt").text("Invalid username").fadeIn("fast");
            } else{
                $.post("../php/login.php",
                {
                    query: "request_status",
                    username: name
                },
                function(data){
                    if(data == "pending"){
                        $("#prompt").text("Your account request is still being reviewed").fadeIn("fast");
                    } else if(data == "denied"){
                        $("#prompt").text("Your account request has been denied due to your violation of our policies").fadeIn("fast");
                    } else{
                        $.post("../php/login.php",
                        {
                            query: "status",
                            username: name
                        },
                        function(data){
                            if(data == "disabled"){
                                $("#prompt").text("Your account has been disabled due to your violation of our policies").fadeIn("fast");
                            } else{
                                $.post("../php/login.php",
                                {
                                    query: "password",
                                    password: $("#password").val()
                                },
                                function(data){
                                    if(data !== $("#password").val() || $("#password").val() == ""){
                                        $("#prompt").text("Invalid password").fadeIn("fast");
                                    } else{
                                        $.post("../php/login.php",
                                        {
                                            query: "type",
                                            username: $("#username").val()
                                        },
                                        function(data){
                                            sessionStorage.setItem("username", name);
                                            if(data == "admin"){
                                                window.location.replace("/admin/requests.html");
                                            }
                                            if(data == "client"){
                                                window.location.replace("http://192.168.1.6:8084/TruckRentals/client/home.jsp");
                                            }
                                            if(data == "provider"){
                                                window.location.replace("http://provider.rentals.com:3000");
                                            }
                                        });
                                    }
                                });
                            }
                        });
                    }
                });
            } 
        });
    }
});