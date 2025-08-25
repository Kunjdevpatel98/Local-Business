package model;

public class Product {
    private int id;
    private int shopId;
    private String name;
    private String description;
    private double price;
//    private int vendorId;

    // No-arg constructor (जरूरी, servlets/DAO में use होता है)
    public Product() {}

    // FULL constructor (DAO में ResultSet से object बनाने के लिए)
    public Product(int id,int shopId, String name, String description, double price) {
        this.id = id;
        this.shopId = shopId;
        this.name = name;
        this.description = description;
        this.price = price;
//        this.vendorId = vendorId;
    }

    // Partial constructor (जब insert करने से पहले id नहीं होती)
    public Product(String name,int shopId, String description, double price) {
        this.name = name;
        this.shopId = shopId;
        this.description = description;
        this.price = price;
//        this.vendorId = vendorId;
        
    }

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

	public int getShopId() {return shopId; }
	public void setShopId(int shopId) {this.shopId = shopId; }

//    public int getVendorId() { return vendorId; }
//    public void setVendorId(int vendorId) { this.vendorId = vendorId; }

    
}

