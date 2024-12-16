<%@ page import="java.io.PrintWriter" %>
<%@ page import="com.example.asusrogonlineshop.CartItem" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get cart items from session
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

    if (cartItems == null || cartItems.isEmpty()) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Calculate total price
    double totalPrice = 0.0;
    for (CartItem item : cartItems) {
        totalPrice += item.getProductPrice() * item.getQuantity();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Asus ROG Laptop Shop</title>
    <style>
        /* Place your existing CSS styles here */
        /* Additional styles for cart page */
        .cart-container {
            padding: 20px;
            max-width: 800px;
            margin: 20px auto;
            background-color: #1a1a1a;
            border-radius: 10px;
            color: #e0e0e0;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding: 10px;
            border: 1px solid #444;
            border-radius: 5px;
        }

        .cart-item .quantity {
            width: 60px;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #444;
            background-color: #333;
            color: #e0e0e0;
        }

        .cart-item .remove {
            color: #ff6347;
            cursor: pointer;
        }

        .cart-item .remove:hover {
            text-decoration: underline;
        }

        .total {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-weight: bold;
        }

        .place-order-btn {
            background-color: #ff6347;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .place-order-btn:hover {
            background-color: #e05337;
        }
    </style>
</head>
<body>

<div class="navbar">
    <a href="#">Cart</a>
    <!-- Other links... -->
    <a href="index.jsp">Back to Home</a>
</div>

<div class="cart-container">
    <h2>Your Cart</h2>
    <c:forEach var="item" items="${cartItems}">
        <div class="cart-item">
            <span>${item.productName}</span>
            <input type="number" class="quantity" name="quantity" value="${item.quantity}" min="1" />
            <span>$${item.productPrice}</span>
            <span class="remove" onclick="removeFromCart(${item.productId})">Remove</span>
        </div>
    </c:forEach>

    <div class="total">
        <span>Total:</span>
        <span id="cartTotal">$${totalPrice}</span>
    </div>

    <button class="place-order-btn" onclick="proceedToOrder()">Proceed to Order</button>
</div>

<script>
    function removeFromCart(productId) {
        fetch('removeFromCart.jsp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `productId=${productId}`
        }).then(response => {
            if (response.ok) {
                alert('Item removed from cart.');
                location.reload(); // Refresh the page to update the cart
            } else {
                alert('Failed to remove item from cart.');
            }
        }).catch(error => {
            console.error('Error:', error);
            alert('An error occurred.');
        });
    }

    function proceedToOrder() {
        var cartItems = getCartItems();
        if (cartItems.length > 0) {
            // Perform an AJAX request to proceed with the order
            fetch('proceedToOrder.jsp', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'cart=' + encodeURIComponent(JSON.stringify(cartItems))
            }).then(response => {
                if (response.ok) {
                    alert('Order placed successfully!');
                    window.location.href = 'orderConfirmation.jsp'; // Redirect to order confirmation page
                } else {
                    alert('Failed to place order.');
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred.');
            });
        } else {
            alert('Your cart is empty.');
        }
    }

    function getCartItems() {
        var cartItems = [];
        document.querySelectorAll('.cart-item').forEach(function(item) {
            var productId = item.getAttribute('data-product-id');
            var quantity = item.querySelector('.quantity').value;
            cartItems.push({ productId: productId, quantity: quantity });
        });
        return cartItems;
    }
</script>

</body>
</html>
