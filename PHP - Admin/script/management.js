$(document).ready(function(){
    if(sessionStorage.length == 0){
        window.location.replace("../index.html");
    }
    
    $.post("../php/management.php", 
    {
        query: "check",
        username: sessionStorage.getItem("username")
    },
    function(data){
        if(data != "super"){
            $("#createAdmin").remove();
        }
    });
    
    function displayUsers(sort, order){
        $.post("../php/database.php",
        {
            function: "management",
            username: sessionStorage.getItem("username"),
            sort: sort,
            order: order
        },
        function(data){
            $("tbody").hide().html(data).slideDown("fast");
            $("thead").slideDown("fast");
            $("#users").DataTable();
            $("#load").remove();
            addHandler();
            if($("tbody").is(":empty")){
                $("#cardBody").empty();
                $("#cardBody").hide().html("<div style=\"padding:20px 0px 20px 0px\"><small>There are no accepted user accounts</small></div>").slideDown("fast");
            }
        });
    }
    
    displayUsers("user_id", "ASC");
    
    function addHandler(){
        $(".danger").click(function(){
            $.post("../php/database.php",
            {
                function: "disable",
                user_id: $(this).parent().parent().find("strong").text()
            });
            $(this).parent().parent().find(".status").text("disabled");
            $(this).parent().parent().find(".status").removeClass("badge-success");
            $(this).parent().parent().find(".status").addClass("badge-danger");
            $(this).parent().parent().find(".btn").text("Enable");
            $(this).parent().parent().find(".btn").removeClass("btn-danger");
            $(this).parent().parent().find(".btn").removeClass("danger");
            $(this).parent().parent().find(".btn").addClass("btn-success");
            $(this).parent().parent().find(".btn").addClass("success");
            addHandler();
        });

        $(".success").click(function(){
            $.post("../php/database.php",
            {
                function: "enable",
                user_id: $(this).parent().parent().find("strong").text()
            });
            $(this).parent().parent().find(".status").text("enabled");
            $(this).parent().parent().find(".status").removeClass("badge-danger");
            $(this).parent().parent().find(".status").addClass("badge-success");
            $(this).parent().parent().find(".request").text("accepted");
            $(this).parent().parent().find(".request").removeClass("badge-danger");
            $(this).parent().parent().find(".request").addClass("badge-success");
            $(this).parent().parent().find(".btn").text("Disable");
            $(this).parent().parent().find(".btn").removeClass("btn-success");
            $(this).parent().parent().find(".btn").removeClass("success");
            $(this).parent().parent().find(".btn").addClass("btn-danger");
            $(this).parent().parent().find(".btn").addClass("danger");
            addHandler();
        });
    }
    
    $("#create").click(function(){
        $("#prompt").fadeOut("fast", function(){
            $.post("../php/management.php",
            {
                query: "email",
                email: $("#email").val()
            },
            function(data){
                var email = data;
                $.post("../php/management.php",
                {
                    query: "number",
                    number: $("#number").val()
                },
                function(data){
                    var number = data;
                    $.post("../php/management.php",
                    {
                        query: "username",
                        username: $("#username").val()
                    },
                    function(data){
                        var username = data;
                        var expression = /.+@.+\..+/;
                        if($("#fname").val() == ""){
                            $("#prompt").text("First Name not provided").fadeIn("fast");
                        } else if ($("#lname").val() == ""){
                            $("#prompt").text("Last Name not provided").fadeIn("fast");
                        } else if ($("#email").val() == "" || email != "" || !(expression.test($("#email").val()))){
                            if(email != ""){
                                $("#prompt").text("Email is already taken").fadeIn("fast");
                            } else if($("#email").val() == ""){
                                $("#prompt").text("Email not provided").fadeIn("fast");
                            } else if(!(expression.test($("#email").val()))){
                                $("#prompt").text("Invalid email").fadeIn("fast");
                            }
                        } else if ($("#number").val() == "" || number != "" || $("#number").val().length < 11){
                            if(number != ""){
                                $("#prompt").text("Phone Number is already taken").fadeIn("fast");
                            } else if($("#number").val() == ""){
                                $("#prompt").text("Phone Number not provided").fadeIn("fast");
                            } else if($("#number").val().length < 11){
                                $("#prompt").text("Phone Number should be at least 11 digits").fadeIn("fast");
                            }
                        } else if ($("#details").val() == ""){
                            $("#prompt").text("House Details not provided").fadeIn("fast");
                        } else if ($("#province").val() == ""){
                            $("#prompt").text("Province not provided").fadeIn("fast");
                        } else if ($("#username").val() == "" || username != ""){
                            if(username != ""){
                                $("#prompt").text("Username is already taken").fadeIn("fast");
                            } else {
                                $("#prompt").text("Username not provided").fadeIn("fast");
                            }
                        } else if ($("#password").val() == "" || $("#password").val().length < 8){
                            if($("#password").val() == ""){
                                $("#prompt").text("Password not provided").fadeIn("fast");
                            } else if($("#password").val().length < 8){
                                $("#prompt").text("Password should be at least 8 characters").fadeIn("fast");
                            }
                        } else if ($("#confirm").val() == ""){
                            $("#prompt").text("Please confirm your password").fadeIn("fast");
                        } else{
                            if($("#password").val() !== $("#confirm").val()){
                                $("#prompt").text("Password confirmation does not match").fadeIn("fast");
                            } else{
                                $.post("../php/management.php",
                                {
                                    query: "insert",
                                    fname: $("#fname").val(),
                                    mname: $("#mname").val(),
                                    lname: $("#lname").val(),
                                    email: $("#email").val(),
                                    number: $("#number").val(),
                                    details: $("#details").val(),
                                    street: $("#street").val(),
                                    barangay: $("#barangay").val(),
                                    municipality: $("#municipality").val(),
                                    city: $("#city").val(),
                                    province: $("#province").val(),
                                    username: $("#username").val(),
                                    password: $("#password").val()
                                },
                                function(data){
                                    alert(data);
                                    if(data == "success"){
                                        alert("Administrator Account Creation Successful");
                                    } else{
                                        alert("Administrator Account Creation Failed");
                                    }
                                    $(".form-control").val("");
                                });
                            }
                        }
                    });
                });
            });
        });
    });
    
    $("#logout").click(function(){
        sessionStorage.removeItem("username");
        window.location.replace("../index.html");
    });
});