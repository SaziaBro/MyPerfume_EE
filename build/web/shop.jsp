<%-- 
    Document   : shop
    Created on : Nov 19, 2019, 1:28:01 AM
    Author     : YakaMiya
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
        <link href="css/main.css" rel='stylesheet' type='text/css' />
        <link href="css/shop.css" rel='stylesheet' type='text/css' />
        <link href="css/fontawesome-all.css" rel="stylesheet">
        <link href="//fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800"
              rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body onload="loadForShop(0);">
        <noscript>
        <META HTTP-EQUIV="Refresh" CONTENT="0;URL=nojs.jsp">
        </noscript>
        <div>
            <%@ include file="includeHeader.jsp" %>
            <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
                <div class="container-fluid">
                    <div class="inner-sec-shop px-lg-4 px-3">
                        <div class="row">
                            <div class="side-bar col-lg-3">
                                <div class="search-hotel">
                                    <h3 class="agileits-sear-head">Search</h3>
                                    <input class="form-control" type="search" name="search" placeholder="Any Keyword" id="frmShoptxtAnyKeyword">
                                    <div class="clearfix"> </div>
                                </div>
                                <div class="search-hotel">
                                    <h3 class="agileits-sear-head">Price range</h3>
                                    <div class="row">
                                        <input class="form-control" type="search" name="search" placeholder="Starting price" id="frmShoptxtStartingPrice">
                                        <input class="form-control" type="search" name="search" placeholder="Ending Price" id="frmShoptxtEndingPrice">
                                    </div>
                                </div>
                                <div class="left-side search-hotel">
                                    <h3 class="agileits-sear-head">For</h3>
                                    <div class="color-quality-right">
                                        <select id="frmShopGenderSelector" style="
                                                width: 100% ; 
                                                text-align-last:left;">
                                            <option>-Selection-</option>
                                            <option>HER</option>
                                            <option>HIM</option>

                                        </select> 
                                    </div>
                                </div>
                                <div class="left-side">
                                    <button class="top_googles_cart fas fa-search" id="frmShopbtnSearch" onclick="searchStockForShop();" style="width: 100%"></button>
                                </div>
                            </div>
                            <div class="left-ads-display col-lg-9">
                                <div class="wrapper_top_shop"id="shopProductContainer" >

                                </div>
                            </div>
                        </div>
                    </div>
            </section>
            <%@ include file="includeFooter.jsp" %>
        </div>
        <script src="js/ViewOperations/jquery-2.2.3.min.js"></script>
        <script src="js/ViewOperations/bootstrap.js"></script>
        <script src="js/ViewOperations/move-top.js"></script>
        <script src="js/ViewOperations/jquery-ui.js"></script>
        <script src="js/ViewOperations/easing.js"></script>
        <script src="js/Ajax/Stock.js" type="text/javascript"></script>
        <script>
                                        jQuery(document).ready(function($) {
                                            $(".scroll").click(function(event) {
                                                event.preventDefault();
                                                $('html,body').animate({
                                                    scrollTop: $(this.hash).offset().top
                                                }, 900);
                                            });
                                        });
        </script>
        <script>
            $(document).ready(function() {

                $().UItoTop({
                    easingType: 'easeOutQuart'
                });

            });
        </script>
    </body>
</html>
