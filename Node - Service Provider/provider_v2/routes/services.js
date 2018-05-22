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
	var sql = "SELECT password,status FROM users WHERE username = ?";

	connection.query(sql,[username],(err,res,fields) => {
		console.log(err);
		console.log(res);
		console.log(fields);
		if(res.length == 1){
			if(res[0].password === password){
				callback(null, res[0].satus);
			} else {
				callback(err);
			}
		} else {
			callback(err);
		}
	});
}

exports.addTruck = function (user,truck,callback){

	var sql = "INSERT INTO trucks SET ?";

	connection.query(sql,[truck],(err,res,fields) => {
		
	});

}
exports.getTrucks = function(user,callback){

	var trucks = [];

	var sql = "SELECT * FROM trucks WHERE trucks.provier_id = ?";

	connection.query(sql,[truck,[user]],(err,res,fields) => {
		if(err){
			callback(err);
		} else {
			for(i in res){
				trucks[i] = res[i];
			}
			callback(null,trucks);
		}
	});

}

exports.getRequests = function(user,callback){

	var transactions = [];
	var clients = [];

	var sql = "SELECT * FROM transactions INNER JOIN users ON transactions.provider_id = users.user_id INNER JOIN trucks ON transactions.truck_id = trucks.truck_id WHERE transactions.provider_id = ?";

	connection.query(sql,[user],(err,res,fields) => {
		console.log(err);
		console.log(res);
		if(err){
			callback(err);
		} else {
			for(i in res){
				transactions[i] = res[i];
			}
			var sql = "SELECT * FROM transactions INNER JOIN users ON transactions.client_id = users.user_id INNER JOIN trucks ON transactions.truck_id = trucks.truck_id WHERE transactions.provider_id = ?";

			connection.query(sql,[user],(err,resp,fields) => {
			console.log(err);
			console.log(res);
				if(err){
					callback(err);
				} else {
					for(j in resp){
						clients[j] = resp[j];
					}
				}
				callback(null,transactions,clients);
			})
		}
	})
}