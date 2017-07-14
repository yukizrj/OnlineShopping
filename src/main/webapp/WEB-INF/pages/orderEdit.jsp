<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>

<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-md-12">

            <fmt:setLocale value="en_US" scope="session"/>

            <h2>Order Info Modification</h2>

            <form:form method="POST" modelAttribute="orderInfo"
                       action="${pageContext.request.contextPath}/editOrder">

                <div class="well">
                    <h3>Customer Information:</h3>

                    <table class="table">
                        <tr>
                            <td class="col-md-2">Name *</td>
                            <td class="col-md-4"><form:hidden path="id"/><form:input path="customerInfo.name"/></td>
                            <td class="col-md-6"><form:errors path="customerInfo.name" class="error-message"/></td>
                        </tr>

                        <tr>
                            <td class="col-md-2">Email *</td>
                            <td class="col-md-4"><form:input path="customerInfo.email"/></td>
                            <td class="col-md-6"><form:errors path="customerInfo.email" class="error-message"/></td>
                        </tr>

                        <tr>
                            <td class="col-md-2">Phone *</td>
                            <td class="col-md-4"><form:input path="customerInfo.phone"/></td>
                            <td class="col-md-6"><form:errors path="customerInfo.phone" class="error-message"/></td>
                        </tr>

                        <tr>
                            <td class="col-md-2">Address *</td>
                            <td class="col-md-4"><form:input path="customerInfo.address"/></td>
                            <td class="col-md-6"><form:errors path="customerInfo.address" class="error-message"/></td>
                        </tr>

                    </table>


                </div>

                <br/>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>Product Code</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${orderInfo.details}" var="orderDetailInfo" varStatus="status">
                        <tr>
                            <td>${orderDetailInfo.productCode}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/productInfo?code=${orderDetailInfo.productCode}">
                                        ${orderDetailInfo.productName}
                                </a>
                            </td>
                            <td><form:hidden path="details[${status.index}].id"/><form:input path="details[${status.index}].quantity" cssClass="qty"/></td>
                            <td>
                                <fmt:formatNumber value="${orderDetailInfo.price}" type="currency"/>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <c:if test="${paginationResult.totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:forEach items="${paginationResult.navigationPages}" var="page">
                                <c:if test="${page != -1 }">

                                    <c:if test="${paginationResult.currentPage == page}">
                                        <li class="active">
                                            <a href="orderList?page=${page}" class="nav-item">
                                                    ${page} <span class="sr-only">(current)</span>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${paginationResult.currentPage != page}">
                                        <li><a href="orderList?page=${page}" class="nav-item">${page}</a></li>
                                    </c:if>

                                </c:if>
                                <c:if test="${page == -1 }">
                                    <span class="nav-item"> ... </span>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
                <div class="text-center">
                    <a class="btn btn-default"
                       href="${pageContext.request.contextPath}/order?orderId=${orderInfo.id}">
                        Cancel
                    </a>
                    <%--<a class="btn btn-primary"--%>
                       <%--href="${pageContext.request.contextPath}/orderEdit?orderId=${orderInfo.id}">--%>
                        <%--Save--%>
                    <%--</a>--%>
                    <input class="btn btn-primary" type="submit" value="Save" />
                </div>
            </form:form>
            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>





