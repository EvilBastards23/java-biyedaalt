package com.example.asusrogonlineshop;

public class CartItem {
    private int id;
    private String name;
    private String description;
    private double price;
    private String imageUrl;
    private int quantity; // Add this field for quantity

    public CartItem(int id, String name, String description, double price, String imageUrl, int quantity) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.quantity = quantity; // Initialize the quantity
    }

    // Getter and setter methods for each field
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getProductPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity; // Return the quantity
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity; // Setter for the quantity
    }
}


