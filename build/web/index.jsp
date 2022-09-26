<%-- 
    Document   : index
    Created on : Nov 18, 2019, 6:57:35 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        String param = (String) session.getAttribute("restorePotin");
        if (param != null) {
            response.sendRedirect(param);
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@ include file="includeHeadTag.jsp" %>
    </head>
    <script>history.pushState(null, null, location.href);
        window.onpopstate = function() {
            history.go(1);
        };</script>
    <body onload="loadForIndex();">

        <div>
            <%@ include file="includeHeader.jsp" %>

            <section class="banner-bottom-wthreelayouts">
                <div class="container-fluid">
                    <div class="inner-sec-shop px-lg-4 px-3">
                        <h3 class="tittle-myCustom my-lg-4 my-4">New Arrivals</h3>
                        <div class="row" id="indexProductContainer">

                        </div>
                    </div>
                </div>
            </section>
            <%@ include file="includeFooter.jsp" %>
        </div>
        <%@ include file="includeCommanScripTag.jsp" %>
        <script src="js/Ajax/Stock.js" type="text/javascript"></script>
    </body>
</html>
