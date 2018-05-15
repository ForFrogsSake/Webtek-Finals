var http = require('http');
var mysql = require('mysql');
var express = require("express");
var bodyparser = require('body-parser');
var path = require('path');
var myConnection = require('express-myconnection');
var app = express();
var expressValidator = require('express-validator');

var config = require('./config');

var dbOptions = {
    host     : config.database.host,
    user     : config.database.user,
    password : config.database.password,
    port     : config.database.port,
    database : config.database.database
}


app.use(myConnection(mysql, dbOptions, 'pool'))

// connection.connect(function(err){
//     if(err) throw err;
//     console.log('Connection Established.');
//     connection.query("SELECT * FROM trucks", function(error,result,fields){
//         if(error) throw error;
//         console.log(result);
//     })
// });

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.engine('.html', require('ejs').renderFile);

app.use(expressValidator());

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

app.use(flash())

app.use(express.static(path.join(__dirname+'/public')));

app.get('/', function(req, res){
    res.render('index.ejs', {

    });
});

app.get('/signup.ejs', function(req, res, next){
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

app.get('/login.ejs', function(req, res, next){
    res.render('login.ejs')
});

app.post('/add', function(req, res, next){

    req.assert('fName', 'First name is required').notEmpty();
    req.assert('lName', 'Last name is required').notEmpty();
    req.assert('username', 'Username is required').notEmpty();
    req.assert('email', ' Email is required').notEmpty();
    req.assert('phone_number', 'Phone number name is required').notEmpty();
    req.assert('password', 'Password name is required').notEmpty();
    req.assert('re_password', 'Confirm password name is required').notEmpty();

    var errors = req.validationErrors()

    var num = req.body.phone_number;

    var pwd = req.body.password;
    var repwd = req.body.re_password;

    if( !errors) {
        if(pwd == repwd){
            if(num.lenght >= 11){
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
                        if (err) {
                            req.flash('error', error)
                            res.render('signup.ejs', {
                                nfName: newProvider.fName,
                                lName: newProvider.lName,
                                username: newProvider.username,
                                email: newProvider.email,
                                phone_number: newProvider.phone_number,
                                password: newProvider.password
                            })
                        } else {
                            req.flash('succes', 'Data added successfully')

                            res.render('signup.ejs', {
                                fName: '',
                                lName: '',
                                username: '',
                                email: '',
                                phone_number: '',
                                password: ''
                            })
                        }
                    })
                })
            } else {
                console.log('phone error');
                var error_message = 'Invalid phone number. Please try again.'
                req.flash(error_message);
                res.render('signup.ejs', {
                    fName: req.body.fName,
                    lName: req.body.lName,
                    username: req.body.username,
                    email: req.body.email,
                    phone_number: req.body.phone_number,
                    password: req.body.password
            })
            }
        } else {
            console.log('password error');
            var error_message = 'Confirm password does not match your password. Please try again.'
            req.flash(error_message);
            res.render('signup.ejs', {
                fName: req.body.fName,
                lName: req.body.lName,
                username: req.body.username,
                email: req.body.email,
                phone_number: req.body.phone_number,
                password: req.body.password
            })
        }
    } else {
        console.log(errors.msg);
        var error_message = ''
        errors.forEach(function(error){
            error_message += error.msg + '<br>'
        })

        req.flash('error', error_message)

        res.render('signup.ejs', {
            fName: req.body.fName,
            lName: req.body.lName,
            username: req.body.username,
            email: req.body.email,
            phone_number: req.body.phone_number,
            password: req.body.password
        })
    }
});

app.listen(3000, function(err){
    if(err) throw err;
    console.log('Server running at port 3000: http://127.0.0.1:3000');
});

var server = app.listen(8081, function(err){
    var host = server.address().address
    var port = server.address().port
    if(err) throw err;
    console.log('Server(Server).');
});

//login

    app.get('/login', function(req, res){
        res.render('home.ejs');
    });