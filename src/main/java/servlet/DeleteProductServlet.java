package servlet;

import dao.ProductDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteProduct")
public class DeleteProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) (session != null ? session.getAttribute("user") : null);

        if (user == null || !"vendor".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        boolean ok = new ProductDAO().deleteProduct(id, user.getId());
        response.sendRedirect("vendorDashboard.jsp?deleted=" + (ok ? "1" : "0"));
    }
}
