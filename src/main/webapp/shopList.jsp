<%@ page import="java.util.*" %>
<%@ page import="model.User, model.Shop" %>
<%
    User me = (User) session.getAttribute("user");
    if (me == null) { response.sendRedirect("login.jsp?error=Please login"); return; }
    List<Shop> shops = (List<Shop>) request.getAttribute("shops");
    String category = (String) request.getAttribute("category");
    String q = (String) request.getAttribute("q");
    if (category == null) category = "all";
    if (q == null) q = "";
%>
<!DOCTYPE html>
<html>
<head>
  <title>Local Business Support</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .pill { border-radius: 999px; padding: 8px 16px; border:1px solid #ddd; background:#fff; }
    .pill.active { border-color:#0d6efd; color:#0d6efd; }
    .card-soft { border:1px solid #eee; border-radius:14px; box-shadow:0 10px 24px rgba(0,0,0,.06); }
  </style>
</head>
<body class="bg-light">
<div class="container py-4">

  <div class="mb-3">
    <h2 class="text-primary fw-bold">Local Business Support</h2>
    <div class="text-muted">Discover & support local vendors</div>
  </div>

  <!-- Search -->
  <form class="input-group mb-3" method="get" action="<%=request.getContextPath()%>/shops">
    <input type="hidden" name="category" value="<%= category %>"/>
    <input type="text" name="q" class="form-control" placeholder="Search vendors, services..." value="<%= q %>">
    <button class="btn btn-primary">Search</button>
  </form>

  <!-- Categories -->
  <div class="d-flex gap-2 flex-wrap mb-3">
    <a class="pill <%= "all".equalsIgnoreCase(category)?"active":"" %>"
       href="<%=request.getContextPath()%>/shops?category=all&q=<%= java.net.URLEncoder.encode(q,"UTF-8") %>">All</a>
    <a class="pill <%= "Grocery".equalsIgnoreCase(category)?"active":"" %>"
       href="<%=request.getContextPath()%>/shops?category=Grocery&q=<%= java.net.URLEncoder.encode(q,"UTF-8") %>">Grocery</a>
    <a class="pill <%= "Medicine".equalsIgnoreCase(category)?"active":"" %>"
       href="<%=request.getContextPath()%>/shops?category=Medicine&q=<%= java.net.URLEncoder.encode(q,"UTF-8") %>">Medicine</a>
    <a class="pill <%= "Electronics".equalsIgnoreCase(category)?"active":"" %>"
       href="<%=request.getContextPath()%>/shops?category=Electronics&q=<%= java.net.URLEncoder.encode(q,"UTF-8") %>">Electronics</a>
  </div>

  <div class="d-flex justify-content-between mb-2">
    <div class="fw-semibold">All Vendors</div>
    <div class="text-muted"><%= (shops==null)?0:shops.size() %> found</div>
  </div>

  <!-- Shops list -->
  <div class="vstack gap-3">
    <% if (shops == null || shops.isEmpty()) { %>
      <div class="alert alert-info">No shops found for your filter/search.</div>
    <% } else {
         for (Shop s : shops) { %>
      <div class="card card-soft">
        <div class="card-body">
          <div class="d-flex justify-content-between align-items-start">
            <div>
              <h5 class="mb-1"><%= s.getShopName() %></h5>
              <div class="text-muted mb-1"><%= s.getLocation() %></div>
              <span class="badge bg-light text-dark border"><%= s.getCategory() %></span>
            </div>
            <div class="text-warning fw-bold"> 4.5</div>
          </div>

          <div class="mt-3 d-flex gap-2">
            <a class="btn btn-success" href="https://wa.me/?text=Hi%20<%= java.net.URLEncoder.encode(s.getShopName(),"UTF-8") %>">WhatsApp</a>
            <a class="btn btn-primary" href="<%=request.getContextPath()%>/shopDetails?id=<%= s.getId() %>">View Products</a>
            <a class="btn btn-info" target="_blank"
               href="https://www.google.com/maps/search/<%= java.net.URLEncoder.encode(s.getLocation(),"UTF-8") %>">Navigate</a>
          </div>
        </div>
      </div>
    <% } } %>
  </div>

</div>
</body>
</html>
