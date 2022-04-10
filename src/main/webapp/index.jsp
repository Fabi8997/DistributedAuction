<html>
<head>
    <link rel="stylesheet" href="styles/indexStyle.css">
    <title>Login</title>
</head>
<body>


<%
    // TODO: 09/04/2022 ADD ON EACH SERVLET THE RETRIEVE THE CREDIT!
%>

<div class="login-card">
    <h1>Log-in</h1><br>
    <form method="post" action="<%= request.getContextPath() %>/LoginServlet">
        <label>
            <input type="text" name="user" placeholder="Username">
        </label>
        <label>
            <input type="password" name="pass" placeholder="Password">
        </label>
        <input type="submit" name="login" class="login login-submit" value="login">
    </form>

    <div class="login-help">
        <a href="<%= request.getContextPath() %>/pages/jsp/register.jsp">Register</a>
    </div>
</div>

</body>
</html>
