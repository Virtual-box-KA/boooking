<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>

<%
    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
    if (message != null) {
%>
<p style="color:green;"><%= message %></p>
<% } %>

<% if (error != null) { %>
<p style="color:red;"><%= error %></p>
<% } %>

<form method="post" action="auth">
    <input type="hidden" name="action" value="login"/>

    <label>Email:
        <input type="email" name="email" required/>
    </label><br/><br/>

    <label>Password:
        <input type="password" name="password" required/>
    </label><br/><br/>

    <button type="submit">Login</button>
</form>

<p>Don't have an account? <a href="register.jsp">Register here</a>.</p>
<p><a href="index.jsp">Back to home</a></p>
</body>
</html>
