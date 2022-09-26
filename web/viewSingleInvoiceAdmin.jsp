<%-- 
    Document   : viewSingleInvoiceAdmin
    Created on : Dec 13, 2019, 2:51:52 PM
    Author     : YakaMiya
--%>

<%@page import="pojos.Invoiceitem"%>
<%@page import="pojos.User"%>
<%@page import="pojos.Invoice"%>
<%@page import="pojos.Paymentdetails"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Utility.HibernateCore"%>
<%@page import="Utility.FnErrorHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%    try {
        Session hibSession = HibernateCore.getInstance().getNewSession();
        Paymentdetails paymentdetails = (Paymentdetails) hibSession.load(Paymentdetails.class, Integer.parseInt(request.getParameter("idPayment")));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles-adminPanel.css" rel='stylesheet' type='text/css'/>
    </head>
    <body>
        <%@ include file="includeDashboardAdminHeader.jsp"%>
        <script>
            document.getElementById("admin-dashboardliPayments").style.backgroundColor = "#212529";
        </script>
        <h1 style="margin-left: 20px; font-size: 2rem">
            Payment ID:<%= paymentdetails.getIdTransaction()%>
        </h1>
        <section style=" margin-left: 20px;">
            <div class="container">
                <table style="width: 1000px">
                    <tr>
                        <td>
                            <label>
                                Invoice ID 
                            </label>
                            <label >
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getIdInvoice()%>
                            </label>
                        </td>
                        <td>
                            <label>
                                Payer Email
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getPayerEmail().toUpperCase()%>
                            </label>
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
                            <label>
                                <%= paymentdetails.getInvoice().getUser().getName().toUpperCase()%>
                            </label>
                        </td>
                        <td>
                            <label>
                                Date
                            </label>
                            <label style="margin-left:80px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getDate()%>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Time
                            </label>
                            <label style="margin-left:55px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getTime()%>
                            </label>
                        </td>
                        <td>
                            <label>
                                Item Count
                            </label>
                            <label style="margin-left:28px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getItemCount()%>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Nettotal
                            </label>
                            <label style="margin-left:20px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getNettotal()%>
                            </label>
                        </td> <td>
                            <label>
                                Address
                            </label>
                            <label style="margin-left:55px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getInvoice().getAddress().toString().toUpperCase()%>
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label>
                                Status
                            </label>
                            <label style="margin-left:38px">
                                : 
                            </label>
                            <label>
                                <%= paymentdetails.getProcessStatus()%>
                            </label>
                        </td> 
                    </tr>
                </table>
            </div>
        </section>
        <br>
        <section style=" margin-left: 20px;">
            <br>
            <table class="timetable_sub" style="width: 1100px;">
                <thead>
                <th>&nbsp;</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
                </thead>
                <tbody>
                    <%
                        for (Invoiceitem invoiceitem : paymentdetails.getInvoice().getInvoiceitems()) {
                    %>
                    <tr>
                        <td class="invert-image">
                            <img style="width: 100px;height: 100px" id="frmMyCarttxtImage"  src="res/<%= invoiceitem.getProduct().getImageurl()%>" class="img-responsive">
                        </td>
                        <td style="text-align: center" ><label>
                                <%= invoiceitem.getProduct().getName().toUpperCase()%>
                            </label></td>
                        <td  style="text-align: center"><label>
                                <%= invoiceitem.getPrice()%>
                            </label></td>
                        <td  style="text-align: center"><label>
                                <%=  invoiceitem.getQty()%>
                            </label></td>
                        <td  style="text-align: center"><label>
                                <%=(invoiceitem.getPrice() * invoiceitem.getQty())%>
                            </label></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </section>
    </body>
</html>

<%
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>