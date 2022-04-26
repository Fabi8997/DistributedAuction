<%@ page import="dto.GoodDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.GoodStatus" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%
        // TODO: 23/04/2022 goods deve essere inizializzato con il valore del db!
        ArrayList<GoodDTO> goods = new ArrayList<>();

        //Initialize an example of goods inside the array list
        goods.add(new GoodDTO("148912","Matita","Matita molto bella", GoodStatus.IN_AUCTION, (String) session.getAttribute("user")));
        goods.add(new GoodDTO("173222","Bicchiere","Bicchiere molto bello", GoodStatus.SOLD, (String) session.getAttribute("user")));
        goods.add(new GoodDTO("128547","Macchina","Macchina molto bella", GoodStatus.NOT_IN_AUCTION, (String) session.getAttribute("user")));
        goods.add(new GoodDTO("138323","Lampada","Lampada molto bella", GoodStatus.IN_AUCTION, (String) session.getAttribute("user")));

    %>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/generalStyle.css">
    <title>goods</title>

    <script src="<%= request.getContextPath() %>/javascript/timer.js"></script>

    <script>
        //variable to track the popupwindow
        let popupWindow = null;

        //Open the popup window with width = w , height = h, newGood is a boolean to decide which page we need
        //the last attribute is useful only if newGood is equal to false
        function openPopupWindow(w, h, newGood,idGood) {
            const y = window.top.outerHeight / 2 + window.top.screenY - ( h / 2);
            const x = window.top.outerWidth / 2 + window.top.screenX - ( w / 2);
            if(newGood){
                popupWindow = window.open('<%=request.getContextPath()%>/NewGoodServlet', 'targetWindow', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width='+w+',height='+h+' top='+y+', left='+x);

            }else{
                popupWindow = window.open('<%=request.getContextPath()%>/NewAuctionServlet?idGood=' + idGood.toString(), 'targetWindow', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width='+w+',height='+h+' top='+y+', left='+x);
            }
            document.getElementById("overlay").style.display = "block";
            document.body.style.filter = "blur(1px)";
        }

        //Search through the rows to find the word typed in the search input
        function searchName() {
            // Declare variables
            let input, filter, table, tr, td1, td3, i, txtValue1, txtValue3;
            input = document.getElementById("myInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("myTable");
            tr = table.getElementsByTagName("tr");

            // Loop through all table rows, and hide those who don't match the search query
            for (i = 0; i < tr.length; i++) {
                td1 = tr[i].getElementsByTagName("td")[1];
                td3 = tr[i].getElementsByTagName("td")[3];
                if (td1 && td3) {
                    txtValue1 = td1.textContent || td1.innerText;
                    txtValue3 = td3.textContent || td3.innerText;
                    if (txtValue1.toUpperCase().indexOf(filter) > -1 || txtValue3.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }

        //Add the event listener to every row in the table
        function addClickEvent() {
            for (let i = 0; i < <%=goods.size()%>; i++) {

                //Retrieve the current row
                const row = document.getElementById("row-"+i.toString());

                //Retrieve from the hidden field of the row the id of the good
                const idGood = row.getElementsByClassName("idGood").item(0).getAttribute("value");

                //Add the event listener to open the window on click
                row.addEventListener("click", () => {
                    openPopupWindow(500,570,false,idGood);
                });
            }
        }

        //focus on the popup window if exists, otherwise remove the overlay from the parent page
        function parent_disable() {
            if(popupWindow && !popupWindow.closed)
                popupWindow.focus();
            else {
                document.getElementById("overlay").style.display = "none";
                document.body.style.filter = "none";
            }

        }
    </script>

</head>
<body onload="addClickEvent(); setTimers();" onfocus="parent_disable();" onclick="parent_disable();">

<div id="overlay">

</div>

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

    <h3>Your goods:</h3>

    <div id="auction_content_actions">
        <label for="myInput"></label><input style= "background-image: url('<%= request.getContextPath() %>/images/searchicon.png');" type="text" id="myInput" onkeyup="searchName()" placeholder="Search for names..">
        <button id="insertGood" onclick="openPopupWindow(500,400,true,0);">Insert Good</button>
    </div>
    <table id="myTable">
        <thead>
        <tr>
            <th scope="col" style="display: none;"></th>
            <th scope="col">Name</th>
            <th scope="col">Description</th>
            <th scope="col">Status</th>
            <th scope="col">Countdown</th>
        </tr>
        </thead>
        <tbody>
        <%
            for(int i = 0; i < goods.size(); i++) {
        %>
        <tr id = "row-<%=i%>">
            <td style="display:none;"><input class="idGood" type="hidden" name="idGood" value="<%=goods.get(i).getId()%>"></td>
            <td><%=goods.get(i).getName()%></td>
            <td><label>
                <textarea readonly rows="2"><%=goods.get(i).getDescription()%></textarea>
            </label></td>
            <td><%=goods.get(i).getStatus().toString()%></td>
            <%
                if(goods.get(i).getStatus().toString().equals("IN_AUCTION")){
            %>
                <td class="timer" id="timer<%=i%>"></td>
            <%}else{%>
                <td></td>
            <%}%>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
