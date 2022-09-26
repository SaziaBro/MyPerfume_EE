<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Address"%>
<%@page import="Utility.FnErrorHandler"%>

<%
    try {
        int itemCount = 0;
        ArrayList<Address> addresslist = (ArrayList<Address>) request.getAttribute("loadAddress");
        String param = (String) request.getAttribute("executeMethod");
        for (Address addres : addresslist) {
            if ((itemCount % 2) == 0) {
%>
divStart

<%
    }
%>

<table style="border-collapse:inherit ;border: 1px solid #CDCDCD;border-spacing: 2px;<%if (param.equals("selection")) {%> margin-left:  50px;<% } else {%> margin-left:  10px;<%}%>margin-top: 10px;margin-bottom: 10px">
    <tbody style="padding: 7px">
        <tr>
            <td style="padding: 10px"> <input type="text" style="border: #ffffff"<%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtName"%>" value="<%= addres.getName().toUpperCase()%>"> </td>
            <td style="padding: 10px"><input type="text" style="border: #ffffff" <%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtMobile"%>" value="<%= addres.getContactNo().toUpperCase()%>"> </td>
        </tr>
        <tr>
            <td style="padding: 10px"><input type="text" style="border: #ffffff" <%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtLine1"%>" value="<%= addres.getLine1().toUpperCase()%>">  </td>
            <td style="padding: 10px"><input type="text" style="border: #ffffff" <%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtLine2"%>" value="<%= addres.getLine2().toUpperCase()%>">  </td>
        </tr>
        <tr>
            <td style="padding: 10px"><input type="text" style="border: #ffffff" <%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtCity"%>"  value="<%= addres.getCity().toUpperCase()%>"> </td>
            <td style="padding: 10px"> <input type="text" style="border: #ffffff" <%if (param.equals("selection")) {%> disabled="" <% }%> id="<%= addres.getIdAddress() + "_addresstxtZipCode"%>"  value="<%= addres.getZipCode()%>"> </td>
        </tr>
        <%
            if (param.equals("selection")) {
        %>
        <tr>
            <td > <div class="checkout-right-basket"  style="width: 100px;margin: 1em 0em;">
                    <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;margin-left: 50px;" onclick="executeSelectUserAddressForInvoice('<%= addres.getIdAddress()%>');">Select</a>
                </div>
            </td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td  colspan="2"> <div class="checkout-right-basket"  style="width: 100%;margin: 1em 0em;">
                    <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;margin-left: 150px;" onclick="executeAddressUpdate(<%= addres.getIdAddress()%>);">Update</a>
                </div> 
            </td>
        </tr>
    </tbody>
</table>

<%
    }

    itemCount++;
    if ((itemCount % 2) == 0) {
%>
divEnd

<%
            }

        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>
