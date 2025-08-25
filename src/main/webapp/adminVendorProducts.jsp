<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%
    User me = (User) session.getAttribute("user");
    if (me == null || !"admin".equals(me.getRole())) {
        response.sendRedirect("login.jsp"); return;
    }
    Integer vendorId = (Integer) request.getAttribute("vendorId");
    List<Product> items = (List<Product>) request.getAttribute("vendorProducts");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Vendor Products</title>
    <style>
        body { font-family: Arial; background:#f6f7fb; margin:0; padding:20px;}
        .wrap { max-width:900px; margin:auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 4px 16px rgba(0,0,0,.08); }
        table { width:100%; border-collapse:collapse; margin-top:10px; }
        th, td { border:1px solid #e5e7eb; padding:10px; text-align:left; }
        th { background:#fafafa; }
        a { text-decoration:none; }
        .btn { padding:6px 10px; border:0; cursor:pointer; background:#2563eb; color:#fff; border-radius:4px; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Vendor #<%= vendorId %> Products</h2>
    <p><a class="btn" href="dashboard">⬅ Back to Admin Dashboard</a></p>

    <table>
        <tr><th>ID</th><th>Name</th><th>Description</th><th>Price</th></tr>
        <% if (items != null) for (Product p : items) { %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= p.getDescription() %></td>
            <td>₹ <%= p.getPrice() %></td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
