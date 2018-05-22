var mysql = require('mysql');
var fs = require('fs');

var connection = mysql.createConnection({
	host: "localhost",
	user: "root",
	password: "",
	database: "truck_rentals"

});

connection.connect((err) => {
	if(err) throw err;
});

exports.authenticate = function(username,password,callback){
	var sql = "SELECT password FROM users WHERE username = ?";

	connection.query(sql,[username],(err,res,fields) => {
		if(res.length == 1){
			if(res[0].passwrod === password){
				callback(null, res[0].satus);
			} else {
				callback(1);
			}
		} else {
			callback(-1);
		}
	});
}

exports.addTruck = function (user,truck,callback){

	var sql = "INSERT INTO trucks SET ?";

	connection.query(sql,[truck],(err,res,fields) => {
		
	})

}
