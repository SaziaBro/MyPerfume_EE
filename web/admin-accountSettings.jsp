<%-- 
    Document   : admin-accountSettings
    Created on : Dec 14, 2019, 5:13:15 PM
    Author     : YakaMiya
--%>

<%@page import="org.hibernate.Session"%>
<%@page import="Utility.HibernateCore"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body>
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliSettings").style.backgroundColor = "#212529";
        </script>
        <section>
            <h1 style="margin-left: 30px; font-size: 2rem">
                My Account
            </h1>
            <%                try {
                    Session hibSession = HibernateCore.getInstance().getSession();
                    User user = (User) hibSession.load(User.class, ((User) request.getSession().getAttribute("currentUserSession")).getIdUser());
                    String email = (String) FnSecurity.FnDecryptUserLoginCredentials.getInstance().process(String.valueOf(user.getEmail()));
            %>
            <div style="margin-left: 50px" class="container">
                <table>
                    <tr>
                        <td colspan="2">
                            <label>
                                Name 
                            </label>
                            <label style="margin-left: 80px">
                                : 
                            </label>
                            <input type="text" id="accountSettingstxtName" value="<%= user.getName()%>"/>
                        </td>


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
                            <input style="width: 300px;" type="button" value="Update" onclick="updateUserProfileData(<%= user.getIdUser()%>);" />
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
                            <input style="width: 300px;" type="button" value="Update" onclick="updateUserProfilePassword(<%= user.getIdUser()%>);" />
                        </td>

                    </tr>
                </table>
            </div>
        </section>
        <%                } catch (Exception e) {
                FnErrorHandler.executeErrorHandler(e);
            }
        %>
        <script src="js/Ajax/User.js" type="text/javascript"></script>
    </body>
</html>
