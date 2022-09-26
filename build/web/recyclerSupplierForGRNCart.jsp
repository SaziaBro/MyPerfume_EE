<%@page import="Utility.FnErrorHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Supplier"%>
<%@page import="pojos.Supplier"%>
<%
    try {
        ArrayList<Supplier> array = (ArrayList<Supplier>) request.getAttribute("executeRetrivalSupplier");
        for (Supplier supplier : array) {
%>
<option><%= supplier.getCompanyName().toUpperCase()%></option>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>