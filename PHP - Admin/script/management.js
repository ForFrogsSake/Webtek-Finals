$(document).ready(function(){
    if(sessionStorage.length == 0){
        window.location.replace("../index.html");
    }
    
    $.post("../php/database.php",
    {
        function: "management",
        username: sessionStorage.getItem("username")
    },
    function(data){
        $("tbody").html(data).hide().slideDown("fast");
        $("thead").slideDown("fast");
        $("#load").remove();
        addHandler();
        if($("tbody").is(":empty")){
            $("#cardBody").empty();
            $("#cardBody").html("<div style=\"padding:20px 0px 20px 0px\"><small>There are no accepted and denied user accounts</small></div>").hide().slideDown("fast");
        }
    });
    
    $("#search").on("keyup", function() {
        var value = $(this).val().toLowerCase();
        $("tbody tr").filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
    
    function addHandler(){
        $(".btn-danger").click(function(){
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
            $(this).parent().parent().find(".btn").addClass("btn-success");
            addHandler();
        });

        $(".btn-success").click(function(){
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
            $(this).parent().parent().find(".btn").addClass("btn-danger");
            addHandler();
        });
    }
    
    $("#logout").click(function(){
        sessionStorage.removeItem("username");
        window.location.replace("../index.html");
    });
});