<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>New Good</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/indexStyle.css">
    <script src="<%= request.getContextPath() %>/javascript/utils.js"></script>

</head>
<body>
<div class="newFormCard">
    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/InsertGoodServlet">
        <label>
            <input type="text" name="nameGood" placeholder="Insert Name">
        </label>
        <label>
            Description:
            <textarea placeholder="Insert a description of the good" rows="4" name="description"></textarea>
        </label>
        <%
            // TODO: 20/04/2022 Add an if to distinguish between goods on auctions or none!
        %>
        <input type="submit" class="login login-submit" value="Insert good" name="start_auction">
    </form>
    <button id="back_btn" class="login login-submit" value="back" name="back" onclick="reloadAndClose()">Back</button>
</div>
</body>
</html>
