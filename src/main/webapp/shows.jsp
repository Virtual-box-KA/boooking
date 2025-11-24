<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Show" %>
<%@ page import="com.bms.moviebooking.model.Movie" %>
<html>
<head>
    <title>Shows</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .nav {
            background: white;
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .nav a {
            text-decoration: none;
            margin-right: 12px;
            color: #007bff;
            font-weight: bold;
        }

        .nav a:hover {
            text-decoration: underline;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        .container {
            max-width: 750px;
            margin: auto;
        }

        .show-card {
            background: white;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .show-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .show-details {
            color: #555;
            margin: 8px 0;
        }

        .btn {
            display: inline-block;
            background: #28a745;
            padding: 10px 16px;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            transition: 0.2s;
            font-size: 14px;
        }

        .btn:hover {
            background: #1c7f32;
        }

        .no-shows {
            text-align: center;
            margin-top: 30px;
            color: #777;
            font-size: 18px;
        }
    </style>
</head>

<body>

<%
    Movie movie = (Movie) request.getAttribute("movie");
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<div class="nav">
    <a href="index.jsp">Home</a>
    <a href="movies">Back to Movies</a>

    <% if (userId != null) { %>
        | Logged in as <b><%= userName %></b>
        | <a href="mybookings.jsp">My Bookings</a>
        | <a href="auth?action=logout">Logout</a>
    <% } else { %>
        | <a href="login.jsp">Login</a>
        | <a href="register.jsp">Register</a>
    <% } %>
</div>

<h1>Shows for <%= (movie != null ? movie.getTitle() : "") %></h1>

<div class="container">

<%
    List<Show> shows = (List<Show>) request.getAttribute("shows");
    if (shows != null && !shows.isEmpty()) {
        for (Show s : shows) {
%>

    <div class="show-card">
        <div class="show-title">Showtime</div>

        <div class="show-details">
            <b>Date:</b> <%= s.getShowDate() %><br>
            <b>Time:</b> <%= s.getShowTime() %><br>
            <b>Screen:</b> <%= s.getScreen() %>
        </div>

        <a href="seats?showId=<%= s.getId() %>" class="btn">View Seats</a>
    </div>

<%
        }
    } else {
%>

    <p class="no-shows">No shows available.</p>

<%
    }
%>

</div>

</body>
</html>
