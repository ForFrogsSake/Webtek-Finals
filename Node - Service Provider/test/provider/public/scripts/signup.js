$(document).ready(function(){
    $("input[name=re_password]").keypress(function(event) {
        if (event.keyCode == 13) {
            query();
         }
    });

     $("#submit").on("click",function (event) {
         event.preventDefault();
         event.stopPropagation();
         console.log();

        $.ajax({
            url: 'http://truckrental.com:3000/provider/signup',
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data)
        })

         $.post("/provider/register",
         $(this).serialize(),function( data ) {
          console.log(data);
        });
     })
 });