package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SignUpServlet", value = "/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // TODO: 10/04/2022 Add utente if possible:  if false => signup error if true login with Success msg!

        System.out.println("Sending the login page...");

        //Retrieve the data from the form
        String user = request.getParameter("user");
        // TODO: 15/04/2022 Encrypt the password
        String pass = request.getParameter("pass");
        

        //Test
        System.out.println("Registering the following user: \n" + user + "\n" + pass);

        // TODO: 15/04/2022 Register the user it's a boolean if ture completed else error

        //Open the login page if is completed correctly
        String targetJSP = "index.jsp";

        //Set the information msg
        request.setAttribute("info","Registration completed!");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
        requestDispatcher.forward(request,response);
    }
}
