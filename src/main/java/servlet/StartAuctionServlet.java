package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "StartAuctionServlet", value = "/StartAuctionServlet")
public class StartAuctionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("auction started");
        System.out.println("idGood: "+request.getParameter("idGood"));
        System.out.println("price: "+request.getParameter("startPrice"));

        // TODO: 20/04/2022 Database things (create an instance of an auction, start the countdown srv)


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
