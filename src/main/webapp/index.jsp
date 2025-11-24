<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movie Booking</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background: white;
            padding: 40px;
            width: 400px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            text-align: center;
        }

        h1 {
            margin-top: 0;
            color: #333;
        }

        .btn {
            display: inline-block;
            padding: 12px 20px;
            margin: 8px 0;
            text-decoration: none;
            font-size: 16px;
            color: white;
            background: #007bff;
            border-radius: 8px;
            transition: 0.3s;
        }

        .btn:hover {
            background: #0056b3;
        }

        .link {
            color: #007bff;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }

        .welcome {
            font-size: 18px;
        }

        hr {
            margin: 20px 0;
        }
    </style>

</head>
<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<div class="container">
    <h1>🎬 Movie Booking</h1>

    <% if (userId != null) { %>

        <p class="welcome">Hello, <b><%= userName %></b> 👋</p>
        <hr/>

        <a href="movies" class="btn">Browse Movies</a><br/>
        <a href="mybookings.jsp" class="btn">My Bookings</a><br/>
        <a href="auth?action=logout" class="btn" style="background:#dc3545;">Logout</a>

    <% } else { %>

        <p class="welcome">Welcome! Please login or register.</p>
        <hr/>

        <a href="login.jsp" class="btn">Login</a><br/>
        <a href="register.jsp" class="btn">Register</a><br/><br/>

        <a href="movies" class="link">Browse Movies (Login required to book)</a>

    <% } %>
</div>

</body>
</html>
