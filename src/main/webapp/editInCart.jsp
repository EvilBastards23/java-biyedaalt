<%@ page import="com.example.asusrogonlineshop.CartItem" %><%
    String productId = request.getParameter("id");
    String newQuantity = request.getParameter("quantity");
    List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cart");

    for (CartItem item : cartItems) {
        if (item.getId().equals(productId)) {
            item.setQuantity(Integer.parseInt(newQuantity));
            break;
        }
    }

    session.setAttribute("cart", cartItems);
    response.sendRedirect("cart.jsp");
%>
