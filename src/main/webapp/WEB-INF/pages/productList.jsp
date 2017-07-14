<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

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

            <h2>Product List</h2>

            <div class="text-center">

                <c:forEach items="${paginationProducts.list}" var="prodInfo">
                    <div class="product-preview-container">
                        <ul>
                            <li class="crop">
                                <a href="${pageContext.request.contextPath}/productInfo?code=${prodInfo.code}">
                                    <img class="product-image"
                                         src="${pageContext.request.contextPath}/productImage?code=${prodInfo.code}"/>
                                </a>
                            </li>
                            <li>Code: ${prodInfo.code}</li>
                            <li>Name:
                                <a href="${pageContext.request.contextPath}/productInfo?code=${prodInfo.code}">
                                        ${prodInfo.name}
                                </a>
                            </li>
                            <li>
                                Price:
                                <span class="price">
                                    <fmt:formatNumber value="${prodInfo.price}" type="currency"/>
                                </span>
                            </li>


                        </ul>
                        <div class="text-center">

                            <div class="btn-group<security:authorize access="hasRole('ROLE_MANAGER')">-xs</security:authorize>"
                                 role="group">

                                <%-- <a class="btn btn-primary"
                                   href="${pageContext.request.contextPath}/buyProduct?code=${prodInfo.code}">
                                    Buy now
                                </a> --%>
                                <!-- For Manager edit Product -->
                                <security:authorize access="hasRole('ROLE_MANAGER')">
                                    <a class="btn btn-warning"
                                       href="${pageContext.request.contextPath}/product?code=${prodInfo.code}">
                                        Edit
                                    </a>
                                    <a class="btn btn-danger"
                                       href="${pageContext.request.contextPath}/deleteProduct?code=${prodInfo.code}">
                                        Delete
                                    </a>
                                </security:authorize>
                            </div>
                        </div>
                    </div>

                </c:forEach>
                <br/>


                <c:if test="${paginationProducts.totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:forEach items="${paginationProducts.navigationPages}" var="page">
                                <c:if test="${page != -1 }">

                                    <c:if test="${paginationProducts.currentPage == page}">
                                        <li class="active">
                                            <a href="productList?page=${page}" class="nav-item">
                                                    ${page} <span class="sr-only">(current)</span>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${paginationProducts.currentPage != page}">
                                        <li><a href="productList?page=${page}" class="nav-item">${page}</a></li>
                                    </c:if>

                                </c:if>
                                <c:if test="${page == -1 }">
                                    <span class="nav-item"> ... </span>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </div>

            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>