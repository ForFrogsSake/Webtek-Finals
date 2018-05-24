var http = require('http');
var mysql = require('mysql');
var express = require("express");
var bodyparser = require('body-parser');
var path = require('path');
var formidale = require('express-formidable');
var app = express();
var expressValidator = require('express-validator');
var router = express.Router();
var $ = require('jquery');
var myConnection = require('express-myconnection');

var AppError = require('./errors/AppError');
var EmailTakenError = require('./errors/EmailTakenError');
var RequestValidationError = require('./errors/RequestValidationError');

var config = require('./config');

var dbOptions = {
    host     : config.database.host,
    user     : config.database.user,
    password : config.database.password,
    port     : config.database.port,
    database : config.database.database
}

app.use(myConnection(mysql, dbOptions, 'pool'));

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.engine('.html', require('ejs').renderFile);

app.use('/js', express.static(__dirname+'/node_modules/bootstrap/dist/js'));
app.use('/js', express.static(__dirname+'/node_modules/tether/dist/js'));
app.use('/js', express.static(__dirname+'/node_modules/jquery/dist/js'));
app.use('/css', express.static(__dirname+'/node_modules/bootstrap/dist/css'));

app.use(expressValidator({
    errorFormatter: function(param, msg, value, location) {
        return {
          location,
          param: param,
          msg: msg,
          value: value
        }
    }
}));

app.use(bodyparser.json());
app.use(bodyparser.urlencoded({
    extended: true
}));

var methodOverride = require('method-override');

app.use(methodOverride(function(req, res){
    if(req.body && typeof req.body === 'object' && '_method' in req.body) {
        var method = req.body._method
        delete req.body._method
        return method
    }
}));

var flash = require('express-flash')
var cookieParser = require('cookie-parser');
var session = require('express-session');

app.use(cookieParser())
app.use(session({
    secret: "secret",
    resave: false,
    saveUninitialized: true,
    cookie: {maxAge: 60000}
}));

app.use(flash());

app.use(function(req, res, next){
    res.locals.success_msg = req.flash('success_msg');
    res.locals.error_msg = req.flash('error_msg');
    res.locals.errors = req.flash('error');
    next();
});

app.use(express.static(path.join(__dirname+'/public')));

app.get('/', function(req, res){
    res.render('index.ejs', {

    });
});

app.get('/provider/signup', function(req, res, next){
    res.render('signup.ejs',{
        fName: '',
        lName: '',
        username: '',
        email: '',
        phone_number: '',
        password: '',
        re_password: ''
    })
});

app.get('/provider/login', function(req, res, next){
    res.redirect('http://truckrentals.com');
});

app.post('/provider/register', function(req, res, next){

    var fName = req.body.fName;
    var lName = req.body.lName;
    var username = req.body.username;
    var email = req.body.email;
    var phone_number = req.body.phone_number;
    var password = req.body.password;
    var re_password = req.body.re_password;

    req.checkBody('fName', 'First name is invalid.').notEmpty();
    req.checkBody('lName', 'Last name is invalid.').notEmpty();
    req.checkBody('username', 'Username is invalid.').notEmpty();
    req.checkBody('email', ' Email is invalid.').isEmail();
    req.checkBody('phone_number', 'Phone number is invalid.').isLength({min: 11, max: 16});
    req.checkBody('password', 'Password is invalid. (Must contain atleast 8 characters.) ').isLength({min: 8}).equals(req.body.re_password);
    req.checkBody('re_password', 'Confirm password is invalid.').isLength({min: 8}).equals(req.body.password);

    var errors = req.validationErrors();

    var num = req.body.phone_number;

    var email = req.body.email;

    var msg = ''

    if( !errors) {
        var currDate = new Date();
            var date = currDate.getFullYear();
            if(((currDate.getMonth()+1) < 10)){
                date += '-0' + ((currDate.getMonth())+1);
            } else {
                date += '-' + ((currDate.getMonth())+1);
                }

            date += '-' + currDate.getDate();
            var newProvider = {
                email: req.sanitize('email').escape().trim(),
                phone_number: req.sanitize('phone_number').escape().trim(),
                date_registered: date,
                username: req.sanitize('username').escape().trim(),
                password: req.sanitize('password').escape().trim(),
                fName: req.sanitize('fName').escape().trim(),
                lName: req.sanitize('lName').escape().trim(),
                user_type: 'provider',
                status: 'disabled',
                request_status: 'pending'
               }
            req.getConnection(function(error, conn){
                conn.query('INSERT INTO users SET ?', newProvider, function(err, result){
                    if (err){
                        console.log(err);
                        req.checkBody('email', ' Email is already taken.').isEmail().isLength({min: 1});
                        errors = req.validationErrors();
                        res.render('signup.ejs',{
                        })
                } else {
                    console.log('SUCCESS');

                    res.render('home.ejs');
                }
            })
        })
    } else {
        console.log(errors);
        res.render('signup.ejs', {
            errors: errors 
        })
    }
});

app.get('/provider/addTruck', (req,res) => {
    res.render('addTruck.ejs');
});

app.post('/provider/addTruck', (req, res) => {
    var name = req.body.name;
    var description = req.body.description;
    var capacity = req.body.capacity;
    var cost = req.body.cost;
    var category = req.body.category;

    var newId = 1;

    req.checkBody('name', 'Name is invalid.').notEmpty();
    req.checkBody('capacity', 'Capacity is invalid.').notEmpty();
    req.checkBody('cost', 'cost is invalid.').notEmpty();
    req.checkBody('category', 'Category is invalid.').notEmpty();

    var errors = req.validationErrors();

    if(!errors){

        req.getConnection(function(err,conn){
        conn.query("SELECT truck_id FROM trucks ORDER BY truck_id DESC LIMIT 0,1 ", function(err,row,fields){
            if(err){
                console.log(err);
            } else {
                newId = row[0].truck_id + 1;
                var newTruck = {
                    truck_id: newId,
                    provider_id: 2,
                    name: req.sanitize('name').escape().trim(),
                    capacity: req.sanitize('capacity').escape().trim(),
                    cost: req.sanitize('cost').escape().trim(),
                    category: req.sanitize('category').escape().trim()
                }
                req.getConnection(function(err, conn){
                    conn.query('INSERT INTO trucks SET ?', newTruck, function(err, result){
                        if (err){
                            console.log(err);
                            res.render('addTruck.ejs',{
                                errors
                            })
                        } else {
                            console.log('SUCCESS');
                            console.log('result');
                            res.render('addTruck.ejs');
                        }
                    })
                })   
                console.log('Success');
            }
        })
    });
        } else {
            console.log(error);
        }
    });

app.post('/provider/signup-form', function(req, res){
    req.getConnection(function(err, conn){
        if (err) throw err;
        var currDate = new Date();
            var date = currDate.getFullYear();
            if(((currDate.getMonth()+1) < 10)){
                date += '-0' + ((currDate.getMonth())+1);
            } else {
                date += '-' + ((currDate.getMonth())+1);
                }
        var newProvider = {
            email: req.body.email,
            phone_number: req.body.phone_number,
            date_registered: date,
            username: req.body.username,
            password: req.body.password,
            fName: req.body.fName,
            lName: req.body.lName,
            user_type: 'provider',
            status: 'disabled',
            request_status: 'pending'
           }
        conn.query('INSERT INTO users SET ?', newProvider, function(err, result){
            if (err) throw err;
		    res.send("Created "+JSON.stringify(result));
        })
    })
});

app.listen(3000, function(err){
    if(err) throw err;
    console.log('Server running at port 3000');
});

function checkEmail(user,callback){
    var userEmail = user;
    
    var sql = "SELECT email FROM users WHERE email =?";

    connection.query(sql,user,(err,res,fields) => {
        if(err){
            console.log('Already taken.');
        } else {
            console.log('Success');
        }
    })
}

// function incrementTruckId(req, callback){
//     var newId = 1;
//     req.getConnection(function(err,conn){
//         conn.query("SELECT truck_id FROM trucks ORDER BY truck_id DESC LIMIT 0,1 ", function(err,row,fields){
//             if(!err){
//                 newId = row[0].truck_id + 1;
//                 callback();
//             } else {
//                 console.log(err);
//                 return callback(err);
//             }
//         });
//     })
// }