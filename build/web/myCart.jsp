<%-- 
    Document   : myCart
    Created on : Nov 19, 2019, 11:18:07 AM
    Author     : YakaMiya
--%>

<%@page import="pojos.Invocartsession"%>
<%@page import="java.util.List"%>
<%@page import="pojos.Stock"%>
<%@page import="org.hibernate.Session"%>
<%@page import="Utility.HibernateCore"%>
<%@page import="org.hibernate.cfg.reveng.DatabaseCollector"%>
<%@page import="Utility.sessionCartItems"%>
<%@page import="java.util.ArrayList"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@ include file="includeHeadTag.jsp" %>
        <link href="css/checkout.css" rel='stylesheet' type='text/css' />
        <%@ include file="includeHeadTag.jsp" %>
    </head>
    <body  oncontextmenu="return false;" onload="loadCartContent();
                loadAddressesForCart();">
        <%@ include file="includeHeader.jsp" %>
        <% String idAddressMain = null;
            int addressCount = 0;
            try {
                if (session.getAttribute("addressCount") != null && !String.valueOf(session.getAttribute("addressCount")).isEmpty()) {
                    addressCount = Integer.parseInt(String.valueOf(session.getAttribute("addressCount")));
                    session.removeAttribute("addressCount");
                }
                if (request.getParameter("idAddress") != null && !request.getParameter("idAddress").isEmpty()) {
                    idAddressMain = request.getParameter("idAddress");
                }
                String total = "";
                session.removeAttribute("restorePotin");
                if (request.getSession().getAttribute("total") != null) {
                    total = String.valueOf((Double) session.getAttribute("total"));
                    System.out.println(total);
                    request.getSession().removeAttribute("total");
                    System.out.println("total removed");
                } else {
                    total = "0.0";
                }

        %>
        <section class="banner-bottom-wthreelayouts py-lg-5 py-3">
            <div class="container">
                <div class="inner-sec-shop px-lg-4 px-3">
                    <h3 class="tittle-myCustom my-lg-4 mt-3">Checkout</h3>
                    <div class="checkout-right">
                        <label id="myCarttxtidAddress"></label>

                        <table class="timetable_sub">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Product</th>
                                    <th>Product Name</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>total</th>
                                    <th>&nbsp;</th>
                                </tr>
                            </thead>
                            <tbody id="myCartDetailedContainer">

                            </tbody>
                        </table>
                        <%                            if (((User) request.getSession().getAttribute("currentUserSession")) != null) {
                        %>
                        <h4 class="tittle-myCustom my-lg-4 mt-3">Address Selection</h4>

                        <div id="myCartAddressContainer">

                        </div>

                        <div  style="margin-top: -10px;margin-left: 150px">
                            <br>
                            <br>
                            <div>
                                <table style="border-collapse:inherit ;border: 1px solid #CDCDCD;border-spacing: 2px;margin-top: 10px;margin-bottom: 10px;margin-left: 150px">
                                    <tbody style="padding: 7px">
                                        <tr>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">Name</label>
                                                <br>
                                                <input id="myCartAddresstxtName" type="text" style="border: 1px solid #CDCDCD" id="">  </td>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">Contact No</label>
                                                <br><input id="myCartAddresstxtContactNo"  type="text" style="border: 1px solid  #CDCDCD" id="" </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">Line 1</label>
                                                <br><input id="myCartAddresstxtLine1"  type="text" style="border: 1px solid  #CDCDCD">  </td>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">Line 2</label>
                                                <br><input id="myCartAddresstxtLine2"  type="text" style="border: 1px solid  #CDCDCD">  </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">City</label>
                                                <br><input id="myCartAddresstxtCity"  type="text" style="border: 1px solid  #CDCDCD" > </td>
                                            <td style="padding: 10px">
                                                <label style="color: #2b2d2d;">Zip Code</label>
                                                <br><input id="myCartAddresstxtZipCode"  type="text" style="border: 1px solid  #CDCDCD" > </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%;"  colspan="2"> <div class="checkout-right-basket"  style="width: 100%;margin: 1em 0em;">
                                                    <a class="btnChekcoutUpdatenRemove" style="width: 100%;color: #ffffff;cursor: default;margin-left: 130px;" onclick="executeAddressSaveCart();">Save & Select</a>
                                                </div> 
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div> 


                            <%
                                if (Double.parseDouble(total) != 0.0 && request.getParameter("idAddress") != null) {
                            %>
                            <script src="https://www.paypal.com/sdk/js?client-id=AaNCdahPJUFdznPMiNSO6cm0X_LoHnjJeAkzjshEr-NCVDSG3q_4PdISkXpWv6sU8Ul6YdX5mHZWOib6&currency=USD&locale=en_LK&commit=false"></script>
                            <script>paypal.Buttons({
                                                                createOrder: function(data, actions) {
                                                                return actions.order.create({
                                                                purchase_units: [{
                                                                amount: {
                                                                value: <%= total%>
                                                                }
                                                                }]
                                                                });
                                                                },
                                                                        onApprove: function(data, actions) {
                                                                        return actions.order.capture().then(function(details) {
                                                                        executeInvoice(details.id, details.payer.email_address, details.payer.payer_id, details.status,<%= total%>,<%= idAddressMain%>);
                                                                        });
                                                                                return actions.order.get().then(function(orderDetails) {
                                                                        console.log(orderDetails);
                                                                                document.querySelector('#confirm-button')
                                                                                .addEventListener('click', function() {
                                                                                return actions.order.capture().then(function() {
                                                                                alert('Transaction complete!');
                                                                                });
                                                                                });
                                                                        });
                                                                        }

                                                                }
                                                                ).render('#paypal-button-container');</script>
                            <div  id="paypal-button-container" style="margin-top: 20px;margin-bottom: 20px"></div>

                            <%
                                }
                            } else {
                                if (request.getSession().getAttribute("currentUserCartItemsArray") != null) {
                                    ArrayList<sessionCartItems> cartItemaArrayList = (ArrayList<sessionCartItems>) request.getSession().getAttribute("currentUserCartItemsArray");
                                    if (cartItemaArrayList.size() > 0) {
                            %>
                            <div class="checkout-left-basket row" style="margin-top: 30px; margin-left: -250%">
                                <a onclick="executesignInwithRestore('myCart.jsp')" style="width: 100%;cursor: default;color: #fff">Sign in to proceed </a>
                            </div>
                            <%               }
                                    }
                                }
                            %>

                        </div>

                    </div>
                </div>
        </section>

        <%
            } catch (Exception e) {
                FnErrorHandler.executeErrorHandler(e);
            }
        %>
        <script>
                    function executeSelectUserAddressForInvoice(idAddress) {
                    console.log('Access');
                            window.location = "myCart.jsp?idAddress=" + idAddress;
                    }
        </script>
        <%@ include file="includeFooter.jsp" %>
        <%@ include file="includeCommanScripTag.jsp" %>
        <script src="js/ViewOperations/myCart.js" type="text/javascript"></script>
        <script>
                    document.onkeydown = function(e) {
                    if (event.keyCode == 123) {
                    return false;
                    }
                    if (e.ctrlKey && e.shiftKey && e.keyCode == 'I'.charCodeAt(0)) {
                    return false;
                    }
                    if (e.ctrlKey && e.shiftKey && e.keyCode == 'J'.charCodeAt(0)) {
                    return false;
                    }
                    if (e.ctrlKey && e.keyCode == 'U'.charCodeAt(0)) {
                    return false;
                    }
                    }
        </script>
        <script>
            document.addEventListener('readystatechange', event = > {

            if (event.target.readyState === "complete") {
            document.addEventListener("contextmenu", function(e){
            e.preventDefault();
            }, false);
                    document.addEventListener("keydown", function(e) {
                    //document.onkeydown = function(e) {
                    // "I" key
                    if (e.ctrlKey && e.shiftKey && e.keyCode == 73) {
                    disabledEvent(e);
                    }
                    // "J" key
                    if (e.ctrlKey && e.shiftKey && e.keyCode == 74) {
                    disabledEvent(e);
                    }
                    // "S" key + macOS
                    if (e.keyCode == 83 && (navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey)) {
                    disabledEvent(e);
                    }
                    // "U" key
                    if (e.ctrlKey && e.keyCode == 85) {
                    disabledEvent(e);
                    }
                    // "F12" key
                    if (event.keyCode == 123) {
                    disabledEvent(e);
                    }
                    }, false);
                    function disabledEvent(e){
                    if (e.stopPropagation){
                    e.stopPropagation();
                    } else if (window.event){
                    window.event.cancelBubble = true;
                    }
                    e.preventDefault();
                            return false;
                    }
            }

            });

        </script>
    </body>
</html>
