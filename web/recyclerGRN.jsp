<%@page import="Utility.HibernateCore"%>
<%@page import="pojos.Supplier"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Grn"%>
<%@page import="Utility.FnErrorHandler"%>
<%
    try {
        ArrayList<Grn> array = (ArrayList<Grn>) request.getAttribute("executeGRNRetrive");
        for (Grn grn : array) {
            Supplier supplier = (Supplier)HibernateCore.getInstance().getSession().load(Supplier.class, grn.getSupplier().getIdSupplier());
%>
<tr>
    <td><input disabled="" style="width: 50px;text-align: center;" type="text" value="<%= grn.getIdGrn()%>" /></td>
    <td><input disabled="" style="width: 100px;text-align: center;" type="text" value="<%= grn.getDate()%>" /></td>
    <td><input disabled="" style="width: 100px;text-align: center;" type="text" value="<%= grn.getTime()%>" /></td>
    <td><input disabled="" style="width: 50px;text-align: center;" type="text" value="<%= grn.getItemCount()%>" /></td>
    <td><input disabled="" style="width: 100px;text-align: center;" type="text" value="<%= grn.getNettotal()%>" /></td>
    <td><input disabled="" style="width: 150px;text-align: center;" type="text" value="<%= supplier.getCompanyName().toUpperCase() %>" /></td>
    <td><input  style="width: 120px" type="button" value="view" onclick="executeGRNView(<%= grn.getIdGrn()%>);" /></td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>