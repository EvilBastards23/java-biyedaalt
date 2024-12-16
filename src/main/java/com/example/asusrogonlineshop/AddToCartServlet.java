package com.example.asusrogonlineshop;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        int quantity = Integer.parseInt(quantityStr);

        HttpSession session = request.getSession();
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new HashMap<>();
            session.setAttribute("cart", cart);
        }

        // Assuming CartItem has constructor CartItem(int id, String name, String description, double price, String imageUrl)
        CartItem product = getProductById(productId); // Implement this method to get product from DB
        product.setQuantity(quantity);
        cart.put(product.getId(), product);

        response.sendRedirect("cart.jsp");
    }

    private CartItem getProductById(String productId) {
        // Query the database to get the product details using the productId
        // For example:
        // SELECT id, name, description, price, image FROM products WHERE id = ?
        // Return a CartItem object with the retrieved product details
        return null;
    }
}
