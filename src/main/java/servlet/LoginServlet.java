package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //if(LoginManager.login()){
        //String targetJSP = "/pages/jsp/homepage.jsp";
        //}else{
        //String targetJSP = "/pages/jsp/loginError.jsp";
        // }

        String targetJSP = "/pages/jsp/homepage.jsp";
        System.out.println(request.getParameter("user") +"\n" + request.getParameter("pass"));
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
        requestDispatcher.forward(request,response);
    }
}
