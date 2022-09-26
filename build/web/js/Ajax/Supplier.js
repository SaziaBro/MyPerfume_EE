function executeSupplierSave() {
    console.log("access");
    var name = document.getElementById("adminSuppliertxtCompanyName").value;
    var address = document.getElementById("adminSuppliertxtAddress").value;
    var email = document.getElementById("adminSuppliertxtemail").value;
    var mobileNo = document.getElementById("adminSuppliertxtmobile").value;
    var status = document.getElementById("adminSupplierselectStatus").value;
    if (name == null || name == "", email == null || email == "", address == null || address == "", mobileNo == null || mobileNo == "", status == null || status == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.status === 200 && req.readyState === 4) {
                    alert(req.responseText);
                }
            };
            var param = "name=" + name + "&email=" + email + "&address=" + address + "&mobileNo=" + mobileNo + "&status=" + status;
            req.open("POST", "ServSupplier?executeMethod=save&" + param, true);
            req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
            req.send();
        } else {
            alert("Mobile Number contains words");
        }
    }
}
function executeSupplierUpdate(x) {
    console.log("access");
    var name = document.getElementById(x + "_recyclerSuppliertxtCompanyName").value;
    var address = document.getElementById(x + "_recyclerSuppliertxtaddress").value;
    var email = document.getElementById(x + "_recyclerSuppliertxtemail").value;
    var mobileNo = document.getElementById(x + "_recyclerSuppliertxtmobile").value;
    var status = document.getElementById(x + "_recyclerSuppliertxtStatus").value;

    if (name == null || name == "", email == null || email == "", address == null || address == "", mobileNo == null || mobileNo == "", status == null || status == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (mobileNo.match(numbers)) {
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.status === 200 && req.readyState === 4) {
                    executeRetriveAllSuppliers();
                }
            };
            var param = "name=" + name + "&email=" + email + "&address=" + address + "&mobileNo=" + mobileNo + "&status=" + status + "&idSupplier=" + x;
            req.open("POST", "ServSupplier?executeMethod=update&" + param, true);
            req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
            req.send();
        } else {
            alert("Mobile Number contains words");
        }
    }
}
function executeRetriveValidSuppliers() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("frmGRNSaveSelectSupplier").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServSupplier?executeMethod=loadValid", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeRetriveAllSuppliers() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminSupplierContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServSupplier?executeMethod=loadAll", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeSearchSuppliers() {
    console.log("access");
    var name = document.getElementById("adminSupplierSearchtxtCompanyName").value;
    var email = document.getElementById("adminSupplierSearchtxtemail").value;
    var status = document.getElementById("adminSupplierSearchselectStatus").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminSupplierContainer").innerHTML = req.responseText;
        }
    };
    var param = "name=" + name + "&email=" + email + "&status=" + status;
    req.open("POST", "ServSupplier?executeMethod=searchSupplier&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}