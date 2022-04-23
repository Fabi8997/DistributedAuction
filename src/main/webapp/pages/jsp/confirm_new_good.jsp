<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
<p>Good inserted!</p>
</body>
</html>
