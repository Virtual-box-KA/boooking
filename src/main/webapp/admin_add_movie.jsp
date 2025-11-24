<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Movie | Admin</title>
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

        .container {
            width: 55%;
            margin: 30px auto;
            background: #1a1a1a;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(255,255,255,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
            color: #ffcc00;
        }

        h3 {
            margin-top: 25px;
            color: #ffcc00;
            border-left: 4px solid #ffcc00;
            padding-left: 10px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 15px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border-radius: 8px;
            border: none;
            background: #2a2a2a;
            color: #fff;
            font-size: 14px;
        }

        input:focus, textarea:focus {
            outline: none;
            border: 2px solid #ffcc00;
        }

        button {
            width: 100%;
            padding: 15px;
            background: #ffcc00;
            color: #000;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: bold;
            margin-top: 25px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #e6b800;
        }

        .message {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }

        .error {
            background: #ff3b3b;
        }

        .success {
            background: #4caf50;
        }

    </style>
</head>
<body>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");

    if (userId == null || userRole == null || !"ADMIN".equalsIgnoreCase(userRole)) {
        response.sendError(403, "Access denied");
        return;
    }

    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>

<div class="navbar">
    <div>
        <a href="index.jsp">Home</a>
        <a href="movies">Movies</a>
    </div>
    <div>
        Logged in as <b><%= userName %></b>
        (<%= userRole %>) |
        <a href="auth?action=logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Add Movie & Show</h1>

    <% if (error != null) { %>
        <div class="message error"><%= error %></div>
    <% } %>

    <% if (message != null) { %>
        <div class="message success"><%= message %></div>
    <% } %>

    <form method="post" action="admin/add-movie">

        <h3>Movie Details</h3>

        <label>Title</label>
        <input type="text" name="title" required/>

        <label>Genre</label>
        <input type="text" name="genre"/>

        <label>Language</label>
        <input type="text" name="language"/>

        <label>Duration (minutes)</label>
        <input type="number" name="duration" min="1" required/>

        <label>Description</label>
        <textarea name="description" rows="4"></textarea>

        <label>Poster URL</label>
        <input type="text" name="posterUrl"/>

        <h3>Show Details</h3>

        <label>Show Date</label>
        <input type="date" name="showDate" required/>

        <label>Show Time</label>
        <input type="time" name="showTime" required/>

        <label>Screen</label>
        <input type="number" name="screen" min="1" required/>

        <label>Ticket Price</label>
        <input type="text" name="price" required/>

        <label>Total Seats</label>
        <input type="number" name="totalSeats" min="1" required/>

        <button type="submit">Add Movie</button>
    </form>

</div>

</body>
</html>
