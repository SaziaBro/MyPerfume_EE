<%-- 
    Document   : myOrders
    Created on : Dec 11, 2019, 10:45:33 AM
    Author     : YakaMiya
--%>
<%try {
        if (request.getSession().getAttribute("currentUserSession") != null || ConUser.getConUser().checkUserType(request) != null) {
            if (request.getSession().getAttribute("currentUserSession") == null && ConUser.getConUser().checkUserType(request) != null) {
                User user = ConUser.getConUser().checkUserType(request);
                FnDecryptUserLoginCredentials decryptUserLoginCredentials = FnSecurity.FnDecryptUserLoginCredentials.getInstance();
                request.getSession().setAttribute("currentUserSession", ConUser.getConUser().executeRetriveUser(String.valueOf(decryptUserLoginCredentials.process(user.getEmail())), String.valueOf(decryptUserLoginCredentials.process(user.getPassword()))));
            }
        } else {
            response.sendRedirect("index.jsp");
        }

    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/checkout.css" rel='stylesheet' type='text/css' />
        <%@ include file="includeHeadTag.jsp" %>
    </head>
    <body onload="loadInvoicesOnMyOrders();">
        <%@ include file="includeHeader.jsp" %>
        <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
            <div class="container">
                <div class="inner-sec-shop px-lg-4 px-3">
                    <h3 class="tittle-myCustom my-lg-4 mt-3">My Orders</h3>
                    <div class="checkout-right">
                        <table class="timetable_sub" style="width: 1100px;">
                            <thead>
                            <th style="width: 50px;">Invoice ID</th>
                            <th style="width: 150px;">Date</th>
                            <th style="width: 150px;">Time</th>
                            <th style="width: 50px;">Item Count</th>
                            <th style="width: 150px;">Nettotal</th>
                            <th style="width: 400px;">Address</th>
                            <th style="width: 150px;">&nbsp;</th>
                            </thead>
                            <tbody id="myOrdersTableContainer">

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

        <%@ include file="includeFooter.jsp" %>
        <%@ include file="includeCommanScripTag.jsp" %>
        <script src="js/Ajax/User.js" type="text/javascript"></script>
    </body>
</html>
