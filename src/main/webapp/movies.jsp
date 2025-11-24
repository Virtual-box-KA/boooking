<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bms.moviebooking.model.Movie" %>
<html>
<head>
    <title>Movies</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #0a0a0a;
            color: #fff;
        }

        .navbar {
            background: #1a1a1a;
            padding: 15px;
            text-align: center;
            font-size: 17px;
            box-shadow: 0 0 15px rgba(255,255,255,0.1);
        }

        .navbar a {
            color: #ffcc00;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }

        h1 {
            text-align: center;
            margin-top: 30px;
            color: #ffcc00;
        }

        .movies-container {
            width: 90%;
            max-width: 1000px;
            margin: 30px auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
        }

        .movie-card {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(255,255,255,0.1);
            transition: 0.3s;
        }

        .movie-card:hover {
            transform: scale(1.05);
            box-shadow: 0 0 25px rgba(255,255,255,0.2);
        }

        .movie-title {
            color: #ffcc00;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 8px;
        }

        .movie-info {
            color: #ccc;
            margin-bottom: 12px;
        }

        .view-btn {
            display: inline-block;
            background: #ffcc00;
            color: #000;
            padding: 10px 14px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .view-btn:hover {
            background: #e6b800;
        }

        .no-movies {
            text-align: center;
            color: #ccc;
            margin-top: 40px;
        }
    </style>
</head>
<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
%>

<div class="navbar">
    <a href="index.jsp">Home</a>

    <% if (userId != null) { %>
        | Logged in as <b style="color:white;"><%= userName %></b>
        | <a href="mybookings.jsp">My Bookings</a>
        | <a href="auth?action=logout">Logout</a>
    <% } else { %>
        | <a href="login.jsp">Login</a>
        | <a href="register.jsp">Register</a>
    <% } %>
</div>

<h1>Now Showing</h1>

<div class="movies-container">
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");

    if (movies != null && !movies.isEmpty()) {
        for (Movie m : movies) {
%>

    <div class="movie-card">
        <div class="movie-title"><%= m.getTitle() %></div>
        <div class="movie-info">
            Genre: <%= m.getGenre() %><br/>
            Language: <%= m.getLanguage() %><br/>
            <% if (m.getDuration() > 0) { %>
                Duration: <%= m.getDuration() %> mins
            <% } %>
        </div>

        <a class="view-btn" href="shows?movieId=<%= m.getId() %>">View Shows</a>
    </div>

<%
        }
    } else {
%>
    <div class="no-movies">No movies available.</div>
<%
    }
%>
</div>

</body>
</html>
