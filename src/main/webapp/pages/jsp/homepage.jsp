<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>homepage</title>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <script>
        function addClickEvent() {
            for (let i = 0; i < 5; i++) {

                <%
                // TODO: 09/04/2022 Add instead of row-i the id of the auction!
                %>

                const row = document.getElementById("row-"+i.toString());

                row.addEventListener("click", () => {
                    window.location.href = "<%=request.getContextPath()%>/ViewAuctionServlet?idGood="+i.toString();
                });
            }
        }
    </script>
</head>
<body onload="addClickEvent(); setTimers()">
<%
    String user = (String) session.getAttribute("user");
    System.out.println("Retrieving the information for "+user+"...");
    // TODO: 15/04/2022 From here we initialize the information for the page content.

    // TODO: 17/04/2022 Retrieve the list of auctions in which the user is involved
    //List<Auctions> auctions = new ArrayList<>();
    //auctions = DBManager.getFollowedAuctions(User);

    //For now, we'll use 5 iterations only for example!


%>

<div class="header">
    <h2>Distributed Auction</h2>
</div>

<ul class="topnav">
    <li><a class="active" href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
    <li id="logout"><a href="<%= request.getContextPath() %>/LogoutServlet" >
        <img src="<%= request.getContextPath() %>/images/logout3.png" alt="logout">
    </a></li>
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
</ul>

<div id="content">
    <div id="current_auction">
        <table id="myTable">
            <thead>
            <tr>
                <th scope="col">Good</th>
                <th scope="col">Time Left</th>
            </tr>
            </thead>
            <tbody>
            <%
                for(int i = 0; i < 5; i++) {
            %>
            <tr id = "row-<%=i%>">
                <td>Good<%=i%></td>
                <td class="timer" id="timer<%=i%>">00:00:00</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <div id="other_actions">
        <button onclick="location.href='<%=request.getContextPath()%>/ShowYourGoodsAuctionsServlet'">Show your goods on auction</button>
        <button onclick="location.href='<%=request.getContextPath()%>/ShowHistoryServlet'">History of your auctions</button>
    </div>
    <p id="timer"></p>
</div>

</body>
</html>
