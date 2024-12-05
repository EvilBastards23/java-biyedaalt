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
        /* Add your existing styles here */
        /* General Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Orbitron', sans-serif;
        }

        body {
            background: linear-gradient(120deg, #121212, #1c1c1c, #050505);
            height: 100vh;
            color: #fff;
        }

        /* Navbar */
        header {
            background-color: #000000;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
            padding: 20px 0;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.8);
            border-bottom: 4px solid rgba(139, 0, 0, 0.8);
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

        /* Grid container */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            padding: 100px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .grid-item {
            position: relative;
            overflow: hidden;
            border: 2px solid #333;
            border-radius: 10px;
            transition: transform 0.3s ease;
            background: rgba(255, 255, 255, 0.1);
            padding: 10px;
        }

        .grid-item:hover {
            transform: scale(1.05);
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.7), 0 0 40px rgba(0, 255, 255, 0.7);
        }

        .grid-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            transition: transform 0.3s ease, filter 0.5s ease;
            border-radius: 5px;
        }

        .grid-item img:hover {
            transform: scale(1.1);
            filter: blur(0);
        }

        .grid-item h3 {
            margin: 10px 0 5px;
            color: #ff6347;
        }

        .grid-item p {
            margin: 5px 0;
            font-size: 14px;
            color: #fff;
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
        }

        @media (max-width: 480px) {
            .grid-container {
                grid-template-columns: 1fr;
            }

            .navbar .user {
                display: flex;
                justify-content: space-between;
                width: 100%;
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
        </div>
    </c:forEach>
    <c:if test="${empty products.rows}">
        <p>No products available.</p>
    </c:if>
</div>

</body>
</html>
