<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Movie" %>
<html>
<head>
    <title>Movies</title>
</head>
<body>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<h1>Now Showing</h1>

<p>
    <a href="index.jsp">Home</a>
    <% if (userId != null) { %>
        | Logged in as <b><%= userName %></b>
        | <a href="mybookings.jsp">My Bookings</a>
        | <a href="auth?action=logout">Logout</a>
    <% } else { %>
        | <a href="login.jsp">Login</a> | <a href="register.jsp">Register</a>
    <% } %>
</p>

<ul>
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    if (movies != null && !movies.isEmpty()) {
        for (Movie m : movies) {
%>
    <li>
        <a href="shows?movieId=<%= m.getId() %>">
            <b><%= m.getTitle() %></b> - <%= m.getGenre() %> - <%= m.getLanguage() %>
        </a>
        <% if (m.getDuration() > 0) { %>
            ( <%= m.getDuration() %> mins )
        <% } %>
    </li>
<%
        }
    } else {
%>
    <li>No movies available.</li>
<%
    }
%>
</ul>

</body>
</html>
