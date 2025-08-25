<%@ page import="java.util.*" %>
<%@ page import="model.User, model.Shop, model.Product" %>
<%
    User me = (User) session.getAttribute("user");
    if (me == null || !"vendor".equalsIgnoreCase(me.getRole())) {
        response.sendRedirect("login.jsp?error=Login as vendor"); return;
    }
    List<Shop> shops = (List<Shop>) request.getAttribute("shops");
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Vendor Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Welcome, <%= me.getName() %> (Vendor)</h3>
        <div>
            <a href="<%=request.getContextPath()%>/shops" class="btn btn-outline-primary">View All Shops (User View)</a>
            <a href="logout.jsp" class="btn btn-outline-danger ms-2">Logout</a>
        </div>
    </div>

    <!-- Flash -->
    <%
        String shopAdded = request.getParameter("shopAdded");
        String productAdded = request.getParameter("productAdded");
        if ("1".equals(shopAdded)) { %><div class="alert alert-success">Shop added.</div><% }
        if ("0".equals(shopAdded)) { %><div class="alert alert-danger">Failed to add shop.</div><% }
        if ("1".equals(productAdded)) { %><div class="alert alert-success">Product added.</div><% }
        if ("0".equals(productAdded)) { %><div class="alert alert-danger">Failed to add product.</div><% }
    %>

    <div class="row g-4">
        <!-- Add Shop -->
        <div class="col-md-5">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Add New Shop</h5>
                   <form action="<%=request.getContextPath()%>/vendor/addShop" method="post" class="mt-3">
					  <div class="mb-3">
					    <label class="form-label">Shop Name</label>
					    <input type="text" name="shopName" class="form-control" required>
					  </div>
					  <div class="mb-3">
					    <label class="form-label">Location</label>
					    <input type="text" name="location" class="form-control" required>
					  </div>
					  <div class="mb-3">
					    <label class="form-label">Category</label>
					    <select name="category" class="form-select" required>
					      <option value="Grocery">Grocery</option>
					      <option value="Medicine">Medicine</option>
					      <option value="Electronics">Electronics</option>
					      <option value="Other">Other</option>
					    </select>
					  </div>
					  <button class="btn btn-primary w-100">Add Shop</button>
					</form>	                   
                </div>
            </div>
        </div>

        <!-- Add Product -->
        <div class="col-md-7">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h5 class="card-title">Add Product to Shop</h5>
                    <form action="<%=request.getContextPath()%>/vendor/addProduct" method="post" class="mt-3">
                        <div class="mb-3">
                            <label class="form-label">Select Shop</label>
                            <select name="shopId" class="form-select" required>
                                <option value="">-- choose shop --</option>
                                <% if (shops != null) {
                                    for (Shop s : shops) { %>
                                        <option value="<%= s.getId() %>"><%= s.getShopName() %> - <%= s.getLocation() %></option>
                                <% }} %>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Product Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="2" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <input type="number" step="0.01" name="price" class="form-control" required>
                        </div>
                        <button class="btn btn-success w-100">Add Product</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Your Shops & Products -->
    <div class="card mt-4 shadow-sm">
        <div class="card-body">
            <h5 class="card-title mb-3">Your Shops & Products</h5>
            <% if (shops == null || shops.isEmpty()) { %>
                <div class="alert alert-info">No shops yet. Add your first shop!</div>
            <% } else { %>
                <% for (Shop s : shops) { %>
                    <div class="border rounded p-3 mb-3">
                        <h6 class="mb-1"><%= s.getShopName() %></h6>
                        <div class="text-muted mb-2"><%= s.getLocation() %></div>
                        <div class="row">
                            <% boolean any=false;
                               if (products != null) {
                                   for (Product p : products) {
                                       if (p.getShopId() == s.getId()) { any=true; %>
                                           <div class="col-md-4 mb-3">
                                               <div class="p-3 border rounded">
                                                   <div class="fw-semibold"><%= p.getName() %></div>
                                                   <div class="small text-muted"><%= p.getDescription() %></div>
                                                   <div class="mt-1">Rs. <%= p.getPrice() %></div>
                                               </div>
                                           </div>
                            <%         }
                                   }
                               }
                               if (!any) { %>
                                   <div class="col-12 text-muted">No products in this shop yet.</div>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            <% } %>
        </div>
    </div>
</div>
</body>
</html>