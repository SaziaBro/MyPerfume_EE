<%@page import="Utility.FnErrorHandler"%>
<%@page import="pojos.Grncartsession"%>
<%@page import="java.util.List"%>

<%
    try {

        List<Grncartsession> grncartsessions = (List<Grncartsession>) request.getAttribute("executeGRNCartSessions");
        for (Grncartsession g : grncartsessions) {

%>
<tr>
    <td> <input style="text-align: center;width: 50px"  value="<%= g.getIdGrncartSession()%>" disabled="" type="text" id="1"/> </td>
    <td> <input style="text-align: center;width: 50px" value="<%= g.getProduct().getIdProduct()%>" disabled="" type="text" id="1"/> </td>
    <td> <input style="text-align: center;width: 200px" value="<%= g.getProduct().getName()%>" disabled="" type="text" id="1"/></td>
    <td> <input style="text-align: center;width: 100px" value="<%= g.getPrice()%>" disabled="" type="text" id="1"/></td>
    <td> <input style="text-align: center;width: 100px" id="<%= g.getIdGrncartSession() + "_recyclerAdminCartSessionQty"%>" value="<%= g.getQty()%>"  type="text" id="1"/></td>
    <td> <input style="font-size: 1rem" onclick="executeGRNCartSessionUpdate(<%= g.getIdGrncartSession()%>)" type="button" value="Update"/></td>
    <td> <input style="font-size: 1rem" onclick="executeGRNCartSessionRemove(<%= g.getIdGrncartSession()%>)" type="button" value="Delete"/></td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>