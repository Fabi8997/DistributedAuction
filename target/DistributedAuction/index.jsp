<html>
<head>
    <link rel="stylesheet" href="styles/generalStyle.css">
    <title>index</title>
</head>
<body>

    <div class="header">
        <h2>Distributed Auction</h2>
        <p>We have to change the title for sure.</p>
    </div>

    <ul class="topnav">
        <li><a class="active" href="<%= request.getContextPath() %>/HomepageServlet">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/AuctionsServlet">Auctions</a></li>
        <li><a href="<%= request.getContextPath() %>/GoodsServlet">Goods</a></li>
        <li id="credit"><a href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
    </ul>

</body>
</html>
