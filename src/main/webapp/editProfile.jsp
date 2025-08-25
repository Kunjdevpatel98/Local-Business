<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    HttpSession sessionObj = request.getSession(false);
    User user = null;
    if (sessionObj != null) {
        user = (User) sessionObj.getAttribute("user");
    }
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f9f9f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .edit-profile-container {
            max-width: 500px;
            margin: 60px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .form-label {
            font-weight: 500;
        }
        .btn-custom {
            background: #007bff;
            color: #fff;
            border-radius: 8px;
            font-weight: 500;
            padding: 10px 20px;
        }
        .btn-custom:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<div class="edit-profile-container">
    <h3 class="text-center mb-4">✏️ Edit Profile</h3>

    <form action="updateProfile" method="post">
        
        <!-- Name -->
        <div class="mb-3">
            <label class="form-label">Full Name</label>
            <input type="text" name="name" class="form-control" value="<%= user.getName() %>" required>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-control" value="<%= user.getEmail() %>" required>
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label class="form-label">New Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter new password">
            <div class="form-text">Leave blank if you don’t want to change.</div>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between">
            <a href="profile.jsp" class="btn btn-secondary">⬅ Back</a>
            <button type="submit" class="btn btn-custom">Update Profile</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
