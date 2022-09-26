function executeProductSave() {
    console.log("access");
    var name = document.getElementById("adminProducttxtName").value;
    var minqty = document.getElementById("adminProducttxtMinQty").value;
    var description = document.getElementById("adminProducttxtDescription").value;
    var volume = document.getElementById("adminProducttxtVolume").value;
    var category = document.getElementById("adminProducttxtSelectCategory").value;
    var gender = document.getElementById("adminProducttxtSelectGender").value;
    var status = document.getElementById("adminProducttxtSelectStatus").value;
    var files = document.getElementById("adminProducttxtFileImages").files;
    if (name == null || name == "", minqty == null || minqty == "", description == null || description == "", volume == null || volume == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (minqty.match(numbers)) {
            var form = new FormData();
            form.append("name", name);
            form.append("minqty", minqty);
            form.append("description", description);
            form.append("volume", volume);
            form.append("category", category);
            form.append("gender", gender);
            form.append("status", status);
            form.append("executeMethod", "save");
            for (var i = 0; i < files.length; i++) {
                form.append("filesInputfrmProduct", files[i]);
            }
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.status === 200 && req.readyState === 4) {
                    alert(req.responseText);
                    executeRetriveAllProductsSelector();
                }
            };
            req.open("POST", "ServExecuteProduct", true);
            req.send(form);
        } else {
            alert("Min Qty contains words");
        }
    }
}
function executeProductUpdate(x) {
    console.log("access");
    var name = document.getElementById(x + "_recyclerProducttxtName").value;
    var minqty = document.getElementById(x + "_recyclerProducttxtMinQty").value;
    var description = document.getElementById(x + "_recyclerProducttxtDescription").value;
    var volume = document.getElementById(x + "_recyclerProducttxtVolume").value;
    var category = document.getElementById(x + "_recyclerProductSelectCategory").value;
    var gender = document.getElementById(x + "_recyclerProductSelectGender").value;
    var status = document.getElementById(x + "_recyclerProductSelectStatus").value;
    var files = document.getElementById(x + "_recyclerProductImageChooser").files;
    if (name == null || name == "", minqty == null || minqty == "", description == null || description == "", volume == null || volume == "", category == null || category == "") {
        alert("please fill all of the fields");
    } else {
        var numbers = /^[0-9]+$/;
        if (minqty.match(numbers)) {
            var form = new FormData();
            form.append("name", name);
            form.append("minqty", minqty);
            form.append("description", description);
            form.append("volume", volume);
            form.append("category", category);
            form.append("idProduct", x);
            form.append("gender", gender);
            form.append("status", status);
            form.append("executeMethod", "update");
            for (var i = 0; i < files.length; i++) {
                form.append("filesInputfrmProduct", files[i]);
            }
            var req = new XMLHttpRequest();
            req.onreadystatechange = function() {
                if (req.status === 200 && req.readyState === 4) {
                    alert(req.responseText);
                    executeRetriveAllProductsSelector();

                }
            };
            req.open("POST", "ServExecuteProduct", true);
            req.send(form);
        } else {
            alert("Min Qty contains words");
        }
    }
}
function executeRetriveValidProductsSelector() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminProductContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteProduct?executeMethod=load_true", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeRetriveAllProductsSelector() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminProductContainer").innerHTML = req.responseText;
        }
    };
    req.open("POST", "ServExecuteProduct?executeMethod=load_all", true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function executeProductSearch() {
    var name = document.getElementById("adminProductSearchtxtName").value;
    var description = document.getElementById("adminProductSearchtxtDescription").value;
    var volume = document.getElementById("adminProductSearchtxtVolume").value;
    var category = document.getElementById("adminProductSearchselectCategory").value;
    var gender = document.getElementById("adminProductSearchselectGender").value;
    var status = document.getElementById("adminProductSearchselectStatus").value;
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            document.getElementById("adminProductContainer").innerHTML = req.responseText;
        }
    };

    var param = "name=" + name + "&description=" + description + "&volume=" + volume + "&category=" + category + "&gender=" + gender + "&status=" + status;
    req.open("POST", "ServExecuteProduct?executeMethod=search&" + param, true);
    req.setRequestHeader("content-type", "application/x-www-form-urlencoded");
    req.send();
}
function downloadImage(idProduct, name) {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if (req.status === 200 && req.readyState === 4) {
            var blob = new Blob([req.response], {type: "image/jpg"});
            console.log(req.response);
            var link = document.createElement("a");
            link.href = window.URL.createObjectURL(blob);
            link.download = name + ".jpg";
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    };
    req.open("POST", "ServExecuteProduct?executeMethod=downloadProductImage&idProduct=" + idProduct, "Download", true);
    req.responseType = "blob";
    req.send();

}
