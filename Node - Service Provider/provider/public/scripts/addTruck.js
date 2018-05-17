$(function(){				
    $('#add').click(function(err){
    err.preventDefault();
    var data = $('form').serializeArray();
    $.ajax({
    type: 'POST',
    data: JSON.stringify(data),
    contentType: 'application/json',
    url: 'http://truckrental.com:3000/provider/addTruck',
    success: function(data){
                console.log('success'),
                console.log(JSON.stringify(data));
            }
        });
    });
});
