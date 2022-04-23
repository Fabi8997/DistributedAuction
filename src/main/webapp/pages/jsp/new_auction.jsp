<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/indexStyle.css">
    <title>Start Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <script src="<%= request.getContextPath() %>/javascript/utils.js"></script>
    <%
        // TODO: 23/04/2022 Get the good from the idGodd!
        String idGood = (request.getAttribute("idGood") != null)?(String) request.getAttribute("idGood"):request.getParameter("idGood");
        //String timestamp = "Apr 18, 2022 23:31:00"; // TODO: 19/04/2022 Take this from the auction object dto retrieved from mnesia
    %>
</head>
<body>

<div class="newFormCard">
    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/StartAuctionServlet">
        <input type="hidden" name="idGood" value="<%=idGood%>">
        <label>
            <input type="text" name="nameGood" placeholder="Name" value="<%=idGood%> name from db" readonly>
        </label>
        <label>
            Description:
            <textarea placeholder="Insert a description of the good" rows="4" name="description"></textarea>
        </label>
        <label>
            Starting date:
            <input type="datetime-local" name="datetime">
        </label>
        <label>
            Duration:
            <input type="number" min="0.00" max="6.00" step="1" value="0" name="duration"/>
        </label>
        <label>
            Starting price:
            <input type="number" min="0.00" max="10000.00" step="0.10" value="0.00" name="startPrice"/>
        </label>
        <%
            // TODO: 20/04/2022 Add an if to distinguish between goods on auctions or none!
        %>
        <input type="submit" class="login login-submit" value="Start auction" name="start_auction">
    </form>
    <button id="back_btn" class="login login-submit" value="back" name="back" onclick="reloadAndClose()">Back</button>
</div>

</body>

</html>
