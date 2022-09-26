<%@page import="FnSecurity.FnDecryptUserLoginCredentials"%>
<%@page import="Utility.FnErrorHandler"%>
<%@page import="controllers.ConUser"%>
<%@page import="pojos.User"%>
<noscript>
<META HTTP-EQUIV="Refresh" CONTENT="0;URL=nojs.jsp">
</noscript>
<header>
    <div class="row">
        <div class="col-md-3 top-info text-left mt-lg-4">
        </div>
        <div class="col-md-6 logo-myCustom text-center">
            <h1 class="logo-myCustom">
                <a class="navbar-brand" href="index.jsp">
                    MyPerfume.lk </a>
            </h1>
        </div>
        <div class="col-md-3 top-info-cart text-right mt-lg-4">
            <ul class="cart-inner-info">
                <%try {
                        if (request.getSession().getAttribute("currentUserSession") != null || ConUser.getConUser().checkUserType(request) != null) {
                            if (request.getSession().getAttribute("currentUserSession") == null && ConUser.getConUser().checkUserType(request) != null) {
                                User user = ConUser.getConUser().checkUserType(request);
                                FnDecryptUserLoginCredentials decryptUserLoginCredentials = FnSecurity.FnDecryptUserLoginCredentials.getInstance();
                                request.getSession().setAttribute("currentUserSession", ConUser.getConUser().executeRetriveUser(String.valueOf(decryptUserLoginCredentials.process(user.getEmail())), String.valueOf(decryptUserLoginCredentials.process(user.getPassword()))));

                            }
                %>
                <button class="top_googles_cart"  style=" margin-right: 35px; margin-top: 5px" onclick="executeLogout();">
                    Logout <span class="fa fa-user" aria-hidden="true"  style=" margin-right: 0px ; margin-left:18px ;" onclick="executeLogout();"></span>
                </button>
                <%if (((User) request.getSession().getAttribute("currentUserSession")).getAccountType().equals("Admin") || (ConUser.getConUser().checkUserType(request)).getAccountType().equals("Admin")) {
                %>
                <button class="top_googles_cart"  style=" margin-right: 35px; margin-top: 5px; width: 140px"  onclick="location.href = 'admin-Orders.jsp'">Admin<span class="fa fa-user" aria-hidden="true"  style=" margin-left:33px ;"  onclick="location.href = 'admin-Orders.jsp'"></span>
                </button>
                <%
                        }
                    }
                    if (request.getSession().getAttribute("currentUserSession") == null) {
                %>
                <button class="top_googles_cart"  style=" margin-right: 35px; margin-top: 5px"  onclick="location.href = 'SignInOrSignUp.jsp'">
                    Signin <span class="fa fa-user" aria-hidden="true"  style=" margin-right: 0px ; margin-left:18px ;"  onclick="location.href = 'SignInOrSignUp.jsp'"></span>
                </button>
                <%
                        }

                    } catch (Exception e) {
                        FnErrorHandler.executeErrorHandler(e);
                    }
                %>
                <li class="galssescart galssescart2 cart cart box_1">
                    <button class="top_googles_cart" type="submit" name="submit" style=" margin-right: 35px; margin-top: 5px" onclick="location.href = 'myCart.jsp'">
                        My Cart
                        <i class="fas fa-cart-arrow-down"></i>
                    </button>
                </li>
            </ul>
        </div>
    </div>
    <label class="top-log mx-auto"></label>
    <nav class="navbar navbar-expand-lg navbar-light bg-light top-header mb-2">
        <button class="navbar-toggler mx-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon">
            </span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav nav-mega mx-auto">
                <li class="nav-item">
                    <a class="nav-link ml-lg-0" href="index.jsp">Home
                        <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="shop.jsp">Shop</a>
                </li>
                <%
                    if (request.getSession().getAttribute("currentUserSession") != null) {
                %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1" role="button" data-toggle="dropdown" aria-haspopup="true"
                       aria-expanded="false">
                        My Preference
                    </a>
                    <ul class="dropdown-menu mega-menu ">
                        <li>
                            <div class="row">
                                <div class="col-md-5 media-list span text-left">
                                    <h5 class="tittle-myCustom-sub">My Account</h5>
                                    <ul>
                                        <li class="media-mini mt-4">
                                            <a href="myOrders.jsp">My Orders</a>
                                        </li>
                                        <li class="media-mini mt-4">
                                            <a href="accountSettings.jsp">Access and security settings</a>
                                        </li>
                                        <li class="media-mini mt-4">
                                            <a href="address.jsp">Addresses</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <hr>
                        </li>
                    </ul>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </nav>
    <script src="js/Ajax/User.js" type="text/javascript"></script>
</header>