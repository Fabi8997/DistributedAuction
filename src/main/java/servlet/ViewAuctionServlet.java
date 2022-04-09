package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ViewAuctionServlet", value = "/ViewAuctionServlet")
public class ViewAuctionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // TODO: 09/04/2022 Retrieve from the db the object Auction with id = idAuction

        // TODO: 09/04/2022 Add to the session the object retrieved in order to display it on auction_view 

        String targetJSP = "/pages/jsp/auction_view.jsp";

        String idGood = request.getParameter("idGood");
        HttpSession session = request.getSession(true);
        session.setAttribute("idGood",idGood);


        RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
        requestDispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
