<%@ page import="dto.GoodDTO" %>
<%@ page import="dto.AuctionDTO" %>
<%@ page import="database.DbManager" %>
<%@ page import="communication.OtpErlangCommunication" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/indexStyle.css">
    <title>Start Auction</title>
    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>
    <script src="<%= request.getContextPath() %>/javascript/utils.js"></script>
    <%
        String user = (String) session.getAttribute("user");
        String idGood = (request.getAttribute("idGood") != null)?(String) request.getAttribute("idGood"):request.getParameter("idGood");

        GoodDTO good = DbManager.getGood(Integer.parseInt(idGood), user);

        assert good != null;%>
</head>
<body>

<div class="newFormCard">
    <form class="ViewAuctionContentForm" action="<%= request.getContextPath() %>/StartAuctionServlet">
        <input type="hidden" name="idGood" value="<%=idGood%>">
        <label>
            <input type="text" name="nameGood" placeholder="Name" value=<%=good.getName()%> readonly>
        </label>
        <label>
            Description:
            <textarea placeholder="Insert a description of the good" rows="4" name="description" readonly><%=good.getDescription().replace("\"", "")%></textarea>
        </label>
        <% if(DbManager.inAuction(user, good.getGoodId())){
            int auctionId = DbManager.getAuctionFromGood(good.getGoodId(),user);
            AuctionDTO auction = OtpErlangCommunication.get_info(auctionId,user);

            assert auction != null;
        %>
        <label>
            End date:
            <input type="datetime-local" name="duration" value="<%=utils.Utils.datetimeFromNow(auction.getDuration())%>" disabled/>
        </label>
        <label>
            Starting price:
            <input type="number" value="<%=auction.getInitialPrice()%>" name="startPrice" disabled/>
        </label>
        <%}else{%>
        <label>
            Duration:
            <input type="number" min="1" max="100" step="1" value="1" name="duration" required/>
        </label>
        <label>
            Starting price:
            <input type="number" min="1.00" max="10000.00" step="0.50" value="1.00" name="startPrice" required/>
        </label>
        <input type="submit" class="login login-submit" value="Start auction" name="start_auction">
        <%}%>
    </form>
    <button id="back_btn" class="login login-submit" value="back" name="back" onclick="reloadAndClose()">Back</button>
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
