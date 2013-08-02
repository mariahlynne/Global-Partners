function checkNavigate() {
    var page = document.getElementById('navigate').value;
    if (/Navigate/.test(page)) {
        return false;
    } else {
        return warn();
    }
}

function validateName() {
    var name = document.getElementById('nameField').value;
    if (name.length == 0) {
        document.getElementById("nameError").innerHTML = "* you must enter your name";
        return false;
    }
    document.getElementById('nameError').innerHTML = " ";
    var invalid = /['&]/.test(document.getElementById("nameField").value);
    if (invalid) {
        document.getElementById("nameError").innerHTML = "* do not use ' or & ";
        return false;
    } else {
        document.getElementById("nameError").innerHTML = "";
        return true;
    }
}

function checkHome() {
    if (validateName()) {
        var page = document.getElementById('navigate').value;
        if (/Navigate/.test(page)) {
            return false;
        } else {
            return true;
        }
    }
    return false;
}

function warn() {
    return window.confirm("You may have unsaved changes.");
}