package model;

public class Shop {
    private int id;
    private int vendorId;
    private String shopName;
    private String location;
    private String category; // NEW

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getVendorId() { return vendorId; }
    public void setVendorId(int vendorId) { this.vendorId = vendorId; }

    public String getShopName() { return shopName; }
    public void setShopName(String shopName) { this.shopName = shopName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
}
