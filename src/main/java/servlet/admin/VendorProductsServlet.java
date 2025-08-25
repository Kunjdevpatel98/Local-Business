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

@WebServlet("/admin/vendorProducts")
public class VendorProductsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("user") : null;
        if (auth == null || !"admin".equals(auth.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int vendorId = Integer.parseInt(req.getParameter("vendorId"));
        List<Product> list = new AdminDAO().getProductsByVendor(vendorId);
        req.setAttribute("vendorId", vendorId);
        req.setAttribute("vendorProducts", list);
        RequestDispatcher rd = req.getRequestDispatcher("/adminVendorProducts.jsp");
        rd.forward(req, resp);
    }
}
