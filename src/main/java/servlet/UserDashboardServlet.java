package servlet;

import dao.ProductDAO;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/userDashboard")
public class UserDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        // ✅ Products fetch from DB
        ProductDAO dao = new ProductDAO();
        List<Product> productList = dao.getAllProducts();

        request.setAttribute("products", productList);
        request.getRequestDispatcher("userDashboard.jsp").forward(request, response);
        
        
    }
}
