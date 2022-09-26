<%-- 
    Document   : Admin-Draft-GRN
    Created on : Nov 28, 2019, 2:37:43 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="executeRetriveValidSupplierSelectorForGRNCart();
            executeRetriveValidProductsSelectorForGRNCart();
            executeGRNCartSessionOnload();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliGrn").style.backgroundColor = "#212529";
        </script>
        <section>
            <h1 style="margin-left: 30px; font-size: 2rem">
                Draft A GRN 
            </h1>
            <div style="margin-left: 50px" class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Product 
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <select style="width: 200px"  id="adminDraftGRNProductSelector">

                            </select>
                        </td>
                        <td>
                            <label>
                                Price
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <input type="text" id="adminDraftGRNtxtPrice"/>
                        </td>
                        <td>
                            <label>
                                Qty 
                            </label>
                            <label style="margin-left:40px">
                                : 
                            </label>
                            <input  type="text" id="adminDraftGRNtxtQty"/>
                        </td>
                    </tr>
                    <tr><td>
                            <label>
                                Supplier 
                            </label>
                            <label style="margin-left:11px">
                                : 
                            </label>
                            <select style="width: 200px;margin-top: 4px"  id="adminDraftGRNSupplierSelector">

                            </select>
                            <br>
                            <br>
                        </td>
                        <td>
                            <input type="button" value="Add Item" onclick="executeGRNCartSession();" id="adminDraftGRNbtnAddItem"/>
                        </td>
                        <td>
                            <input type="button" value="Submit GRN" onclick="executeGRN();" id="adminDraftGRNbtnSubmitGRN"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <br>
        <section style="margin-left: 20px">
            <table>
                <thead>
                <th style="width: 100px">Session ID</th>
                <th style="width: 100px">Product ID</th>
                <th style="width: 200px">Product Name</th>
                <th style="width: 100px">Price</th>
                <th style="width: 100px">Qty</th>
                <th>&nbsp<th>
                <th>&nbsp<th>
                    </thead>
                <tbody id="adminDraftGRNContainer">

                </tbody>
            </table>
        </section>
        <script src="js/Ajax/GRN.js" type="text/javascript"></script>
    </body>
</html>
