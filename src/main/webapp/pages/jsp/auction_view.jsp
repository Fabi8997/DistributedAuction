<%@ page import="database.DbManager" %>
<%@ page import="dto.AuctionDTO" %>
<%@ page import="communication.OtpErlangCommunication" %>
<%@ page import="dto.GoodDTO" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>View Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <%
        String user = (String) session.getAttribute("user");
        System.out.println("Retrieving the information for "+user+"...");
        double credit = DbManager.getCredit(user);
        String idAuction = (request.getAttribute("idAuction") != null)?(String) request.getAttribute("idAuction"):request.getParameter("idAuction");
        AuctionDTO auction = OtpErlangCommunication.get_info(Integer.parseInt(idAuction),user);
        assert auction != null;
        GoodDTO good = DbManager.getGood(Integer.parseInt(auction.getIdGood()),user);
        assert good != null;%>
</head>
<body onload="setTimer('<%=utils.Utils.datetimeFromNow(auction.getDuration())%>')">

<div class="header">
    <h2>Distributed Auction</h2>
</div>

<ul class="topnav">
    <li><a href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
    <li id="logout"><a href="<%= request.getContextPath() %>/LogoutServlet" >
        <img src="<%= request.getContextPath() %>/images/logout3.png" alt="logout">
    </a></li>
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet"><%=credit%>&euro;</a></li>
</ul>

<div class="ViewAuctionContent">
    <table>
        <tr>
            <th>Good:</th>
            <td><%=good.getName().replace("\"", "")%></td>
        </tr>
        <tr>
            <th>Seller:</th>
            <td><%=auction.getSeller().replace("\"", "")%></td>
        </tr>
        <tr>
            <th>Current offer:</th>
            <td><%=auction.getCurrentPrice()%>&euro;</td>
        </tr>
        <tr>
            <th>Time left:</th>
            <td id="timer"></td>
        </tr>
    </table>


    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/MakeOfferServlet">
        <input type="hidden" name="idAuction" value="<%=auction.getIdAuction()%>">
        <label for="offerInput"></label><input id="offerInput" type="text" placeholder="Insert your offer.." name="offer">
        <button type="submit">OFFER</button>
    </form>

</div>

</body>
</html>
