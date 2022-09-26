<%-- 
    Document   : admin-GRN
    Created on : Nov 28, 2019, 2:22:22 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="executeRetriveValidSupplierSelectorForGRNSearch();executeGRNload();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliGrn").style.backgroundColor = "#212529";
        </script>
        <section>
            <h1 style="margin-left: 30px; font-size: 2rem">
                Search GRN 
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
                            <select style="width: 200px"  id="adminGRNSupplierSelector">

                            </select>
                        </td>
                        <td>
                            <label>
                                From Date 
                            </label>
                            <label style="margin-left:5px">
                                : 
                            </label>
                            <input type="date" id="adminGRNdateFrom"/>
                        </td>
                        <td>
                            <label>
                                End Date 
                            </label>
                            <label style="margin-left:5px">
                                : 
                            </label>
                            <input type="date" id="adminGRNdateTo"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="row" colspan="3">
                            <input style="width: 200px;margin-left: 150px" type="button" value="Search" onclick="executeSearchGRN();" id="adminDraftGRNbtnAddItem"/>
                            <a href="admin-Draft-GRN.jsp"><input style="width: 200px;margin-left: 30px" type="button" value="Draft GRN"  id="adminDraftGRNbtnSubmitGRN"/></a>
                            <input style="width:200px;margin-left: 30px" type="button" onclick="resetGRNFields();" value="Reset"  id="adminDraftGRNbtnSubmitGRN"/>
                        </td>

                    </tr>
                </table>
            </div>
        </section>
        <br>
        <br>
        <section>
            <table style="margin-left: 25px">
                <thead>
                <th style="width: 50px">GRN ID</th>
                <th style="width: 100px">Date</th>
                <th style="width: 100px">Time</th>
                <th style="width: 50px">Item count</th>
                <th style="width: 100px">Nettotal</th>
                <th style="width: 150px">Supplier</th>
                <th>&nbsp<th>
                </th>
                </thead>
                <tbody id="adminGRNTableContainer">
                   
            </table>
        </section>
        <script src="js/Ajax/GRN.js" type="text/javascript"></script>
    </body>
</html>
