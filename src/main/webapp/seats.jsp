<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Seat" %>
<%@ page import="com.bms.moviebooking.model.Show" %>
<html>
<head>
    <title>Seats</title>
</head>
<body>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    Integer showId = (Integer) request.getAttribute("showId");
    Show show = (Show) request.getAttribute("show");
%>

<p>
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
</p>

<h1>Seats</h1>

<% if (show != null) { %>
    <p>Show: Date <%= show.getShowDate() %>, Time <%= show.getShowTime() %>, Screen <%= show.getScreen() %></p>
<% } %>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
<p style="color:red;"><%= error %></p>
<% } %>

<% if (userId == null) { %>
<p style="color:red;">You must be logged in to book seats.</p>
<% } %>

<form method="post" action="book">
    <input type="hidden" name="showId" value="<%= showId %>"/>

    <table border="1" cellpadding="5" cellspacing="0">
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
            <td><%= seat.getStatus() %></td>
            <td>
                <% if ("AVAILABLE".equalsIgnoreCase(seat.getStatus()) && userId != null) { %>
                    <input type="checkbox" name="seats" value="<%= seat.getSeatNo() %>"/>
                <% } else if (!"AVAILABLE".equalsIgnoreCase(seat.getStatus())) { %>
                    Booked
                <% } else { %>
                    Login to book
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
        <%
            }
        %>
    </table>

    <% if (userId != null) { %>
        <br/>
        <button type="submit">Book Selected Seats</button>
    <% } %>
</form>

</body>
</html>
