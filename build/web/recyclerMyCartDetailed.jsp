<%@page import="pojos.User"%>
<%@page import="pojos.Stock"%>
<%@page import="Utility.sessionCartItems"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Invocartsession"%>
<%@page import="java.util.List"%>
<%@page import="Utility.HibernateCore"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Utility.FnErrorHandler"%>
<%
    try {
        Session mycartSession = HibernateCore.getInstance().getNewSession();
        User user = (User) request.getSession().getAttribute("currentUserSession");
        if (user != null) {
            List<Invocartsession> executeLoad = (List<Invocartsession>) request.getAttribute("executeLoad");
            int count = 1;
            int qtyTotal = 0;
            double nettotal = 0;
            for (Invocartsession cartItems1 : executeLoad) {
                Invocartsession cartItems = (Invocartsession) mycartSession.load(Invocartsession.class, cartItems1.getIdInvoCartSession());
                Stock stock = (Stock) mycartSession.load(Stock.class, cartItems.getStock().getIdStock());
                qtyTotal = qtyTotal + cartItems.getQty();
                nettotal = nettotal + (cartItems.getQty() * stock.getSellingPrice());
%>
<tr class="rem1">
    <td class="invert"><%=count%></td>
    <td class="invert-image">
        <a  id="frmMyCarttxtPage" onclick="executeViewSingleProduct(<%= stock.getIdStock()%>);">
            <img id="frmMyCarttxtImage" src="res/<%= stock.getProduct().getImageurl()%>" class="img-responsive">
        </a>
    </td>
    <td class="invert" id="frmMyCarttxtItemName"><%= stock.getProduct().getName().toUpperCase()%></td>
    <%
        if (stock.getQty() >= cartItems.getQty()) {
    %>
    <td>
        <input class="form-control qty"  min="1" max="<%= stock.getQty()%>" type="number" value="<%= cartItems.getQty()%>" id="<%= cartItems.getIdInvoCartSession() + "_qty"%>" />
    </td>
    <%
    } else {
    %>
    <td>
        <input class="form-control qty"  min="1" max="<%= stock.getQty()%>" type="number" value="<%= cartItems.getQty()%>" id="<%= cartItems.getIdInvoCartSession() + "_qty"%>" />
        <label style="color: red; font-size: 1rem;    font-family: 'Inconsolata', monospace;" ><%= "Qty left only: " + stock.getQty()%> </label>
    </td>
    <%
        }
    %>


    <td class="invert" id="frmMyCarttxtItemPrice"><%= "$ " + stock.getSellingPrice()%></td>
    <td class="invert"><%="$ " + cartItems.getQty() * cartItems.getStock().getSellingPrice()%></td>
    <td>
        <div class="rem">
            <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;">
                <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;" onclick="updateDBCartSession(<%= cartItems.getIdInvoCartSession()%>)">Update</a>
            </div>
            <div class="checkout-right-basket"  style="width: 100%;margin: 1em 0em;">
                <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;" onclick="removeDBCartSession(<%= cartItems.getIdInvoCartSession()%>)">Remove</a>
            </div>
        </div>
    </td>

</tr>
<% count++;
    }
    System.out.println("Invocartsession nettotal: " + nettotal);

    request.getSession().setAttribute("total", nettotal);
%>
<tr>
    <td></td>
    <td></td>
    <td></td>
    <td><%= qtyTotal%></td>
    <td colspan="3"><%= "Nettotal: $" + nettotal%></td>
</tr>
<%
} else {
    ArrayList<sessionCartItems> executeLoad = (ArrayList<sessionCartItems>) request.getAttribute("executeLoad");
    int count = 1;
    int qtyTotal = 0;
    double nettotal = 0;
    for (sessionCartItems sessionCartItem : executeLoad) {
        Stock stock = (Stock) mycartSession.load(Stock.class, sessionCartItem.getStock().getIdStock());
        qtyTotal = qtyTotal + sessionCartItem.getQty();
        nettotal = nettotal + (sessionCartItem.getQty() * stock.getSellingPrice());

%>
<tr class="rem1">
    <td class="invert"><%=count%></td>
    <td class="invert-image">
        <a  id="frmMyCarttxtPage" onclick="executeViewSingleProduct(<%= stock.getIdStock()%>);">
            <img id="frmMyCarttxtImage" src="res/<%= stock.getProduct().getImageurl()%>" class="img-responsive">
        </a>
    </td>
    <td class="invert" id="frmMyCarttxtItemName"><%= stock.getProduct().getName().toUpperCase()%></td>
    <td>
        <input class="form-control qty"  min="1" max="<%= stock.getQty()%>" type="number" value="<%= sessionCartItem.getQty()%>" id="<%= stock.getIdStock() + "_qty"%>"  />
    </td>


    <td class="invert" id="frmMyCarttxtItemPrice"><%= "$ " + stock.getSellingPrice()%></td>
    <td class="invert"><%="$ " + sessionCartItem.getQty() * stock.getSellingPrice()%></td>
    <td class="invert">
        <div class="rem">
            <div class="checkout-right-basket" style="width: 100%;margin: 1em 0em;">
                <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;" onclick="updateServletCartSession(<%= sessionCartItem.getStock().getIdStock()%>)">Update</a>
            </div>
            <div class="checkout-right-basket"  style="width: 100%;margin: 1em 0em;">
                <a class="btnChekcoutUpdatenRemove" style="color: #ffffff;cursor: default;" onclick="removeServletCartSession(<%= sessionCartItem.getStock().getIdStock()%>)">Remove</a>
            </div>
        </div>
    </td>
</tr>
<% count++;
    }
    System.out.println("sessionCartItems nettotal: " + nettotal);
    request.getSession().setAttribute("total", nettotal);
%>
<tr>
    <td></td>
    <td></td>
    <td></td>
    <td><%= qtyTotal%></td>
    <td colspan="3"><%= "Nettotal: $" + nettotal%></td>
</tr>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>
