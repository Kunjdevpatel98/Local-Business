<%@ page import="java.util.*" %>
<%@ page import="model.User, model.Shop, model.Product" %>
<%
    User me = (User) session.getAttribute("user");
    if (me == null) { response.sendRedirect("login.jsp?error=Please login"); return; }
    Shop shop = (Shop) request.getAttribute("shop");
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= shop != null ? shop.getShopName() : "Shop" %> - Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <a href="<%=request.getContextPath()%>/shops" class="btn btn-link"> Back to shops</a>

    <div class="card shadow-sm mt-2">
        <div class="card-body">
            <h3 class="card-title mb-1"><%= shop.getShopName() %></h3>
            <div class="text-muted mb-3"><%= shop.getLocation() %></div>

            <h5 class="mb-3">Products</h5>
            <div class="row g-3">
                <% if (products == null || products.isEmpty()) { %>
                    <div class="col-12 text-muted">No products in this shop yet.</div>
                <% } else {
                       for (Product p : products) { %>
                    <div class="col-md-4">
                        <div class="border rounded p-3 h-100">
                            <div class="fw-semibold"><%= p.getName() %></div>
                            <div class="small text-muted"><%= p.getDescription() %></div>
                            <div class="mt-1">Rs. <%= p.getPrice() %></div>
                        </div>
                    </div>
                <% } } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>
