<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: #fff;
            padding: 40px 35px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .input-field {
            position: relative;
            margin-bottom: 20px;
        }
        .input-field input {
            width: 100%;
            padding: 12px 40px 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            outline: none;
            transition: border 0.3s;
        }
        .input-field input:focus {
            border-color: #4facfe;
        }
        .input-field i {
            position: absolute;
            right: 12px;
            top: 12px;
            color: #999;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #4facfe;
            border: none;
            border-radius: 8px;
            color: #fff;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #00c6ff;
        }
        .error {
            color: red;
            margin: 10px 0;
            font-size: 14px;
        }
        .register-link {
            margin-top: 15px;
            font-size: 14px;
        }
        .register-link a {
            color: #4facfe;
            font-weight: bold;
            text-decoration: none;
        }
        .register-link a:hover {
            text-decoration: underline;
        }
    </style>
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body> 
    <div class="login-container">
        <h2>User Login</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-field">
                <input type="email" name="email" placeholder="Enter Email" required>
                <i class="fa fa-envelope"></i>
            </div>
            <div class="input-field">
                <input type="password" name="password" placeholder="Enter Password" required>
                <i class="fa fa-lock"></i>
            </div>
            <button type="submit">Login</button>
        </form>
        <p class="error">${param.error}</p>
        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register Now</a>
        </div>
    </div>
</body>
</html>
