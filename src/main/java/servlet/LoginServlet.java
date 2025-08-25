package servlet;

import dao.UserDAO;
import model.User;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(email, password);

        if (user != null) {
            // ✅ Session me user object dalna
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Role check karke redirect
            if ("vendor".equals(user.getRole())) {
                response.sendRedirect("vendorDashboard.jsp");
            } else if ("admin".equals(user.getRole())) {
            	response.sendRedirect("admin/dashboard"); 
            } else {
                response.sendRedirect("shops");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
