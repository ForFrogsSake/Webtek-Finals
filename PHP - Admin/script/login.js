$(document).ready(function(){
    $("#password").keypress(function(event) {
        if (event.keyCode == 13) {
            query();
         }
    });
    
    $("#signin").click(function(){
        query();
    });
    
    function query(){
        $.post("../php/login.php",
        {
            query: "username",
            username: $("#username").val()
        },
        function(data){
            if(data !== $("#username").val()){
                $("#prompt").text("Invalid username");
            } else{
                $.post("../php/login.php",
                {
                    query: "password",
                    password: $("#password").val()
                },
                function(data){
                    if(data !== $("#password").val()){
                        $("#prompt").text("Invalid password");
                    } else{
                        $.post("../php/login.php",
                        {
                            query: "type",
                            username: $("#username").val()
                        },
                        function(data){
                            sessionStorage.setItem("username", $("#username").val());
                            window.location.replace(data+"/"+ data +"signup.html");
                        });
                    }
                });
            } 
        });
    }
});