<%@ page import="com.example.asusrogonlineshop.CartItem" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
    String cartJson = request.getParameter("cart");
    if (cartJson == null || cartJson.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    Gson gson = new Gson();
    Type type = new TypeToken<List<CartItem>>() {}.getType();
    List<CartItem> cartItems = gson.fromJson(cartJson, type);

    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Simulate order processing here. In a real-world application, you would save the order to a database
    // For now, we just display a confirmation message
    // OrderService orderService = new OrderService();
    // Connection connection = null;
    // try {
    //     connection = dataSource.getConnection();
    //     orderService.placeOrder(new Order(0, username, cartItems), connection);
    // } catch (SQLException e) {
    //     e.printStackTrace();
    //     response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to place order");
    // } finally {
    //     if (connection != null) {
    //         try {
    //             connection.close();
    //         } catch (SQLException e) {
    //             e.printStackTrace();
    //         }
    //     }
    // }

    // Simulate order confirmation
    String orderCompleteMessage = "Order completed successfully! Thank you for your purchase, " + username + ".";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation</title>
    <style>
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Orbitron', sans-serif;
        }

        body {
            background: linear-gradient(120deg, #0c0c0c, #1a1a1a, #2b2b2b);
            height: 100vh;
            color: #e0e0e0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: center;
        }

        h1 {
            font-size: 2.5em;
            color: #ff6347;
        }

        p {
            font-size: 1.2em;
            color: #e0e0e0;
        }
    </style>
</head>
<body>

<h1>Order Complete!</h1>
<p><%= orderCompleteMessage %></p>

<a href="index.jsp" style="color: #ff6347; text-decoration: none;">Return to Home</a>

</body>
</html>
