package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "MakeOfferServlet", value = "/MakeOfferServlet")
public class MakeOfferServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // TODO: 09/04/2022 Perform the offer and redirect to the previous page
        
        String targetJSP = "/pages/jsp/auction_view.jsp";

        // TODO: 09/04/2022 Retrieve from the db the object Auction with id = idAuction

        // TODO: 09/04/2022 Add to the session the object retrieved in order to display it on auction_view 
        HttpSession session = request.getSession(true);
        String offer = (String)request.getParameter("offer");
        System.out.println(offer +  " for " + session.getAttribute("idGood"));
        //Remember to delete the good if we exit this page!

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
        requestDispatcher.forward(request,response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
