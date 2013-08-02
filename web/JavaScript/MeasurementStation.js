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

function validateWeight() {
    var weight = parseFloat(document.getElementById("weightField").value).toFixed(1);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (weight >= 1 && weight <= 250) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 1 and 250 kg";
        isValidated =  false;
    } else {
        document.getElementById("weightField").value = weight;
    }
    document.getElementById("weightError").innerHTML = errorText;
    return isValidated;
}

function validateHeight() {
    var height = parseFloat(document.getElementById("heightField").value).toFixed(1);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (height >= 10 && height <= 250) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 10 and 250 cm";
        isValidated =  false;
    } else {
        document.getElementById("heightField").value = height;
    }
    document.getElementById("heightError").innerHTML = errorText;
    return isValidated;
}

function validateHead() {
    var head = parseFloat(document.getElementById("headField").value).toFixed(1);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (head >= 20 && head <= 60) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 20 and 60 cm";
        isValidated =  false;
    } else {
        document.getElementById("headField").value = head;
    }
    document.getElementById("headError").innerHTML = errorText;
    return isValidated;
}

function saveMeasurement() {
    if (validateHeight() && validateWeight() && validateComment()) {
        if ($("#headSection").is(":visible")) {
            if (validateHead()) {
                var height2 = document.getElementById("heightField").value;
                var weight2 = document.getElementById("weightField").value;
                var head = document.getElementById("headField").value;
                var com2 = document.getElementById("commentField").value;
                var url2 = "StationsServlet?station=Measurement&heightField=" + height2 + "&weightField=" + weight2 + "&headField=" + head
                + "&comment=" + com2;
                save(url2);
                $("#savedNotification").show(10).delay(2500).hide(10);
            }
        } else {
            var height = document.getElementById("heightField").value;
            var weight = document.getElementById("weightField").value;
            var com = document.getElementById("commentField").value;
            var url = "StationsServlet?station=Measurement&heightField=" + height + "&weightField=" + weight + "&comment=" + com;
            save(url);
            $("#savedNotification").show(10).delay(2500).hide(10);
        }

    }
    return false;
}

function save(url) {
    document.getElementById('savedNotification').innerHTML = "Saving...";
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (req != undefined) {
        req.onreadystatechange = function() {
            saveDone(url);
        };
        req.open("GET", url, true);
        req.send("");
    }
}

function saveDone(url) {
    if (req.readyState == 4) { // only if req is "loaded"
        if (req.status == 200) { // only if "OK"
            document.getElementById('savedNotification').innerHTML = "Saved!";
            scroll(0,0);
        } else {
            document.getElementById('savedNotification').innerHTML=" AHAH Error:\n" + req.status + "\n" + req.statusText;
        }
    }
}

function calculateBMI() {
    if (validateHeight() && validateWeight()) {
        var height = document.getElementById("heightField").value * .01;
        var weight = document.getElementById("weightField").value;
        var bmi = weight / (height*height);
        bmi = bmi.toFixed(2);
        document.getElementById("BMIError").innerHTML = "";
        var url = "StationsServlet?station=BMI&bmi=" + bmi;
        zscore(url);
    } else {
        document.getElementById("BMIError").innerHTML = "* invalid height and/or weight";
    }
    return false;
}

function zscore(url) {
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (req != undefined) {
        req.onreadystatechange = function() {
            zscoreDone(url);
        };
        req.open("GET", url, true);
        req.send("");
    }
}

function zscoreDone(url) {
    if (req.readyState == 4) { // only if req is "loaded"
        if (req.status == 200) { // only if "OK"
            document.getElementById('bmiSection').innerHTML = req.responseText;
        } else {
            window.alert('error');
        }
    }
}