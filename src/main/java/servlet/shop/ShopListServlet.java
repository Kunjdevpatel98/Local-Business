package servlet.shop;

import dao.ShopDAO;
import model.Shop;
import model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/shops")
public class ShopListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User me = (session != null) ? (User) session.getAttribute("user") : null;
        if (me == null) {
            resp.sendRedirect(req.getContextPath()+"/login.jsp?error=Please login");
            return;
        }

        String category = req.getParameter("category"); // all/grocery/medicine/electronics
        String q = req.getParameter("q");               // search text

        List<Shop> shops = new ShopDAO().getShops(category, q);
        req.setAttribute("shops", shops);
        req.setAttribute("category", category == null ? "all" : category);
        req.setAttribute("q", q == null ? "" : q);

        req.getRequestDispatcher("/shopList.jsp").forward(req, resp);
    }
}
