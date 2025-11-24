<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Show" %>
<%@ page import="com.bms.moviebooking.model.Movie" %>
<html>
<head>
    <title>Shows</title>
</head>
<body>
<%
    Movie movie = (Movie) request.getAttribute("movie");
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<p>
    <a href="index.jsp">Home</a> | <a href="movies">Back to Movies</a>
    <% if (userId != null) { %>
        | Logged in as <b><%= userName %></b>
        | <a href="mybookings.jsp">My Bookings</a>
        | <a href="auth?action=logout">Logout</a>
    <% } else { %>
        | <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
    <% } %>
</p>

<h1>Shows for <%= (movie != null ? movie.getTitle() : "") %></h1>

<ul>
<%
    List<Show> shows = (List<Show>) request.getAttribute("shows");
    if (shows != null && !shows.isEmpty()) {
        for (Show s : shows) {
%>
    <li>
        Date: <%= s.getShowDate() %>,
        Time: <%= s.getShowTime() %>,
        Screen: <%= s.getScreen() %>
        - <a href="seats?showId=<%= s.getId() %>">View Seats</a>
    </li>
<%
        }
    } else {
%>
    <li>No shows available.</li>
<%
    }
%>
</ul>

</body>
</html>
