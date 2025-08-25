<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    // ✅ check login
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
    <title>My Account</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f9f9f9; }
        .account-container { max-width: 900px; margin: 50px auto; }
        .sidebar { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0px 2px 6px rgba(0,0,0,0.1); }
        .sidebar a { display: block; padding: 10px; text-decoration: none; color: #333; border-radius: 5px; }
        .sidebar a:hover { background-color: #f0f0f0; }
        .content { background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0px 2px 6px rgba(0,0,0,0.1); }
        .active-link { font-weight: bold; color: #007bff; }
    </style>
</head>
<body>

<div class="container account-container">
    <div class="row">
        
        <!-- Sidebar -->
        <div class="col-md-4">
            <div class="sidebar">
                <h5>My Account</h5>
                <p><%= user.getEmail() %></p>
                <hr>
                <a href="myOrders.jsp">My Orders</a>
                <a href="savedAddresses.jsp">Saved Addresses</a>
                <a href="giftCards.jsp">E-Gift Cards</a>
                <a href="faqs.jsp">FAQ's</a>
                <a href="accountPrivacy.jsp">Account Privacy</a>
                <a href="logout" class="text-danger">Log Out</a>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-8">
            <div class="content">
                <h3>Welcome, <%= user.getName() %> </h3>
                <p>Here you can manage your account details and preferences.</p>

                <h5>Profile Details</h5>
                <ul>
                    <li><strong>Name:</strong> <%= user.getName() %></li>
                    <li><strong>Email:</strong> <%= user.getEmail() %></li>
                </ul>

                <a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
            </div>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
