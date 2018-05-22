<%@ page import="java.sql.*"
         import= "java.text.SimpleDateFormat" 
         import= "java.util.Date" %>

<% 
  
       String trucknum =request.getParameter("truckid");
       String daynum =request.getParameter("daynum");  
       String startdate = request.getParameter("startdate");
       java.util.Date start = new SimpleDateFormat("yyyy-mm-dd").parse(startdate);
       java.sql.Date date = new java.sql.Date(start.getTime());
       
       out.print(trucknum + "    " + daynum + "     " + startdate);
%>

