<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Shopping Cart Confirmation</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>


<div class="container">
    <div class="row">
        <div class="col-md-12">


            <fmt:setLocale value="en_US" scope="session"/>

            <h2>Confirmation</h2>

            <div class="well">
                <h3>Customer Information:</h3>
                <ul>
                    <li>Name: ${myCart.customerInfo.name}</li>
                    <li>Email: ${myCart.customerInfo.email}</li>
                    <li>Phone: ${myCart.customerInfo.phone}</li>
                    <li>Address: ${myCart.customerInfo.address}</li>
                </ul>
                <h3>Cart Summary:</h3>
                <ul>
                    <li>Quantity: ${myCart.quantityTotal}</li>
                    <li>
                        Total:
                        <span class="total">
                            <fmt:formatNumber value="${myCart.amountTotal}" type="currency"/>
                        </span>
                    </li>
                </ul>
            </div>
            <div class="text-center">

                <form method="POST" action="${pageContext.request.contextPath}/shoppingCartConfirmation">

                    <!-- Edit Cart -->
                    <a class="btn btn-default"
                       href="${pageContext.request.contextPath}/shoppingCart">Edit Cart</a>

                    <!-- ECustomerInfoomer Info -->
                    <a class="btn btn-default"
                       href="${pageContext.request.contextPath}/shoppingCartCustomerEdit">Edit
                        Customer Info</a>

                    <!-- Send/Save -->
                    <input type="submit" value="Submit" class="btn btn-primary"/>
                </form>

                <br>
                <br>
                <div class="container">

                    <c:forEach items="${myCart.cartLines}" var="cartLineInfo">
                        <div class="product-preview-container">
                            <ul>
                                <li class="crop">
                                    <img class="product-image"
                                         src="${pageContext.request.contextPath}/productImage?code=${cartLineInfo.productInfo.code}"/>
                                </li>
                                <li>
                                    Code: ${cartLineInfo.productInfo.code}
                                    <input type="hidden" name="code" value="${cartLineInfo.productInfo.code}"/>
                                </li>
                                <li>Name:
                                    <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                            ${cartLineInfo.productInfo.name}
                                    </a>
                                </li>
                                <li>
                                    Price:
                                    <span class="price">
                                    <fmt:formatNumber value="${cartLineInfo.productInfo.price}" type="currency"/>
                                </span>
                                </li>
                                <li>Quantity: ${cartLineInfo.quantity}</li>
                                <li>
                                    Subtotal:
                                    <span class="total">
                                    <fmt:formatNumber value="${cartLineInfo.amount}" type="currency"/>
                                </span>
                                </li>
                            </ul>
                        </div>
                    </c:forEach>

                </div>
            </div>
            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>