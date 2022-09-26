<%@page import="Utility.FnErrorHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Product"%>
<%@page import="pojos.Product"%>
<%
    try {
        ArrayList<Product> array = (ArrayList<Product>) request.getAttribute("executeRetriveProducts");
        for (Product product : array) {
%>
<option><%= product.getName().toUpperCase()%></option>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>