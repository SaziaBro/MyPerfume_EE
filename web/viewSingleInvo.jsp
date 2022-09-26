<%-- 
    Document   : viewSingleInvo
    Created on : Dec 11, 2019, 1:42:16 PM
    Author     : YakaMiya
--%>

<%@page import="Utility.FnErrorHandler"%>
<%@page import="pojos.Invoiceitem"%>
<%@page import="org.hibernate.criterion.Restrictions"%>
<%@page import="pojos.Paymentdetails"%>
<%@page import="org.hibernate.Criteria"%>
<%@page import="pojos.Invoice"%>
<%@page import="Utility.HibernateCore"%>
<%    try {
        System.out.println(request.getParameter("idInvoice"));
        Invoice invoice = (Invoice) HibernateCore.getInstance().getSession().load(Invoice.class, Integer.parseInt(request.getParameter("idInvoice")));
        Criteria paymentCriteria = HibernateCore.getInstance().getSession().createCriteria(Paymentdetails.class);
        paymentCriteria.add(Restrictions.eq("invoice", invoice));
        Paymentdetails payDetails = (Paymentdetails) paymentCriteria.uniqueResult();
        if (payDetails != null) {
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/checkout.css" rel='stylesheet' type='text/css' />
        <%@ include file="includeHeadTag.jsp" %>
    </head>
    <body>
        <%@ include file="includeHeader.jsp" %>
        <section id="Datasection" class="banner-bottom-wthreelayouts py-lg-5 py-3">
            <div class="container">
                <div class="inner-sec-shop px-lg-4 px-3">
                    <h3 class="tittle-myCustom my-lg-4 mt-3"><%= "Invoice ID: " + invoice.getIdInvoice()%></h3>
                    <div class="checkout-right">
                        <table class="timetable_sub" style="width: 1100px;">
                            <thead>
                            <th style="width: 150px;">Date</th>
                            <th style="width: 150px;">Time</th>
                            <th style="width: 50px;">Item Count</th>
                            <th style="width: 150px;">Nettotal</th>
                            <th style="width: 400px;">Address</th>
                            <th style="width: 150px;">Payment ID</th>
                            <th style="width: 150px;">Payer Email</th>
                            <th style="width: 150px;">Status</th>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;"><%= invoice.getDate()%></td>
                                    <td style="text-align: center;"><%= invoice.getTime()%></td>
                                    <td style="text-align: center;"><%= invoice.getItemCount()%></td>
                                    <td style="text-align: center;"><%= "$ " + invoice.getNettotal()%></td>
                                    <td style="text-align: center;"><%= invoice.getAddress().toString()%></td>
                                    <td style="text-align: center;"><%= payDetails.getIdTransaction()%></td>
                                    <td style="text-align: center;"><%= payDetails.getPayerEmail()%></td>
                                    <td style="text-align: center;"><%= payDetails.getProcessStatus() %></td>
                                </tr>
                            </tbody>
                        </table>
                        <br>
                        <br>
                        <table class="timetable_sub" style="width: 1100px;">
                            <thead>
                            <th style="width: 300px;">&nbsp;</th>
                            <th style="width: 150px;">Product Name</th>
                            <th style="width: 50px;">Price</th>
                            <th style="width: 50px;">Qty</th>
                            <th style="width: 50px;">Total</th>
                            </thead>
                            <tbody>
                                <%
                                    for (Invoiceitem invoiceitem : invoice.getInvoiceitems()) {
                                %>
                                <tr>
                                    <td class="invert" class="invert-image">
                                        <img style="width: 250px;height: 250px" id="frmMyCarttxtImage"  src="res/<%= invoiceitem.getProduct().getImageurl()%>" class="img-responsive">
                                    </td>
                                    <td class="invert" style="text-align: center;"><%= invoiceitem.getProduct().getName().toUpperCase()%></td>
                                    <td class="invert" style="text-align: center;"><%="$ " + invoiceitem.getPrice()%></td>
                                    <td class="invert" style="text-align: center;"><%= invoiceitem.getQty()%></td>
                                    <td class="invert" style="text-align: center;"><%="$ " + (invoiceitem.getPrice() * invoiceitem.getQty())%></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;">
                            <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;width: 100%;cursor: default" onclick="printWindow();">Print</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@ include file="includeFooter.jsp" %>
        <%@ include file="includeCommanScripTag.jsp" %>
        <script src="js/Ajax/User.js" type="text/javascript"></script>
        <script>
                                function printWindow() {
                                    var content = document.getElementById("Datasection").innerHTML;
                                    var mywindow = window.open('', 'Print', 'height=600,width=800');

                                    mywindow.document.write(content);
                                    mywindow.focus()
                                    mywindow.print();
                                    mywindow.close();
                                }
        </script>
    </body>
</html>
<%        }

    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }


%>