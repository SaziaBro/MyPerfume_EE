<%-- 
    Document   : admin-supplier
    Created on : Nov 26, 2019, 3:46:51 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>

    </head>
    <body onload="executeRetriveAllSuppliers();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliSuppliers").style.backgroundColor = "#212529";
        </script>
    <main>
        <h1 style="margin-left: 30px; font-size: 2rem">
            Suppliers
        </h1>
        <section style=" margin-left: 15%;">
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Company Name
                            </label>
                            <label>
                                : 
                            </label>
                            <input type="text" id="adminSuppliertxtCompanyName"/>
                        </td>
                        <td>
                            <label>
                                Email
                            </label>
                             <label style="margin-left:35px">
                                : 
                            </label>
                            <input  type="email" id="adminSuppliertxtemail"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Address 
                            </label>
                            <label style="margin-left:45px">
                                : 
                            </label>
                            <input  type="text" id="adminSuppliertxtAddress"/>
                        </td>
                        <td>
                            <label>
                                Telephone
                            </label>
                             <label>
                                : 
                            </label>
                            <input  type="text" id="adminSuppliertxtmobile"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Status 
                            </label>
                             <label style="margin-left:55px">
                                : 
                            </label>
                            <select style="padding-left: 10px" id="adminSupplierselectStatus">
                                <option>Active</option>
                                <option>Deactive</option>
                            </select>
                        </td>
                        <td>

                            <input  type="button" value="Save" onclick="executeSupplierSave();" id="adminSuppliertxtmobile"/>
                        </td>
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <section style=" margin-left: 2%;">
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Company Name: 
                            </label>
                            <input type="text" id="adminSupplierSearchtxtCompanyName"/>
                        </td>
                        <td>
                            <label>
                                Email: 
                            </label>
                            <input  type="email" id="adminSupplierSearchtxtemail"/>
                        </td>

                        <td>
                            <label>
                                Status: 
                            </label>
                            <select style="width: 130px" id="adminSupplierSearchselectStatus">
                                <option>-Selection-</option>
                                <option>Active</option>
                                <option>Deactive</option>
                            </select>
                        </td>
                        <td>
                            <input  type="button" value="Search" onclick="executeSearchSuppliers();" id="adminSuppliertxtmobile"/>
                        </td>
                    </tr>

                </table>
            </div>
        </section>
        <br><br>
        <section style=" margin-left: 0.5%;">
            <table>
                <thead>
                <th style="width: 15px"> ID</th>
                <th style="width: 150px"> Company Name</th>
                <th style="width: 150px"> Email</th>
                <th style="width: 150px"> Telephone</th>
                <th style="width: 150px"> Address</th>
                <th> Status</th>
                <th> &nbsp</th>
                </thead>
                <tbody id="adminSupplierContainer">

                </tbody>

            </table>
        </section>
    </main>
    <script src="js/Ajax/Supplier.js" type="text/javascript"></script>
</body>
</html>
