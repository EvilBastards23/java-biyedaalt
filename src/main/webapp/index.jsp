<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<%
    // Get the username from session
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!-- Database connection -->
<sql:setDataSource var="dataSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/asus"
                   user="root" password="12345679"/>

<!-- Query to fetch products -->
<sql:query var="products" dataSource="${dataSource}">
    SELECT id, name, description, price, image FROM products;
</sql:query>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Asus ROG Laptop Shop</title>
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
        }

        /* Navbar */
        header {
            background-color: #333;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            padding: 15px 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.8);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            max-width: 960px;
            margin: auto;
            color: #e0e0e0;
        }

        .navbar a {
            color: #e0e0e0;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        .navbar a:hover {
            color: #ff6347;
            text-shadow: 0 0 10px #ff6347, 0 0 20px #ff6347;
        }

        .navbar .user {
            display: flex;
            align-items: center;
        }

        .navbar .user span {
            margin-right: 10px;
        }

        .navbar .search-input {
            border: none;
            background: none;
            color: #e0e0e0;
            border-bottom: 2px solid #ff6347;
            transition: border-color 0.3s ease;
            padding: 5px;
        }

        .navbar .search-input:focus {
            outline: none;
            border-color: #ff4500;
        }

        .navbar .cart {
            position: relative;
            margin-left: 15px;
            cursor: pointer;
        }

        .navbar .cart::after {
            content: "0"; /* Default items count */
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ff6347;
            border-radius: 50%;
            padding: 2px 6px;
            font-size: 12px;
            color: #fff;
        }

        /* Grid container */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            padding: 100px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .grid-item {
            position: relative;
            overflow: hidden;
            border: 2px solid #444;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(255, 255, 255, 0.1);
            padding: 10px;
        }

        .grid-item:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(255, 99, 71, 0.7);
        }

        .grid-item img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s ease, filter 0.5s ease;
            border-radius: 5px;
        }

        .grid-item img:hover {
            transform: scale(1.1);
            filter: brightness(1.2);
        }

        .grid-item h3 {
            margin: 10px 0;
            color: #ff6347;
        }

        .grid-item p {
            margin: 5px 0;
            font-size: 14px;
            color: #e0e0e0;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .grid-container {
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
            }

            .navbar .search-input {
                width: 100%;
                margin-top: 10px;
            }
        }

        @media (max-width: 480px) {
            .grid-container {
                grid-template-columns: 1fr;
            }

            .navbar .user {
                flex-direction: column;
                align-items: flex-start;
            }

            .navbar .search-input {
                width: calc(100% - 40px);
            }

            .navbar .cart {
                margin-left: 0;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<header>
    <div class="navbar">
        <div class="links">
            <a href="#">Latest</a>
            <a href="#">Toplist</a>
        </div>
        <div class="user">
            <span>${username}</span>
            <input type="text" class="search-input" placeholder="Search..." id="searchInput">
            <button onclick="searchProducts()">Search</button> <!-- Button added here -->
            <a class="cart" href="#">Cart</a>
            <a class="logout" href="logout.jsp">Logout</a>
        </div>
    </div>
</header>

<!-- Grid container -->
<div class="grid-container">
    <c:forEach var="product" items="${products.rows}">
        <div class="grid-item">
            <!-- Assuming image column is Base64 encoded -->
            <img src="image?id=${product.id}" alt="${product.name}">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p>Price: $${product.price}</p>

            <!-- Add to Cart -->
            <form action="addToCart.jsp" method="post">
                <input type="hidden" name="productId" value="${product.id}" />
                <button type="submit">Add to Cart</button>
            </form>

            <!-- Update Cart -->
            <form action="updateCart" method="post" style="margin-top: 10px;">
                <input type="hidden" name="productId" value="${product.id}" />
                <input type="number" name="quantity" value="1" min="1" />
                <button type="submit">Update</button>
            </form>

            <!-- Remove from Cart -->
            <form action="removeFromCart" method="post" style="margin-top: 5px;">
                <input type="hidden" name="productId" value="${product.id}" />
                <button type="submit">Remove</button>
            </form>
        </div>
    </c:forEach>
    <c:if test="${empty products.rows}">
        <p>No products available.</p>
    </c:if>
</div>

<script>
    function searchProducts() {
        var query = document.getElementById('searchInput').value;
        if (query) {
            window.location.href = 'search.jsp?query=' + encodeURIComponent(query);
        }
    }
</script>

</body>
</html>
