package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "NewAuctionServlet", value = "/NewAuctionServlet")
public class NewAuctionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: 09/04/2022 Retrieve from the db the object Auction with id = idAuction

        // TODO: 09/04/2022 Add to the session the object retrieved in order to display it on auction_view

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
                System.out.println("Sending the auction page...");

                //Retrieve the data from the request
                String idGood = request.getParameter("idGood");
                System.out.println("The idGood is: " + idGood);

                //Set the data to be displayed in the jsp file
                request.setAttribute("idGood", idGood);

                // TODO: 15/04/2022 Retrieve the information of the good from the db

                //Open the goods page
                String targetJSP = "/pages/jsp/new_auction.jsp";

                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
