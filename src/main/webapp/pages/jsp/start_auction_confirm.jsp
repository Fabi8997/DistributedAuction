<%--
  Created by IntelliJ IDEA.
  User: fabia
  Date: 20/04/2022
  Time: 20:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Title</title>
    <script>

        setTimeout(reloadAndClose,3000);

        function reloadAndClose(){
            window.opener.location.reload();
            window.close();
        }
    </script>
</head>
<body>
  <%
      //Retrieve the result of the req from the request attribute of the servet
      /*if(req.state){
        <p>Auction Started Correctly!</p>
      }else{
        <p>Something has gone wrong, retry!</p>
      }*/
  %>
    <p>Auction started!</p>
</body>
</html>
