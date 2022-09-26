<%-- 
    Document   : singleProduct
    Created on : Nov 18, 2019, 11:08:03 PM
    Author     : YakaMiya
--%>

<%@page import="controllers.ConStock"%>
<%@page import="pojos.Stock"%>
<%@page import="Utility.FnErrorHandler"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="css/main.css" rel='stylesheet' type='text/css' />
        <link href="css/shop.css" rel='stylesheet' type='text/css' />
        <link rel="stylesheet" href="css/select.css" type="text/css" />
        <link href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800"
              rel="stylesheet">

        <link href="css/fontawesome-all.css" rel="stylesheet">
        <link href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800"
              rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <%            try {
            Stock stock = ConStock.getConStock().getIndiStock(request.getParameter("idStock"));

    %>
    <body>
        <div>
            <%@ include file="includeHeader.jsp" %>
            <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
                <div class="container">
                    <div class="inner-sec-shop pt-lg-4 pt-3">
                        <div class="row">
                            <div class="col-lg-4 single-right-left ">
                                <div class="grid images_3_of_2">
                                    <div data-thumb="res/<%= stock.getProduct().getImageurl()%>">

                                        <div class="thumb-image"> <img src="res/<%= stock.getProduct().getImageurl()%>" data-imagezoom="true" class="img-fluid"> </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="col-lg-8 single-right-left simpleCart_shelfItem">
                                <h3><%= stock.getProduct().getName().toUpperCase()%></h3>
                                <h3><%= stock.getProduct().getVolume().toUpperCase()%></h3>
                                <p><span class="item_price">USD:<%= stock.getSellingPrice()%></span>
                                </p>
                                <div class="color-quality">
                                    <div class="color-quality-right">
                                        <h5>Quality left: <%= stock.getQty()%></h5>
                                    </div>
                                    <div class="color-quality-right">
                                        <select style="width: 182px" id="frmSiingleProductQtySelector">
                                            <option value="hide">-- Qty --</option>
                                            <%
                                                for (int i = 1; i <= stock.getQty(); i++) {
                                            %>
                                            <option value="<%= i%>"><%= i%></option>
                                            <%
                                                }
                                            %>

                                        </select> 
                                    </div>
                                            <button class="top_googles_cart" onclick="addtoCart(<%= stock.getIdStock() %>);" type="button" style=" margin-right: 35px; margin-top: 5px">
                                        Add to cart
                                        <i class="fas fa-cart-arrow-down"></i>
                                    </button>
                                </div>

                                <div class="occasion-cart">
                                    <div class="googles single-item singlepage">
                                        <!--addtocart-->

                                    </div>
                                </div>
                            </div>
                            <div class="clearfix"> </div>
                            <div class="responsive_tabs">
                                <div id="horizontalTab">
                                    <div class="resp-tabs-container">
                                        <div class="tab1">
                                            <div class="single_page">
                                                <h3>Description</h3>
                                                <br>
                                                <h6><%= stock.getProduct().getCategory().toUpperCase()%></h6>
                                                <p><%= stock.getProduct().getDescription().toUpperCase()%>.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <%@ include file="includeFooter.jsp" %>
            <script src="js/Ajax/User.js" type="text/javascript"></script>
            <script src="js/ViewOperations/jquery-2.2.3.min.js"></script>
            <script src="js/ViewOperations/bootstrap.js"></script>
            <script src="js/ViewOperations/modernizr-2.6.2.min.js"></script>
            <script src="js/ViewOperations/imagezoom.js"></script>

            <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'>

                < script >
                        jQuery(document).ready(function($) {
                    $(".scroll").click(function(event) {
                        event.preventDefault();
                        $('html,body').animate({
                            scrollTop: $(this.hash).offset().top
                        }, 900);
                    });
                });
            </script>
            <script src="js/ViewOperations/move-top.js"></script>
            <script src="js/ViewOperations/easing.js"></script>
            <script>
                $(document).ready(function() {

                    $().UItoTop({
                        easingType: 'easeOutQuart'
                    });

                });
            </script>
    </body>
    <%        } catch (Exception e) {
            FnErrorHandler.executeErrorHandler(e);
        }
    %>
</html>
