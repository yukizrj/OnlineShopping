<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Access Denied</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>


<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>

<div class="container">
    <div class=" row">
        <div class="col-md-12">

            <h2>Not Found</h2>

            <h3 style="color:red;">The requested URL ${requestScope['javax.servlet.forward.request_uri']} was not found on this server.</h3>

            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
</div>

</body>
</html>