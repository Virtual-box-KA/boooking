<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
<h1>Register</h1>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p style="color:red;"><%= error %></p>
<% } %>

<form method="post" action="auth">
    <input type="hidden" name="action" value="register"/>

    <label>Name:
        <input type="text" name="name" required/>
    </label><br/><br/>

    <label>Email:
        <input type="email" name="email" required/>
    </label><br/><br/>

    <label>Phone:
        <input type="text" name="phone"/>
    </label><br/><br/>

    <label>Password:
        <input type="password" name="password" required/>
    </label><br/><br/>

    <label>Confirm Password:
        <input type="password" name="confirm" required/>
    </label><br/><br/>

    <button type="submit">Register</button>
</form>

<p>Already have an account? <a href="login.jsp">Login here</a>.</p>
<p><a href="index.jsp">Back to home</a></p>
</body>
</html>
