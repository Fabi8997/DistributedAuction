package servlet;

import com.ericsson.otp.erlang.OtpConnection;
import communication.OtpErlangCommunication;

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

        // TODO: 15/04/2022 substitute the if with if(LoginManager.login(req.getParam("user")))
        if(request.getParameter("user").equals("prova")){

            String targetJSP = "/pages/jsp/homepage.jsp";
            String user = request.getParameter("user");

            HttpSession session=request.getSession(false);

            //If there isn't a session => Create it
            if(session == null){
                System.out.println("Creating the session");
                session = request.getSession();
                session.setAttribute("user", user);
            }

            //Set up the logged user, if the user wasn't already logged!
            if(session.getAttribute("user") == null){
                session.setAttribute("user", user);
            }else{
                //If the session is referred to another user => invalidate it and set up the new user
                if(!session.getAttribute("user").equals(user)){
                    session.invalidate();
                    session.setAttribute("user",user);
                }
            }

            /*if(session.getAttribute("otpConnection") == null){
                session.setAttribute("otpConnection", OtpErlangCommunication.getConnection(user));
            }*/

            RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
            requestDispatcher.forward(request,response);
        }else{
            String targetJSP = "index.jsp";
            request.setAttribute("error", "Username/Password not correct!");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
            requestDispatcher.forward(request,response);
        }
    }
}
