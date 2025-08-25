package servlet;

import dao.UserDAO;
import model.User;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);

        UserDAO dao = new UserDAO();
        boolean updated = dao.updateUser(user);

        if(updated) {
            session.setAttribute("user", user); // refresh session
            resp.sendRedirect("profile.jsp?success=Profile updated!");
        } else {
            resp.sendRedirect("profile.jsp?error=Update failed!");
        }

        
    }
}
