package servlet;

import dao.UserDAO;
import model.User;

import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")   // URL mapping
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        
        // 1. Form data पढ़ना
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // 2. User object बनाना (id = 0, role = user)
        User user = new User(0, name, email, password, "user");

        // 3. DB में insert करना
        UserDAO dao = new UserDAO();
        boolean inserted = dao.register(user);

        // 4. Response भेजना
        if (inserted) {
        	response.sendRedirect("login.jsp"); // Success page
        } else {
            response.sendRedirect("error.jsp");    // Error page
        }
    }
}
