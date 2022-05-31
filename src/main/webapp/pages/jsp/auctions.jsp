<%@ page import="dto.AuctionDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="database.DbManager" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>Auctions</title>

    <%
        String user = (String) session.getAttribute("user");
        double credit = DbManager.getCredit(user);
        ArrayList<AuctionDTO> auctions = DbManager.getAllAuctions(user);
    %>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>

    <script>

        let timestampArray = [];

        <% for(int i = 0; i < auctions.size(); i++){%>
            timestampArray[<%=i%>] = "<%=utils.Utils.datetimeFromNow(auctions.get(i).getDuration())%>";
        <%}%>

        console.log(timestampArray);

        function myFunction() {
            // Declare variables
            let input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("myInputAuct");
            filter = input.value.toUpperCase();
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

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
    <li><a href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a class="active" href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
    <li id="logout"><a href="<%= request.getContextPath() %>/LogoutServlet" >
        <img src="<%= request.getContextPath() %>/images/logout3.png" alt="logout">
    </a></li>
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet"><%=credit%>&euro;</a></li>
</ul>

<div class="auction_content">

    <h3>List of available auctions</h3>

    <label for="myInputAuct"></label><input style= "background-image: url('<%= request.getContextPath() %>/images/searchicon.png');" type="text" id="myInputAuct" onkeyup="myFunction()" placeholder="Search for names..">

    <table id="myTable">
        <thead>
        <tr>
            <th scope="col">Good</th>
            <th scope="col">Seller</th>
            <th scope="col">CurrentPrice</th>
            <th scope="col">Countdown</th>
        </tr>
        </thead>
        <tbody>
        <%
            for(int i = 0; i < auctions.size(); i++) {
        %>
        <tr id = "row-<%=i%>">
            <td><%=Objects.requireNonNull(DbManager.getGood(Integer.parseInt(auctions.get(i).getIdGood()), user)).getName().replace("\"", "")%></td>
            <td><%=auctions.get(i).getSeller().replace("\"", "")%></td>
            <td><%=auctions.get(i).getCurrentPrice()%>&euro;</td>
            <td class="timer" id="timer<%=i%>"></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
