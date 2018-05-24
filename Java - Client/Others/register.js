$('document').ready(function() {
/* handle form validation */
$("#registerform").validate({
rules:
	{
		uname:{
		required: true,
		minlength: 3
	},
	pwd: {
		required: true,
		minlength: 8,
		maxlength: 15
	},
	rpwd: {
		required: true,
		equalTo: '#password'
	},
	user_email: {
		required: true,
		email: true
	},
	},
	messages:
	{
	uname: "please enter username",
	pwd:{
	required: "please provide a password",
	minlength: "password at least have 8 characters"
	},
	email: "please enter a valid email address",
	rpwd:{
	required: "please retype your password",
	equalTo: "password doesn't match !"
	}
	},
	submitHandler: submitForm
});
/* handle form submit */
function submitForm() {
var data = $("#registerform").serialize();
// AJAX code to submit form.
$.ajax({
type: "POST",
url: "ajaxjs.php",
data: dataString,
cache: false,
success: function(html) {
alert(html);
}
});
}
return false;
}