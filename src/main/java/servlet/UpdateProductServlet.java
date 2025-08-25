package servlet;

import dao.ProductDAO;
import model.Product;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProduct")
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null || !"vendor".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));

        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);

        boolean ok = new ProductDAO().updateProduct(p, user.getId());
        response.sendRedirect("vendorDashboard.jsp?updated=" + (ok ? "1" : "0"));
    }
}
