<%-- 
    Document   : admin-product
    Created on : Nov 27, 2019, 2:37:03 PM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body onload="executeRetriveAllProductsSelector();">
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliProduct").style.backgroundColor = "#212529";
        </script>
    <main>
        <h1 style="margin-left: 30px; font-size: 2rem">
            Product
        </h1>
        <section style=" margin-left: 15%;">
            <div class="container">
                <table>
                    <tr>
                        <td>
                            <label>
                                Name 
                            </label>
                            <label style="margin-left:100px">
                                : 
                            </label>
                            <input type="text" id="adminProducttxtName"/>
                        </td>
                        <td>
                            <label>
                                Min Qty
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <input type="text" id="adminProducttxtMinQty"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Description 
                            </label>
                            <label style="margin-left:40px">
                                : 
                            </label>
                            <input  type="text" id="adminProducttxtDescription"/>
                        </td>
                        <td>
                            <label>
                                Volume
                            </label>
                            <label style="margin-left:30px">
                                : 
                            </label>
                            <input   type="text" id="adminProducttxtVolume"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Category 
                            </label>
                            <label style="margin-left: 65px">
                                : 
                            </label>
                            <select  id="adminProducttxtSelectCategory">
                                <option>Perfume</option>
                                <option>Eau de Perfume</option>
                                <option>Eau de Toilette</option>
                                <option>Eau de Cologne</option>
                                <option>Eau Fraiche</option>
                            </select>
                            <br>
                            <label>
                                Status 
                            </label>
                            <label style="margin-left: 84px">
                                : 
                            </label>
                            <select  id="adminProducttxtSelectStatus">
                                <option>Active</option>
                                <option>Deactive</option>
                            </select>
                        </td>
                        <td>
                            <label>
                                Gender 
                            </label>
                            <label style="margin-left: 30px">
                                : 
                            </label>
                            <select   id="adminProducttxtSelectGender">
                                <option>Male</option>
                                <option>Female</option>
                            </select>
                            <br>
                            <br>
                            <br>
                            <label
                                >Image
                            </label>
                            <label style="margin-left: 38px">
                                :
                            </label>
                            <input
                                id="adminProducttxtFileImages"
                                type="file"
                                multiple=""
                                value="Add IMAGE"/>
                            <br>
                            <br>
                            <input type="button" value="Save" onclick="executeProductSave();" id="adminSuppliertxtmobile"/>
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
                                Name: 
                            </label>
                            <input type="text" id="adminProductSearchtxtName"/>
                        </td>
                        <td>
                            <label>
                                Des: 
                            </label>
                            <input type="text" id="adminProductSearchtxtDescription"/>
                        </td>
                        <td>
                            <label>
                                Vol: 
                            </label>
                            <input type="text" id="adminProductSearchtxtVolume"/>
                        </td>

                    </tr>
                    <tr>
                        <td>  <label>
                                Status: 
                            </label>
                            <select  style="width: 130px" id="adminProductSearchselectStatus">
                                <option>-Selection-</option>
                                <option>Active</option>
                                <option>Deactive</option>
                            </select>
                        </td>
                        <td>  <label>
                                Gender: 
                            </label>
                            <select style="width: 130px" id="adminProductSearchselectGender">
                                <option>-Selection-</option>
                                <option>Male</option>
                                <option>Female</option>
                            </select>
                        </td>
                        <td>  <label>
                                Category: 
                            </label>
                            <select style="width: 130px" id="adminProductSearchselectCategory">
                                <option>-Selection-</option>
                                <option>Perfume</option>
                                <option>Eau de Perfume</option>
                                <option>Eau de Toilette</option>
                                <option>Eau de Cologne</option>
                                <option>Eau Fraiche</option>
                            </select>
                        </td>
                        <td>
                            <input  type="button" value="Search" onclick="executeProductSearch();" id="adminProductSearchbtnSearch"/>
                        </td>
                    </tr>

                </table>
            </div>
        </section>
        <br><br>
        <section id="adminProductContainer" style=" margin-left: 1%;">
           
        </section>
    </main>
    <script src="js/Ajax/Product.js" type="text/javascript"></script>
</body>
</html>
