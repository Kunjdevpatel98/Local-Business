package servlet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.DBConnection;

import java.io.*;
import java.sql.Connection;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            Connection conn = DBConnection.getConnection();
            out.println("<h2 style='color:green;'>✅ Database Connected Successfully!</h2>");
            conn.close();
        } catch (Exception e) {
            out.println("<h2 style='color:red;'>❌ Database Connection Failed!</h2>");
            out.println("<pre>" + e.getMessage() + "</pre>");
            e.printStackTrace(out);
        }
    }
}
