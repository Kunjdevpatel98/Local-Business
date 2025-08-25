package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.*;
import servlet.UserDashboardServlet;


public class ProductDAO {

    // ---------------------- CREATE ----------------------
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products(shop_id, name, description, price) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
        	
            ps.setInt(1, product.getShopId());
            ps.setString(2, product.getName());
            ps.setString(3, product.getDescription());
            ps.setDouble(4, product.getPrice());


            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("❌ addProduct error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    // ---------------------- READ (List by Vendor) ----------------------
    public List<Product> getProductsByShop(int shopId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE shop_id=? ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, shopId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                    rs.getInt("id"),
                    rs.getInt("shop_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            System.out.println("❌ getProductsByVendor error: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // ---------------------- READ (Single Product with Ownership Check) ----------------------
    public Product getProductById(int id, int shopId) {
        String sql = "SELECT * FROM products WHERE id=? AND shop_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setInt(2, shopId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(
                    rs.getInt("id"),
                    rs.getInt("shop_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price")
                );
            }
        } catch (Exception e) {
            System.out.println("❌ getProductById error: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    // ---------------------- UPDATE (With Ownership) ----------------------
    public boolean updateProduct(Product p, int shopId) {
        String sql = "UPDATE products SET name=?, description=?, price=? WHERE id=? AND shop_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setInt(4, p.getId());
            ps.setInt(5, shopId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("❌ updateProduct error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }


    // ---------------------- DELETE (With Ownership) ----------------------
    public boolean deleteProduct(int id, int shopId) {
        String sql = "DELETE FROM products WHERE id=? AND shop_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setInt(2, shopId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("❌ deleteProduct error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
        

       //Vendor जो products add करेगा वो user को दिखाने के लिए:
    
    private Connection conn;
    
    public ProductDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/local_business", "root", "root");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }

        public List<Product> getAllProducts() {
            List<Product> list = new ArrayList<>();
            try {
                String sql = "SELECT * FROM products";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    Product p = new Product(
                        rs.getInt("id"),
                        rs.getInt("shop_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price")
                    );
                    list.add(p);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return list;
           }
}
