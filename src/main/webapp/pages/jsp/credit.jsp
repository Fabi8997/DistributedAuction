<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>Credits</title>
</head>
<body>

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
    <li id="credit"><a class="active" href="<%= request.getContextPath() %>/CreditServlet">0,00&euro;</a></li>
</ul>


<div class="ViewAuctionContent">
    <h3 id="titleAdd">Add credit to your account:</h3>

    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/AddCreditServlet">
        <label for="creditInput"></label><input id="creditInput" type="text" placeholder="Insert the sum to add.." name="credit">
        <button type="submit">ADD</button>
    </form>
    <%
        if(request.getAttribute("error") != null){
    %>
    <p id="error"><%= request.getAttribute("error")%></p>
    <% }else if(request.getAttribute("info") != null){%>
    <p id="info"><%= request.getAttribute("info")%></p>
    <% }%>
</div>


</body>
</html>
