<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"vendor".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Vendor Dashboard</title>
</head>
<body>
<h2>Welcome, <%= user.getName() %> (Vendor)</h2>  

<form action="addProduct" method="post">
    <label>Product Name:</label><input type="text" name="name" required><br>
    <label>Description:</label><input type="text" name="description" required><br>
    <label>Price:</label><input type="number" step="0.01" name="price" required><br>
    <input type="submit" value="Add Product">
</form>
</body>
</html>
