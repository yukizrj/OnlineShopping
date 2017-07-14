<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Amazon Shopping Store</title>

    <jsp:include page="_styles.jsp"/>

</head>
<body>


<jsp:include page="_header.jsp"/>
<jsp:include page="_menu.jsp"/>

<div class="header-bot">
<div class="container">
        <div class="col-md-3 header-left">
            <h2>Home page</h2>
            </div>
			
            <div class="col-md-6 header-middle">

                
               <form method="GET"
                      action="${pageContext.request.contextPath}/productList">
                      <div class="input-group">
                      <div class="col-md-6 search">
                      <input type="text" class="form-control" name="name">
                      </div>
                      <div class="col-md-4 search_room">
                      <select class="form-control" name="category">
                      							<option value="" >All</option>			
                        						 <option value="Home" >Home</option>
                        						 <option value="Travel">Travel</option>
                        						 <option value="Movies">Movies</option>
                        						 <option value="Office">Office</option>
                        						 <option value="Pet">Pet</option>
                        						 <option value="Outdoors">Outdoors</option>
                        						 <option value="Games">Games</option>
                        						 <option value="Beauty">Beauty</option>
                        						 <option value="Books">Books</option>
                        						 <option value="Electronics">Electronics</option>
                      </select>
                      </div>
                   		
                     <div class="col-md-2 sear-sub">
                      <button type="submit" class="glyphicon glyphicon-search"></button>
                      </div>
                      <div class="clearfix"></div>
                     
                      </div>
                </form>
                

                <%-- <table class="table">
                    <thead>
                        <tr>
                            <th>Role</th>
                            <th>Login</th>
                            <th>Password</th>
                            <th>Login</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>

                            <td>EMPLOYEE</td>
                            <td>employee1</td>
                            <td>employee1</td>
                            <td><a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/autoLogin?login=employee1&pass=employee1">Auto login</a></td>
                        </tr>
                        <tr>
                            <td>MANAGER</td>
                            <td>manager1</td>
                            <td>manager1</td>
                            <td><a class="btn btn-default btn-xs" href="${pageContext.request.contextPath}/autoLogin?login=manager1&pass=manager1">Auto login</a></td>
                        </tr>
                    </tbody>
                </table> --%>

            </div>


            <jsp:include page="_footer.jsp"/>
        </div>
    </div>
   </div>
</body>
</html>