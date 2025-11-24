<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movie Booking</title>
</head>
<body>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<h1>Welcome to Movie Booking</h1>

<% if (userId != null) { %>
    <p>Hello, <b><%= userName %></b>!</p>
    <p>
        <a href="movies">Browse Movies</a> |
        <a href="mybookings.jsp">My Bookings</a> |
        <a href="auth?action=logout">Logout</a>
    </p>
<% } else { %>
    <p>
        <a href="login.jsp">Login</a> |
        <a href="register.jsp">Register</a>
    </p>
    <p><a href="movies">Browse Movies (login to book)</a></p>
<% } %>

</body>
</html>
