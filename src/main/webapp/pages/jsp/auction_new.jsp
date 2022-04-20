<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>Start Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <%
        String idGood = (request.getAttribute("idGood") != null)?(String) request.getAttribute("idGood"):request.getParameter("idGood");
        String timestamp = "Apr 18, 2022 23:31:00"; // TODO: 19/04/2022 Take this from the auction object dto retrieved from mnesia
    %>
    <script>

        function prova(){
            window.opener.location.href = "<%= request.getContextPath() %>/StartAuctionServlet";
            window.close();
        }
    </script>
</head>
<body onload="setTimer('<%=timestamp%>')">

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
            <td>Not in auction</td>
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



    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/StartAuctionServlet">
        <input type="hidden" name="idGood" value="<%=idGood%>">
         <label>
            <input type="datetime-local" >
        </label>
        <label>
            <select name="option">
                <option value="volvo">Volvo</option>
                <option value="saab">Saab</option>
                <option value="opel">Opel</option>
                <option value="audi">Audi</option>
            </select>
        </label>
        <label>
            <input type="number" min="0.00" max="10000.00" step="0.10" value="0,00" name="startPrice"/>
        </label>
        <%
            // TODO: 20/04/2022 Add an if to distinguish between goods on auctions or none!
        %>
        <button type="submit" >Start</button>
    </form>

</div>

</body>
</html>
