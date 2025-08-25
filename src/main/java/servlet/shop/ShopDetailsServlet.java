package servlet.shop;

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
import java.util.List;

@WebServlet("/shopDetails")
public class ShopDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User u = (session != null) ? (User) session.getAttribute("user") : null;
        if (u == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp?error=Please login");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            ShopDAO shopDAO = new ShopDAO();
            ProductDAO productDAO = new ProductDAO();

            Shop shop = shopDAO.getShopById(id);
            if (shop == null) {
                resp.sendRedirect(req.getContextPath() + "/shops?error=Shop not found");
                return;
            }

            List<Product> products = productDAO.getProductsByShop(id);
            req.setAttribute("shop", shop);
            req.setAttribute("products", products);

            RequestDispatcher rd = req.getRequestDispatcher("/shopDetails.jsp");
            rd.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/shops?error=Invalid shop id");
        }
    }
}
