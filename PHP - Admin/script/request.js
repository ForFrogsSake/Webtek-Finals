$(document).ready(function(){
    $("#username").text("Welcome " + sessionStorage.getItem("username"));
    $("#client").html("<small>Loading Requests...</small>");
    $("#provider").html("<small>Loading Requests...</small>");
    
    $.post("../php/database.php",
    {
        function: "display",
        type: "client"
    },
    function(data){
        $("#client").html(data).hide().fadeIn("fast");
        denyHandler();
        acceptHandler();
    });
    
    $.post("../php/database.php",
    {
        function: "display",
        type: "provider"
    },
    function(data){
        $("#provider").html(data).hide().fadeIn("fast");
        denyHandler();
        acceptHandler();
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
                    $(this).parent().remove();
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
    
});