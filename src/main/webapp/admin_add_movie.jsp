<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin - Add Movie</title>
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

<p>
    <a href="index.jsp">Home</a> |
    <a href="movies">Movies</a> |
    Logged in as <b><%= userName %></b> (<%= userRole %>) |
    <a href="auth?action=logout">Logout</a>
</p>

<h1>Add Movie & Show</h1>

<% if (error != null) { %>
    <p style="color:red;"><%= error %></p>
<% } %>
<% if (message != null) { %>
    <p style="color:green;"><%= message %></p>
<% } %>

<form method="post" action="admin/add-movie">
    <h3>Movie Details</h3>
    <label>Title:
        <input type="text" name="title" required/>
    </label><br/><br/>

    <label>Genre:
        <input type="text" name="genre"/>
    </label><br/><br/>

    <label>Language:
        <input type="text" name="language"/>
    </label><br/><br/>

    <label>Duration (minutes):
        <input type="number" name="duration" min="1" required/>
    </label><br/><br/>

    <label>Description:<br/>
        <textarea name="description" rows="4" cols="50"></textarea>
    </label><br/><br/>

    <label>Poster URL:
        <input type="text" name="posterUrl"/>
    </label><br/><br/>

    <h3>Show Details</h3>

    <label>Show Date:
        <input type="date" name="showDate" required/>
    </label><br/><br/>

    <label>Show Time:
        <input type="time" name="showTime" required/>
    </label><br/><br/>

    <label>Screen:
        <input type="number" name="screen" min="1" required/>
    </label><br/><br/>

    <label>Ticket Price:
        <input type="text" name="price" required/>
    </label><br/><br/>

    <label>Total Seats:
        <input type="number" name="totalSeats" min="1" required/>
    </label><br/><br/>

    <button type="submit">Add Movie</button>
</form>

</body>
</html>
