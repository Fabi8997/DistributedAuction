package servlet;

import dto.GoodDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "InsertGoodServlet", value = "/InsertGoodServlet")
public class InsertGoodServlet extends HttpServlet {
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
                System.out.println("Receiving the new good info...");

                String name = request.getParameter("nameGood");
                String description = request.getParameter("description");
                String owner = session.getAttribute("user").toString();

                GoodDTO good = new GoodDTO(name, description, owner);
                System.out.println(good);

                // TODO: 20/04/2022 Database things (create an instance of an auction, start the countdown srv)
                /*
                    if(DBManager.insert(good){
                        //if no errors occur then it goes to the confirmation page!
                        targetJSP = "/pages/jsp/confirm_new_good.jsp";
                    }else{
                        //redirect to the previous page with an error msg!
                        String targetJSP = "/pages/jsp/new_good.jsp";
                        request.setAttribute("error", "Something has gone wrong!");
                    }
                */

                // TODO: 24/04/2022 Substitute this with the commented part
                //Commenting and use this only for try
                String targetJSP = "/pages/jsp/confirm_new_good.jsp";
                //String targetJSP = "/pages/jsp/new_good.jsp";
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
