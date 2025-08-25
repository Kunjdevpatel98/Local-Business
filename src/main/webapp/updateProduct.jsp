<%@ page import="model.User, model.Product" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"vendor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect("vendorDashboard.jsp?notfound=1");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Product</title>
    <style>
        body { font-family: Arial; background:#f6f7fb; margin:0; padding:20px;}
        .card { max-width: 720px; margin:auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 4px 16px rgba(0,0,0,.08);}
        input, textarea { width:100%; padding:8px; margin:6px 0; }
        .btn { padding:8px 14px; border:0; background:#2563eb; color:#fff; cursor:pointer; }
        .btn:hover { background:#1e40af; }
        a { text-decoration:none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Edit Product (#<%= product.getId() %>)</h2>
    <form action="updateProduct" method="post">
        <input type="hidden" name="id" value="<%= product.getId() %>">
        <input type="text" name="name" value="<%= product.getName() %>" required>
        <textarea name="description" required><%= product.getDescription() %></textarea>
        <input type="number" step="0.01" name="price" value="<%= product.getPrice() %>" required>
        <button class="btn" type="submit">Save Changes</button>
        <a href="vendorDashboard.jsp">Cancel</a>
    </form>
</div>
</body>
</html>
