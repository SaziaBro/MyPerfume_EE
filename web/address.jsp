<%-- 

    Document   : address
    Created on : Dec 9, 2019, 11:05:04 AM
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
    <body onload="loadAddress();">
        <%@ include file="includeHeader.jsp" %>
        <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
            <div class="container">
                <div class="inner-sec-shop px-lg-4 px-3">
                    <h3 class="tittle-myCustom my-lg-4 mt-3">My Address</h3>
                    <div class="checkout-right">
                        <table class="timetable_sub" style="width: 800px;">
                            <tbody >
                                <tr>
                                    <td><label style="text-align: left">Name</label><label style="margin-left: 30px">:</label> <input type="name" id="addresstxtName" style="width: 200px;text-align: center;" value=""> </td>
                                    <td><label style="text-align: left">Contact  No</label><label style="margin-left: 10px">:</label> <input type="tel" id="addresstxtMobile" autocomplete="tel"  style="width: 200px;text-align: center;" value=""> </td>
                                </tr>
                                <tr>
                                    <td><label style="text-align: left">Line 1</label><label style="margin-left: 8px">:</label> <input type="street-address" id="addresstxtLine1" autocomplete="shipping street-address"  style="width: 200px;text-align: center;" value=""> </td>
                                    <td><label style="text-align: left">Line 2</label><label style="margin-left: 40px">:</label> <input type="address-line1" id="addresstxtLine2" autocomplete="address-line1" style="width: 200px;text-align: center;" value=""> </td>
                                </tr>
                                <tr>
                                    <td><label style="text-align: left">City</label><label style="margin-left: 25px">:</label> <input type="text" id="addresstxtCity" autocomplete="shipping locality" style="width: 200px;text-align: center;" value=""> </td>
                                    <td> <label style="text-align: left">Zip code</label><label style="margin-left: 20px">:</label> <input type="text" id="addresstxtZipCode" autocomplete="shipping postal-code"  style="width: 200px;text-align: center;" value=""> </td>
                                </tr>
                                <tr>
                                    <td colspan="2">  <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em; margin-right: 20px">
                                            <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;width: 100%;cursor: default" onclick="executeSaveAddress();">Save</a>
                                        </div></td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <br>
                        <div id="addressContainer" style="margin-left: 100px;"></div>
                    </div>
                </div>
            </div>
        </section>
        <br>
        <br>
        <br>
        <br>
        <br>
        <%@ include file="includeFooter.jsp" %>
        <%@ include file="includeCommanScripTag.jsp" %>
        <script src="js/Ajax/User.js" type="text/javascript"></script>
    </body>
</html>
