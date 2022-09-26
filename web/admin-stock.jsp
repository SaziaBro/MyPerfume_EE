<%-- 
    Document   : admin-stock
    Created on : Nov 28, 2019, 6:19:16 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="loadSupplierToStock();
          loadStock();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliStock").style.backgroundColor = "#212529";
        </script>
        <section>
            <h1 style="margin-left: 30px; font-size: 2rem">
                Stock 
            </h1>
            <div style="margin-left: 50px" class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Supplier 
                            </label>
                            <label>
                                : 
                            </label>
                            <select style="width: 200px"  id="adminStockSupplierSelector">

                            </select>
                        </td>
                        <td>
                            <label style="margin-left:30px">
                                From Date 
                            </label>
                            <label style="margin-left:5px">
                                : 
                            </label>
                            <input type="date" id="adminStockdateFrom"/>
                        </td>
                        <td>
                            <label>
                                End Date 
                            </label>
                            <label style="margin-left:5px">
                                : 
                            </label>
                            <input type="date" id="adminStockdateTo"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                          <label>
                                Status 
                            </label>
                            <label style="margin-left:15px">
                                : 
                            </label>  
                            <select style="width: 200px;"  id="adminStockStatusSelector">
                                <option>-Selection-</option>
                                <option>Active</option>
                                <option>Deactive</option>
                                <option>New Stocks</option>
                            </select>
                        </td>
                        <td class="row" colspan="2">
                            <input style="width: 200px;margin-left: 30px" type="button" value="Search" onclick="searchStock();"/>
                            <input style="width:200px;margin-left: 30px" type="button" onclick="resetGRNFields();" value="Reset"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <section style="margin-left: 30px">
            <table>
                <thead>
                <th>Stock ID</th>
                <th>Product ID</th>
                <th>Name</th>
                <th>Purchased price</th>
                <th>Qty</th>
                <th>Selling Price</th>
                <th>Status</th>
                <th>&nbsp</th>
                </thead>
                <tbody id="adminStockTableContainer">
                </tbody>
            </table>
        </section>
        <script src="js/Ajax/Stock.js" type="text/javascript"></script>
    </body>
</html>
