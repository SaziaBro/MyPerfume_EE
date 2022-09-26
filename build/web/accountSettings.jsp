<%-- 
    Document   : accountSettings
    Created on : Dec 14, 2019, 6:23:16 PM
    Author     : YakaMiya
--%>
<%@page import="Utility.HibernateCore"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Utility.FnErrorHandler"%>
<%@page import="FnSecurity.FnDecryptUserLoginCredentials"%>
<%@page import="controllers.ConUser"%>
<%@page import="controllers.ConUser"%>
<%@page import="pojos.User"%>
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
    <body>
        <%@ include file="includeHeader.jsp" %>
        <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
            <div class="container">
                <div class="inner-sec-shop px-lg-4 px-3">
                    <h3 class="tittle-myCustom my-lg-4 mt-3">My Profile</h3>
                    <div class="checkout-right">

                        <%                try {
                                Session hibSession = HibernateCore.getInstance().getSession();
                                User user = (User) hibSession.load(User.class, ((User) request.getSession().getAttribute("currentUserSession")).getIdUser());
                                String email = (String) FnSecurity.FnDecryptUserLoginCredentials.getInstance().process(String.valueOf(user.getEmail()));
                        %>

                        <table class="timetable_sub" style="width: 1100px;">
                            <tr>
                                <td>
                                    <label >
                                        Name 
                                    </label>
                                    <label style="margin-left: 80px">
                                        : 
                                    </label>
                                    <input type="text" id="accountSettingstxtName" value="<%= user.getName()%>"/>
                                </td>
                                <td></td>


                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Mobile Number 
                                    </label>
                                    <label>
                                        : 
                                    </label>
                                    <input type="text" id="accountSettingstxtMobileNo"value="<%= user.getMobileNumber()%>"/>
                                </td>
                                <td>
                                    <label>
                                        Email
                                    </label>
                                    <label style="margin-left: 90px">
                                        : 
                                    </label>
                                    <input type="email"  id="accountSettingstxtEmail"value="<%= email%>"/>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">
                                    <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;margin-right: 15px;">
                                        <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;width: 100%;cursor: default" onclick="updateUserProfileData(<%= user.getIdUser()%>);">Update</a>
                                    </div>

                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        Old Password 
                                    </label>
                                    <label style="margin-left:10px">
                                        : 
                                    </label>
                                    <input type="password" id="accountSettingstxtOldPassword"/>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <label>
                                        New password 
                                    </label>
                                    <label style="margin-left:10px">
                                        : 
                                    </label>
                                    <input type="password" id="accountSettingstxtNewPassword"/>
                                </td>
                                <td>
                                    <label>
                                        Retype password 
                                    </label>
                                    <label style="margin-left:5px">
                                        : 
                                    </label>
                                    <input type="password" id="accountSettingstxtretypePassword"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;margin-right: 15px;">
                                        <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;width: 100%;cursor: default" onclick="updateUserProfilePassword(<%= user.getIdUser()%>);">Update</a>
                                    </div>
                                </td>

                            </tr>
                        </table>

                        <%                } catch (Exception e) {
                                FnErrorHandler.executeErrorHandler(e);
                            }
                        %>
                    </div>
                </div>
        </section>
    </div>
</section>
<%@ include file="includeFooter.jsp" %>
<%@ include file="includeCommanScripTag.jsp" %>
<script src="js/Ajax/User.js" type="text/javascript"></script>
</body>
</html>
