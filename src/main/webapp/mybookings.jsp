<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.dao.BookingDAO" %>
<%@ page import="com.bms.moviebooking.dao.ShowDAO" %>
<%@ page import="com.bms.moviebooking.dao.MovieDAO" %>
<%@ page import="com.bms.moviebooking.model.Booking" %>
<%@ page import="com.bms.moviebooking.model.Show" %>
<%@ page import="com.bms.moviebooking.model.Movie" %>
<html>
<head>
    <title>My Bookings</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #0a0a0a;
            color: #fff;
        }

        .navbar {
            background: #111;
            padding: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.5);
        }

        .navbar a {
            color: #ffcc00;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }

        .page-title {
            text-align: center;
            margin-top: 25px;
            font-size: 32px;
            color: #ffcc00;
        }

        .container {
            width: 80%;
            margin: 30px auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #1a1a1a;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(255,255,255,0.1);
        }

        th, td {
            padding: 14px;
            text-align: center;
        }

        th {
            background: #ffcc00;
            color: #000;
            font-weight: bold;
            font-size: 14px;
        }

        tr:nth-child(even) {
            background: #222;
        }

        tr:hover {
            background: #333;
        }

        .empty {
            text-align: center;
            font-size: 18px;
            margin-top: 40px;
            background: #1a1a1a;
            padding: 20px;
            width: 50%;
            margin-left: auto;
            margin-right: auto;
            border-radius: 10px;
            color: #ffcc00;
            box-shadow: 0 0 15px rgba(255,255,255,0.1);
        }
    </style>
</head>

<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="navbar">
    <div>
        <a href="index.jsp">Home</a>
        <a href="movies">Movies</a>
    </div>
    <div>
        Logged in as <b><%= userName %></b> |
        <a href="auth?action=logout">Logout</a>
    </div>
</div>

<h1 class="page-title">My Bookings</h1>

<div class="container">
<%
    BookingDAO bookingDAO = new BookingDAO();
    ShowDAO showDAO = new ShowDAO();
    MovieDAO movieDAO = new MovieDAO();

    List<Booking> bookings = null;
    try {
        bookings = bookingDAO.getBookingsByUserId(userId);
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error loading bookings: " + e.getMessage() + "</p>");
    }

    if (bookings == null || bookings.isEmpty()) {
%>

    <div class="empty">
        You have no bookings yet.
    </div>

<%
    } else {
%>

    <table>
        <tr>
            <th>Booking ID</th>
            <th>Movie</th>
            <th>Date</th>
            <th>Time</th>
            <th>Screen</th>
            <th>Seat</th>
            <th>Booking Time</th>
            <th>Payment Status</th>
        </tr>

        <%
            for (Booking b : bookings) {
                Show show = null;
                Movie movie = null;
                try {
                    show = showDAO.getShowById(b.getShowId());
                    if (show != null) {
                        movie = movieDAO.getMovieById(show.getMovieId());
                    }
                } catch (Exception ex) {
                    // ignore errors
                }
        %>
        <tr>
            <td><%= b.getId() %></td>
            <td><%= (movie != null ? movie.getTitle() : "N/A") %></td>
            <td><%= (show != null ? show.getShowDate() : "") %></td>
            <td><%= (show != null ? show.getShowTime() : "") %></td>
            <td><%= (show != null ? show.getScreen() : "") %></td>
            <td><%= b.getSeatNo() %></td>
            <td><%= b.getBookingTime() %></td>
            <td><%= b.getPaymentStatus() %></td>
        </tr>
        <%
            }
        %>
    </table>

<%
    }
%>
</div>

</body>
</html>
