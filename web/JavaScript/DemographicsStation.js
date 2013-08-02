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

function validateHouseNumber() {
    var houseNumber = document.getElementById("houseNumberField").value;
    var na = document.getElementById("houseNumberNA").checked;
    var errorText = "";
    var isValid = true;
    if (houseNumber.length == 0 && !na) {
        errorText = "* required field";
        isValid = false;
    }
    document.getElementById("houseNumberError").innerHTML = errorText;
    var invalid = /['&]/.test(document.getElementById("houseNumberField").value);
    if (invalid) {
        document.getElementById("houseNumberError").innerHTML = "* do not use ' or & ";
        return false;
    }
    return isValid;
}


function houseNA() {
    if (document.getElementById("houseNumberNA").checked) {
        document.getElementById("houseNumberField").disabled = true;
        document.getElementById("houseNumberField").value = "N/A";
    } else {
        document.getElementById("houseNumberField").disabled = false;
        document.getElementById("houseNumberField").value = "";
    }
    validateHouseNumber();
}

function validatePartner() {
    if (document.getElementById('partnerYes').checked) {
        $("#PartnerNameSection").show();
        return true;
    } else if (document.getElementById('partnerNo').checked) {
        $("#PartnerNameSection").hide();
        return true;
    } else {
        document.getElementById("partnerError").innerHTML = "* required field";
        return false;
    }
}

function validatePartnerName() {
    if (document.getElementById('partnerYes').checked) {
        if (document.getElementById("partnerNameField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("partnerNameField").value);
            if (invalid) {
                document.getElementById("partnerNameError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("partnerNameError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("partnerNameError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function getPartner() {
    if (document.getElementById('partnerYes').checked) {
        return "Y";
    } else  {
        return "N";
    }
}

function validateMomName() {
    var name = document.getElementById("momNameField").value;
    if (name.length > 0) {
        var invalid = /['&]/.test(document.getElementById("momNameField").value);
        if (invalid) {
            document.getElementById("momNameError").innerHTML = "* do not use ' or & ";
            return false;
        } else {
            document.getElementById("momNameError").innerHTML = "";
            return true;
        }
    }
    document.getElementById("momNameError").innerHTML = "* required field";
    return false;
}

function validateDadName() {
    var name = document.getElementById("dadNameField").value;
    if (name.length > 0) {
        var invalid = /['&]/.test(document.getElementById("dadNameField").value);
        if (invalid) {
            document.getElementById("dadNameError").innerHTML = "* do not use ' or & ";
            return false;
        } else {
            document.getElementById("dadNameError").innerHTML = "";
            return true;
        }
    }
    document.getElementById("dadNameError").innerHTML = "* required field";
    return false;
}

function validateSchool() {
    var level = document.getElementById('primaryLevel').value;
    if (document.getElementById('schoolYes').checked) {
        $("#PrimaryLevelSection").show();
        $("#ReasonSection").hide();
        document.getElementById("primaryLabel").innerHTML = "Current primary school status:";
        document.getElementById("secondaryLabel").innerHTML = "Current secondary school status:";
        if (/Completed/.test(level)) {
            $("#SecondaryLevelSection").show();
        } else {
            $("#SecondaryLevelSection").hide();
        }
        document.getElementById("schoolError").innerHTML = "";
        return true;
    } else if (document.getElementById('schoolNo').checked) {
        $("#PrimaryLevelSection").show();
        document.getElementById("primaryLabel").innerHTML = "Highest level of primary school completed:";
        document.getElementById("secondaryLabel").innerHTML = "Highest level of secondary school completed:";
        if (/Completed/.test(level)) {
            $("#SecondaryLevelSection").show();
        } else {
            $("#SecondaryLevelSection").hide();
        }
        $("#ReasonSection").show();
        document.getElementById("schoolError").innerHTML = "";
        return true;
    } else if (document.getElementById('schoolYoung').checked) {
        $("#PrimaryLevelSection").hide();
        $("#SecondaryLevelSection").hide();
        $("#ReasonSection").hide();
        document.getElementById("schoolError").innerHTML = "";
        return true;
    } else {
        document.getElementById("schoolError").innerHTML = "* required field";
        return false;
    }
}

function validatePrimaryLevel() {
    if (document.getElementById('schoolYes').checked || document.getElementById('schoolNo').checked) {
        var level = document.getElementById('primaryLevel').value;
        if (/Completed/.test(level)) {
            $("#SecondaryLevelSection").show();
            return true;
        } else if (/Primary/.test(level)) {
            $("#SecondaryLevelSection").hide();
            document.getElementById("primaryLevelError").innerHTML = "* please select a grade level";
            return false;
        } else {
            $("#SecondaryLevelSection").hide();
            document.getElementById("primaryLevelError").innerHTML = "";
            return true;
        }
    } else {
        return true;
    }
}

function validateSecondaryLevel() {
    if (document.getElementById('schoolYes').checked || document.getElementById('schoolNo').checked) {
        var plevel = document.getElementById('primaryLevel').value;
        if (/Completed/.test(plevel)) {
            $("#SecondaryLevelSection").show();
            var slevel = document.getElementById('secondaryLevel').value;
            if (/Secondary/.test(slevel)) {
                document.getElementById("secondaryLevelError").innerHTML = "* select a level since you indicated primary school has been completed";
                return false;
            } else {
                document.getElementById("secondaryLevelError").innerHTML = "";
                return true;
            }
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function validateReason() {
    if (document.getElementById('schoolNo').checked) {
        if (document.getElementById("reasonField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("reasonField").value);
            if (invalid) {
                document.getElementById("reasonError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("reasonError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("reasonError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function getSchool() {
    if (document.getElementById('SchoolYes').checked) {
        return "Yes";
    } else if (document.getElementById('SchoolNo').checked) {
        return "No";
    } else {
        return "Too young";
    }
}

function validateCommunity() {
    if (document.getElementById('communityNo').checked) {
        $("#CommunityNameSection").show();
        $("#CommunityLengthSection").hide();
        return true;
    } else if (document.getElementById('communityYes').checked) {
        $("#CommunityNameSection").hide();
        $("#CommunityLengthSection").show();
        return true;
    } else {
        document.getElementById("communityError").innerHTML = "* required field";
        return false;
    }
}

function validateCommunityName() {
    if (document.getElementById('communityNo').checked) {
        if (document.getElementById("communityNameField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("communityNameField").value);
            if (invalid) {
                document.getElementById("communityNameError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("communityNameError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("communityNameError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateCommunityLength() {
    if (document.getElementById('communityYes').checked) {
        var errorText = " ";
        var isValidated = true;
        var years = parseInt(document.getElementById("communityLengthField").value);
        var valid = false;
        if (years >= 0 && years < 120) {
            valid = true;
        }
        if(!valid){
            errorText = "* must be digits (< 120 years)";
            isValidated = false;
        } else {
            document.getElementById("communityLengthField").value = years;
        }
        document.getElementById("communityLengthError").innerHTML = errorText;
        return isValidated;
    } else {
        return true;
    }
}

function getCommunity() {
    if (document.getElementById('communityYes').checked) {
        return "Y";
    } else  {
        return "N";
    }
}

function validateJob() {
    var job = document.getElementById("jobField").value;
    var errorText = "";
    var isValid = true;
    if (job.length == 0) {
        errorText = "* required field (put \"none\" if they do not have a job)";
        isValid = false;
    }
    document.getElementById("jobError").innerHTML = errorText;
    var invalid = /['&]/.test(document.getElementById("jobField").value);
    if (invalid) {
        document.getElementById("jobError").innerHTML = "* do not use ' or & ";
        return false;
    }
    return isValid;
}

function saveAdultDemographics() {
    if (validateHouseNumber() && validatePartner() && validatePartnerName() && validateJob() && validateCommunity()
        && validateCommunityName() && validateCommunityLength() && validateComment()) {
        var houseNumber = document.getElementById("houseNumberField").value;
        var partner = getPartner();
        var partnerName = document.getElementById("partnerNameField").value;
        var community = getCommunity();
        var communityName = document.getElementById("communityNameField").value;
        var communityLength = document.getElementById("communityLengthField").value;
        var job = document.getElementById("jobField").value;
        var comment = document.getElementById("commentField").value;
        var url = "StationsServlet?station=AdultDemographics&houseNumber=" + houseNumber + "&partner=" + partner + "&partnerName="
        + partnerName + "&community=" + community + "&communityName=" + communityName + "&communityLength=" + communityLength
        + "&job=" + job + "&comment=" + comment;
        save(url, "");
        $("#savedNotification").show(10).delay(2500).hide(10);
    }
    return false;
}

function saveChildDemographics() {
    if (validateHouseNumber() && validateMomName() && validateDadName() && validateSchool() && validatePrimaryLevel()
        && validateSecondaryLevel() && validateReason() && validateComment()) {
        var houseNumber = document.getElementById("houseNumberField").value;
        var momName = document.getElementById("momNameField").value;
        var dadName = document.getElementById("dadNameField").value;
        var comment = document.getElementById("commentField").value;
        var url = "StationsServlet?station=ChildDemographics&houseNumber=" + houseNumber + "&momName=" + momName +
        "&dadName=" + dadName + "&comment=" + comment;
        if (document.getElementById('schoolYoung').checked) {
            var reason2 = "Too young";
            url = url + "&reason=" + reason2;
        } else {
            var primary = document.getElementById('primaryLevel').value;
            var secondary = document.getElementById('secondaryLevel').value;
            url = url + "&primary=" + primary + "&secondary=" + secondary;
            if (document.getElementById('schoolNo').checked) {
                var reason = document.getElementById('reasonField').value;
                url += "&reason=" + reason;
            }
        }
        save(url, "");
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