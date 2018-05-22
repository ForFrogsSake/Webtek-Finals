<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>

<% 
  
       String trucknum =request.getParameter("truckid");
   
      out.print(trucknum);
%>

