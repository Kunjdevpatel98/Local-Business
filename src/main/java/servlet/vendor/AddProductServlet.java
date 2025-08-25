package servlet.vendor;

import dao.ProductDAO;
import dao.ShopDAO;
import model.Product;
import model.Shop;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/vendor/addProduct")
public class AddProductServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || !"vendor".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Login as vendor");
            return;
        }

        try {
            int shopId = Integer.parseInt(req.getParameter("shopId"));
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));

            // Ownership check: shop belongs to this vendor
            ShopDAO shopDAO = new ShopDAO();
            Shop shop = shopDAO.getShopById(shopId);
            if (shop == null || shop.getVendorId() != user.getId()) {
                resp.sendRedirect(req.getContextPath() + "/vendor/dashboard?error=invalidShop");
                return;
            }

            Product p = new Product();
            p.setShopId(shopId);
            p.setName(name);
            p.setDescription(description);
            p.setPrice(price);

            boolean ok = new ProductDAO().addProduct(p);
            resp.sendRedirect(req.getContextPath() + "/vendor/dashboard?productAdded=" + (ok ? "1" : "0"));
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/vendor/dashboard?productAdded=0");
        }
    }
}
