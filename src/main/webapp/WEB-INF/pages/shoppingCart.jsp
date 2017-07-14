<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Shopping Cart</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>

<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <fmt:setLocale value="en_US" scope="session"/>

            <h2>
                Cart
                <c:if test="${cartSize > 0}">
                    <span class="label label-success">${cartSize}</span>
                </c:if>
            </h2>

            <c:if test="${empty cartForm or empty cartForm.cartLines}">
                <div class="well">

                    <h3>There is no items in Cart</h3>
                    <br>
                    <br>
                    <a href="${pageContext.request.contextPath}/productList">Show
                        Product List</a>
                </div>
            </c:if>

            <c:if test="${not empty cartForm and not empty cartForm.cartLines   }">
                <form:form method="POST" modelAttribute="cartForm"
                           action="${pageContext.request.contextPath}/shoppingCart">

                    <c:forEach items="${cartForm.cartLines}" var="cartLineInfo"
                               varStatus="varStatus">
                        <div class="product-preview-container">
                            <ul>
                                <li class="crop">
                                    <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                        <img class="product-image"
                                             src="${pageContext.request.contextPath}/productImage?code=${cartLineInfo.productInfo.code}"/>
                                    </a>
                                </li>
                                <li>Code: ${cartLineInfo.productInfo.code} <form:hidden
                                        path="cartLines[${varStatus.index}].productInfo.code"/>

                                </li>
                                <li>Name:
                                    <a href="${pageContext.request.contextPath}/productInfo?code=${cartLineInfo.productInfo.code}">
                                            ${cartLineInfo.productInfo.name}
                                    </a>
                                </li>
                                <li>
                                    Price:
                                    <span class="price" id="price-${cartLineInfo.productInfo.code}">
                                            <fmt:formatNumber value="${cartLineInfo.productInfo.price}"
                                                              type="currency"/>
                                    </span>
                                </li>
                                <li>
                                    Quantity:
                                    <form:input cssClass="int-only qty"
                                                path="cartLines[${varStatus.index}].quantity"/>
                                </li>
                                <li>
                                    Subtotal:
                                    <span class="total" id="total-${cartLineInfo.productInfo.code}">
                                        <fmt:formatNumber value="${cartLineInfo.amount}" type="currency"/>
                                    </span>
                                </li>
                                <li style="text-align: right">
                                    <a id="update-cart-product-${cartLineInfo.productInfo.code}"
                                       class="btn btn-xs btn-primary" style="display: none"
                                       onclick="update('${cartLineInfo.productInfo.code}', ${varStatus.index});">
                                        Update
                                    </a>
                                    <script>
                                        $("#cartLines${varStatus.index}\\.quantity").focusin(function () {
                                            $('#update-cart-product-${cartLineInfo.productInfo.code}').show();
                                        });
                                    </script>

                                    <a class="btn btn-xs btn-danger"
                                       href="${pageContext.request.contextPath}/shoppingCartRemoveProduct?code=${cartLineInfo.productInfo.code}">
                                        Remove
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:forEach>
                    <div style="clear: both"></div>

                    <div class="well-sm text-center">

                            <%--<input class="btn btn-primary" type="submit" value="Update Quantity"/> no--%>
                        <a class="btn btn-default"
                           href="${pageContext.request.contextPath}/productList">Continue
                            Buy</a>
                        <%-- <a class="btn btn-primary"
                           href="${pageContext.request.contextPath}/shoppingCartCustomer">Enter
                            Customer Info</a> --%>
                            <a class="btn btn-primary"
                           href="${pageContext.request.contextPath}/shoppingCartCustomer">Go to Check out</a>
                    </div>
                </form:form>


            </c:if>

            <script>
                function update(code, varStatusIndex) {
                    var url = '${pageContext.request.contextPath}/shoppingCartUpdateProduct?code=' + code + '&qty=';
                    var newQty = Number($("#cartLines" + varStatusIndex + "\\.quantity").val());
                    var price = $('#price-' + code).html();
                    var newTotal = newQty * Number(price.replace(/[^0-9\.]+/g, ""));
                    console.log(url + newQty);
                    $.get(url + newQty).then(function () {
                        $("#total-" + code).html('$' + (newTotal).formatMoney(2));
                        $('#update-cart-product-' + code).hide();
                    });
                }
                Number.prototype.formatMoney = function (c, d, t) {
                    var n = this,
                        c = isNaN(c = Math.abs(c)) ? 2 : c,
                        d = d == undefined ? "." : d,
                        t = t == undefined ? "," : t,
                        s = n < 0 ? "-" : "",
                        i = String(parseInt(n = Math.abs(Number(n) || 0).toFixed(c))),
                        j = (j = i.length) > 3 ? j % 3 : 0;
                    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
                };
            </script>

            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>

</body>
</html>