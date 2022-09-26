<%-- 
    Document   : admin-userAccounts
    Created on : Dec 15, 2019, 10:17:26 AM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="loadUsersToAdmin();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliUsers").style.backgroundColor = "#212529";
        </script>
        <h1 style="margin-left: 30px; font-size: 2rem">
            User Accounts
        </h1>
        <section style=" margin-left: 15%;">
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Name
                            </label>
                            <label style="margin-left:19px">
                                : 
                            </label>
                            <input type="text" id="adminAccounttxtName"/>
                        </td>
                        <td>
                            <label>
                                Mobile No
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <input type="text" id="adminAccounttxtMobileNo"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Status
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <select id="adminAccountselectStatus">
                                <option>-Selection-</option>
                                <option>Active</option>
                                <option>Deactive</option>
                            </select>
                        </td>
                        <td>
                            <label>
                                Type
                            </label>
                            <label style="margin-left:50px">
                                : 
                            </label>
                            <select id="adminAccountselectType">
                                <option>-Selection-</option>
                                <option>Admin</option>
                                <option>User</option>

                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" value="Search" onclick="searchUserAdmin();"/>
                        </td>
                        <td>
                            <input type="button" value="Clear" onclick="clearFieldsUsersAdmin();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <section style=" margin-left: 11%;" id="adminUserAccountsContainer">

        </section>
        <script src="js/Ajax/User.js" type="text/javascript">

        </script>
    </body>
</html>
