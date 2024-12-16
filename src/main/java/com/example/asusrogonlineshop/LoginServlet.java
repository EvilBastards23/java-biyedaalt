package com.example.asusrogonlineshop;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // Create a BCryptPasswordEncoder instance for password matching
    private static final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Query to retrieve the hashed password for the user
            String sql = "SELECT password FROM users WHERE username = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");

                    // Check if the provided password matches the stored hashed password
                    if (passwordEncoder.matches(password, storedHashedPassword)) {
                        // Password is correct, create a session and redirect to index.jsp
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        response.sendRedirect("index.jsp");
                    } else {
                        // Invalid password
                        response.sendRedirect("login.jsp");
                    }
                } else {
                    // No user found with the given username
                    response.sendRedirect("login.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp");
        }
    }
}
