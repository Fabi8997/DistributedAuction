<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>View Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <%
        String idGood = (request.getAttribute("idGood") != null)?(String) request.getAttribute("idGood"):request.getParameter("idGood");
        String timestamp = "Apr 18, 2022 23:31:00"; // TODO: 19/04/2022 Take this from the auction object dto retrieved from mnesia
    %>
</head>
<body onload="setTimer('<%=timestamp%>')">

<div class="header">
    <h2>Distributed Auction</h2>
    <p>We have to change the title for sure.</p>
</div>

<ul class="topnav">
    <li><a href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
    <li id="logout"><a href="<%= request.getContextPath() %>/LogoutServlet" >
        <img src="<%= request.getContextPath() %>/images/logout3.png" alt="logout">
    </a></li>
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
</ul>

<div class="ViewAuctionContent">
    <table>
        <tr>
            <th>Good:</th>
            <td>Good1</td>
        </tr>
        <tr>
            <th>Seller:</th>
            <td>john doe</td>
        </tr>
        <tr>
            <th>Status:</th>
            <td>Status</td>
        </tr>
        <tr>
            <th>Current offer:</th>
            <td>200&euro;</td>
        </tr>
        <tr>
            <th>Time left:</th>
            <td id="timer"></td>
        </tr>
    </table>


    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/MakeOfferServlet">
        <input type="hidden" name="idGood" value="<%=idGood%>">
        <label for="offerInput"></label><input id="offerInput" type="text" placeholder="Insert your offer.." name="offer">
        <button type="submit">OFFER</button>
    </form>

</div>

</body>
</html>
