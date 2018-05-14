$(document).ready(function(){

    $("#display").click(function() {

        $.ajax({
            type: "GET",
            url: "login.php",
            dataType: "html",
            success: function(response){
                $("#submit").html(response);
            }
        });
    });
});

function logIn(){
	console.log('ad');
	var transaction = db.transaction(["users"]);
	var objectStore = transaction.objectStore("users");

	var username = document.forms['signInForm']['username'].value;
	var password = document.forms['signInForm']['passwd'].value;

	var request = objectStore.get(username);

	request.onsuccess = function(e){ 
		
		if(request.result == undefined){ 
			console.log('User not found!');
			document.getElementById("Error").innerHTML = "Username or Password isncorrect!";
			window.location = "signin.html";
		}else{
			console.log(request.result.username); 
			if (request.result.password == password){ 
				console.log('yay');
				sessionStorage.setItem("user", JSON.stringify({"username": username, "password": password}));
			
			}else { 
				console.log('wrong password');
				

				

				document.getElementById("passwordError").innerHTML = "Incorrect password";
			}
		}
	};

	request.onerror = function(e){
		console.log('failed objectStore');
	};
};