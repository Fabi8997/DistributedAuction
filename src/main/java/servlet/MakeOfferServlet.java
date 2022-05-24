package servlet;

import communication.OtpErlangCommunication;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "MakeOfferServlet", value = "/MakeOfferServlet")
public class MakeOfferServlet extends HttpServlet {
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
                System.out.println("Sending the offer...");

                //Retrieve the information to make the offer!
                String offer = request.getParameter("offer");
                String idAuction = request.getParameter("idAuction");
                String user = (String) session.getAttribute("user");

                //Test
                System.out.println(user + " offered " + offer +  " for " + idAuction);

                //Send the offer to the server and reload the page

                OtpErlangCommunication.make_offer(idAuction,user,Double.parseDouble(offer));

                //including the id of the good in the reloaded page
                request.setAttribute("idAuction", idAuction);

                String targetJSP = "/pages/jsp/auction_view.jsp";
                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
