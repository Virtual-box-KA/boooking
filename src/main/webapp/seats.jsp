<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Seat" %>
<%@ page import="com.bms.moviebooking.model.Show" %>
<html>
<head>
    <title>Seats</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f1f1f1;
            padding: 20px;
            margin: 0;
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
            color: #222;
            margin-bottom: 20px;
        }

        .show-info {
            text-align: center;
            background: white;
            padding: 15px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            font-size: 16px;
            color: #555;
        }

        .error {
            color: red;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        table {
            width: 70%;
            margin: auto;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 12px rgba(0,0,0,0.12);
            border-collapse: collapse;
        }

        th {
            background: #007bff;
            color: white;
            padding: 12px;
            font-size: 16px;
        }

        td {
            text-align: center;
            padding: 12px;
            border-bottom: 1px solid #ddd;
            font-size: 15px;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .btn {
            display: block;
            margin: 25px auto;
            padding: 12px 22px;
            background: #28a745;
            color: white;
            border-radius: 10px;
            text-decoration: none;
            font-size: 16px;
            text-align: center;
            border: none;
            cursor: pointer;
            transition: 0.2s;
        }

        .btn:hover {
            background: #1c7f32;
        }

        .booked {
            color: red;
            font-weight: bold;
        }

        .login-msg {
            color: #444;
            font-size: 14px;
        }
    </style>

</head>
<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    Integer showId = (Integer) request.getAttribute("showId");
    Show show = (Show) request.getAttribute("show");
%>

<div class="nav">
    <a href="index.jsp">Home</a> |
    <a href="movies">Movies</a> |
    <% if (show != null) { %>
        <a href="shows?movieId=<%= show.getMovieId() %>">Back to Shows</a>
    <% } %>

    <% if (userId != null) { %>
        | Logged in as <b><%= userName %></b>
        | <a href="mybookings.jsp">My Bookings</a>
        | <a href="auth?action=logout">Logout</a>
    <% } else { %>
        | <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
    <% } %>
</div>

<h1>Seat Selection</h1>

<% if (show != null) { %>
<div class="show-info">
    <b>Show Details</b><br>
    Date: <%= show.getShowDate() %> |
    Time: <%= show.getShowTime() %> |
    Screen: <%= show.getScreen() %>
</div>
<% } %>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) { %>
        <div class="error"><%= error %></div>
<% } %>

<% if (userId == null) { %>
    <div class="error">You must be logged in to book seats.</div>
<% } %>

<form method="post" action="book">
    <input type="hidden" name="showId" value="<%= showId %>"/>

    <table>
        <tr>
            <th>Seat</th>
            <th>Status</th>
            <th>Select</th>
        </tr>

        <%
            List<Seat> seats = (List<Seat>) request.getAttribute("seats");
            if (seats != null && !seats.isEmpty()) {
                for (Seat seat : seats) {
        %>
        <tr>
            <td><%= seat.getSeatNo() %></td>
            <td>
                <% if (!"AVAILABLE".equalsIgnoreCase(seat.getStatus())) { %>
                    <span class="booked">Booked</span>
                <% } else { %>
                    Available
                <% } %>
            </td>

            <td>
                <% if ("AVAILABLE".equalsIgnoreCase(seat.getStatus()) && userId != null) { %>
                    <input type="checkbox" name="seats" value="<%= seat.getSeatNo() %>"/>
                <% } else if (!"AVAILABLE".equalsIgnoreCase(seat.getStatus())) { %>
                    <span class="booked">X</span>
                <% } else { %>
                    <span class="login-msg">Login to book</span>
                <% } %>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="3">No seats found.</td>
        </tr>
        <% } %>
    </table>

    <% if (userId != null) { %>
        <button type="submit" class="btn">Book Selected Seats</button>
    <% } %>
</form>

</body>
</html>
