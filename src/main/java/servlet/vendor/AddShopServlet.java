package servlet.vendor;

import dao.ShopDAO;
import model.Shop;
import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;

@WebServlet("/vendor/addShop")
public class AddShopServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User u = (session != null) ? (User) session.getAttribute("user") : null;
        if (u == null || !"vendor".equalsIgnoreCase(u.getRole())) {
            resp.sendRedirect(req.getContextPath()+"/login.jsp?error=Login as vendor");
            return;
        }

        String name = req.getParameter("shopName");
        String location = req.getParameter("location");
        String category = req.getParameter("category"); // NEW

        Shop s = new Shop();
        s.setVendorId(u.getId());
        s.setShopName(name);
        s.setLocation(location);
        s.setCategory(category);

        boolean ok = new ShopDAO().addShop(s);
        resp.sendRedirect(req.getContextPath()+"/vendor/dashboard?shopAdded="+(ok?"1":"0"));
    }
}
