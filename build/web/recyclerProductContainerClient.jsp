<%@page import="Utility.FnErrorHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pojos.Stock"%>
<%
    try {
        int itemCount = 0;
        ArrayList<Stock> array = (ArrayList<Stock>) request.getAttribute("executeLoad");
        for (Stock stock : array) {

            if ((itemCount % 6) == 0) {
%>
divStart

<%
    }
%>

<div id="indexProductContainer" class=" col-md-2 product-men women_two" style=" -ms-flex: 0 0 33%;
     flex: 0 0 33%;
     max-width: 33%;
     -webkit-box-flex: 0;">
    <div class="product-googles-info googles">
        <div class="men-pro-item">
            <div class="men-thumb-item">
                <img src="res/<%= stock.getProduct().getImageurl()%>" class="img-fluid"  >
                <div class="men-cart-pro">
                    <div class="inner-men-cart-pro">
                        <a onclick="executeViewSingleProduct(<%= stock.getIdStock()%>);" class="link-product-add-cart" style="color: #ffffff">Quick View</a>
                    </div>
                </div>
                <span class="product-new-top"><%= stock.getProduct().getCategory().toUpperCase()%></span>
            </div>
            <div class="item-info-product">
                <div class="info-product-price">
                    <div class="grid_meta">
                        <div class="product_price">
                            <h4>
                                <a onclick="executeViewSingleProduct(<%= stock.getIdStock()%>);"><%= stock.getProduct().getName().toUpperCase()%></a>
                            </h4>
                            <div class="grid-price mt-2">
                                <span class="money">USD:<%= stock.getSellingPrice()%></span>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <br>
</div>
<%
    itemCount++;
    if ((itemCount % 6) == 0) {
%>
divEnd

<%
        }
    }

%>


<br>                               
<br>

<%    if ((itemCount % 6) != 0 || (itemCount % 6) == 0) {
        if ((itemCount % 6) != 0) {
%>
divEnd
<%
    }

    if (!String.valueOf(request.getAttribute("executePages")).equals("null")) {
        Integer count = (Integer) request.getAttribute("pageCount");

        for (int i = 1; i <= count; i++) {

            if (Integer.parseInt(request.getParameter("pageNo")) == (i * 6) - 6) {
%>
<button class="btn" style="color: #ff4e00" onclick="loadForShop(<%=(i * 6) - 6%>);"><%=i%></button>
<%
} else {
%>

<button class="btn" onclick="loadForShop(<%=(i * 6) - 6%>);"><%=i%></button>

<%
                    }
                }
            }
        }

    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>