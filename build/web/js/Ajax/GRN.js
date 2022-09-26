function executeGRN() {
    console.log("access");
    var name = document.getElementById("adminDraftGRNSupplierSelector").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            alert(req.responseText);

        }
    };
    req.open("POST", "ServExecuteGRN?supplier=" + name + "&executeMethod=submitGRN", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeGRNCartSession() {
    console.log("access");
    var qty = document.getElementById("adminDraftGRNtxtQty").value;
    var price = document.getElementById("adminDraftGRNtxtPrice").value;
    var product = document.getElementById("adminDraftGRNProductSelector").value;
    if (qty == null || qty == "", price == null || price == "", product == null || product == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (qty.match(numbers)) {
            if (price.match(numbers)) {
                var req = new XMLHttpRequest();
                req.onreadystatechange = function() {
                    if (req.status === 200 && req.readyState === 4) {
                        document.getElementById("adminDraftGRNContainer").innerHTML = req.responseText;
                    }
                };
                var param = "product=" + product + "&price=" + price + "&qty=" + qty + "&executeMethod=addToCartSession";
                req.open("POST", "ServExecuteGRN?" + param, true);
                req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
                req.send();
            } else {
                alert("price contains words");
            }
        } else {
            alert("qty contains words");
        }
    }
}
function executeGRNCartSessionOnload() {
    console.log("access");
    var req = new XMLHttpRequest();

    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            var response = req.responseText;
            document.getElementById("adminDraftGRNContainer").innerHTML = response;
        }
    };
    req.open("POST", "ServExecuteGRN?executeMethod=loadGRNCartSessions", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeGRNCartSessionRemove(x) {
    console.log("access");
    var idCartSession = x;
    console.log(idCartSession);
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminDraftGRNContainer").innerHTML = req.responseText;

        }
    };
    req.open("POST", "ServExecuteGRN?idCartSession=" + x + "&executeMethod=deleteItemsCartSession", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeGRNCartSessionUpdate(x) {
    console.log("access");
    var idCartSession = x;
    var qty = document.getElementById(x + "_recyclerAdminCartSessionQty").value;
    console.log(idCartSession);
    var numbers = /^[0-9]+$/;
    if (qty.match(numbers)) {
        var req = new XMLHttpRequest();
        req.onreadystatechange = function() {
            if (req.status === 200 && req.readyState === 4) {
                var response = req.responseText;
                document.getElementById("adminDraftGRNContainer").innerHTML = response;


            }
        };
        req.open("POST", "ServExecuteGRN?idCartSession=" + x + "&executeMethod=updateItemsCartSession&qty=" + qty, true);
        req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
        req.send();
    } else {
        alert("qty contains words");
    }
}

function executeGRNView(x) {
    console.log("access");
    console.log(x);
    window.location = "admin-detailedGrnReport?idGrn=" + x;
}
function executeRetriveValidProductsSelectorForGRNCart() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminDraftGRNProductSelector").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteProduct?executeMethod=load_true&executeLoaction=recyclerProductForGRNCart", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeRetriveValidSupplierSelectorForGRNCart() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminDraftGRNSupplierSelector").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServSupplier?executeMethod=loadValid&executeLoaction=recyclerSupplierForGRNCart", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeRetriveValidSupplierSelectorForGRNSearch() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminGRNSupplierSelector").innerHTML = "<option>-Selection-</option>"+req.responseText;
        }
    };
    req.open("POST", "ServSupplier?executeMethod=loadValid&executeLoaction=recyclerSupplierForGRNCart", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeSearchGRN() {
    var supplier = document.getElementById("adminGRNSupplierSelector").value;
    var fromDate = document.getElementById("adminGRNdateFrom").value;
    var toDate = document.getElementById("adminGRNdateTo").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminGRNTableContainer").innerHTML = req.responseText;
        }
    };
    var param = "supplier=" + supplier + "&fromDateS=" + fromDate + "&toDateS=" + toDate + "&executeMethod=searchGRN&executeLoaction=recyclerGRN";
    req.open("POST", "ServExecuteGRN?" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeGRNload() {
    console.log("access");
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            var response = req.responseText;
            document.getElementById("adminGRNTableContainer").innerHTML = response;
        }
    };
    req.open("POST", "ServExecuteGRN?executeMethod=loadGRN&executeLoaction=recyclerGRN", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function resetGRNFields(){
    document.getElementById("adminGRNdateFrom").value="";
    document.getElementById("adminGRNdateTo").value="";
}