<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!-- Retrieve the search query parameter from the request -->
<sql:setDataSource var="dataSource" driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/asus"
                   user="root" password="12345679"/>
<sql:query var="products" dataSource="${dataSource}">
    SELECT id, name, description, price, image FROM products WHERE name LIKE ?
    <sql:param value="%${param.query}%" />
</sql:query>

<!-- Grid container to display search results -->
<div class="grid-container">
    <c:forEach var="product" items="${products.rows}">
        <div class="grid-item">
            <img src="image?id=${product.id}" alt="${product.name}">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p>Price: $${product.price}</p>
        </div>
    </c:forEach>
    <c:if test="${empty products.rows}">
        <p>No products found for "${param.query}".</p>
    </c:if>
</div>

</body>
</html>
