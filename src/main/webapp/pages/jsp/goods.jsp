<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>goods</title>

    <%
        int iterations = 10;
    %>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>

    <script>
        function myFunction() {
            // Declare variables
            let input, filter, table, tr, td, i, txtValue;
            input = document.getElementById("myInput");
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
            for (let i = 0; i < <%=iterations%>; i++) {

                <%
                // TODO: 09/04/2022 Add instead of row-i the id of the auction!
                %>

                const row = document.getElementById("row-"+i.toString());

                row.addEventListener("click", () => {
                    //window.location.href = "<%=request.getContextPath()%>/NewAuctionServlet?idGood="+i.toString();
                    window.open('<%=request.getContextPath()%>/NewAuctionServlet?idGood='+i.toString(),'targetWindow','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=350,height=250')
                });
            }
        }
    </script>

</head>
<body onload="addClickEvent(); setTimers()">

<div class="header">
    <h2>Distributed Auction</h2>
</div>

<ul class="topnav">
    <li><a href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a class="active" href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
    <li id="logout"><a href="<%= request.getContextPath() %>/LogoutServlet" >
        <img src="<%= request.getContextPath() %>/images/logout3.png" alt="logout">
    </a></li>
    <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
</ul>

<div class="auction_content">

    <h3>Test dynamic auction list</h3>

    <label for="myInput"></label><input style= "background-image: url('<%= request.getContextPath() %>/images/searchicon.png');" type="text" id="myInput" onkeyup="myFunction()" placeholder="Search for names..">

    <table id="myTable">
        <thead>
        <tr>
            <th scope="col">Column1</th>
            <th scope="col">Column2</th>
            <th scope="col">Column3</th>
            <th scope="col">Countdown</th>
        </tr>
        </thead>
        <tbody>
        <%
            for(int i = 0; i < iterations; i++) {
                // TODO: 20/04/2022 insert the data ordered by timestamp, so from the lower value to the higher
        %>
        <tr id = "row-<%=i%>">
            <td>Data<%=i%></td>
            <td>Data<%=i%></td>
            <td>Data<%=i%></td>
            <td class="timer" id="timer<%=i%>"></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
