<%-- 
    Document   : editProfile
    Created on : 05 16, 18, 9:23:44 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import = "java.sql.*" %>

<%
    
   
   String newPhone = request.getParameter("newphone");
   String oldpass = request.getParameter("oldpass");
   String newpass = request.getParameter("newpass");
   String repass = request.getParameter("repass");
   
%>
