package servlet.admin;

import dao.AdminDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/updateRole")
public class UpdateUserRoleServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User auth = (session != null) ? (User) session.getAttribute("user") : null;
        if (auth == null || !"admin".equals(auth.getRole())) {
            resp.sendRedirect("login.jsp");
            return;
        }

        int userId = Integer.parseInt(req.getParameter("userId"));
        String role = req.getParameter("role");

        boolean ok = new AdminDAO().updateUserRole(userId, role);
        resp.sendRedirect("dashboard?roleUpdated=" + (ok ? "1" : "0"));
    }
}
