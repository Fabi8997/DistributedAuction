package servlet;

import communication.OtpErlangCommunication;
import dto.AuctionDTO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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

                String idAuction = "auction12312";
                String idGood = request.getParameter("idGood");
                String user = (String)session.getAttribute("user");
                String startPrice = request.getParameter("startPrice");
                String duration = request.getParameter("duration");


                AuctionDTO auction = new AuctionDTO(idAuction,idGood, Integer.toString(Integer.parseInt(duration)*60*60*1000),startPrice,user);
                System.out.println(auction);

                String targetJSP;

                if(OtpErlangCommunication.start_auction(auction)){
                    //if no errors occur then it goes to the confirmation page!
                    targetJSP = "/pages/jsp/confirm_start_auction.jsp";
                    System.out.println("auction started");
                }else{
                    //redirect to the previous page with an error msg!
                    targetJSP = "/pages/jsp/new_auction.jsp";
                    request.setAttribute("error", "Something has gone wrong!");
                }

                System.out.println("auction started");

                RequestDispatcher requestDispatcher = request.getRequestDispatcher(targetJSP);
                requestDispatcher.forward(request,response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
