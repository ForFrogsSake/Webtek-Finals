<%-- 
    Document   : registerRequest
    Created on : 05 12, 18, 12:54:19 AM
    Author     : HP
--%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign-up Request</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    </head>
    <body style="background-color:#F8F9F9">
        
        <sql:setDataSource var="trucks"
            driver="com.mysql.jdbc.Driver"
            user="root"
            password= ""
            url="jdbc:mysql://localhost/truck_rentals?useSSL=false"/>
        <c:choose>
            <c:when test = "${ not empty param.fName && not empty param.lName && not empty param.username
                          && not empty param.email && not empty param.password && not empty param.phone}">     
                <sql:update var="result" dataSource="${trucks}">
                    INSERT INTO `users` (`user_id`, `fname`, `mname`, `lname`, `email`, `phone_number`,
                                        `date_registered`, `username`, `password`, `user_type`, `status`,
                                        `request_status`) VALUES (NULL, ?, NULL, ?, ?, ?, CURRENT_DATE(), ?, ?, 'client', 'disabled', 'pending');
                    <sql:param>
                        value= "${param.fname}"
                        value= "${param.lname}"
                        value= "${param.email}"
                        value= "${param.phone}"
                        value= "${param.username}"
                        value= "${param.password}"
                    </sql:param>
                </sql:update>
                <h1>Sign-up Request has been sent! Kindly wait for approval. Thank you.</h1>
            </c:when>
            <c:otherwise>
                <h1>Please enter mandatory information.</h1>
            </c:otherwise>
        </c:choose>
    </body>
</html>
