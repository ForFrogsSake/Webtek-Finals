var http = require('http');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var mysql = require('mysql');
var session = require('express-session');
var FileStore = require('session-file-store')(session);
var formidable = require('express-formidable');

var services = require('./routes/services');

var connection = mysql.createConnection({
  host: '192.168.1.2',
  user: 'root',
  password: '',
  database: 'truck_rentals'
});

var app = express();

app.use(session({
  store: new FileStore,
  secret: 'secret',
  resave: false,
  saveUninitialized: true,
  cookie: { maxAge: 3600000, secure: false }
}));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.listen(3000, (err) => {
  if (err) throw err;
  console.log("listening on port 3000");
});

//GET
app.get('/', (req, res) => {
  if (!req.session.user) {
    services.authenticate(req.fields['username'], req.fields['password'], (err,stat) => {
      if(!err){
        if(stat === "approved"){
          req.session.user = req.fields['username'];
          res.writeHead(200,{'Content-Type' : 'text/plain'});
					res.end("1_authenticated");
        } else {
          response.writeHead(200,{'Content-Type' : 'text/plain'});
					response.end("unapproved");
        }
      }else{
        response.writeHead(200,{'Content-Type' : 'text/plain'})
				response.end("0_unauthenticated");
      }
    });
    res.render('index.ejs');
  } else {

  }
});

app.get('/trucks', (req, res) => {
  if (!req.session.user) {
    res.redirect('/');
  } else {

  }
});

app.get('/transactions', (req, res) => {
  if (!req.session.user) {
    res.render('transactions.ejs');
  } else {

  }
});

app.get('/profile', (req, res) => {
  if (!req.session.user) {
    res.render('profile.ejs');
  } else {

  }
});

app.get('/register', (req, res) => {
  if (!req.session.user) {
    res.sendFile(path.join(__dirname + '/public/html/register.html'));
  } else {

  }
});

//POST

app.post('/register', (req, res) => {

  var currDate = new Date();
  var date = currDate.getFullYear();
  if (((currDate.getMonth() + 1) < 10)) {
    date += '-0' + ((currDate.getMonth()) + 1);
  } else {
    date += '-' + ((currDate.getMonth()) + 1);
  }
  date += '-' + currDate.getDate();

  var newProvider = {
    fName: req.body.fName,
    lName: req.body.lName,
    email: req.body.email,
    phone_number: req.body.number,
    date_registered: date,
    username: req.body.username,
    password: req.body.password,
    user_type: 'provider',
    status: 'disabled',
    request_status: 'pending'
  }

  var sql = 'SELECT username FROM users WHERE username = ?';

  connection.query(sql, req.body.username, (err, resp, fields) => {
    if (res[0]) {
      console.log(resp[0]);
      console.log("Username taken.");
      res.status(500).send('Username already taken.');
    } else {
      var sql = 'SELECT email FROM users WHERE email = ?';

      connection.query(sql, req.body.email, (err, resp, fields) => {
        if (res[0]) {
          console.log(resp[0]);
          console.log("Email taken.");
          res.status(500).send('Email already taken.');
        } else {
          var sql = 'SELECT phone_number FROM users WHERE phone_number = ?';

          connection.query(sql, req.body.number, (err, resp, fields) => {
            console.log(resp[0]);
            if (resp[0]) {
              console.log("Phone number taken.");
              res.status(500).send('Phone number already taken.');
            } else {
              console.log("Okay.");
              var sql = 'INSERT INTO users SET ?';

              connection.query(sql, newProvider, (err, respo, fields) => {
                console.log(err);
                console.log(respo);
                console.log(fields);
              })
            }
          })
        }
      })
    }
  })
});

app.post('/addTruck', (req,res) => {
  var truck = {
    name: req.body.name,
    description: req.body.description,
    capacity: req.body.capacity,
    cost: req.body.cost,
    category: req.body.category,
    status: 'available',
    number_of_wheels: req.body.number_of_wheels,
    license_number: license_number
  }
});

app.post('/approve', (req,res) => {

});

app.post('/reject', (req,res) => {

});

app.get('/logout', (req, res) => {

});

module.exports = app;

