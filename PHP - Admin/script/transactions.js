$(document).ready(function(){
    /*if(sessionStorage.length == 0){
        window.location.replace("../index.html");
    }*/
    $("#transaction").html("<small style=\"margin-left: 20px\">Loading Transactions...</small>");
    
    $.post("../php/database.php",
    {
        function: "transactions"
    },
    function(data){
        $("#transaction").html(data).hide().slideDown("fast");
        if($("#transaction").is(":empty")){
            $("#transaction").html("<small style=\"margin-left: 20px\">There are no transactions</small>");
        }
    });
    
    $(".btn-secondary").click(function(){
        $(".badge-success").parent().parent().parent().parent().hide();
        $(".badge-warning").parent().parent().parent().parent().hide();
        $(".badge-danger").parent().parent().parent().parent().hide();
        $(".badge-success").parent().parent().parent().parent().show("fast");
        $(".badge-warning").parent().parent().parent().parent().show("fast");
        $(".badge-danger").parent().parent().parent().parent().show("fast");
        if($(".badge-success").length == 0 && $(".badge-warning").length == 0 && $(".badge-danger").length == 0){
            $("#none").slideDown("fast");
        } else {
            $("#none").hide();
        }
    });
    
    $(".btn-success").click(function(){
        $(".badge-success").parent().parent().parent().parent().show("fast");
        $(".badge-warning").parent().parent().parent().parent().hide();
        $(".badge-danger").parent().parent().parent().parent().hide();
        if($(".badge-success").length == 0){
            $("#none").slideDown("fast");
        } else {
            $("#none").hide();
        }
    });
    
    $(".btn-warning").click(function(){
        $(".badge-success").parent().parent().parent().parent().hide();
        $(".badge-warning").parent().parent().parent().parent().show("fast");
        $(".badge-danger").parent().parent().parent().parent().hide();
        if($(".badge-warning").length == 0){
            $("#none").slideDown("fast");
        } else {
            $("#none").hide();
        }
    });
    
    $(".btn-danger").click(function(){
        $(".badge-success").parent().parent().parent().parent().hide();
        $(".badge-warning").parent().parent().parent().parent().hide();
        $(".badge-danger").parent().parent().parent().parent().show("fast");
        if($(".badge-danger").length == 0){
            $("#none").slideDown("fast");
        } else {
            $("#none").hide();
        }
    });
    
    $("#logout").click(function(){
        sessionStorage.removeItem("username");
        window.location.replace("../index.html");
    });
});