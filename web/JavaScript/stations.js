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

function validateDiastolic() {
    var dia = parseInt(document.getElementById("diastolicField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (dia >= 40 && dia <= 140) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 40 and 140 (no decimals)";
        isValidated =  false;
    } else {
        document.getElementById("diastolicField").value = dia;
    }
    document.getElementById("diastolicError").innerHTML = errorText;
    return isValidated;
}

function validateSystolic() {
    var sys = parseInt(document.getElementById("systolicField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (sys >= 60 && sys <= 220) {
        valid = true;
    }
    if(!valid){
        errorText = "* must be between 60 and 220 (no decimals)";
        isValidated =  false;
    } else {
        document.getElementById("systolicField").value = sys;
    }
    document.getElementById("systolicError").innerHTML = errorText;
    return isValidated;
}

function validateBday() {
    var year = document.getElementById('birth[year]').value;
    var month = document.getElementById('birth[month]').value;
    var day = document.getElementById('birth[day]').value;
    var errorText = " ";
    var isValidated = true;
    var date = new Date();
    var currentYear = date.getYear() + 1900;
    var currentMonth = date.getMonth() + 1;
    if (year == 0) {
        errorText = "* you must select a year";
        isValidated = false;
    } else if (currentYear - year <= 5) {
        if (month == 0) {
            isValidated = false;
            errorText = "* you must select a month because the child may be less than 4 years old"
        } else if ((currentYear - year == 0 && currentMonth - month <= 2) || (currentYear - year == 1 && currentMonth - month <= -10)){
            if (day == 0) {
                isValidated = false;
                errorText = "* you must select a day because the child may be less than 5 weeks old"
            }
        }
    }
    document.getElementById("ageError").innerHTML = errorText;
    return isValidated;
}

function validateName() {
    var name = document.getElementById("nameField").value;
    if (name.length > 0) {
        var invalid = /['&]/.test(document.getElementById("nameField").value);
        if (invalid) {
            document.getElementById("nameError").innerHTML = "* do not use ' or & ";
            return false;
        } else {
            document.getElementById("nameError").innerHTML = "";
            return true;
        }
    }
    document.getElementById("nameError").innerHTML = "* required field";
    return false;
}

function validateSex() {
    if (document.getElementById('male').checked) {
        return true;
    } else if (document.getElementById('female').checked) {
        return true;
    } else {
        document.getElementById("sexError").innerHTML = "* required field";
        return false;
    }
}

function getSex() {
    if (document.getElementById('male').checked) {
        return "M";
    } else  {
        return "F";
    }
}

function validatePresent() {
    var number = parseInt(document.getElementById("presentField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (number >= 0 && number <= 35) {
        valid = true;
    }
    if(!valid){
        errorText = "* please enter a number between 0 and 35";
        isValidated =  false;
    } else {
        document.getElementById("presentField").value = number;
    }
    document.getElementById("presentError").innerHTML = errorText;
    return isValidated;
}

function validateMissing() {
    var number = parseInt(document.getElementById("missingField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (number >= 0 && number <= 35) {
        valid = true;
    }
    if(!valid){
        errorText = "* please enter a number between 0 and 35";
        isValidated =  false;
    } else {
        document.getElementById("missingField").value = number;
    }
    document.getElementById("missingError").innerHTML = errorText;
    return isValidated;
}

function validateDecayed() {
    var number = parseInt(document.getElementById("decayedField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (number >= 0 && number <= 35) {
        valid = true;
    }
    if(!valid){
        errorText = "* please enter a number between 0 and 35";
        isValidated =  false;
    } else {
        document.getElementById("decayedField").value = number;
    }
    document.getElementById("decayedError").innerHTML = errorText;
    return isValidated;
}

function validateFilled() {
    var number = parseInt(document.getElementById("filledField").value);
    var valid = false;
    var errorText = " ";
    var isValidated = true;
    if (number >= 0 && number <= 35) {
        valid = true;
    }
    if(!valid){
        errorText = "* please enter a number between 0 and 35";
        isValidated =  false;
    } else {
        document.getElementById("filledField").value = number;
    }
    document.getElementById("filledError").innerHTML = errorText;
    return isValidated;
}

function saveBP() {
    if (validateDiastolic() && validateSystolic() && validateComment()) {
        var sys = document.getElementById("systolicField").value;
        var dia = document.getElementById("diastolicField").value;
        var com = document.getElementById("commentField").value;
        var url = "StationsServlet?station=BloodPressure&systolicField=" + sys + "&diastolicField=" + dia + "&comment=" + com;
        save(url, "");
        $("#savedNotification").show(10).delay(2500).hide(10);
    }
    return false;
}

function saveDental() {
    if (validatePresent() && validateMissing() && validateDecayed() && validateFilled() && validateComment()) {
        var present = document.getElementById("presentField").value;
        var missing = document.getElementById("missingField").value;
        var decayed = document.getElementById("decayedField").value;
        var filled = document.getElementById("filledField").value;
        var com = document.getElementById("commentField").value;
        var url = "StationsServlet?station=Dental&&comment=" + com + "&present=" + present + "&missing=" + missing
        + "&decayed=" + decayed + "&filled=" + filled;
        save(url, "");
        $("#savedNotification").show(10).delay(2500).hide(10);
    }
    return false;
}

function saveBasics() {
    if (validateBday() && validateSex() && validateName() && validateComment()) {
        var year = document.getElementById("birth[year]").value;
        var month = document.getElementById("birth[month]").value;
        var day = document.getElementById('birth[day]').value;
        var sex = getSex();
        var name = document.getElementById("nameField").value;
        var com = document.getElementById("commentField").value;
        var url = "StationsServlet?station=Basics&year=" + year + "&month=" + month + "&day=" + day + "&sexField=" + sex + "&nameField=" + name + "&comment=" + com;
        save(url, "Basics");
        $("#savedNotification").show(10).delay(2500).hide(10);
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