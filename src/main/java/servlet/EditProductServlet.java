package servlet;

import dao.ProductDAO;
import model.Product;
import model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/editProduct")
public class EditProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null || !"vendor".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        Product product = new ProductDAO().getProductById(id, user.getId());

        if (product == null) {
            response.sendRedirect("vendorDashboard.jsp?notfound=1");
            return;
        }

        request.setAttribute("product", product);
        RequestDispatcher rd = request.getRequestDispatcher("updateProduct.jsp");
        rd.forward(request, response);
    }
}
