<%-- <%@ page import="model.User, model.Product, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0; padding: 0;
            background: #f4f6f9;
        }
        .navbar {
            background: #4facfe;
            padding: 15px 30px;
            color: #fff;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar h2 { margin: 0; }
        .profile {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            margin: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .products {
            margin: 20px;
            display: grid;
            grid-template-columns: repeat(auto-fill,minmax(250px,1fr));
            gap: 20px;
        }
        .card {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card h3 { margin-top: 0; }
        .logout {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <div class="navbar">
        <h2>Welcome, <%= user.getName() %> 👋</h2>
        <a href="logout.jsp" class="logout">Logout</a>
    </div>

    <!-- Profile Section -->
    <div class="profile">
        <h3>Your Profile</h3>
        <p><b>Name:</b> <%= user.getName() %></p>
        <p><b>Email:</b> <%= user.getEmail() %></p>
        <p><b>Role:</b> <%= user.getRole() %></p>
    </div>

    <!-- Products Section -->
    <div class="products">
        <% for(Product p : products) { %>
            <div class="card">
                <h3><%= p.getName() %></h3>
                <p><%= p.getDescription() %></p>
                <p><b>Price:</b> ₹<%= p.getPrice() %></p>
            </div>
        <% } %>
    </div>
</body>
</html> --%>

<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    
%>
<!-- userDashboard.jsp -->
<%@ page import="model.User" %>
<%
    HttpSession sess = request.getSession(false);
    User user = null;
    if(sess != null){
        user = (User) sess.getAttribute("user");
    }

    if(user == null){
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Local Business Support</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            
        }
         
        .vendor-card {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0px 2px 6px rgba(0,0,0,0.1);
            padding: 16px;
            margin-bottom: 16px;
        }
        .category-btn {
            border-radius: 30px;
            margin: 4px;
        }
         body { font-family: Arial, sans-serif; margin:0; padding:0; background:#f4f4f4; }
        .navbar { background:#333; padding:15px; color:white; display:flex; justify-content:space-between; }
        .navbar a { color:white; text-decoration:none; margin-left:15px; }
        .card { background:white; padding:15px; margin:20px; border-radius:8px; }
    </style>
</head>
<body>
<div class="navbar">
    <div>Welcome, <%= user.getName() %> </div>
    <div>
        <a href="userDashboard.jsp">Dashboard</a>
        <a href="profile.jsp">My Account</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="container mt-4">
    <h2 class="mb-3 text-primary">Local Business Support</h2>
    <p class="text-muted">Discover & support local vendors</p>

    <!-- Search Box -->
    <input type="text" class="form-control mb-3" placeholder="Search vendors, services...">

    <!-- Categories -->
    <div class="mb-4">
        <button class="btn btn-outline-primary category-btn">All</button>
        <button class="btn btn-outline-success category-btn">Grocery</button>
        <button class="btn btn-outline-danger category-btn">Medicine</button>
        <button class="btn btn-outline-dark category-btn">Electronics</button>
    </div>

    <!-- Vendors List -->
    <h5 class="mb-3">All Vendors <span class="text-muted">( <%= products != null ? products.size() : 0 %> found )</span></h5>

    <%
        if (products != null) {
            for (Product p : products) {
    %>
        <div class="vendor-card">
            <div class="d-flex justify-content-between">
                <h5><%= p.getName() %></h5>
                <!-- ⭐ Default Rating दिखेगा -->
                <span class="text-warning fw-bold"> 4.5</span>
            </div>
            <p class="text-muted mb-1"><%= p.getDescription() %></p>
            <p class="mb-1">Rs.<%= p.getPrice() %></p>

            <!-- Action Buttons -->
            <div class="mt-2">
                <button class="btn btn-success btn-sm">WhatsApp</button>
                <button class="btn btn-primary btn-sm">Pay UPI</button>
                <button class="btn btn-info btn-sm">Navigate</button>
            </div>
        </div>
    <%
            }
        }
    %>
</div>
 
</body>
</html>
