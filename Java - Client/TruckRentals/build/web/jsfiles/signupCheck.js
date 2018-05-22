/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function(){
    $("#fname").keypress(function(event) {
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
        $.post("../php/signupcheckquery.jsp",
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
                                window.location.replace("/admin/requests.html");
                            }
                            if(data == "provider"){
                                window.location.replace("/admin/requests.html");
                            }
                        });
                    }
                });
            } 
        });
    }
});
