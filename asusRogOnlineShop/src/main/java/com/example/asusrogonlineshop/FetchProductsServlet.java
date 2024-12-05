package com.example.asusrogonlineshop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/fetchProducts")
public class FetchProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Product> productList = new ArrayList<>();

        try (Connection connection = DatabaseConnection.getConnection()) {
            String sql = "SELECT id, name, description, price, image FROM products";
            try (PreparedStatement statement = connection.prepareStatement(sql);
                 ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    String description = resultSet.getString("description");
                    double price = resultSet.getDouble("price");
                    byte[] imageBytes = resultSet.getBytes("image");

                    // Convert image bytes to Base64 string
                    String imageBase64 = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);

                    // Add product to the list
                    Product product = new Product(id, name, description, price, imageBase64);
                    productList.add(product);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
            return;
        }

        // Convert product list to JSON and set the response type to application/json
        response.setContentType("application/json");
        Gson gson = new Gson();
        String jsonResponse = gson.toJson(productList);
        response.getWriter().write(jsonResponse);
    }
}
