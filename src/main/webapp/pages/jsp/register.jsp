<html>
<head>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/indexStyle.css">
    <title>Registration</title>
</head>
<body>


<%
    // TODO: 09/04/2022 ADD ON EACH SERVLET THE RETRIEVE THE CREDIT!
%>

<div class="login-card">
    <h1>Sign-Up</h1><br>
    <form method="post" action="<%= request.getContextPath() %>/SignUpServlet">
        <label>
            <input type="text" name="user" placeholder="Username">
        </label>
        <label>
            <input type="password" name="pass" placeholder="Password">
        </label>
        <label>
            <input type="password" name="pass" placeholder="Repeat Password">
        </label>
        <input type="submit" name="signup" class="login login-submit" value="Sign Up">
    </form>
</div>

</body>
</html>
