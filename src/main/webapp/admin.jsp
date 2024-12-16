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
    <title>Admin - Asus ROG Laptop Shop</title>
    <style>
        /* Cyberpunk X ASUS ROG Style */
        body {
            background: linear-gradient(120deg, #1c1c1c, #2e2e2e, #050505);
            height: 100vh;
            color: #fff;
            font-family: 'Orbitron', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Navbar */
        header {
            background-color: #000;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            padding: 20px 0;
            box-shadow: 0 0 15px rgba(139, 0, 0, 1);
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            max-width: 960px;
            margin: auto;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
            transition: all 0.3s ease;
        }

        .navbar a:hover {
            color: #ff6347;
            text-shadow: 0 0 10px #ff6347, 0 0 20px #ff6347;
        }

        .navbar .logout {
            color: #ff4d4d;
            text-shadow: 0 0 10px #ff4d4d, 0 0 20px #ff0000;
        }

        /* Product Management */
        .manage-products {
            padding: 100px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-card {
            background: rgba(0, 0, 0, 0.8);
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .product-card:hover {
            transform: scale(1.05);
            background-color: rgba(0, 0, 0, 1);
            box-shadow: 0 0 20px rgba(139, 0, 0, 0.7);
        }

        .product-card h3 {
            margin: 10px 0;
            color: #ff6347;
        }

        .product-card p {
            margin: 5px 0;
            color: #ccc;
        }

        .product-card .btn {
            background-color: #ff6347;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .product-card .btn:hover {
            background-color: #e5533b;
        }

        /* Responsive Styles */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .manage-products {
                padding: 50px 10px;
            }
        }

        @media (max-width: 480px) {
            .navbar .user {
                display: flex;
                justify-content: space-between;
                width: 100%;
                margin-top: 10px;
            }

            .product-card {
                padding: 15px;
            }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<header>
    <div class="navbar">
        <div class="links">
            <a href="admin.jsp">Dashboard</a>
            <a href="manageProducts.jsp">Manage Products</a>
            <a class="logout" href="logout.jsp">Logout</a>
        </div>
    </div>
</header>

<!-- Manage Products Section -->
<div class="manage-products">
    <c:forEach var="product" items="${products.rows}">
        <div class="product-card">
            <!-- Assuming image column is Base64 encoded -->
            <img src="image?id=${product.id}" alt="${product.name}" width="100%">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p>Price: $${product.price}</p>
            <a href="editProduct.jsp?id=${product.id}" class="btn">Edit</a>
            <a href="deleteProduct.jsp?id=${product.id}" class="btn">Delete</a>
        </div>
    </c:forEach>
    <c:if test="${empty products.rows}">
        <p>No products available.</p>
    </c:if>
</div>

</body>
</html>
