<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        label {
            display: block;
            margin-top: 10px;
            text-align: left;
            color: #555;
            font-weight: bold;
        }
        input[type="text"], 
        input[type="email"], 
        input[type="password"], 
        select {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }
        input:focus {
            border-color: #4facfe;
        }
        .btn {
            width: 100%;
            padding: 12px;
            margin-top: 20px;
            background: #4facfe;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #00c6ff;
        }
        .login-link {
            margin-top: 15px;
            display: block;
            color: #333;
            font-size: 14px;
        }
        .login-link a {
            color: #4facfe;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>User Registration</h2>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <label>Name:</label>
            <input type="text" name="name" placeholder="Enter your name" required>

            <label>Email:</label>
            <input type="email" name="email" placeholder="Enter your email" required>

            <label>Password:</label>
            <input type="password" name="password" placeholder="Enter your password" required>

            <label>Role:</label>
            <select name="role" required>
                <option value="user">User</option>
                <option value="vendor">Vendor</option>
            </select>

            <button type="submit" class="btn">Register</button>
        </form>
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login Here</a>
        </div>
    </div>
</body>
</html>
