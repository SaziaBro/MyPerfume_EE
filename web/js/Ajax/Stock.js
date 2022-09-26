function loadSupplierToStock() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminStockSupplierSelector").innerHTML = "<option>-Selection-</option>" + req.responseText;
        }
    };
    req.open("POST", "ServSupplier?executeMethod=loadValid&executeLoaction=recyclerSupplierForGRNCart", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function updateStock(x) {
    var status = document.getElementById(x + "_SelectStatus").value;
    var sellingPrice = document.getElementById(x + "_txtSellingPrice").value;
    if (status !== "New") {
        var numbers = /^[.0-9]+$/;
        if (sellingPrice.match(numbers)) {
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.status === 200 && req.readyState === 4) {
                    document.getElementById("adminStockTableContainer").innerHTML = req.responseText;
                }
            };
            req.open("POST", "ServExecuteStock?executeMethod=updateStock&executeLocation=recyclerStock&idStock=" + x + "&status=" + status + "&sellingPrice=" + sellingPrice, true);
            req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
            req.send();
        } else {
            alert("Selling price contains words");
        }

    } else {
        alert("Cannot assign `new` for the status");
    }
}
function loadStock() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminStockTableContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteStock?executeMethod=loadStock&executeLocation=recyclerStock", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function loadForIndex() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            var responesText = req.responseText;
            var regex1 = /divStart/gi;
            var regex2 = /divEnd/gi;
            responesText = responesText.replace(regex1, "<div class='row'>");
            responesText = responesText.replace(regex2, "</div>");
            document.getElementById("indexProductContainer").innerHTML = responesText;
        }
    };
    req.open("POST", "ServExecuteStock?executeMethod=loadStockForIndex&executeLocation=recyclerProductContainerClient", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function loadForShop(value) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            var responesText = req.responseText;
            var regex1 = /divStart/gi;
            var regex2 = /divEnd/gi;
            responesText = responesText.replace(regex1, "<div class='row'>");
            responesText = responesText.replace(regex2, "</div>");
            console.log(responesText);
            document.getElementById("shopProductContainer").innerHTML = responesText;
        }
    };
    req.open("POST", "ServExecuteStock?executeMethod=loadStockForShop&executeLocation=recyclerProductContainerClient&pageNo=" + value, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function searchStock() {
    var supplier = document.getElementById("adminStockSupplierSelector").value;
    var fromDate = document.getElementById("adminStockdateFrom").value;
    var toDate = document.getElementById("adminStockdateTo").value;
    var status = document.getElementById("adminStockStatusSelector").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            
            document.getElementById("adminStockTableContainer").innerHTML = req.responseText;
        }
    };
    var param = "supplier=" + supplier + "&fromDates=" + fromDate + "&todates=" + toDate + "&status=" + status;
    req.open("POST", "ServExecuteStock?executeMethod=searchStock&executeLocation=recyclerStock&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function searchStockForShop() {
    var anyKeyword = document.getElementById("frmShoptxtAnyKeyword").value;
    var fromPrice = document.getElementById("frmShoptxtStartingPrice").value;
    var endingPrice = document.getElementById("frmShoptxtEndingPrice").value;
    var gender = document.getElementById("frmShopGenderSelector").value;
    var numbers = /^[.0-9]+$/;
//    if (endingPrice.match(numbers) && endingPrice.match(fromPrice)) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
             var responesText = req.responseText;
            var regex1 = /divStart/gi;
            var regex2 = /divEnd/gi;
            responesText = responesText.replace(regex1, "<div class='row'>");
            responesText = responesText.replace(regex2, "</div>");
            document.getElementById("shopProductContainer").innerHTML = responesText;
        }
    };
    var param = "anyKeyword=" + anyKeyword + "&fromPrice=" + fromPrice + "&endingPrice=" + endingPrice + "&gender=" + gender;
    req.open("POST", "ServExecuteStock?executeMethod=searchStockForShop&executeLocation=recyclerProductContainerClient&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
//    } else {
//        alert("price contains words");
//    }
}
function resetGRNFields() {
    document.getElementById("adminStockSupplierSelector").value = "-Selection-";
    document.getElementById("adminStockdateFrom").value = "";
    document.getElementById("adminStockdateTo").value = "";
    document.getElementById("adminStockStatusSelector").value = "-Selection-";
}
function executeViewSingleProduct(x) {
    console.log("access");
    console.log(x);
    window.location = "singleProduct?idStock=" + x;
}
