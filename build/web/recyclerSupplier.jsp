
<%@page import="Utility.FnErrorHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Supplier"%>
<%@page import="pojos.Supplier"%>
<%
    try {
        ArrayList<Supplier> array = (ArrayList<Supplier>) request.getAttribute("executeRetrivalSupplier");
        for (Supplier supplier : array) {
%>
<tr>
    <td style="width: 15px">
        <input style="width: 15px" value="<%= supplier.getIdSupplier()%>" disabled="" type="text" id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtidSupplier"%>"/>
    </td>
    <td style="width: 150px">
        <input style="width: 150px"  value="<%= supplier.getCompanyName()%>" type="email" id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtCompanyName"%>"/>
    </td>
    <td style="width: 150px">
        <input style="width: 150px"  value="<%= supplier.getEmail()%>" type="text" id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtemail"%>"/>
    </td>
    <td style="width: 150px">
        <input style="width: 150px"  value="<%= supplier.getTel()%>" type="text" id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtmobile"%>"/>
    </td>
    <td style="width: 150px">
        <input style="width: 150px"  value="<%= supplier.getBusinessAddress()%>" type="text" id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtaddress"%>"/>
    </td>

    <td>
        <select style="width: 95px"  id="<%= supplier.getIdSupplier() + "_recyclerSuppliertxtStatus"%>">
            <option  <% if (supplier.getStatus() == Byte.parseByte("1")) {%> selected <% } %>>Active</option>
            <option <% if (supplier.getStatus() == Byte.parseByte("0")) {%> selected <% }%>>Deactive</option>
        </select>
    </td>
    <td>
        <input style="width: 150px;font-size: 0.8rem;width: 50px; padding: 0px;margin: 0px"  type="button" value="Update" onclick="executeSupplierUpdate(<%= supplier.getIdSupplier()%>);" />
    </td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>