<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page import="model.Product" %>

<%
    User me = (User) session.getAttribute("user");
    if (me == null || !"admin".equals(me.getRole())) {
        response.sendRedirect("login.jsp"); return;
    }
    List<User> users = (List<User>) request.getAttribute("users");
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; background:#f6f7fb; margin:0; padding:20px;}
        .wrap { max-width:1100px; margin:auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 4px 16px rgba(0,0,0,.08); }
        table { width:100%; border-collapse:collapse; margin-top:10px; }
        th, td { border:1px solid #e5e7eb; padding:10px; text-align:left; }
        th { background:#fafafa; }
        .btn { padding:6px 10px; border:0; cursor:pointer; background:#2563eb; color:#fff; border-radius:4px; }
        .btn.del { background:#dc2626; }
        .tag { padding:2px 8px; background:#e5e7eb; border-radius:99px; }
        .flash { margin:10px 0; }
        .ok { color:#16a34a; } .err { color:#dc2626; }
        form.inline { display:inline-block; margin:0; }
        select { padding:6px; }
        a { text-decoration:none; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Welcome, <%= me.getName() %> (Admin)</h2>
    <p><a href="logout.jsp">Logout</a></p>

    <div class="flash">
        <% if ("1".equals(request.getParameter("roleUpdated"))) { %><span class="ok">✅ Role updated</span><% } %>
        <% if ("0".equals(request.getParameter("roleUpdated"))) { %><span class="err">❌ Role update failed</span><% } %>
        <% if ("1".equals(request.getParameter("userDeleted"))) { %><span class="ok">✅ User deleted</span><% } %>
        <% if ("0".equals(request.getParameter("userDeleted"))) { %><span class="err">❌ User delete failed</span><% } %>
        <% if ("1".equals(request.getParameter("productDeleted"))) { %><span class="ok">✅ Product deleted</span><% } %>
        <% if ("0".equals(request.getParameter("productDeleted"))) { %><span class="err">❌ Product delete failed</span><% } %>
    </div>

    <h3>Users</h3>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Set Role</th><th>Action</th>
        </tr>
        <% if (users != null) for (User u : users) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getName() %></td>
            <td><%= u.getEmail() %></td>
            <td><span class="tag"><%= u.getRole() %></span></td>
            <td>
                <form class="inline" action="updateRole" method="post">
                    <input type="hidden" name="userId" value="<%= u.getId() %>">
                    <select name="role">
                        <option value="user"   <%= "user".equals(u.getRole())?"selected":"" %>>user</option>
                        <option value="vendor" <%= "vendor".equals(u.getRole())?"selected":"" %>>vendor</option>
                        <option value="admin"  <%= "admin".equals(u.getRole())?"selected":"" %>>admin</option>
                    </select>
                    <button class="btn" type="submit">Save</button>
                </form>
            </td>
            <td>
                <% if (u.getId() != me.getId()) { %>
                <a class="btn del" href="deleteUser?id=<%= u.getId() %>" onclick="return confirm('Delete this user?')">Delete</a>
                <% } else { %>—<% } %>
            </td>
        </tr>
        <% } %>
    </table>

    <h3 style="margin-top:28px;">All Products</h3>
    <table>
        <tr>
            <th>ID</th><th>Name</th><th>Description</th><th>Price</th><th>Vendor ID</th><th>Action</th>
        </tr>
        <% if (products != null) for (Product p : products) { %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= p.getDescription() %></td>
            <td>₹ <%= p.getPrice() %></td>
            <td>
                <a href="vendorProducts?vendorId=<%= p.getVendorId() %>"><%= p.getVendorId() %></a>
            </td>
            <td>
                <a class="btn del" href="deleteProduct?id=<%= p.getId() %>" onclick="return confirm('Delete product #<%= p.getId() %>?')">Delete</a>
            </td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
