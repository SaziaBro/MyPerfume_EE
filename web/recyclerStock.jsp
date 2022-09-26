
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Stock"%>
<%@page import="Utility.FnErrorHandler"%>
<%
    try {
        ArrayList<Stock> array = (ArrayList<Stock>) request.getAttribute("executeLoad");
        for (Stock stock : array) {
%>
<tr>
    <td style="width: 40px;"><input style="width: 40px; text-align: center;" disabled="" type="text" value="<%= stock.getIdStock()%>"></td>
    <td style="width: 40px;"><input style="width: 40px; text-align: center;" disabled=""  type="text" value="<%= stock.getProduct().getIdProduct()%>"></td>
    <td style="width: 150px;"><input style="width: 150px; text-align: center;" disabled=""  type="text" value="<%= stock.getProduct().getName().toUpperCase() %>"></td>
    <td style="width: 100px;"><input style="width: 100px; text-align: center;"disabled=""  type="text" value="<%= stock.getPrice()%>"></td>
    <td style="width: 40px;"><input style="width: 40px; text-align: center;"disabled=""  type="text" value="<%= stock.getQty()%>"></td>
    <td style="width: 100px;"><input style="width: 100px; text-align: center;" id="<%= stock.getIdStock()+"_txtSellingPrice"%>" type="text" value="<%= stock.getSellingPrice()%>"></td>
    <td style="width: 100px; text-align: center;">
        <select style="width: 100px;" id="<%= stock.getIdStock()+"_SelectStatus"%>">
            <option <% if (stock.getStatus() == Byte.parseByte("1")) {%> selected="" <%} %>>Active</option>
            <option  <% if (stock.getStatus() == Byte.parseByte("0")) {%> selected="" <%} %>>Deactive</option>
        </select>
    </td>
    <td style="width: 100px;"><input style="width: 100px; font-size: 1rem" type="button" onclick="updateStock(<%= stock.getIdStock()%>)" value="Update"></td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>