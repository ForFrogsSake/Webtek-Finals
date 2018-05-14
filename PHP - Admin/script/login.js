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

	request.onsuccess = function(e){ //e = laman ng request 
		//check if result nung request is undefined
		//undefined meaning walang username na nahanap sa db
		if(request.result == undefined){ 
			console.log('User not found!');
			document.getElementById("Error").innerHTML = "Username or Password isncorrect!";
			window.location = "signin.html";
		}else{
			console.log(request.result.username); //if di siya undefined print yung username
			if (request.result.password == passwd){ //yung passwd ay correct
				console.log('yay');
				sessionStorage.setItem("user", JSON.stringify({"username": username, "password": passwd}));
				//to check if the user is login 
				//window.location = "../index.html"; //punta siya sa home
			}else { //if hindi correct
				console.log('wrong password');
				//window.location = "signin.html"; //reload yung sign html;

				//var errorNode = document.createElement("p");

				document.getElementById("passwordError").innerHTML = "Incorrect password";
			}
		}
	};

	request.onerror = function(e){
		console.log('failed objectStore');
	};
};