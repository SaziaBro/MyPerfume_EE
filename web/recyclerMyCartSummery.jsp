
<%@page import="pojos.Stock"%>
<%@page import="Utility.sessionCartItems"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Invocartsession"%>
<%@page import="java.util.List"%>
<%@page import="pojos.User"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Utility.HibernateCore"%>
<%@page import="Utility.FnErrorHandler"%>
<h4>Summery</h4>
<ul>
    <%
        try {
            Session mycartSession = HibernateCore.getInstance().getNewSession();
            User user = (User) request.getSession().getAttribute("currentUserSession");
            if (user != null) {
                double total = 0;
                List<Invocartsession> executeLoad = (List<Invocartsession>) request.getAttribute("executeLoad");
                for (Invocartsession cartItems : executeLoad) {
                    Stock stock = (Stock) mycartSession.load(Stock.class, cartItems.getStock().getIdStock());
                    Invocartsession cartItemsload = (Invocartsession) mycartSession.load(Invocartsession.class, cartItems.getIdInvoCartSession());
                    total = total + (stock.getSellingPrice() * cartItemsload.getQty());
    %>
    <li><%= stock.getProduct().getName().toUpperCase() + "   (" + cartItemsload.getQty() + ")"%>
        <span><%="USD: " + stock.getSellingPrice()%></span>
    </li>
    <%
        }
        session.setAttribute("total", total);
    %>

    <li>Total
        <span><%="USD: " + total%></span>
    </li>
</ul>
<%
} else {
    ArrayList<sessionCartItems> executeLoad = (ArrayList<sessionCartItems>) request.getAttribute("executeLoad");
    double total = 0;
    for (sessionCartItems sessionCartItem : executeLoad) {
        Stock stock = (Stock) mycartSession.load(Stock.class, sessionCartItem.getStock().getIdStock());
        total = total + (stock.getSellingPrice() * sessionCartItem.getQty());

%>
<li><%= stock.getProduct().getName().toUpperCase() + "   (" + sessionCartItem.getQty() + ")"%>
    <span><%="USD: " + stock.getSellingPrice()%></span>
</li>
<%
    }
%>

<li>Total
    <span><%="USD: " + total%></span>
    <span hidden="" id="myCartNettotal"><%= total%></span>
</li>
</ul>
<%
        }
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>