var express = require('express');
var mysql = require('mysql');
var app = express();

var server = mysql.createPool({
	server limit: 100000000,
	host: 'localhost',
	user: 'root',
	password: ' ',
	database: 'truck_rental' 
});

server.connect(function(error)){
	if(!!error) {
		console.log('Error');
		} else {
			console.log('Connected');
	}
});

app.get('/', function(req, resp){
// about mysql
server.query("select * from truck_rental", function(error, rows, fields)
	if (!!error){
		console.log('Error in the query');
		} else {
			console.log('Successful')
			console.log(rows);
		}
});
});

app.listen(1337);
