<html lang="it">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>Auctions</title>

    <script>
        function myFunction() {
            // Declare variables
            var input, filter, table, tr, td, i, txtValue;
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
    </script>

</head>
<body>

<%
    int iteration =(int)request.getAttribute("iterations");
%>

<div class="header">
    <h2>Distributed Auction</h2>
    <p>We have to change the title for sure.</p>
</div>

<ul class="topnav">
    <li><a href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
    <li><a class="active" href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
    <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
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
            <th scope="col">Column4</th>
        </tr>
        </thead>
        <tbody>
        <%
            for(int i = 0; i < iteration; i++) {
        %>
        <tr>
            <td>Data<%=i%></td>
            <td>Data<%=i%></td>
            <td>Data<%=i%></td>
            <td><a href="#auctionData<%=i%>">Data<%=i%></a></td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
