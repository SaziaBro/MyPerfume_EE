<%@page import="Utility.FnErrorHandler"%>
<%@page import="pojos.User"%>
<%@page import="controllers.ConUser"%>
<noscript>
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=nojs.jsp">
</noscript>
<nav class="menu" tabindex="0">
    <div class="smartphone-menu-trigger"></div>
    <header class="avatar">
        <%
            try {
                if (request.getSession().getAttribute("currentUserSession") != null) {
                    User user = (User) request.getSession().getAttribute("currentUserSession");
                    if (user.getAccountType().equals("Admin")) {
        %>
        <h2><%= user.getName()%></h2>
        <%
            } else if (user.getAccountType().equals("User")) {
                response.sendRedirect("index.jsp");
            } else if (user.getStatus() == Byte.parseByte("0")) {
                response.sendRedirect("index.jsp");
            }
        } else if (ConUser.getConUser().checkUserType(request) != null) {
            User user = ConUser.getConUser().checkUserType(request);
            if (user.getAccountType().equals("Admin")) {
        %>
        <h2><%= user.getName()%></h2>
        <%
                    } else if (user.getAccountType().equals("User")) {
                        response.sendRedirect("index.jsp");
                    } else if (user.getStatus() == Byte.parseByte("0")) {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (Exception e) {
                FnErrorHandler.executeErrorHandler(e);
            }
        %>

    </header>
    <ul>
        <li id = "admin-dashboardliOrders" tabindex = "0" style = "background-image:url('images/payments.png')" ><a class="nav-link" href="admin-Orders.jsp"> <span>Orders</span></a></li >
        <li id = "admin-dashboardliSuppliers" tabindex = "0" style = "background-image:url('images/user.png')" ><a class="nav-link" href="admin-supplier.jsp"> <span>Suppliers</span></a></li >
        <li id="admin-dashboardliProduct" tabindex="0" style="background-image:url('images/product.png')"><a class="nav-link" href="admin-product.jsp"> <span>Products</span></a></li>
        <li id="admin-dashboardliStock" tabindex="0" style="background-image:url('images/stock.png')"><a class="nav-link" href="admin-stock.jsp"> <span>Stock</span></a></li>
        <li id="admin-dashboardliGrn" tabindex="0" style="background-image:url('images/invoice.png')"><a  class="nav-link" href="admin-GRN.jsp"> <span>GRN</span></a></li>
        <li id="admin-dashboardliPayments" tabindex="0" style="background-image:url('images/payments.png')"><a  class="nav-link" href="admin-payments.jsp"> <span>Payments</span></a></li>
        <li id="admin-dashboardliUsers" tabindex="0" style="background-image:url('images/user.png')"><a  class="nav-link" href="admin-userAccounts.jsp"> <span>Accounts</span></a></li>
        <li id="admin-dashboardliSettings" tabindex="0" style="background-image:url('images/settings.png')"><a  class="nav-link" href="admin-accountSettings.jsp"> <span>Settings</span></a></li>
        <li id="admin-dashboardliLogout" tabindex="0" style="background-image:url('images/logout.png')"><a  class="nav-link" href="index.jsp"> <span>Customer Home</span></a></li>
    </ul>
</nav>