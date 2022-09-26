function executeSignIn() {
    console.log("access");
    var email = document.getElementById("frmSignintxtUsername").value;
    var password = document.getElementById("frmSignintxtpassword").value;
    var remMe = document.getElementById("checkbox").value;
    if (email == null || email == "", password == null || password == "") {
        alert("please fill all of the fields");
    } else {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                window.location = "index.jsp";
            }
        };
        var param = "email=" + email + "&password=" + password + "&remMe=" + remMe;
        req.open("POST", "ServExecuteUser?executeMethod=signin&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();
    }
}
function executeSignUp() {
    console.log("access");
    var name = document.getElementById("frmSignuptxtname").value;
    var email = document.getElementById("frmSignuptxtemail").value;
    var password = document.getElementById("frmSignuptxtpassword").value;
    var password1 = document.getElementById("frmSignuptxtpassword1").value;
    var mobileNo = document.getElementById("frmSignuptxtMobileNo").value;
    var dob = document.getElementById("frmSignupdateDOB").value;
    if (name == null || name == "", email == null || email == "", password == null || password == "", password1 == null || password1 == "", mobileNo == null || mobileNo == "", dob == null || dob == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            if ((password.localeCompare(password1)) == 0) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.status === 200 && req.readyState === 4) {
                        alert(req.responseText);
                        window.location = "index.jsp";
                    }
                };
                var param = "name=" + name + "&email=" + email + "&password=" + password + "&mobile=" + mobileNo + "&dob=" + dob;
                req.open("POST", "ServExecuteUser?executeMethod=signup&" + param, true);
                req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
                req.send();
            } else {
                alert("password doesn't match");
            }
        } else {
            alert("Mobile Number contains words");
        }

    }
}
function executeSaveAddress() {
    console.log("access");
    var name = document.getElementById("addresstxtName").value;
    var mobileNo = document.getElementById("addresstxtMobile").value;
    var line1 = document.getElementById("addresstxtLine1").value;
    var line2 = document.getElementById("addresstxtLine2").value;
    var city = document.getElementById("addresstxtCity").value;
    var zipCode = document.getElementById("addresstxtZipCode").value;
    if (name == null || name == "", line1 == null || line1 == "", line2 == null || line2 == "", city == null || city == "", mobileNo == null || mobileNo == "", zipCode == null || zipCode == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            if (zipCode.match(numbers)) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.status === 200 && req.readyState === 4) {
                        alert(req.responseText);
                        loadAddress();
                    }
                };
                var param = "name=" + name + "&mobileNo=" + mobileNo + "&line1=" + line1 + "&line2=" + line2 + "&city=" + city + "&zipCode=" + zipCode;
                req.open("POST", "ServExecuteUser?executeMethod=addAddress&" + param, true);
                req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
                req.send();
            } else {
                alert("zip code contains words");
            }
        } else {
            alert("Mobile Number contains words");
        }
    }
}
function executeLogout() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            window.location = "index.jsp";
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=logout", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function rerouteTOIndex() {
    window.location = "index.jsp";
}
function addtoCart(x) {
    var qty = document.getElementById("frmSiingleProductQtySelector").value;
    if (qty === "hide") {
        alert("please select an amount!");
    } else {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                alert("Added to cart");
            }
        };
        var param = "qty=" + qty + "&idStock=" + x;
        req.open("POST", "ServExecuteUser?executeMethod=addItemstoCart&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();

    }
}
function updateDBCartSession(x) {
    var qty = document.getElementById(x + "_qty").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                alert(req.responseText);
                loadCartContent();
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=updateDBCartSession&qty=" + qty + "&idInvoCartSession=" + x, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function removeDBCartSession(x) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                alert(req.responseText);
                loadCartContent();
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=removeDBCartSession&idInvoCartSession=" + x, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function updateServletCartSession(x) {
    var qty = document.getElementById(x + "_qty").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                alert(req.responseText);
                loadCartContent();
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=updateServketCartSession&qty=" + qty + "&idStock=" + x, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function removeServletCartSession(x) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                alert(req.responseText);
                loadCartContent();
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=removeServketCartSession&idStock=" + x, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function loadCartContent() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                document.getElementById("myCartDetailedContainer").innerHTML = req.responseText;
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=loadCartItemsDetail&executeLocation=recyclerMyCartDetailed", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
//    window.setInterval(loadCartContent, 30000);
    req.send();
}
function loadCartSummeryContent() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                document.getElementById("myCartSummeryContainer").innerHTML = req.responseText;
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=loadCartItemsDetail&executeLocation=recyclerMyCartSummery", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executesignInwithRestore(x) {
    console.log("access");
    console.log(x);
    window.location = "SignInOrSignUp?restore=" + x;
}

function executeAddressUpdate(x) {
    console.log(x);
    console.log("access");
    var name = document.getElementById(x + "_addresstxtName").value;
    var mobileNo = document.getElementById(x + "_addresstxtMobile").value;
    var line1 = document.getElementById(x + "_addresstxtLine1").value;
    var line2 = document.getElementById(x + "_addresstxtLine2").value;
    var city = document.getElementById(x + "_addresstxtCity").value;
    var zipCode = document.getElementById(x + "_addresstxtZipCode").value;
    if (name == null || name == "", line1 == null || line1 == "", line2 == null || line2 == "", city == null || city == "", mobileNo == null || mobileNo == "", zipCode == null || zipCode == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            if (zipCode.match(numbers)) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.status === 200 && req.readyState === 4) {
                        alert(req.responseText);
                        loadAddress();
                    }
                };
                var param = "name=" + name + "&mobileNo=" + mobileNo + "&line1=" + line1 + "&line2=" + line2 + "&city=" + city + "&zipCode=" + zipCode + "&idAddress=" + x;
                req.open("POST", "ServExecuteUser?executeMethod=updateAddress&" + param, true);
                req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
                req.send();
            } else {
                alert("zip code contains words");
            }
        } else {
            alert("Mobile Number contains words");
        }
    }

}

function loadAddressesForCart() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                if (req.responseText.length >= 5) {
                    var responesText = req.responseText;
                    var regex1 = /divStart/gi;
                    var regex2 = /divEnd/gi;
                    responesText = responesText.replace(regex1, "<div class='row'>");
                    responesText = responesText.replace(regex2, "</div>");
                    document.getElementById("myCartAddressContainer").innerHTML = responesText;
                }
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=loadAddressForCart&executeLocation=recyclerAddress", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function loadAddress() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            if (req.responseText != null) {
                var responesText = req.responseText;
                var regex1 = /divStart/gi;
                var regex2 = /divEnd/gi;
                responesText = responesText.replace(regex1, "<div class='row'>");
                responesText = responesText.replace(regex2, "</div>");
                document.getElementById("addressContainer").innerHTML = responesText;
            }
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=loadAddress&executeLocation=recyclerAddress", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeInvoice(transactionId, email, payer_id, status, total, idaddress) {
    console.log("access");
    if (status === 'COMPLETED') {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                if (req.responseText != null) {
                    alert(req.responseText);
                }
            }
        };
        var param = "transactionId=" + transactionId + "&email=" + email + "&payer_id=" + payer_id + "&status=" + status + "&total=" + total + "&idAddress=" + idaddress;
        req.open("POST", "ServExecuteInvoice?executeMethod=executeInvoice&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();
    } else {
        alert("payment is not complete");
    }
}
function executeviewSingleInvoice(idInvoice) {
    console.log("access");
    console.log(idInvoice);
    window.location = "viewSingleInvo.jsp?idInvoice=" + idInvoice;
}
function loadInvoicesOnMyOrders() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("myOrdersTableContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteInvoice?executeMethod=loadInvoicesAll&param=userOnly&executeLocation=recyclermyOrders", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeAddressSaveCart() {
    console.log("access");
    var name = document.getElementById("myCartAddresstxtName").value;
    var mobileNo = document.getElementById("myCartAddresstxtContactNo").value;
    var line1 = document.getElementById("myCartAddresstxtLine1").value;
    var line2 = document.getElementById("myCartAddresstxtLine2").value;
    var city = document.getElementById("myCartAddresstxtCity").value;
    var zipCode = document.getElementById("myCartAddresstxtZipCode").value;
    if (name == null || name == "", line1 == null || line1 == "", line2 == null || line2 == "", city == null || city == "", mobileNo == null || mobileNo == "", zipCode == null || zipCode == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            if (zipCode.match(numbers) && mobileNo.match(numbers)) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.status === 200 && req.readyState === 4) {
                        alert(req.responseText);
                        window.location = "myCart.jsp?idAddress=" + req.responseText;
                    }
                };
                var param = "name=" + name + "&mobileNo=" + mobileNo + "&line1=" + line1 + "&line2=" + line2 + "&city=" + city + "&zipCode=" + zipCode;
                req.open("POST", "ServExecuteUser?executeMethod=addAddressCartMode&" + param, true);
                req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
                req.send();
            } else {
                alert("zip code contains words");
            }
        } else {
            alert("Mobile Number contains words");
        }
    }

}
function resetPaymentFields() {
    document.getElementById("adminPaymentttxtInvoiceID").value = "";
    document.getElementById("adminPaymentttxtPaymentID").value = "";
    document.getElementById("adminPaymentttxtUserName").value = "";
    document.getElementById("adminPaymentttxtPayerEmail").value = "";
    document.getElementById("adminPaymenttdateEnd").value = "";
    document.getElementById("adminPaymenttdateFrom").value = "";
    loadPaymentDetails();

}
function searchPaymentDetails() {
    console.log("access");
    var idInvo = document.getElementById("adminPaymentttxtInvoiceID").value;
    var idPayment = document.getElementById("adminPaymentttxtPaymentID").value;
    var userName = document.getElementById("adminPaymentttxtUserName").value;
    var payerEmail = document.getElementById("adminPaymentttxtPayerEmail").value;
    var dateEnd = document.getElementById("adminPaymenttdateEnd").value;
    var dateFrom = document.getElementById("adminPaymenttdateFrom").value;
    var req = new XMLHttpRequest();
    console.log(idPayment);
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminPaymentTableContainer").innerHTML = req.responseText;
        }
    };
    var param = "idInvo=" + idInvo + "&idPayment=" + idPayment + "&userName=" + userName + "&payerEmail=" + payerEmail + "&dateEnd=" + dateEnd + "&dateFrom=" + dateFrom;
    req.open("POST", "ServExecuteInvoice?executeMethod=searchPayments&executeLocation=recyclerPaymentDetails&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function loadPaymentDetails() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminPaymentTableContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteInvoice?executeMethod=loadPaymentDetails&executeLocation=recyclerPaymentDetails&param=a", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeViewInvoiceAdmin(idPayment) {
    console.log("access");
    window.location = "viewSingleInvoiceAdmin.jsp?idPayment=" + idPayment;
}
function updateUserProfileData(idUser) {
    console.log("access");
    var name = document.getElementById("accountSettingstxtName").value;
    var mobile = document.getElementById("accountSettingstxtMobileNo").value;
    var email = document.getElementById("accountSettingstxtEmail").value;
    var numbers = /^[0-9]+$/;
    if (mobile.match(numbers)) {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                alert(req.responseText);
            }
        };
        var param = "name=" + name + "&mobile=" + mobile + "&email=" + email + "&idUser=" + idUser;
        req.open("POST", "ServExecuteUser?executeMethod=updateProfileData&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();
    }
}
function updateUserProfilePassword(idUser) {
    console.log("access");

    var pass = document.getElementById("accountSettingstxtNewPassword").value;
    var oldPassword = document.getElementById("accountSettingstxtOldPassword").value;
    var retypePass = document.getElementById("accountSettingstxtretypePassword").value;
    if ((pass.localeCompare(retypePass)) == 0) {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                alert(req.responseText);
                document.getElementById("accountSettingstxtNewPassword").value = "";
                document.getElementById("accountSettingstxtOldPassword").value = "";
                document.getElementById("accountSettingstxtretypePassword").value = "";
            }
        };
        var param = "password=" + pass + "&oldPassword=" + oldPassword + "&idUser=" + idUser;
        req.open("POST", "ServExecuteUser?executeMethod=updateProfilePassword&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();

    } else {
        alert("password doesn't match");
    }
}
function loadUsersToAdmin() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminUserAccountsContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteUser?executeMethod=loadUserAdmin&executeLocation=recyclerUserAccountsAdmin", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();

}
function searchUserAdmin() {
    console.log("access");
    var name = document.getElementById("adminAccounttxtName").value;
    var mobileNo = document.getElementById("adminAccounttxtMobileNo").value;
    var accountStatus = document.getElementById("adminAccountselectStatus").value;
    var accountType = document.getElementById("adminAccountselectType").value;

    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            console.log(req.responseText);
            document.getElementById("adminUserAccountsContainer").innerHTML = req.responseText;
        }
    };
    var param = "name=" + name + "&mobileNo=" + mobileNo + "&type=" + accountType + "&status=" + accountStatus;
    req.open("POST", "ServExecuteUser?executeMethod=searchUserAdmin&executeLocation=recyclerUserAccountsAdmin&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();

}
function updateUserAdmin(idUser) {
    console.log("access");
    var name = document.getElementById(idUser + "_adminAccounttxtName").value;
    var mobileNo = document.getElementById(idUser + "_adminAccounttxtMobileNo").value;
    var email = document.getElementById(idUser + "_adminAccounttxtEmail").value;
    var accountStatus = document.getElementById(idUser + "_adminAccountselectStatus").value;
    var accountType = document.getElementById(idUser + "_adminAccountselectType").value;

    var numbers = /^[0-9]+$/;
    if (mobileNo.match(numbers)) {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                alert(req.responseText);
            }
        };
        var param = "name=" + name + "&mobileNo=" + mobileNo + "&email=" + email + "&idUser=" + idUser + "&type=" + accountType + "&status=" + accountStatus;
        req.open("POST", "ServExecuteUser?executeMethod=updateUserAdmin&executeLocation=recyclerUserAccountsAdmin&" + param, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();
    }
}
function clearFieldsUsersAdmin() {
    document.getElementById("adminAccounttxtName").value = "";
    document.getElementById("adminAccounttxtMobileNo").value = "";
    document.getElementById("adminAccounttxtEmail").value = "";
    loadUsersToAdmin();
}
function clearFieldsAdminOrder() {
    document.getElementById("adminOrdersdateEnd").value = "";
    document.getElementById("adminOrdersdateFrom").value = "";
    loadAdminOrders();
}
function loadAdminOrders() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminOrderTableContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteInvoice?executeMethod=loadAdminOrders&executeLocation=recyclerAdminOrder", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function searchAdminOrders() {
    var status = document.getElementById("adminOrderselectStatus").value;
    var fromDate = document.getElementById("adminOrdersdateFrom").value;
    var endDate = document.getElementById("adminOrdersdateEnd").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminOrderTableContainer").innerHTML = req.responseText;
        }
    };
    var param = "status=" + status + "&fromDate=" + fromDate + "&endDate=" + endDate;
    req.open("POST", "ServExecuteInvoice?executeMethod=searchAdminOrders&executeLocation=recyclerAdminOrder&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function updateAdminOrders(idPayment) {
    var status = document.getElementById(idPayment + "_adminOrderselectStatus").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            alert(req.responseText);
        }
    };
    req.open("POST", "ServExecuteInvoice?executeMethod=updateAdminOrders&executeLocation=recyclerAdminOrder&status=" + status + "&idPayment=" + idPayment, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}