<%@ page import="dto.GoodDTO" %>
<%@ page import="dto.GoodStatus" %>
<%@ page import="dto.AuctionDTO" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/indexStyle.css">
    <title>Start Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <script src="<%= request.getContextPath() %>/javascript/utils.js"></script>
    <%
        String user = (String) session.getAttribute("user");
        // TODO: 23/04/2022 Get the good from the idGood!
        String idGood = (request.getAttribute("idGood") != null)?(String) request.getAttribute("idGood"):request.getParameter("idGood");
        //String timestamp = "Apr 18, 2022 23:31:00"; // TODO: 19/04/2022 Take this from the auction object dto retrieved from mnesia

        //Only for test DELETE THIS
        GoodDTO good = new GoodDTO(idGood,"Example","Example for test", GoodStatus.NOT_IN_AUCTION, (String) session.getAttribute("user"));

        // TODO: 25/04/2022
        /* We have to do this:
            GoodDTO good = DBManager.getGoodFromID(idGood);
         */

    %>
</head>
<body>

<div class="newFormCard">
    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/StartAuctionServlet">
        <input type="hidden" name="idGood" value="<%=idGood%>">
        <label>
            <input type="text" name="nameGood" placeholder="Name" value="<%=idGood%> name from db" readonly>
        </label>
        <label>
            Description:
            <textarea placeholder="Insert a description of the good" rows="4" name="description" readonly><%=good.getDescription()%></textarea>
        </label>
        <% if(good.getStatus().equals(GoodStatus.IN_AUCTION)){
            // TODO: 25/04/2022
            //AuctionDTO auction = DBManager.getAuction(UserDTO,GoodDTO);

            //DELETE THIS, I'm using this only for test!
            AuctionDTO auction = new AuctionDTO(idGood,"11111",user,"10.0","2022-04-27T06:22:30.781785");
            String datetime = LocalDateTime.parse(auction.getDatetime()).truncatedTo(ChronoUnit.MINUTES).toString();
        %>
        <label>
            End date:
            <input type="datetime-local" name="datetime" value="<%=datetime%>" disabled/>
        </label>
        <label>
            Starting price:
            <input type="number" value="<%=auction.getStartPrice()%>" name="startPrice" disabled/>
        </label>
        <%}else if(good.getStatus().equals(GoodStatus.NOT_IN_AUCTION)){%>
        <label>
            Duration:
            <input type="number" min="1" max="100" step="1" value="1" name="duration" required/>
        </label>
        <label>
            Starting price:
            <input type="number" min="1.00" max="10000.00" step="0.50" value="1.00" name="startPrice" required/>
        </label>
        <input type="submit" class="login login-submit" value="Start auction" name="start_auction">
        <%}else{
            // TODO: 26/04/2022 Retrieve the auction from the db
            //AuctionDTO auction = DBManager.getAuction(User,Good);

            //DELETE THIS, I'm using this only for test!
            AuctionDTO auction = new AuctionDTO(idGood,"11111",user,"10.0","2022-04-26T22:50:41.654542800Z", "50");
        %>
        <label>
            <input type="text" name="Status" placeholder="status" value="SOLD" disabled>
        </label>
        <label>
            Final price:
            <input type="number" value="<%=auction.getFinalPrice()%>" name="finalPrice" disabled/>
        </label>
        <%}%>
    </form>
    <button id="back_btn" class="login login-submit" value="back" name="back" onclick="reloadAndClose()">Back</button>
    <%
        if(request.getAttribute("error") != null){
    %>
    <p id="error"><%= request.getAttribute("error")%></p>
    <% }else if(request.getAttribute("info") != null){%>
    <p id="info"><%= request.getAttribute("info")%></p>
    <% }%>
</div>

</body>

</html>
