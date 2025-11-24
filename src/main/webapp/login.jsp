<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #0a0a0a;
            color: #fff;
        }

        .container {
            width: 420px;
            margin: 90px auto;
            background: #1a1a1a;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255,255,255,0.1);
        }

        h1 {
            text-align: center;
            color: #ffcc00;
            margin-bottom: 25px;
            font-size: 28px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 12px;
            margin-top: 5px;
            border-radius: 8px;
            border: none;
            background: #2a2a2a;
            color: #fff;
        }

        input:focus {
            outline: none;
            border: 2px solid #ffcc00;
        }

        button {
            width: 100%;
            padding: 14px;
            background: #ffcc00;
            border: none;
            border-radius: 10px;
            color: #000;
            font-weight: bold;
            font-size: 16px;
            margin-top: 25px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #e6b800;
        }

        .msg, .error {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
        }

        .msg {
            background: #2e7d32; /* green */
        }

        .error {
            background: #d32f2f; /* red */
        }

        .links {
            margin-top: 18px;
            text-align: center;
        }

        .links a {
            color: #ffcc00;
            font-weight: bold;
            text-decoration: none;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>

</head>
<body>

<div class="container">

    <h1>Login</h1>

    <%
        String error = (String) request.getAttribute("error");
        String message = (String) request.getAttribute("message");

        if (message != null) {
    %>
        <div class="msg"><%= message %></div>
    <%
        }

        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <form method="post" action="auth">
        <input type="hidden" name="action" value="login"/>

        <label>Email</label>
        <input type="email" name="email" required/>

        <label>Password</label>
        <input type="password" name="password" required/>

        <button type="submit">Login</button>
    </form>

    <div class="links">
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        <p><a href="index.jsp">Back to Home</a></p>
    </div>

</div>

</body>
</html>
