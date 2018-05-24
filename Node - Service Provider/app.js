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
  host: "192.168.5.81",
  port: "3306",
  user: "root",
  password: "",
  database: "truck_rentals"
});

var app = express();

app.use(session({
  store: new FileStore,
  secret: 'secret',
  resave: false,
  saveUninitialized: true,
  cookie: { maxAge: 360000000, secure: false }
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
app.get('/register', (req, res) => {
  var mess = "";
  res.render('register.ejs', {message : mess});
});

app.get('/:id', (req, res) => {
  var id = req.params.id;
  services.getRequests(id,(err,resp,respo) => {
    res.render('transactions.ejs', {transactions : resp, clients : respo, id : id});
  });
});

app.get('/:id/trucks', (req, res) => {
  var id = req.params.id;
  services.getTrucks(id,(err,resp) => {
    res.render('trucks.ejs', {trucks : resp, id : id});
  });
});

app.get('/:id/transactions', (req, res) => {
  var id = req.params.id;
  if (!req.session.user) {
    services.getRequests(id,(err,resp,respo) => {
      res.render('transactions.ejs', {transactions : resp, clients : respo, id : id});
    })
  } else {

  }
});

app.get('/:id/addTruck', (req, res) => {
  var id = req.params.id;
  if (!req.session.user) {
    res.render('addTruck.ejs', {id : id, message : ""});
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


  var sql = "SELECT user_id FROM address ORDER BY user_id DESC LIMIT 0,1 ";
  connection.query(sql, function (err, row, fields) {
    if (!err || row[0] == null) {
      console.log(row[0]);
      var id = row[0].user_id + 1;
      console.log(id);
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
  
      var newProviderAddress = {
        user_id: id,
        house_details: req.body.house_details,
        street: req.body.street,
        barangay: req.body.barangay,
        municipality: req.body.municipality,
        city: req.body.city,
        province: req.body.province
      }

  var sql = 'SELECT username FROM users WHERE username = ?';

  connection.query(sql, req.body.username, (err, resp, fields) => {
    if (resp[0]) {
      var mes = 'Username already taken';
      res.render('register.ejs', {message : mes});
    } else {
      var sql = 'SELECT email FROM users WHERE email = ?';

      connection.query(sql, req.body.email, (err, respo, fields) => {
        if (respo[0]) {
          var mes = 'Email already taken';
          res.render('register.ejs', {message : mes});
        } else {
          var sql = 'SELECT phone_number FROM users WHERE phone_number = ?';

          connection.query(sql, req.body.number, (err, respos, fields) => {
            if (respos[0]) {
              var mes = 'Phone number already taken';
              res.render('register.ejs', {message : mes});
            } else {
              var sql = 'INSERT INTO users SET ?';

              connection.query(sql, newProvider, (err, respons, fields) => {
                if(!err){
                  console.log(respons[0]);
                  
                  var sql = 'INSERT INTO address SET ?';

                  connection.query(sql,newProviderAddress,(err,response,fields) => {
                    if(!err){
                      console.log(err);
                      console.log(response);
                      console.log(fields);
                      var mes = 'Registration completed';
                      res.render('register.ejs', {message : mes});
                    }
                  })
                }
                console.log(err);                
              })
            }
          })
        }
      })
    }
  })
}
  })
});

app.post('/:id/addTruck', (req, res) => {
  var id = req.params.id;
  var sql = "SELECT truck_id FROM trucks ORDER BY truck_id DESC LIMIT 0,1 ";

  connection.query(sql, function (err, row, fields) {
    if (!err || row[0] == null) {
      var newId = row[0].truck_id + 1;
      var truck = {
        truck_id: newId,
        provider_id: req.params.id,
        name: req.body.name,
        description: req.body.description,
        capacity: req.body.capacity,
        cost: req.body.cost,
        category: req.body.category,
        status: req.body.status,
        number_of_wheels: req.body.number_of_wheels,
        license_number: req.body.license_number
      }

      var sql = "INSERT INTO trucks SET ?";

      connection.query(sql, truck, (err, row, field) => {
        if(err){
          console.log(err);
          var mes = 'License number already taken';
          res.render('addTruck.ejs', {id : id , message : mes});
        } else if(row){
          console.log(row);
          var mes = 'Truck successfully added';
          res.render('addTruck.ejs', {id : id, message : mes});
        }

      });

    } else {
      console.log(err);
    }
  });
});

app.post('/:id/approve', (req, res) => {
  var id = req.params.id;
  var tId = req.body.transaction
  
  console.log(id);
  console.log(tId);

  var currDate = new Date();
  var date = currDate.getFullYear();
  if (((currDate.getMonth() + 1) < 10)) {
    date += '-0' + ((currDate.getMonth()) + 1);
  } else {
    date += '-' + ((currDate.getMonth()) + 1);
  }
  date += '-' + currDate.getDate();
  
  var sql = "UPDATE transactions SET request_status ='accepted', date_accepted = ? WHERE transaction_id = ?";

  connection.query(sql,[date,tId],(err,row,fields) => {
    if(err){
      console.log(err);
    } else if(row){
      console.log(row);
      services.getRequests(id,(err,resp,respo) => {
        res.render('transactions.ejs', {transactions : resp, clients : respo, id : id});
      })
    }
  });

});

app.post('/:id/deny', (req, res) => {
  var id = req.params.id;
  var tId = req.body.transaction;
  
  var sql = "UPDATE transactions SET request_status ='denied' WHERE transaction_id = ?";

  connection.query(sql,[tId],(err,row,fields) => {
    if(err){
      console.log(err);
    } else if(row){
      console.log("row");
      console.log(row);
      services.getRequests(id,(err,resp,respo) => {
        res.render('transactions.ejs', {transactions : resp, clients : respo, id : id});
      })
    }
  });
});

app.get('/logout', (req, res) => {

});

app.post('/login', (req, res) => {
  
});

module.exports = app;

// app.post('/login', function (request, response) {
//   'use strict';
//   var username = request.body.username,
//       password = sha1(request.body.password),
//       sql = "Select * from accounts natural join customer where username = '" + username + "';",
//       reply1 = "<script> alert('Username does not exist'); window.history.back(); </script>",
//       reply2 = "<script> alert('Wrong password'); window.history.back(); </script>",
//       reply3 = "<script> alert('You are now logged in'); window.history.back(); </script>";
//   connection.query(sql, function (err, result, field) {
//       if (err) {
//           throw err;
//       }
//       if (result.length === 1) {
//           if (result[0].password === password) {
//               request.session.loggedin = true;
//               request.session.username = username;
//               request.session.email = result[0].email;
//               request.session.password = password;
//               request.session.first_name = result[0].first_name;
//               request.session.last_name = result[0].last_name;
//               request.session.address = result[0].address;
//               request.session.birthdate = result[0].birthdate;
//               request.session.contact = result[0].contact_number;
//               response.redirect('/');
//           } else {
//               response.send(reply2);
//           }

//       } else {
//           response.send(reply1);
//       }
//   });
// });

// <style>
//     body{
//         display: none;
//     }
// </style>

// <?php
// include 'access_db.php';

// $conn = OpenCon();
// session_start();
// $username = $_POST['username'];
// $password = sha1($_POST['password']);

// $username = mysqli_real_escape_string($conn, $username);
// $password = mysqli_real_escape_string($conn, $password);

// $sql = "SELECT * FROM accounts where username = '$username';";
// $result = $conn->query($sql);
// if (isset($_POST['login'])) {

//     if ($result->num_rows > 0) {
//         // output data of each row
//         while ($row = $result->fetch_assoc()) {
//             if ($row['password'] == $password) {
//                 switch ($row['status']) {
//                     case "r":
//                         echo "
//                         <script>
//                             alert('Registration rejected by admin.');
//                             window.location.replace('/');
//                         </script>
//                         ";
//                         break;
//                     case "p":
//                         echo "
//                         <script>
//                             alert('Your account is still pending.');
//                             window.location.replace('/');
//                         </script>
//                         ";
//                         break;
//                     case "a":
//                         switch ($row['account_type']) {
//                             case "sa":
//                                 $password = $_POST['password'];
//                                 echo "
//                                 <form method='POST' action='http://admin.tenterent.com:8080/LoginServlet' id='login_form'>
//                                 <input type='text' name='username' value='$username'>
//                                 <input type='password' name='password' value='$password'>
//                                 <input type='submit' value='login' name='login'>
//                                 </form>
//                                 ";
//                                 break;
//                             case "sp":
//                                 $password = $_POST['password'];
//                                 echo "
//                                 <form method='POST' action='http://provider.tenterent.com:8082/php/sp_login.php' id='login_form'>
//                                     <input type='text' name='username' value='$username'>
//                                     <input type='password' name='password' value='$password'>
//                                     <input type='submit' value='login' name='login'>
//                                 </form>
//                                 ";
//                                 break;
//                             case "c":
//                                 $password = $_POST['password'];
//                                 echo "
//                                 <form method='POST' action='http://www.tenterent.com:8081' id='login_form'>
//                                     <input type='text' name='username' value='$username'>
//                                     <input type='password' name='password' value='$password'>
//                                     <input type='submit' value='login' name='login'>
//                                 </form>
//                                 ";
//                                 break;
//                             case "a":
//                                 $password = $_POST['password'];
//                                 echo "
//                                 <form method='POST' action='http://admin.tenterent.com:8080/LoginServlet' id='login_form'>
//                                     <input type='text' name='username' value='$username'>
//                                     <input type='password' name='password' value='$password'>
//                                     <input type='submit' value='login' name='login'>
//                                 </form>
//                                 ";
//                                 break;
//                         }
//                         echo "
//                         <script>
//                         window.onload = function(){
//                             document.getElementById('login_form').submit();
//                         }
//                         </script>
//                         ";
//                         break;
//                 }

//             } else {

//                 echo "
//                     <script>
//                         alert('Wrong password.');
//                         window.history.back();
//                     </script>
//                 ";

//             }
//         }
//     } else {
//         echo "
//             <script>
//                 alert('Account doesn\'t exist.');
//                 window.history.back();
//             </script>
//         ";

//     }

// } else {
//     echo "Failed";
// }

// CloseCon($conn);
