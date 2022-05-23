package servlet;

import database.DbManager;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddCreditServlet", value = "/AddCreditServlet")
public class AddCreditServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("Session not exists!");

            //Return to login page
            String targetJSP = "index.jsp";

            //Set the error msg
            request.setAttribute("error","Please Login!");

            RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
            requestDispatcher.forward(request,response);
        } else {

            if(session.getAttribute("user") == null){
                System.out.println("Not logged!");

                //Return to login page
                String targetJSP = "index.jsp";

                //Set the error msg
                request.setAttribute("error","Please Login!");

                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }else{

                String user = (String) session.getAttribute("user");
                System.out.println(request.getParameter("credit"));
                double credit = Double.parseDouble((request.getParameter("credit")));

                System.out.println("Adding the sum...");

                //Send the credit to add to the server and reload the page
                if(DbManager.addCredit(user,credit)){
                    request.setAttribute("info", "Credit added correctly!");
                }else{
                    request.setAttribute("error", "Sorry, something has gone wrong. Retry!");
                }

                //Reload the page to trigger the change of the credit in the jsp file
                String targetJSP = "/pages/jsp/credit.jsp";
                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
