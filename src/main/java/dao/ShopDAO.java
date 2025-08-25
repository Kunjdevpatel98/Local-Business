package dao;

import model.Shop;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ShopDAO {

    public boolean addShop(Shop shop) {
        String sql = "INSERT INTO shops(vendor_id, shop_name, location, category) VALUES (?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, shop.getVendorId());
            ps.setString(2, shop.getShopName());
            ps.setString(3, shop.getLocation());
            ps.setString(4, shop.getCategory());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace(); return false;
        }
    }

    public Shop getShopById(int id) {
        String sql = "SELECT * FROM shops WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Shop s = new Shop();
                s.setId(rs.getInt("id"));
                s.setVendorId(rs.getInt("vendor_id"));
                s.setShopName(rs.getString("shop_name"));
                s.setLocation(rs.getString("location"));
                s.setCategory(rs.getString("category"));
                return s;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public List<Shop> getShopsByVendor(int vendorId) {
        List<Shop> list = new ArrayList<>();
        String sql = "SELECT * FROM shops WHERE vendor_id=? ORDER BY id DESC";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, vendorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shop s = new Shop();
                s.setId(rs.getInt("id"));
                s.setVendorId(rs.getInt("vendor_id"));
                s.setShopName(rs.getString("shop_name"));
                s.setLocation(rs.getString("location"));
                s.setCategory(rs.getString("category"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // MAIN FILTER + SEARCH
    public List<Shop> getShops(String category, String q) {
        List<Shop> list = new ArrayList<>();
        StringBuilder sb = new StringBuilder("SELECT * FROM shops WHERE 1=1 ");

        if (category != null && !category.equalsIgnoreCase("all") && !category.isBlank()) {
            sb.append(" AND category = ? ");
        }
        if (q != null && !q.isBlank()) {
            sb.append(" AND (shop_name LIKE ? OR location LIKE ?) ");
        }
        sb.append(" ORDER BY id DESC");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sb.toString())) {

            int idx = 1;
            if (category != null && !category.equalsIgnoreCase("all") && !category.isBlank()) {
                ps.setString(idx++, category);
            }
            if (q != null && !q.isBlank()) {
                String like = "%" + q.trim() + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Shop s = new Shop();
                s.setId(rs.getInt("id"));
                s.setVendorId(rs.getInt("vendor_id"));
                s.setShopName(rs.getString("shop_name"));
                s.setLocation(rs.getString("location"));
                s.setCategory(rs.getString("category"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}
