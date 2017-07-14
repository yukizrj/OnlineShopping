<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Shopping Cart Finalize</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>
<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>


<div class="container">
    <div class="row">
        <div class="col-md-12">


            <h2>Your order has been placed</h2>

            <div class="text-center">
                <h2><b>Thank you for Order:}</b></h2>
                <h4>Your order number is: <span class="label label-success label-">${lastOrderedCart.orderNum}</span></h4>
            </div>

            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>