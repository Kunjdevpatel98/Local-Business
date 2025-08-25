<%
    session.invalidate();
    response.sendRedirect("login.jsp?error=Logged out successfully");
%>
