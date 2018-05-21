<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>

<% 
  
       String trucknum =request.getParameter("trucknum");
       String daynum = request.getParameter("lname");
       String startdate = request.getParameter("exp");
       java.util.Date start = new SimpleDateFormat("yyyy-mm-dd").parse(startdate);
       java.sql.Date date = new java.sql.Date(start.getTime());
   
      
%>

