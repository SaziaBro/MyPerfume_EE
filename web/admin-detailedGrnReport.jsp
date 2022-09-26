<%-- 
    Document   : admin-detailedGrnReport
    Created on : Nov 29, 2019, 7:45:39 PM
    Author     : YakaMiya
--%>

<%@page import="Utility.FnErrorHandler"%>
<%@page import="pojos.Grnitem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Grn"%>
<%@page import="controllers.ConGRN"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body>
        <%            try {
                Grn grn = ConGRN.getConGRN().getIndiGRNFile(request.getParameter("idGrn"));
                ArrayList<Grnitem> grnItemArrayList = new ArrayList<Grnitem>(grn.getGrnitems());
        %>
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliGrn").style.backgroundColor = "#212529";
        </script>
        <section>
            <h1 style="margin-left: 30px; font-size: 2rem">
                GRN ID: <%= grn.getIdGrn()%>
            </h1>
            <div style="margin-left: 50px" class="container">
                <table>
                    <tr>
                        <td>
                            <div class="row">
                                <lable style="font-size: 1rem;">
                                    Supplier
                                </lable>
                                <label style="font-size: 1rem;">:</label>
                                <input type="text" disabled="" value="<%=grn.getSupplier().getCompanyName().toUpperCase()%>">
                            </div>
                        </td>

                        <td>
                    <lable style="font-size: 1rem;">
                        Nettotal
                    </lable>
                    <label style="font-size: 1rem;">:</label>
                    <input type="text" disabled="" value="<%=grn.getNettotal()%>">
                    </td>
                    <td>
                    <lable style="font-size: 1rem;">
                        Item Count
                    </lable>
                    <label style="font-size: 1rem;margin-left: 13px">:</label>
                    <input type="text" disabled="" value="<%=grn.getItemCount()%>">
                    </td>
                    </tr>
                    <tr>
                        <td>
                    <lable style="font-size: 1rem;">
                        Date
                    </lable>
                    <label style="font-size: 1rem;margin-left: 35px">:</label>
                    <input type="text" disabled="" value="<%=grn.getDate()%>">
                    </td>
                    <td>
                    <lable style="font-size: 1rem;">
                        Time
                    </lable>
                    <label style="font-size: 1rem;margin-left: 35px">:</label>

                    <input type="text" disabled="" value="<%=grn.getTime()%>">
                    </td>
                    <td>
                    <lable style="font-size: 1rem;">
                        Employee
                    </lable>
                    <label style="font-size: 1rem;margin-left: 30px">:</label>

                    <input type="text" disabled="" value="<%=grnItemArrayList.get(0).getUser().getName().toUpperCase()%>">
                    </td>
                    </tr> 
                </table>
                <br>
                <br>
                <table style="margin-left: 180px">
                    <thead>
                    <th style="width: 100px; text-align: center;">Product ID</th>
                    <th style="width: 200px; text-align: center;">Product Name</th>
                    <th style="width: 200px; text-align: center;">Category</th>
                    <th style="width: 100px; text-align: center;">Price</th>
                    <th style="width: 50px; text-align: center;">Qty</th>
                    </thead>
                    <tbody>
                        <%
                            for (Grnitem g : grnItemArrayList) {
                        %>
                        <tr>
                            <td><lable style="font-size: 1rem; text-align: center;"><%=g.getProduct().getIdProduct()%></lable></td>
                    <td style=" text-align: center;"><lable style="font-size: 1rem; text-align: center;"><%=g.getProduct().getName().toUpperCase()%></lable></td>
                    <td style=" text-align: center;"><lable style="font-size: 1rem; text-align: center;"><%=g.getProduct().getCategory().toUpperCase()%></lable></td>
                    <td style=" text-align: center;"><lable style="font-size: 1rem; text-align: center;"><%=g.getPrice()%></lable></td>
                    <td style=" text-align: center;"><lable style="font-size: 1rem; text-align: center;"><%=g.getQty()%></lable></td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </section>
        <%
            } catch (Exception e) {
                FnErrorHandler.executeErrorHandler(e);
            }
        %>
    </body>
</html>
