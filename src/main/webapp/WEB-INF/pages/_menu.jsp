<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<div class="container">
    <div class="row">

        <div class="menu-container col-md-12">
        <%-- <a class="btn btn-default" href="${pageContext.request.contextPath}/">Home</a>
   		<a class="btn btn-default" href="${pageContext.request.contextPath}/productList">All Products
                <span class="glyphicon glyphicon-search" aria-hidden="true"></span>  
   		</a> --%>

           <div class="btn-group" role="group">
                <a class="btn btn-default" href="${pageContext.request.contextPath}/">Home</a>
                <%-- <a class="btn btn-default" href="${pageContext.request.contextPath}/productList">Product List</a> --%>
                <a class="btn btn-default" href="${pageContext.request.contextPath}/shoppingCart">
                    <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
                    Cart
                    <c:if test="${cartSize > 0}">
                        <span class="label label-success">${cartSize}</span>
                    </c:if>
                </a>
                <security:authorize access="hasAnyRole('ROLE_EMPLOYEE')">
                    <a class="btn btn-default" href="${pageContext.request.contextPath}/orderList">Order List</a>
                </security:authorize>

                <security:authorize access="hasRole('ROLE_MANAGER')">
                    <a class="btn btn-default" href="${pageContext.request.contextPath}/product">Create Product</a>
                </security:authorize>
            </div> 

        </div>
    </div>
</div>
