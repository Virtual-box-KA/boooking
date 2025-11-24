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

<p>
    <a href="index.jsp">Home</a> |
    <a href="movies">Movies</a> |
    Logged in as <b><%= userName %></b> |
    <a href="auth?action=logout">Logout</a>
</p>

<h1>My Bookings</h1>

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
    <p>You have no bookings yet.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
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
                    // ignore for now
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

</body>
</html>
