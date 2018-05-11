/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javafiles;

import dbase.connection.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "registerClient", urlPatterns = {"/registerClient"})
public class registerClient extends HttpServlet {
 
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        response.setStatus(HttpServletResponse.SC_OK);
        response.setHeader("Content-Type", "text/html");
        // or, alternatively..
        //   response.setContentType("text/html");

        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html lang=\"en\">");
        out.println("<head>");
        out.println("<title>REGISTER ACCOUNT</title>");
        out.println("<meta charset=\"utf-8\">");
        out.println("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">");
        out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css\">");
        out.println("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js\"></script>");
        out.println("<script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js\"></script>");
        out.println("<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js\"></script>");
        out.println("</head>");
        out.println("<body style=\"background-color:#F8F9F9\">");
        out.println("<div class=\"container\">");
        out.println("<div class=\"card card-register mx-auto mt-4\">");
        out.println("<!--card header-->");
        out.println("<div class=\"card-header\" style=\"background-color:#FDEBD0\" >Register an Account</div>");
        out.println("<div class=\"card-body\">");
        out.println("<!--inputs-->");
        out.println("<form>");
        out.println("<div class=\"form-group\">");
        out.println("<div class=\"form-row\">");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"exampleInputName\">First name</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputName\" type=\"text\" aria-describedby=\"nameHelp\" placeholder=\"Enter first name\">");
        out.println("</div>");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"exampleInputLastName\">Last name</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputLastName\" type=\"text\" aria-describedby=\"nameHelp\" placeholder=\"Enter last name\">");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"exampleInputEmail1\">User name</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputUserName\" type=\"username\" aria-describedby=\"nameHelp\" placeholder=\"Enter username\">");
        out.println("</div>");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"exampleInputEmail1\">Email address</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputEmail1\" type=\"email\" aria-describedby=\"emailHelp\" placeholder=\"Enter email\">");
        out.println("</div>");
        out.println("<div class=\"form-group\">");
        out.println("<label for=\"exampleInputEmail1\">Phone number</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputNumber\" type=\"number\" aria-describedby=\"numberHelp\" placeholder=\"Enter phone number\">");
        out.println("</div>");
        out.println("<div class=\"form-group\">");
        out.println("<div class=\"form-row\">");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"exampleInputPassword1\">Password</label>");
        out.println("<input class=\"form-control\" id=\"exampleInputPassword1\" type=\"password\" placeholder=\"Password\">");
        out.println("</div>");
        out.println("<div class=\"col-md-6\">");
        out.println("<label for=\"exampleConfirmPassword\">Confirm password</label>");
        out.println("<input class=\"form-control\" id=\"exampleConfirmPassword\" type=\"password\" placeholder=\"Confirm password\">");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");
        out.println("<!--register button-->");
        out.println("<a class=\"btn btn-warning btn-block\" href=\"login.html\">Register</a>");
        out.println("</form>");
        out.println("<div class=\"text-center\">");
        out.println("<a class=\"d-block small mt-4\" href=\"login.html\">Login Page</a>");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");
        out.println("</div>");
        out.println("<!-- Bootstrap core JavaScript-->");
        out.println("<script src=\"vendor/jquery/jquery.min.js\"></script>");
        out.println("<script src=\"vendor/bootstrap/js/bootstrap.bundle.min.js\"></script>");
        out.println("<!-- Core plugin JavaScript-->");
        out.println("<script src=\"vendor/jquery-easing/jquery.easing.min.js\"></script>");
        out.println("</body>");
        out.println("</html>");

        out.close();

    }
}
