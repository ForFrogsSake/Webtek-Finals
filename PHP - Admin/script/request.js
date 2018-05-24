$(document).ready(function(){
    if(sessionStorage.length == 0){
        window.location.replace("../index.html");
    }
    $("#username").text("Welcome " + sessionStorage.getItem("username"));
    $("#client").html("<small>Loading Requests...</small>");
    $("#provider").html("<small>Loading Requests...</small>");
    
    $.post("../php/database.php",
    {
        function: "requests",
        type: "client"
    },
    function(data){
        $("#client").html(data).hide().slideDown("fast");
        denyHandler();
        acceptHandler();
    });
    
    $.post("../php/database.php",
    {
        function: "requests",
        type: "provider"
    },
    function(data){
        $("#provider").html(data).hide().slideDown("fast");
        denyHandler();
        acceptHandler();
    });
    
    $("#logout").click(function(){
        sessionStorage.removeItem("username");
        window.location.replace("http://client.rentals.com:8084/TruckRentals/client/intro.jsp");
    });
    
    function denyHandler(){
        $(".deny").click(function(){
            $(this).parent().next().children().fadeOut("fast", function(){
                $(this).parent().parent().hide("slow", function(){
                    $.post("../php/database.php",
                    {
                        function: "deny",
                        username: $(this).find("strong").text(),
                    });
                    $(this).remove();
                    if($("#client").is(":empty")){
                        $("#client").html("<small>There are no account requests</small>");
                    }
                    if($("#provider").is(":empty")){
                        $("#provider").html("<small>There are no account requests</small>");
                    }
                });
            });
        });
    }
    
    function acceptHandler(){
        $(".accept").click(function(){
            $(this).parent().prev().children().fadeOut("fast", function(){
                $(this).parent().parent().hide("slow", function(){
                    $.post("../php/database.php",
                    {
                        function: "accept",
                        username: $(this).find("strong").text(),
                    });
                    $(this).remove();
                    if($("#client").is(":empty")){
                        $("#client").html("<small>There are no account requests</small>");
                    }
                    if($("#provider").is(":empty")){
                        $("#provider").html("<small>There are no account requests</small>");
                    }
                });
            });
        });
    }
    
    $("#searchClient").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#client").find(".row").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
    
    $("#searchProvider").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("#provider").find(".row").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
    
});