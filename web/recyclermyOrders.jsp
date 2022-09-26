
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Invoice"%>
<%@page import="Utility.FnErrorHandler"%>
<%

    try {
        ArrayList<Invoice> array = (ArrayList<Invoice>) request.getAttribute("loadInvoices");
        for (Invoice invoice : array) {
%>
<tr>
    <td><%= invoice.getIdInvoice()%></td>
    <td><%= invoice.getDate()%></td>
    <td><%= invoice.getTime()%></td>
    <td><%= invoice.getItemCount()%></td>
    <td><%= "$ " + invoice.getNettotal()%></td>
    <td> <%= invoice.getAddress().toString()%> </td>
    <td> <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;">
            <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;width: 100%;cursor: default" onclick="executeviewSingleInvoice(<%= invoice.getIdInvoice()%>);">View</a>
        </div>
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>