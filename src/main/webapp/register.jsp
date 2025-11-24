<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>

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
            margin: 70px auto;
            background: #1a1a1a;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(255,255,255,0.1);
        }

        h1 {
            text-align: center;
            color: #ffcc00;
            margin-bottom: 25px;
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
            margin-top: 20px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #e6b800;
        }

        .error {
            background: #ff3b3b;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            margin-bottom: 20px;
        }

        .links {
            text-align: center;
            margin-top: 15px;
        }

        .links a {
            color: #ffcc00;
            text-decoration: none;
            font-weight: bold;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>

</head>
<body>

<div class="container">

    <h1>Create Account</h1>

    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <form method="post" action="auth">
        <input type="hidden" name="action" value="register"/>

        <label>Name</label>
        <input type="text" name="name" required/>

        <label>Email</label>
        <input type="email" name="email" required/>

        <label>Phone</label>
        <input type="text" name="phone"/>

        <label>Password</label>
        <input type="password" name="password" required/>

        <label>Confirm Password</label>
        <input type="password" name="confirm" required/>

        <button type="submit">Register</button>
    </form>

    <div class="links">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
        <p><a href="index.jsp">Back to Home</a></p>
    </div>

</div>

</body>
</html>
