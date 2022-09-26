 
<%@page import="Utility.FnErrorHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Product"%>
<%
    try {
        ArrayList<Product> array = (ArrayList<Product>) request.getAttribute("executeRetriveProducts");
        for (Product product : array) {
%>
<table>
    <tr>
        <td>
            <label>
                Product ID:<%= product.getIdProduct()%>
            </label>
            <br><br>
            <div style="height: 300px;width: 300px;background-image:url('res/<%= product.getImageurl()%>');background-position: center;
                 background-size: cover;" id="<%= product.getIdProduct() + "_recyclerProductImage"%>"></div>
            <input
                id="<%= product.getIdProduct() + "_recyclerProductImageChooser"%>"
                type="file"
                multiple=""
                value="Add IMAGE"/>
        </td>
        <td>
            <table>
                <tr>
                    <td>
                        <label>
                            Name
                        </label>
                        <label style="margin-left: 37px">
                            :
                        </label>
                        <input type="text" value="<%= product.getName()%>" id="<%= product.getIdProduct() + "_recyclerProducttxtName"%>"/>
                    </td>
                    <td>
                        <label>
                            Min Qty 
                        </label>
                        <label style="margin-left: 3px">
                            :
                        </label>
                        <input type="text" value="<%= product.getMinumumQty()%>" id="<%= product.getIdProduct() + "_recyclerProducttxtMinQty"%>"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            Vol
                        </label>
                        <label style="margin-left: 45px">
                            :
                        </label>
                        <input type="text" value="<%= product.getVolume()%>" id="<%= product.getIdProduct() + "_recyclerProducttxtVolume"%>"/>
                    </td>
                    <td>
                        <label>
                            Status 
                        </label>
                        <label style="margin-left: 10px">
                            :
                        </label>
                        <select id="<%= product.getIdProduct() + "_recyclerProductSelectStatus"%>">
                            <option <% if (product.getStatus() == Byte.parseByte("1")) {%> selected <%} %>>Active</option>
                            <option <% if (product.getStatus() == Byte.parseByte("0")) {%> selected <%}%>>Deactive</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            Category 
                        </label>
                        <label style="">
                            :
                        </label>
                        <select id="<%= product.getIdProduct() + "_recyclerProductSelectCategory"%>">
                            <option<% if (product.getCategory().equals("Perfume")) {%> selected <%} %>>Perfume</option>
                            <option<% if (product.getCategory().equals("Eau de Perfume")) {%> selected <%} %>>Eau de Perfume</option>
                            <option<% if (product.getCategory().equals("Eau de Toilette")) {%> selected <%} %>>Eau de Toilette</option>
                            <option<% if (product.getCategory().equals("Eau de Cologne")) {%> selected <%} %>>Eau de Cologne</option>
                            <option<% if (product.getCategory().equals("Eau Fraiche")) {%> selected <%}%>>Eau Fraiche</option>
                        </select>
                    </td>
                    <td>
                        <label>
                            Gender
                        </label>
                        <label style="margin-left: 10px">
                            :
                        </label>
                        <select id="<%= product.getIdProduct() + "_recyclerProductSelectGender"%>">
                            <option <% if (product.getGender() == Byte.parseByte("1")) {%> selected <%} %>>Male</option>
                            <option<% if (product.getGender() == Byte.parseByte("0")) {%> selected <%}%>>Female</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label>
                            Description
                        </label>
                        <br><br>
                        <textarea rows="5" cols="30" type="text" id="<%= product.getIdProduct() + "_recyclerProducttxtDescription"%>"><%= product.getDescription()%></textarea>
                    </td>
                    <td class="row">
                        <input  type="button" value="Update" onclick="executeProductUpdate(<%= product.getIdProduct()%>);" id="adminProductSearchbtnSearch"/>

                        <input style="margin-top: 10px" type="button" value="Download" onclick="downloadImage('<%= product.getIdProduct()%>', '<%= product.getName()%>');" id="adminProductSearchbtnSearch"/>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<%        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>
%>