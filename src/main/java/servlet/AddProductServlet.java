package servlet;

import dao.ProductDAO;
import model.Product;
import model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addProduct")
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !"vendor".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        Product product = new Product();
        product.setName(name);
        product.setDescription(description);
        product.setPrice(price);
        product.setShopId(user.getId());

        ProductDAO dao = new ProductDAO();
        dao.addProduct(product);

        response.sendRedirect("vendorDashboard.jsp");
    }
}
