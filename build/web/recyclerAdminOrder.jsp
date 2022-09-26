
<%@page import="org.hibernate.Session"%>
<%@page import="pojos.User"%>
<%@page import="Utility.HibernateCore"%>
<%@page import="pojos.Invoice"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Paymentdetails"%>
<%@page import="Utility.FnErrorHandler"%>
<%
    try {
        ArrayList<Paymentdetails> array = (ArrayList<Paymentdetails>) request.getAttribute("executeLoad");
        Session hibSession = HibernateCore.getInstance().getNewSession();
        for (Paymentdetails paymentdetails : array) {
            Paymentdetails loadPayment = (Paymentdetails) hibSession.load(Paymentdetails.class, paymentdetails.getIdpaymentDetails());
            Invoice loadInvo = (Invoice) hibSession.load(Invoice.class, paymentdetails.getInvoice().getIdInvoice());
            User loadUser = (User) hibSession.load(User.class, paymentdetails.getInvoice().getUser().getIdUser());
%>
<tr>
    <td> <input style="text-align: center;width: 40px"  value="<%= loadPayment.getInvoice().getIdInvoice()%>" disabled="" type="text" /> </td>
    <td> <input style="text-align: center;width: 100px" value="<%= loadInvo.getDate()%>" disabled="" type="text" /> </td>
    <td> <input style="text-align: center;width: 100px" value="<%= loadInvo.getTime()%>" disabled="" type="text" /> </td>
    <td> <input style="text-align: center;width: 200px"  value="<%= loadUser.getName()%>" disabled="" type="text"/> </td>
    <td> 
        <select style="width: 100px" id="<%= loadPayment.getIdpaymentDetails() + "_adminOrderselectStatus"%>">
            <option <% if (loadPayment.getProcessStatus().equals("Ordered")) {%> selected="" <%} %>>Ordered</option>
            <option <% if (loadPayment.getProcessStatus().equals("Working")) {%> selected="" <%} %>>Working</option>
            <option <% if (loadPayment.getProcessStatus().equals("Dispatched")) {%> selected="" <%}%>>Dispatched</option>
        </select>
    </td>
    <td class="row">  <input type="button" value="Update" style="font-size: 1rem; width: 70px;padding: 0px" onclick="updateAdminOrders(<%= loadPayment.getIdpaymentDetails()%>)"/></td>
    <td class="row">  <input type="button" value="View"style="font-size: 1rem; width: 70px;padding: 0px" onclick="executeViewInvoiceAdmin(<%= loadPayment.getIdpaymentDetails()%>)"/></td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>