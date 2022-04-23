package servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "StartAuctionServlet", value = "/StartAuctionServlet")
public class StartAuctionServlet extends HttpServlet {
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
                System.out.println("Receiving the new auction info...");

                System.out.println("auction started");
                System.out.println("idGood: "+request.getParameter("idGood"));
                System.out.println("name: "+request.getParameter("nameGood"));
                System.out.println("description: "+request.getParameter("description"));
                System.out.println("seller: "+session.getAttribute("user"));
                System.out.println("price: "+request.getParameter("startPrice"));
                System.out.println("start date: "+request.getParameter("datetime"));
                System.out.println("duration: "+request.getParameter("duration"));

                // TODO: 20/04/2022 Database things (create an instance of an auction, start the countdown srv)


                String targetJSP = "/pages/jsp/confirm_start_auction.jsp";
                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
