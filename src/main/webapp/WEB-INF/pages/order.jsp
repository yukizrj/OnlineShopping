<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Info</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>

<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>

<div class="container">
    <div class="row">
        <div class="col-md-12">

            <div>
                <a href="${pageContext.request.contextPath}/orderList">
                    &crarr; Back to Order list
                </a>
            </div>

            <fmt:setLocale value="en_US" scope="session"/>

            <h2>Order #${orderInfo.orderNum}</h2>

            <div class="well">
                <h3>Customer Information:</h3>
                <ul>
                    <li>Name: ${orderInfo.customerInfo.name}</li>
                    <li>Email: ${orderInfo.customerInfo.email}</li>
                    <li>Phone: ${orderInfo.customerInfo.phone}</li>
                    <li>Address: ${orderInfo.customerInfo.address}</li>
                </ul>
                <h3>Order Summary:</h3>
                <ul>
                    <li>Total:
                        <span class="total">
                            <fmt:formatNumber value="${orderInfo.amount}" type="currency"/>
                        </span>
                    </li>
                </ul>
            </div>

            <br/>

            <table class="table table-striped table-hover">
                <thead>
                <tr>
                    <th>Product Code</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Amount</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${orderInfo.details}" var="orderDetailInfo">
                    <tr>
                        <td>${orderDetailInfo.productCode}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/productInfo?code=${orderDetailInfo.productCode}">
                                    ${orderDetailInfo.productName}
                            </a>
                        </td>
                        <td>${orderDetailInfo.quantity}</td>
                        <td>
                            <fmt:formatNumber value="${orderDetailInfo.price}" type="currency"/>
                        </td>
                        <td>
                            <b><fmt:formatNumber value="${orderDetailInfo.amount}" type="currency"/></b>
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
            <div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">Confirm Delete</h4>
                        </div>
                        <div class="modal-body">
                            <p>You are about to delete <b><i class="title"></i></b> record, this procedure is
                                irreversible.</p>
                            <p>Do you want to proceed?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-danger btn-ok">Delete</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-right">
                <a class="btn btn-warning"
                   href="${pageContext.request.contextPath}/editOrder?orderId=${orderInfo.id}">
                    Edit order
                </a>

                <%--<button class="btn btn-danger"--%>
                <%--data-href="${pageContext.request.contextPath}/deleteOrder?orderId=${orderInfo.id}"--%>
                <%--data-toggle="modal" data-target="#confirm-delete">--%>
                <button class="btn btn-danger"
                        data-record-num="${orderInfo.orderNum}"
                        data-path="${pageContext.request.contextPath}"
                        data-path-add="/deleteOrder?orderId="
                        data-record-id="${orderInfo.id}" data-record-title="Order"
                        data-toggle="modal" data-target="#confirm-delete">
                    Delete order
                </button>
                <%--Delete order--%>
                <%--</button>--%>
            </div>
            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>