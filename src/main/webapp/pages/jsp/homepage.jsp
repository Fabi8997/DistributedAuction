<%@ page import="dto.AuctionDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.DbManager" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        String user = (String) session.getAttribute("user");
        System.out.println("Retrieving the information for "+user+"...");
        double credit = DbManager.getCredit(user);
        ArrayList<AuctionDTO> auctions = DbManager.getAllAuctions(user);
    %>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>homepage</title>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <script>
        let timestampArray = [];

        <% for(int i = 0; i < auctions.size(); i++){%>
        timestampArray[<%=i%>] = "<%=utils.Utils.datetimeFromNow(auctions.get(i).getDuration())%>";
        <%}%>

        function addClickEvent() {
            let row;
            <%for (int i = 0; i < auctions.size(); i++) { %>

            row = document.getElementById("row-"+<%=i%>);

            row.addEventListener("click", () => {
                window.location.href = "<%=request.getContextPath()%>/ViewAuctionServlet?idAuction="+<%=auctions.get(i).getIdAuction()%>;
            });
            <%}%>
        }
    </script>
</head>
<body onload="addClickEvent(); setTimers(timestampArray)">


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
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet"><%=credit%>&euro;</a></li>
</ul>

<h3>Welcome <%=user%> !</h3>

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
                for(int i = 0; i < auctions.size(); i++) {
                    if(Integer.parseInt(auctions.get(i).getDuration()) < 120000){
            %>
            <tr id = "row-<%=i%>">
                <td><%=Objects.requireNonNull(DbManager.getGood(Integer.parseInt(auctions.get(i).getIdGood()), user)).getName().replace("\"", "")%></td>
                <td class="timer" id="timer<%=i%>">00:00:00</td>
            </tr>
            <%      }
                }%>
            </tbody>
        </table>
    </div>
    <p id="timer"></p>
</div>

</body>
</html>
