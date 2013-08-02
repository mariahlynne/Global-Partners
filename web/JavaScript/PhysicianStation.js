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

function validateTobacco() {
    if (document.getElementById('tobaccoYes').checked) {
        $("#tobaccoSection").show();
        document.getElementById("tobaccoError").innerHTML = "";
        return true;
    } else if (document.getElementById('tobaccoNo').checked) {
        $("#tobaccoSection").hide();
        document.getElementById("tobaccoError").innerHTML = "";
        return true;
    } else {
        document.getElementById("tobaccoError").innerHTML = "* required field";
        return false;
    }
}

function validateTobaccoAmount() {
    if (document.getElementById('tobaccoYes').checked) {
        var amount = document.getElementById('tobaccoAmount').value;
        if (/Amount/.test(amount)) {
            document.getElementById("tobaccoSectionError").innerHTML = "* please select an amount";
            return false;
        } else {
            document.getElementById("tobaccoSectionError").innerHTML = "";
            return true;
        }
    }
    else {
        return true;
    }
}

function getTobacco() {
    if (document.getElementById('tobaccoYes').checked) {
        return "Yes";
    } else  {
        return "No";
    }
}

function validateNumberPregnancies() {
    var number = document.getElementById('numberPregnancies').value;
    if (/Number/.test(number)) {
        document.getElementById("numberPregnanciesError").innerHTML = "* please select a number";
        return false;
    } else {
        document.getElementById("numberPregnanciesError").innerHTML = "";
        return true;
    }
}

function updateNumberPregnancies(page) {
    var number = document.getElementById('numberPregnancies').value;
    if (/Number/.test(number)) {
        document.getElementById("numberPregnanciesError").innerHTML = "* please select a number";
        return false;
    } else {
        if (number == 0) {
            $("#deadSection").hide();
            document.getElementById('numberDead').value = 0;
            $("#deathsSection").hide();
        } else {
            var options = "<option value=\"Number\">Number</option>", ndx;
            if (page == "teen") {
                for (ndx = 0; ndx <= 10; ndx++) {
                    options += "<option value=\"" + ndx + "\">" + ndx + "</option>";
                }
            } else {
                for (ndx = 0; ndx <= 15; ndx++) {
                    options += "<option value=\"" + ndx + "\">" + ndx + "</option>";
                }
                $("#deadSection").show();
                document.getElementById('numberDead').innerHTML = options;
            }
        }
        document.getElementById("numberPregnanciesError").innerHTML = "";
        return true;
    }
}

function validateNumberDead() {
    var number = document.getElementById('numberDead').value;
    if (/Number/.test(number)) {
        $("#deathsSection").hide();
        document.getElementById("numberDeadError").innerHTML = "* please select a number";
        return false;
    } else {
        document.getElementById("numberDeadError").innerHTML = "";
        if (number == 0) {
            $("#deathsSection").hide();
        } else {
            $("#deathsSection").show();
        }
        return true;
    }
}

function validateDeaths() {
    var number = document.getElementById('numberDead').value;
    if (number >= 1) {
        if (document.getElementById("deathsField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("deathsField").value);
            if (invalid) {
                document.getElementById("deathsError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("deathsError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("deathsError").innerHTML = "* required field";
            return false;
        }
    } else {
        document.getElementById("deathsError").innerHTML = "";
        return true;
    }
}

function validateContraception() {
    if (document.getElementById('contraceptionYes').checked) {
        $("#contraceptionSection").show();
        $("#contraceptionNASection").hide();
        var type = document.getElementById('contraceptionType').value;
        if (/Type/.test(type)) {
            document.getElementById("contraceptionSectionError").innerHTML = "* please select a type";
            return false;
        } else if (type == "Other") {
            if (!$("#otherSection").is(":visible")) {
                $("#otherSection").show();
            }
        } else {
            $("#otherSection").hide();
        }
        document.getElementById("contraceptionError").innerHTML = "";
        return true;
    } else if (document.getElementById('contraceptionNo').checked) {
        $("#contraceptionSection").hide();
        $("#otherSection").hide();
        $("#contraceptionNASection").hide();
        document.getElementById("contraceptionError").innerHTML = "";
        return true;
    } else if(document.getElementById('contraceptionNA').checked) {
        $("#contraceptionSection").hide();
        $("#otherSection").hide();
        document.getElementById("contraceptionError").innerHTML = "";
        $("#contraceptionNASection").show();
        return true;
    } else {
        document.getElementById("contraceptionError").innerHTML = "* required field";
        return false;
    }
}

function validateContraceptionNA() {
    var invalid = /['&]/.test(document.getElementById("contraceptionNAField").value);
    if (invalid) {
        document.getElementById("contraceptionNAError").innerHTML = "* do not use ' or & ";
        return false;
    } else {
        document.getElementById("contraceptionNAError").innerHTML = "";
        return true;
    }
}

function validateContraceptionType() {
    if (document.getElementById('contraceptionYes').checked) {
        var type = document.getElementById('contraceptionType').value;
        if (/Type/.test(type)) {
            document.getElementById("contraceptionSectionError").innerHTML = "* please select a type";
            return false;
        } else if (type == "Other") {
            if (!$("#otherSection").is(":visible")) {
                $("#otherSection").show();
            }
        } else {
            $("#otherSection").hide();
        }
        document.getElementById("contraceptionSectionError").innerHTML = "";
        return true;
    } else {
        return true;
    }
}

function validateOther() {
    if ($("#otherSection").is(":visible")) {
        if (document.getElementById('contraceptionType').value == "Other") {
            if (document.getElementById("otherField").value.length > 0) {
                var invalid = /['&]/.test(document.getElementById("otherField").value);
                if (invalid) {
                    document.getElementById("otherError").innerHTML = "* do not use ' or & ";
                    return false;
                } else {
                    document.getElementById("otherError").innerHTML = "";
                    return true;
                }
            } else {
                document.getElementById("otherError").innerHTML = "* required field";
                return false;
            }
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function validateMoreChildren() {
    if (document.getElementById('moreChildrenYes').checked) {
        document.getElementById("moreChildrenError").innerHTML = "";
        return true;
    } else if (document.getElementById('moreChildrenNo').checked) {
        document.getElementById("moreChildrenError").innerHTML = "";
        return true;
    } else {
        document.getElementById("moreChildrenError").innerHTML = "* required field";
        return false;
    }
}

function validateWantContraception() {
    if (document.getElementById('wantContraceptionYes').checked) {
        return true;
    } else if (document.getElementById('wantContraceptionNo').checked) {
        return true;
    } else {
        document.getElementById("wantContraceptionError").innerHTML = "* required field";
        return false;
    }
}

function validateAvailable() {
    if (document.getElementById('availableYes').checked) {
        return true;
    } else if (document.getElementById('availableNo').checked) {
        return true;
    } else {
        document.getElementById("availableError").innerHTML = "* required field";
        return false;
    }
}

function validateHealthy() {
    if (document.getElementById('healthyYes').checked) {
        $("#healthyReasonSection").hide();
        document.getElementById("healthyError").innerHTML = "";
        return true;
    } else if (document.getElementById('healthyNo').checked) {
        $("#healthyReasonSection").show();
        document.getElementById("healthyError").innerHTML = "";
        return true;
    } else {
        document.getElementById("healthyError").innerHTML = "* required field";
        return false;
    }
}

function validateHealthyReason() {
    if (document.getElementById('healthyNo').checked) {
        if (document.getElementById("healthyReasonField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("healthyReasonField").value);
            if (invalid) {
                document.getElementById("healthyReasonError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("healthyReasonError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("healthyReasonError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateHeart() {
    if (document.getElementById('heartYes').checked) {
        $("#heartReasonSection").hide();
        document.getElementById("heartError").innerHTML = "";
        return true;
    } else if (document.getElementById('heartNo').checked) {
        $("#heartReasonSection").show();
        document.getElementById("heartError").innerHTML = "";
        return true;
    } else {
        document.getElementById("heartError").innerHTML = "* required field";
        return false;
    }
}

function validateHeartReason() {
    if (document.getElementById('heartNo').checked) {
        if (document.getElementById("heartReasonField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("heartReasonField").value);
            if (invalid) {
                document.getElementById("heartReasonError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("heartReasonError").innerHTML = "";
                return true;
            }
            document.getElementById("heartReasonError").innerHTML = " ";
            return true;
        } else {
            document.getElementById("heartReasonError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateLungs() {
    if (document.getElementById('lungsYes').checked) {
        $("#lungsReasonSection").hide();
        document.getElementById("lungsError").innerHTML = "";
        return true;
    } else if (document.getElementById('lungsNo').checked) {
        $("#lungsReasonSection").show();
        document.getElementById("lungsError").innerHTML = "";
        return true;
    } else {
        document.getElementById("lungsError").innerHTML = "* required field";
        return false;
    }
}

function validateLungsReason() {
    if (document.getElementById('lungsNo').checked) {
        if (document.getElementById("lungsReasonField").value.length > 0) {
            var invalid = /['&]/.test(document.getElementById("lungsReasonField").value);
            if (invalid) {
                document.getElementById("lungsReasonError").innerHTML = "* do not use ' or & ";
                return false;
            } else {
                document.getElementById("lungsReasonError").innerHTML = "";
                return true;
            }
        } else {
            document.getElementById("lungsReasonError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateBornHome() {
    if (document.getElementById('bornHomeYes').checked) {
        $("#bornHomeSection").show();
        $("#helpAfterBirthSection").show();
        var attended = document.getElementById('bornHomeHelp').value;
        if (attended == "Attended") {
            document.getElementById("bornHomeError").innerHTML = "";
            document.getElementById("bornHomeSectionError").innerHTML = "* please select who attended the birth";
            return false;
        } else if (attended == "Other") {
            if (!$("#attendedOtherSection").is(":visible")) {
                $("#attendedOtherSection").show();
            }
        } else {
            $("#attendedOtherSection").hide();
        }
        document.getElementById("bornHomeSectionError").innerHTML = "";
        document.getElementById("bornHomeError").innerHTML = "";
        return true;
    } else if (document.getElementById('bornHomeNo').checked) {
        $("#helpAfterBirthSection").hide();
        $("#bornHomeSection").hide();
        $("#attendedOtherSection").hide();
        document.getElementById("bornHomeError").innerHTML = "";
        return true;
    } else {
        document.getElementById("bornHomeError").innerHTML = "* required field";
        return false;
    }
}

function validateBornHomeHelp() {
    if (document.getElementById('bornHomeYes').checked) {
        var attended = document.getElementById('bornHomeHelp').value;
        if (attended == "Attended") {
            document.getElementById("bornHomeSectionError").innerHTML = "* please select who attended the birth";
            return false;
        } else if (attended == "Other") {
            if (!$("#attendedOtherSection").is(":visible")) {
                $("#attendedOtherSection").show();
            }
        } else {
            $("#attendedOtherSection").hide();
        }
        document.getElementById("bornHomeSectionError").innerHTML = "";
        return true;
    } else {
        return true;
    }
}

function validateAttendedOther() {
    if ($("#attendedOtherSection").is(":visible")) {
        if (document.getElementById('bornHomeHelp').value == "Other") {
            if (document.getElementById("attendedOtherField").value.length > 0) {
                var invalid = /['&]/.test(document.getElementById("attendedOtherField").value);
                if (invalid) {
                    document.getElementById("attendedOtherError").innerHTML = "* do not use ' or & ";
                    return false;
                } else {
                    document.getElementById("attendedOtherError").innerHTML = "";
                    return true;
                }
            } else {
                document.getElementById("attendedOtherError").innerHTML = "* required field";
                return false;
            }
        } else {
            return true;
        }
    } else {
        return true;
    }
}

function validatePremature() {
    if (document.getElementById('prematureYes').checked) {
        $("#prematureWeeksSection").show();
    } else if (document.getElementById('prematureNo').checked) {
        $("#prematureWeeksSection").hide();
    } else {
        document.getElementById("prematureError").innerHTML = "* required field";
        return false;
    }
    document.getElementById("prematureError").innerHTML = "";
    return true;
}

function validatePrematureWeeks() {
    if (document.getElementById('prematureYes').checked) {
        var weeks = document.getElementById("prematureWeeks").value;
        if (weeks.length > 0) {
            if (/([1-9])|(1[0-9])/.test(weeks)) {
                document.getElementById("prematureWeeksError").innerHTML = " ";
                return true;
            }
            else {
                document.getElementById("prematureWeeksError").innerHTML = "* please enter a number between 1 and 19";
                return false;
            }
        } else {
            document.getElementById("prematureWeeksError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateHelpAfterBirth() {
    if ($("#helpAfterBirthSection").is(":visible")) {
        if (document.getElementById('helpAfterBirthYes').checked || document.getElementById('helpAfterBirthNo').checked) {
            document.getElementById("helpAfterBirthError").innerHTML = "";
            return true;
        } else {
            document.getElementById("helpAfterBirthError").innerHTML = "* required field";
            return false;
        }
    } else {
        return true;
    }
}

function validateDiarrhea() {
    if (document.getElementById('diarrheaYes').checked || document.getElementById('diarrheaNo').checked) {
        document.getElementById("diarrheaError").innerHTML = "";
        return true;
    } else {
        document.getElementById("diarrheaError").innerHTML = "* required field";
        return false;
    }
}

function validateAsthma() {
    if (document.getElementById('asthmaYes').checked || document.getElementById('asthmaNo').checked) {
        document.getElementById("asthmaError").innerHTML = "";
        return true;
    } else {
        document.getElementById("asthmaError").innerHTML = "* required field";
        return false;
    }
}
//
//function validateWheezing() {
//    if (document.getElementById('wheezingYes').checked || document.getElementById('wheezingNo').checked) {
//        document.getElementById("wheezingError").innerHTML = "";
//        return true;
//    } else {
//        document.getElementById("wheezingError").innerHTML = "* required field";
//        return false;
//    }
//}

function validateCoughing() {
    if (document.getElementById('coughingYes').checked || document.getElementById('coughingNo').checked) {
        document.getElementById("coughingError").innerHTML = "";
        return true;
    } else {
        document.getElementById("coughingError").innerHTML = "* required field";
        return false;
    }
}

function validateNightCoughing() {
    if (document.getElementById('nightCoughingYes').checked || document.getElementById('nightCoughingNo').checked) {
        document.getElementById("nightCoughingError").innerHTML = "";
        return true;
    } else {
        document.getElementById("nightCoughingError").innerHTML = "* required field";
        return false;
    }
}

function validateBreathing() {
    if (document.getElementById('breathingYes').checked || document.getElementById('breathingNo').checked) {
        document.getElementById("breathingError").innerHTML = "";
        return true;
    } else {
        document.getElementById("breathingError").innerHTML = "* required field";
        return false;
    }
}

function validateAbdominal() {
    if (document.getElementById('abdominalYes').checked || document.getElementById('abdominalNo').checked) {
        document.getElementById("abdominalError").innerHTML = "";
        return true;
    } else {
        document.getElementById("abdominalError").innerHTML = "* required field";
        return false;
    }
}

function validateScars() {
    if (document.getElementById('scarsYes').checked || document.getElementById('scarsNo').checked) {
        document.getElementById("scarsError").innerHTML = "";
        return true;
    } else {
        document.getElementById("scarsError").innerHTML = "* required field";
        return false;
    }
}

function validatePregnant() {
    if (document.getElementById('pregnantYes').checked) {
        $("#femaleSection").show();
    } else if (document.getElementById('pregnantNo').checked) {
        $("#femaleSection").hide();
    } else {
        document.getElementById("pregnantError").innerHTML = "* required field";
        return false;
    }
    document.getElementById("pregnantError").innerHTML = "";
    return true;
}

function saveAdultPhysicianStation() {
    if (validateTobacco() && validateTobaccoAmount() && validateHealthy() && validateHealthyReason() && validateHeart()
        && validateHeartReason() && validateLungs() && validateLungsReason() && validateComment()) {
        var tobacco = getTobacco();
        var tobaccoAmount = document.getElementById('tobaccoAmount').value;
        var comment = document.getElementById("commentField").value;
        var url = "StationsServlet?station=AdultPhysician&tobacco=" + tobacco + "&tobaccoAmount=" + tobaccoAmount + "&comment=" + comment;
        var healthy;
        if (document.getElementById('healthyYes').checked) {
            healthy = "Yes";
        } else  {
            healthy = "No";
            var healthyReason = document.getElementById("healthyReasonField").value;
            url = url + "&healthyReason=" + healthyReason;
        }
        var heart;
        if (document.getElementById('heartYes').checked) {
            heart = "Yes";
        } else  {
            heart = "No";
            var heartReason = document.getElementById("heartReasonField").value;
            url = url + "&heartReason=" + heartReason;
        }
        var lungs;
        if (document.getElementById('lungsYes').checked) {
            lungs = "Yes";
        } else  {
            lungs = "No";
            var lungsReason = document.getElementById("lungsReasonField").value;
            url = url + "&lungsReason=" + lungsReason;
        }
        url = url + "&healthy=" + healthy + "&heart=" + heart + "&lungs=" + lungs;
        if ($("#femaleSection").is(":visible")) {
            if (validateMoreChildren() && validateWantContraception() && validateNumberPregnancies()
                && validateNumberDead() && validateDeaths() && validateContraception()
                && validateContraceptionType() && validateOther()) {
                var pregnancies = document.getElementById('numberPregnancies').value;
                var dead = document.getElementById('numberDead').value;
                var reasons = document.getElementById('deathsField').value;
                var contraception;
                var type = "";
                var other = "";
                if (document.getElementById('contraceptionYes').checked) {
                    contraception = "Yes";
                    type = document.getElementById('contraceptionType').value;
                    if (type == "Other") {
                        other = document.getElementById('otherField').value;
                    }
                } else if (document.getElementById('contraceptionNo').checked) {
                    contraception = "No";
                } else {
                    contraception = "N/A: " + document.getElementById('contraceptionNAField').value;
                }
                var moreChildren;
                if (document.getElementById('moreChildrenYes').checked) {
                    moreChildren = "Yes";
                } else  {
                    moreChildren = "No";
                }
                var wantContraception;
                if (document.getElementById('wantContraceptionYes').checked) {
                    wantContraception = "Yes";
                } else  {
                    wantContraception = "No";
                }
                if ($("#availableSection").is(":visible")) {
                    if (!validateAvailable()) {
                        return false;
                    } else {
                        if (document.getElementById('availableYes').checked) {
                            url += "&available=Yes";
                        } else {
                            url += "&available=No";
                        }
                    }
                }
                url = url + "&pregnancies=" + pregnancies + "&dead=" + dead + "&reasons=" + reasons
                + "&contraception=" + contraception + "&type=" + type + "&other=" + other + "&sex=female&moreChildren="
                + moreChildren + "&wantContraception=" + wantContraception;
                save(url, "");
                $("#savedNotification").show(10).delay(2500).hide(10);
            }
        } else {
            save(url, "");
            $("#savedNotification").show(10).delay(2500).hide(10);
        }
    }
    return false;
}

function saveTeenFemalePhysicianStation() {
    if (validateBornHome() && validateBornHomeHelp() && validatePremature() && validatePrematureWeeks() && validateHelpAfterBirth()
        && validateAsthma() /*&& validateWheezing()*/ && validateCoughing() && validateNightCoughing() && validateBreathing()
        && validatePregnant() && validateContraception() && validateContraceptionType() && validateOther() &&
        validateHealthy() && validateHealthyReason() && validateHeart() && validateHeartReason() && validateLungs() &&
        validateLungsReason() && validateAbdominal() && validateScars() && validateComment()) {
        var url = "StationsServlet?station=TeenFemalePhysicianStation&comment=" + document.getElementById("commentField").value;
        var bornHome;
        if (document.getElementById('bornHomeYes').checked) {
            bornHome = "Yes: " + document.getElementById('bornHomeHelp').value;
            if (document.getElementById('bornHomeHelp').value == "Other") {
                bornHome += "-" + document.getElementById('attendedOtherField').value;
            }
        } else  {
            bornHome = "No";
        }
        url += "&bornHome=" + bornHome;
        if (document.getElementById('prematureYes').checked) {
            url += "&premature=Yes: " + document.getElementById('prematureWeeks').value + " weeks early";
        } else {
            url += "&premature=No";
        }
        if ($("#helpAfterBirthSection").is(":visible")) {
            if (!validateHelpAfterBirth()) {
                return false;
            } else {
                if (document.getElementById('helpAfterBirthYes').checked) {
                    url += "&helpAfterBirth=Yes";
                } else {
                    url += "&helpAfterBirth=No";
                }
            }
        }
        if (document.getElementById('asthmaYes').checked) {
            url += "&asthma=Yes";
        } else {
            url += "&asthma=No";
        }
        //        if (document.getElementById('wheezingYes').checked) {
        //            url += "&wheezing=Yes";
        //        } else {
        //            url += "&wheezing=No";
        //        }
        if (document.getElementById('coughingYes').checked) {
            url += "&coughing=Yes";
        } else {
            url += "&coughing=No";
        }
        if (document.getElementById('nightCoughingYes').checked) {
            url += "&nightCoughing=Yes";
        } else {
            url += "&nightCoughing=No";
        }
        if (document.getElementById('breathingYes').checked) {
            url += "&breathing=Yes";
        } else{
            url += "&breathing=No";
        }
        if (document.getElementById('abdominalYes').checked) {
            url += "&abdominal=Yes";
        } else {
            url += "&abdominal=No";
        }
        if (document.getElementById('scarsYes').checked) {
            url += "&scars=Yes";
        } else {
            url += "&scars=No";
        }
        var healthy;
        if (document.getElementById('healthyYes').checked) {
            healthy = "Yes";
        } else  {
            healthy = "No";
            url += "&healthyReason=" + document.getElementById("healthyReasonField").value;
        }
        var heart;
        if (document.getElementById('heartYes').checked) {
            heart = "Yes";
        } else  {
            heart = "No";
            url += "&heartReason=" + document.getElementById("heartReasonField").value;
        }
        var lungs;
        if (document.getElementById('lungsYes').checked) {
            lungs = "Yes";
        } else  {
            lungs = "No";
            url += "&lungsReason=" + document.getElementById("lungsReasonField").value;
        }
        url += "&healthy=" + healthy + "&heart=" + heart + "&lungs=" + lungs;
        if (document.getElementById('pregnantYes').checked) {
            url += "&pregnant=Yes";
        } else {
            url += "&pregnant=No";
        }
        var contraception;
        var type = "";
        var other = "";
        if (document.getElementById('contraceptionYes').checked) {
            contraception = "Yes";
            type = document.getElementById('contraceptionType').value;
            if (type == "Other") {
                other = document.getElementById('otherField').value;
            }
        } else  {
            contraception = "No";
        }
        url += "&contraception=" + contraception + "&type=" + type + "&other=" + other;
        if ($("#femaleSection").is(":visible")) {
            if (validateMoreChildren() && validateWantContraception() && validateAvailable() && validateNumberPregnancies()
                && validateNumberDead() && validateDeaths() && validateContraception()
                && validateContraceptionType() && validateOther()) {
                var pregnancies = document.getElementById('numberPregnancies').value;
                var dead = document.getElementById('numberDead').value;
                var reasons = document.getElementById('deathsField').value;
                var moreChildren;
                if (document.getElementById('moreChildrenYes').checked) {
                    moreChildren = "Yes";
                } else  {
                    moreChildren = "No";
                }
                var wantContraception;
                if (document.getElementById('wantContraceptionYes').checked) {
                    wantContraception = "Yes";
                } else  {
                    wantContraception = "No";
                }
                var available;
                if (document.getElementById('availableYes').checked) {
                    available = "Yes";
                } else  {
                    available = "No";
                }
                url += "&pregnancies=" + pregnancies + "&dead=" + dead + "&reasons=" + reasons
                + "&sex=female&available="
                + available + "&moreChildren=" + moreChildren + "&wantContraception=" + wantContraception;
                save(url, "");
                $("#savedNotification").show(10).delay(2500).hide(10);
            }
        } else {
            save(url, "");
            $("#savedNotification").show(10).delay(2500).hide(10);
        }
    }
    return false;
}

function saveChildPhysicianStation() {
    if (validateBornHome() && validateBornHomeHelp() && validatePremature() && validatePrematureWeeks() && validateHelpAfterBirth()
        && validateAsthma() /*&& validateWheezing()*/ && validateCoughing() && validateNightCoughing() && validateBreathing()
        && validateHealthy() && validateHealthyReason() && validateHeart() && validateHeartReason() && validateLungs() &&
        validateLungsReason() && validateAbdominal() && validateScars() && validateComment()) {
        var url = "StationsServlet?station=ChildPhysicianStation&comment=" + document.getElementById("commentField").value;
        var bornHome;
        if (document.getElementById('bornHomeYes').checked) {
            bornHome = "Yes: " + document.getElementById('bornHomeHelp').value;
            if (document.getElementById('bornHomeHelp').value == "Other") {
                bornHome += "-" + document.getElementById('attendedOtherField').value;
            }
        } else  {
            bornHome = "No";
        }
        url += "&bornHome=" + bornHome;
        if (document.getElementById('prematureYes').checked) {
            url += "&premature=Yes: " + document.getElementById('prematureWeeks').value + " weeks early";
        } else {
            url += "&premature=No";
        }
        if ($("#helpAfterBirthSection").is(":visible")) {
            if (!validateHelpAfterBirth()) {
                return false;
            } else {
                if (document.getElementById('helpAfterBirthYes').checked) {
                    url += "&helpAfterBirth=Yes";
                } else {
                    url += "&helpAfterBirth=No";
                }
            }
        }
        if (document.getElementById('asthmaYes').checked) {
            url += "&asthma=Yes";
        } else {
            url += "&asthma=No";
        }
        //        if (document.getElementById('wheezingYes').checked) {
        //            url += "&wheezing=Yes";
        //        } else {
        //            url += "&wheezing=No";
        //        }
        if (document.getElementById('coughingYes').checked) {
            url += "&coughing=Yes";
        } else {
            url += "&coughing=No";
        }
        if (document.getElementById('nightCoughingYes').checked) {
            url += "&nightCoughing=Yes";
        } else {
            url += "&nightCoughing=No";
        }
        if (document.getElementById('breathingYes').checked) {
            url += "&breathing=Yes";
        } else{
            url += "&breathing=No";
        }
        if (document.getElementById('abdominalYes').checked) {
            url += "&abdominal=Yes";
        } else {
            url += "&abdominal=No";
        }
        if (document.getElementById('scarsYes').checked) {
            url += "&scars=Yes";
        } else {
            url += "&scars=No";
        }
        if ($("#diarrheaSection").is(":visible")) {
            if (!validateDiarrhea()) {
                return false;
            } else {
                if (document.getElementById('diarrheaYes').checked) {
                    url += "&diarrhea=Yes";
                } else {
                    url += "&diarrhea=No";
                }
            }
        }
        var healthy;
        if (document.getElementById('healthyYes').checked) {
            healthy = "Yes";
        } else  {
            healthy = "No";
            url = url + "&healthyReason=" + document.getElementById("healthyReasonField").value;
        }
        var heart;
        if (document.getElementById('heartYes').checked) {
            heart = "Yes";
        } else  {
            heart = "No";
            url = url + "&heartReason=" + document.getElementById("heartReasonField").value;
        }
        var lungs;
        if (document.getElementById('lungsYes').checked) {
            lungs = "Yes";
        } else  {
            lungs = "No";
            url = url + "&lungsReason=" + document.getElementById("lungsReasonField").value;
        }
        url += "&healthy=" + healthy + "&heart=" + heart + "&lungs=" + lungs;
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
            scroll(0,0);
        } else {
            document.getElementById('savedNotification').innerHTML=" AHAH Error:\n" + req.status + "\n" + req.statusText;
        }
    }
}