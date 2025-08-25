package servlet.admin;

import dao.AdminDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("user") : null;
        if (auth == null || !"admin".equals(auth.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(req.getParameter("id"));
        boolean ok = new AdminDAO().deleteProduct(id);
        resp.sendRedirect("dashboard?productDeleted=" + (ok ? "1" : "0"));
    }
}
