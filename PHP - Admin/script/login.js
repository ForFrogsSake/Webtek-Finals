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
    
    $("#newConfirm").keypress(function(event) {
        if (event.keyCode == 13) {
            $("#changePrompt").fadeOut("fast", function(){
                forgot();
            });
         }
    });
    
    $("#change").click(function(){
        $("#changePrompt").fadeOut("fast", function(){
            forgot();
        });
    });
    
    function forgot(){
        $.post("../php/login.php",
        {
            query: "username",
            username: $("#changeUsername").val()
        },
        function(data){
            var name = data;
            if($("#changeUsername").val() == ""){
                $("#changePrompt").text("Username not provided").fadeIn("fast");
            } else
            if(data.toUpperCase() !== $("#changeUsername").val().toUpperCase()){
                $("#changePrompt").text("Invalid username").fadeIn("fast");
            } else{
                $.post("../php/login.php",
                {
                    query: "request_status",
                    username: name
                },
                function(data){
                    if(data == "pending"){
                        $("#changePrompt").text("Your account request is still being reviewed").fadeIn("fast");
                    } else if(data == "denied"){
                        $("#changePrompt").text("Your account request has been denied due to your violation of our policies").fadeIn("fast");
                    } else{
                        $.post("../php/login.php",
                        {
                            query: "status",
                            username: name
                        },
                        function(data){
                            if(data == "disabled"){
                                $("#changePrompt").text("Your account has been disabled due to your violation of our policies").fadeIn("fast");
                            } else{
                                $.post("../php/login.php",
                                {
                                    query: "password",
                                    password: $("#changePassword").val()
                                },
                                function(data){
                                    if($("#changePassword").val() == ""){
                                        $("#changePrompt").text("Old password not provided").fadeIn("fast");
                                    } else if(data == ""){
                                        $("#changePrompt").text("Old password is incorrect").fadeIn("fast");
                                    } else if($("#newPassword").val() == ""){
                                        $("#changePrompt").text("New password not provided").fadeIn("fast");
                                    } else if($("#newPassword").val().length < 8){
                                        $("#changePrompt").text("New password should be at least 8 characters").fadeIn("fast");
                                    } else if($("#newConfirm").val() == ""){
                                        $("#changePrompt").text("Please confirm your new password").fadeIn("fast");
                                    } else if($("#newConfirm").val() !== $("#newPassword").val()){
                                        $("#changePrompt").text("Password confirmation does not match").fadeIn("fast");
                                    } else{
                                        $.post("../php/login.php",
                                        {
                                            query: "change",
                                            password: $("#newPassword").val(),
                                            username: name
                                        },
                                        function(data){
                                            $(".form-control").val("");
                                            $("#changePrompt").hide("fast");
                                            $("#myModal").modal("toggle");
                                            if(data == "success"){
                                                alert("Succesfully changed your password");
                                            } else if(data == "failed"){
                                                alert("Failed to changed your password");
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
                                            username: name
                                        },
                                        function(data){
                                            sessionStorage.setItem("username", name);
                                            if(data == "admin"){
                                                window.location.replace("/admin/requests.html");
                                            }
                                            if(data == "client"){
                                                window.location.replace("http://192.168.1.6:8084/TruckRentals/client/home.jsp?username="+name);
                                            }
                                            if(data == "provider"){
                                                $.post("../php/login.php", 
                                                {
                                                    query: "user_id",
                                                    username: name
                                                }, 
                                                function(data){
                                                    window.location.replace("http://provider.rentals.com:3000/"+data);
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
    }
});