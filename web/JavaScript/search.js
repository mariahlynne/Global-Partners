function validateSearch() {
    var id = document.getElementById("idField").value;
    var name = document.getElementById("nameField").value;
    var age = document.getElementById("ageField").value;
    var invalid = true;
    var errorText = " ";
    var isValidated = true;
    var ageIsValidated = validateAge(age);
    if (id.length == 0) {
        invalid = false;
    } else {
        invalid = /[^0-9]/.test(id);
    }
    if(invalid){
        errorText = "* id must only contain digits ";
        isValidated =  false;
    }
    document.getElementById("idError").innerHTML = errorText;
    if (isValidated && ageIsValidated) {
        var idURL = "", nameURL = "", ageURL = "";
        if (id.length > 0) {
            idURL = "&idField=" + id;
        } else {
            idURL = "&idField=";
        }
        if (name.length > 0) {
            nameURL = "&nameField=" + name;
        } else {
            nameURL = "&nameField=";
        }
        if (age.length > 0) {
            ageURL = "&ageField=" + age;
        } else {
            ageURL = "&ageField=";
        }
        var url = "StationsServlet?station=Search" + idURL + nameURL + ageURL;
        ahah(url);
    }
}

function validateAge(age) {
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (age.length == 1) {
        valid = /[0-9]/.test(age);
    } else if (age.length == 2) {
        valid = /[1-9][0-9]/.test(age);
    } else if (age.length == 3) {
        valid = /(10[0-9])|(11[0-5])/.test(age);
    } else if (age.length == 0) {
        valid = true;
        isValidated = true;
    }
    if(!valid){
        errorText = "* age must be between 1 and 115 ";
        isValidated =  false;
    }
    document.getElementById("ageError").innerHTML = errorText;
    return isValidated;
}

function ahah(url) {
    document.getElementById('table').innerHTML = ' Loading...';
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (req != undefined) {
        req.onreadystatechange = function() {
            ahahDone(url);
        };
        req.open("GET", url, true);
        req.send("");
    }
}

function ahahDone(url) {
    if (req.readyState == 4) { // only if req is "loaded"
        if (req.status == 200) { // only if "OK"
            document.getElementById('table').innerHTML = req.responseText;
        } else {
            document.getElementById('table').innerHTML= " AHAH Error:\n" + req.status + "\n" + req.statusText;
        }
    }
}