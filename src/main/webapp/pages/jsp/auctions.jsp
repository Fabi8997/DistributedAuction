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
        auctions.add(new AuctionDTO("112133","13232","Filippo","10.0","2022-04-27T23:41:41.781785"));
        auctions.add(new AuctionDTO("123444","86676","Andrea","22.0","2022-04-30T23:00"));
        auctions.add(new AuctionDTO("144544","17667","Bruno","300.0","2022-05-12T23:10"));
        auctions.add(new AuctionDTO("111124","15454","Andrea","40.0","2022-05-01T12:30"));
        auctions.add(new AuctionDTO("123254","12123","Nicola","12.0","2022-05-21T23:45"));
        auctions.add(new AuctionDTO("887674","56511","Andrea","12.5","2022-06-12T11:20"));
        auctions.add(new AuctionDTO("342344","21111","Filippo","11.2","2022-05-09T14:50"));
    %>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>

    <script>

        let timestampArray = [];

        <% for(int i = 0; i < auctions.size(); i++){%>
            timestampArray[<%=i%>] = "<%=auctions.get(i).getDatetime()%>";
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
            <td><%=auctions.get(i).getUser()%></td>
            <td><%=auctions.get(i).getStartPrice()%></td>
            <td class="timer" id="timer<%=i%>"></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
