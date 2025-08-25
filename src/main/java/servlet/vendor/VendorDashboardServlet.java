package servlet.vendor;

import dao.ProductDAO;
import dao.ShopDAO;
import model.Product;
import model.Shop;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/vendor/dashboard")
public class VendorDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"vendor".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Login as vendor");
            return;
        }

        ShopDAO shopDAO = new ShopDAO();
        ProductDAO productDAO = new ProductDAO();

        List<Shop> shops = shopDAO.getShopsByVendor(user.getId());

        // Aggregate products of all vendor shops
        List<Product> allProducts = new ArrayList<>();
        for (Shop s : shops) {
            allProducts.addAll(productDAO.getProductsByShop(s.getId()));
        }

        req.setAttribute("shops", shops);
        req.setAttribute("products", allProducts);

        RequestDispatcher rd = req.getRequestDispatcher("/vendorDashboard.jsp");
        rd.forward(req, resp);
    }
}
