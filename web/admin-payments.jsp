<%-- 
    Document   : admin-payments
    Created on : Dec 13, 2019, 12:23:58 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="loadPaymentDetails();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliPayments").style.backgroundColor = "#212529";
        </script>
        <h1 style="margin-left: 30px; font-size: 2rem">
            Payments
        </h1>
        <section style=" margin-left: 15%;">
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Invoice ID 
                            </label>
                            <label >
                                : 
                            </label>
                            <input type="text" id="adminPaymentttxtInvoiceID"/>
                        </td>
                        <td>
                            <label>
                                Status
                            </label>
                            <label style="margin-left:53px">
                                : 
                            </label>
                            <select id="adminPaymentttxtPaymentID">
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
                                User Name
                            </label>
                            <label style="margin-left:10px">
                                : 
                            </label>
                            <input  type="text" id="adminPaymentttxtUserName"/>
                        </td>
                        <td>
                            <label>
                                Payer Email
                            </label>
                            <label style="margin-left:10px">
                                : 
                            </label>
                            <input  type="text" id="adminPaymentttxtPayerEmail"/>
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
                            <input  type="date" id="adminPaymenttdateFrom"/>
                        </td>
                        <td>
                            <label>
                                End Date
                            </label>
                            <label style="margin-left:35px">
                                : 
                            </label>
                            <input  type="date" id="adminPaymenttdateEnd"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="button" value="Search" onclick="searchPaymentDetails();"/>
                        </td>
                        <td>
                            <input type="button" value="Clear" onclick="resetPaymentFields();"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <section>
            <table style="margin-left: 30px">
                <thead>
                <th style="width: 40px">Invoice ID</th>
                <th style="width: 100px">Date</th>
                <th style="width: 100px">Time</th>
                <th style="width: 40px">Item count</th>
                <th style="width: 100px">Nettotal</th>
                <th style="width: 200px">User</th>
                <th>&nbsp<th>
                </th>
                </thead>
                <tbody id="adminPaymentTableContainer">

            </table>
        </section>
        <script src="js/Ajax/User.js" type="text/javascript"></script>
    </body>
</html>
