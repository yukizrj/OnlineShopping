<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Enter Customer Information</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div>
                <a href="${pageContext.request.contextPath}/productList">
                    &crarr; Back to Product list
                </a>
            </div>

            <h2>Enter Customer Information</h2>

            <form:form method="POST" modelAttribute="customerForm"
                       action="${pageContext.request.contextPath}/shoppingCartCustomer">

                <table class="table">
                    <tr>
                        <td class="col-md-2">Name *</td>
                        <td class="col-md-4"><form:input path="name"/></td>
                        <td class="col-md-6"><form:errors path="name" class="error-message"/></td>
                    </tr>

                    <tr>
                        <td class="col-md-2">Email *</td>
                        <td class="col-md-4"><form:input path="email"/></td>
                        <td class="col-md-6"><form:errors path="email" class="error-message"/></td>
                    </tr>

                    <tr>
                        <td class="col-md-2">Phone *</td>
                        <td class="col-md-4"><form:input path="phone"/></td>
                        <td class="col-md-6"><form:errors path="phone" class="error-message"/></td>
                    </tr>

                    <tr>
                        <td class="col-md-2">Address *</td>
                        <td class="col-md-4"><form:input path="address"/></td>
                        <td class="col-md-6"><form:errors path="address" class="error-message"/></td>
                    </tr>

                    <tr>
                        <td class="col-md-2">&nbsp;</td>
                        <td class="col-md-4">
                            <input class="btn btn-default" type="reset" value="Reset"/>
                            <input class="btn btn-primary" type="submit" value="Submit"/>
                        </td>
                        <td class="col-md-6">&nbsp;</td>
                    </tr>
                </table>

            </form:form>


            <jsp:include page="_footer.jsp"/>

        </div>
    </div>
</div>
</body>
</html>