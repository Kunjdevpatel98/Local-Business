package servlet.admin;

import dao.AdminDAO;
import model.User;
import model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("user") : null;
        if (auth == null || !"admin".equals(auth.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        AdminDAO dao = new AdminDAO();
        List<User> users = dao.getAllUsers();
        List<Product> products = dao.getAllProducts();

        req.setAttribute("users", users);
        req.setAttribute("products", products);
        RequestDispatcher rd = req.getRequestDispatcher("/adminDashboard.jsp");
        rd.forward(req, resp);
    }
}
