<%@ page import="dto.AuctionDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>Auctions</title>

    <%// TODO: 26/04/2022 ADD the timer when it's passed the normal time! %>

    <%
        ArrayList<AuctionDTO> auctions = new ArrayList<>();

        auctions.add(new AuctionDTO("131213","31213","600000","15.0","Fabiano"));
        auctions.add(new AuctionDTO("123444","86676","800000","22.0","Andrea"));
        auctions.add(new AuctionDTO("144544","17667","150000","300.0","Paolo"));
        auctions.add(new AuctionDTO("111124","15454","2121212","40.0","Bruno"));
        auctions.add(new AuctionDTO("123254","12123","900000","12.0","Chiara"));
        auctions.add(new AuctionDTO("321312","23132","4554455","15.0","Fabiano"));
        auctions.add(new AuctionDTO("535355","43343","9898912","22.0","Andrea"));
        auctions.add(new AuctionDTO("634622","54543","1050000","300.0","Paolo"));
        auctions.add(new AuctionDTO("745545","54544","1300000","40.0","Bruno"));
        auctions.add(new AuctionDTO("755445","53211","932000","12.0","Chiara"));
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
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
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
                // TODO: 20/04/2022 insert the data ordered by timestamp, so from the lower value to the higher
        %>
        <tr id = "row-<%=i%>">
            <%// TODO: 26/04/2022 change getIdGood with DBManager.getGoodById(auction.getIdGood)
              // Oppure conservare il nome del good nella tabella di mnesia!%>
            <td><%=auctions.get(i).getIdGood()%></td>
            <td><%=auctions.get(i).getSeller()%></td>
            <td><%=auctions.get(i).getInitialPrice()%></td>
            <td class="timer" id="timer<%=i%>"></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
