package servlet;

import com.ericsson.otp.erlang.OtpConnection;
import communication.OtpErlangCommunication;
import dto.AuctionDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.time.*;

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

                String idAuction = "auction12312";
                String idGood = request.getParameter("idGood");
                String user = (String)session.getAttribute("user");
                String startPrice = request.getParameter("startPrice");
                String duration = request.getParameter("duration");

                // TODO: 27/04/2022 use this to instantiate the server! It's the number of seconds until the end of the auction
                //System.out.println(localDateTime.toEpochSecond(ZoneOffset.of("+02:00"))-Instant.now().getEpochSecond());


                //Generate the auction to be passed to the db manager!

                AuctionDTO auction = new AuctionDTO(idAuction,idGood, Integer.toString(Integer.parseInt(duration)*60*60*1000),startPrice,user);
                System.out.println(auction);

                OtpErlangCommunication.start_auction(auction);
                // TODO: 20/04/2022 Database things (create an instance of an auction, start the countdown srv)
                //Change the status value on the db
                /*
                    if(DBManager.startAuction(auction){
                        //if no errors occur then it goes to the confirmation page!
                        targetJSP = "/pages/jsp/confirm_new_auction.jsp";
                        System.out.println("auction started");
                    }else{
                        //redirect to the previous page with an error msg!
                        String targetJSP = "/pages/jsp/new_auction.jsp";
                        request.setAttribute("error", "Something has gone wrong!");
                    }
                */

                System.out.println("auction started");

                // TODO: 24/04/2022 Substitute this with the commented part
                //Commenting and use this only for try
                String targetJSP = "/pages/jsp/confirm_start_auction.jsp";
                //String targetJSP = "/pages/jsp/new_auction.jsp";
                //request.setAttribute("error", "Something has gone wrong!");

                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
