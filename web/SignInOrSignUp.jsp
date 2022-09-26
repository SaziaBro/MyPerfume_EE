<%-- 
    Document   : SignInOrSignUp
    Created on : Nov 18, 2019, 5:00:41 PM
    Author     : YakaMiya
--%>

<%@page import="pojos.User"%>
<%@page import="Utility.FnErrorHandler"%>
<%@page import="controllers.ConUser"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String param = request.getParameter("restore");
        if (param != null) {
            System.out.println(param);
            session.setAttribute("restorePotin", param);
        }
        if (((User) request.getSession().getAttribute("currentUserSession")) != null) {
            response.sendRedirect("index.jsp");
%>
<%
} else {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/credentials.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300,700' rel='stylesheet' type='text/css'>
        <script src="js/ViewOperations/jquery-3.2.1.min.js"></script>


    </head>
    <body style="background:
          linear-gradient(
          rgba(68,59,128,0.75),
          rgba(35,43,85,0.95));">
        <noscript>
        <div style="border: 1px solid purple; padding: 10px">
            <span style="color:red">JavaScript is not enabled!</span>
        </div>
        </noscript>
        <div class="container">
            <div class="frame">
                <div class="nav">
                    <ul class="links">
                        <li class="signin-active"><a class="btn">Sign in</a></li>
                        <li class="signup-inactive"><a class="btn">Sign up </a></li>
                    </ul>
                </div>
                <div ng-app ng-init="checked = false">
                    <div  class="form-signin">

                        <label for="username">Username</label>
                        <input InputGurd  class="form-styling" type="email" id="frmSignintxtUsername" placeholder=""/>
                        <label   for="password">Password</label>
                        <input InputGurd class="form-styling" type="password" id="frmSignintxtpassword" placeholder=""/>
                        <input type="checkbox"  id="checkbox"/>
                        <label for="checkbox" ><span class="ui"></span>Keep me signed in</label>
                        <div class="btn-animate">
                            <button  class="btn-signin" onclick="executeSignIn();">Sign in</button>
                        </div>
                    </div>
                    <div class ="form-signup">
                        <label for="fullname">Full name</label>
                        <input class="form-styling" type="text" id="frmSignuptxtname"  placeholder=""/>
                        <label for="email">Email</label>
                        <input class="form-styling" type="text" id="frmSignuptxtemail" placeholder=""/>
                        <label for="password">Password</label>
                        <input class="form-styling" type="password" id="frmSignuptxtpassword"  placeholder=""/>
                        <label for="confirmpassword">Confirm password</label>
                        <input class="form-styling" type="password" id="frmSignuptxtpassword1" placeholder=""/>
                        <label for="mobilenumber">Mobile Number</label>
                        <input class="form-styling" type="text" id="frmSignuptxtMobileNo" placeholder=""/>
                        <label for="DOB">DOB</label>
                        <input class="form-styling" type="date" id="frmSignupdateDOB"  required pattern="\d{4}-\d{2}-\d{2}">
                        <button ng-click="checked = !checked" onclick="executeSignUp();" class="btn-signup">Sign Up</button>
                    </div>
                </div>
            </div>
        </div>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.3.14/angular.min.js'></script>
        <script  src="js/ViewOperations/credentials.js"></script>
        <script  src="js/ViewOperations/dateChooser.js"></script>
        <script  src="js/Ajax/User.js"></script>
        <script src="js/ViewOperations/InputGurd.js" ></script>
    </body>
</html>
<%
        }
    } catch (NullPointerException n) {
    } catch (Exception e) {
        FnErrorHandler.executeErrorHandler(e);
    }
%>