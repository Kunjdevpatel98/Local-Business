package dao;

import model.User;

import java.sql.*;

public class UserDAO {
    
    // ---------------------- REGISTER USER ----------------------
    public boolean register(User user) {
        String sql = "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
//        	ps.setString(1, user.getId());
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            return ps.executeUpdate() > 0;  // true if inserted
        } catch (Exception e) {
            System.out.println("❌ Error in register: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // ---------------------- LOGIN USER ----------------------
    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),           // ✅ id भी set कर दिया
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }
        } catch (Exception e) {
            System.out.println("❌ Error in login: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
    }


    // ---------------------- MAIN (Testing Only) ----------------------
	    public static void main(String[] args) {
	        UserDAO dao = new UserDAO();
	
	        // Test Register
	        User u = new User();
	        u.setName("DAO Test");
	        u.setEmail("dao@gmail.com");
	        u.setPassword("1234");
	        u.setRole("user");
	        
	        if (dao.register(u)) {
	            System.out.println("✅ User inserted successfully!");
	        } else {
	            System.out.println("❌ Insert failed!");
	        }
	
	        // Test Login
	        User loginUser = dao.login("dao@gmail.com", "1234");
	        if (loginUser != null) {
	            System.out.println("✅ Login successful: " + loginUser.getName() + " (" + loginUser.getRole() + ")");
	        } else {
	            System.out.println("❌ Login failed!");
	        }
	    }
	    
	    public boolean updateUser(User user) {
	        boolean f = false;
	        try {
	            Connection con = DBConnection.getConnection();
	            String sql = "UPDATE users SET name=?, email=?, password=? WHERE id=?";
	            PreparedStatement ps = con.prepareStatement(sql);
	            ps.setString(1, user.getName());
	            ps.setString(2, user.getEmail());
	            ps.setString(3, user.getPassword());
	            ps.setInt(4, user.getId());

	            int i = ps.executeUpdate();
	            if(i == 1) f = true;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return f;
	    }
	    
	    

}
