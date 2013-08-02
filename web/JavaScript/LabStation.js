function validateComment() {
    var invalid = /['&]/.test(document.getElementById("commentField").value);
    if (invalid) {
        document.getElementById("commentError").innerHTML = "* do not use ' or & ";
        return false;
    } else {
        document.getElementById("commentError").innerHTML = "";
        return true;
    }
}

function validateHemo() {
    var value = parseFloat(document.getElementById("hemoglobinField").value).toFixed(1);
    var valid = false;
    var errorText = " ";
    var isValidated = false;
    if (value >= 2 && value <= 20) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 2 and 20";
    } else {
        isValidated =  true;
        document.getElementById("hemoglobinField").value = value;
    }
    document.getElementById("hemoError").innerHTML = errorText;
    return isValidated;
}

function validateGlucose() {
    var value = parseInt(document.getElementById("glucoseField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (value >=20 && value <= 600) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 20 and 600";
        isValidated =  false;
    } else {
        document.getElementById("glucoseField").value = value;
    }
    document.getElementById("glucoseError").innerHTML = errorText;
    return isValidated;
}

function saveLabStation() {
    if (validateHemo() && validateComment()) {
        if ($("#glucoseSection").is(":visible")) {
            if (validateGlucose()) {
                var gluc = document.getElementById("glucoseField").value;
                var hemo2 = document.getElementById("hemoglobinField").value;
                var com2 = document.getElementById("commentField").value;
                var url2 = "StationsServlet?station=LabStation&glucoseField=" + gluc + "&hemoglobinField=" + hemo2
                + "&comment=" + com2;
                save(url2, "");
                $("#savedNotification").show(10).delay(2500).hide(10);
            }
        } else {
            var hemo = document.getElementById("hemoglobinField").value;
            var com = document.getElementById("commentField").value;
            var url = "StationsServlet?station=LabStation&hemoglobinField=" + hemo + "&comment=" + com;
            save(url, "");
            $("#savedNotification").show(10).delay(2500).hide(10);
        }
    }
    return false;
}

function save(url, station) {
    document.getElementById('savedNotification').innerHTML = "Saving...";
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (req != undefined) {
        req.onreadystatechange = function() {
            saveDone(url, station);
        };
        req.open("GET", url, true);
        req.send("");
    }
}

function saveDone(url, station) {
    if (req.readyState == 4) { // only if req is "loaded"
        if (req.status == 200) { // only if "OK"
            document.getElementById('savedNotification').innerHTML = "Saved!";
            if (station == "Basics") {
                window.alert("Please note that this patient's id number is: " + req.responseText);
            }
            scroll(0,0);
        } else {
            document.getElementById('savedNotification').innerHTML=" AHAH Error:\n" + req.status + "\n" + req.statusText;
        }
    }
}