<%-- 
    Document   : admin-Orders
    Created on : Dec 15, 2019, 6:27:36 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body>
    <body onload="loadAdminOrders();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliOrders").style.backgroundColor = "#212529";
        </script>
        <h1 style="margin-left: 30px; font-size: 2rem">
            Orders
        </h1>
        <section style=" margin-left: 15%;">
            <div class="container">
                <table>
                    <tr>

                        <td>
                            <label>
                                Status
                            </label>
                            <label style="margin-left:35px">
                                : 
                            </label>
                            <select id="adminOrderselectStatus">
                                <option>-Selection-</option>
                                <option>Ordered</option>
                                <option>Working</option>
                                <option>Dispatched</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <label>
                                From Date
                            </label>
                            <label style="margin-left:10px">
                                : 
                            </label>
                            <input  type="date" id="adminOrdersdateFrom"/>
                        </td>
                        <td>
                            <label>
                                End Date
                            </label>
                            <label style="margin-left:35px">
                                : 
                            </label>
                            <input  type="date" id="adminOrdersdateEnd"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" value="Search" onclick="searchAdminOrders();"/>
                        </td>
                        <td>
                            <input type="button" value="Clear" onclick="clearFieldsAdminOrder();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
    <selection>
        <table style="margin-left: 30px">
            <thead>
            <th style="width: 40px">Invoice ID</th>
            <th style="width: 100px">Date</th>
            <th style="width: 100px">Time</th>
            <th style="width: 200px">User</th>
            <th style="width: 100px">Status</th>
            <th>&nbsp<th>
            <th>&nbsp<th>
                </thead>
            <tbody id="adminOrderTableContainer">

        </table>
    </selection>
    <script src="js/Ajax/User.js" type="text/javascript"></script>
</body>
</html>
