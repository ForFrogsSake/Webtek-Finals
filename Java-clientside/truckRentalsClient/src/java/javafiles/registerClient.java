/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javafiles;

import java.io.IOException;
import java.io.PrintWriter;
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
        out.println("<html lang='en'>");
        out.println("<head>");
        out.println("<link rel=\"icon\" href=\"/pictures/LOGO.png\">");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<title>Sign-up | Truck Rentals</title>");
        out.println("<style>");
        out.println("body {");
        out.println(" background-color: rgba(202, 207, 210, 0.7);");
        out.println("}");
        out.println("#maincontainer {");
        out.println("background-color: rgba(211, 84, 0, 0.5);");
        out.println("}");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div id=\"maincontainer\">");
        out.println("<form action=\"truckRentalsClient/registerClient\" method=\"GET\"><!--AWAN PAY-->");
        out.println("<div class=\"container\">");
        out.println("<h1>Register</h1>");
        out.println("<h4>Please fill in the needed details to create your account.</h4>");
        out.println("<hr>");
        out.println("<label for=\"email\"><b>Email</b></label>");
        out.println("<input type=\"text\" placeholder=\"Enter Email\" name=\"email\" required>");
        out.println("<label for=\"psw\"><b>Password</b></label>");
        out.println("<input type=\"password\" placeholder=\"Enter Password\" name=\"pass\" required>");
        out.println("<label for=\"psw-repeat\"><b>Repeat Password</b></label>");
        out.println("<input type=\"password\" placeholder=\"Repeat Password\" name=\"pass-repeat\" required>");
        out.println("<hr>");
        out.println("<p>By creating an account you agree to our <a href=\"#\">Terms & Privacy</a>.</p>");
        out.println("<button type=\"submit\" class=\"registerbtn\">Register</button>");
        out.println("</div>");
        out.println("<div class=\"container signin\">");
        out.println("<p>Already have an account? <a href=\"#\">Sign in</a>.</p><!--LOGINpAGE NEEDED-->");
        out.println("</div>");
        out.println("</form>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
     
        out.close();
    }
}
