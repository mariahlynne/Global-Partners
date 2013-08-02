<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Scanner"%>
<%@page import="Model.PhysicianStationAdapter"%>
<%@page import="Model.MeasurementAdapter"%>
<%@page import="Model.LabAdapter"%>
<%@page import="Model.DemographicsAdapter"%>
<%@page import="Model.BPAdapter"%>
<%@page import="Model.DentalAdapter"%>
<!DOCTYPE html>
<html>
    <%  session = request.getSession();
        String name = session.getAttribute("name").toString();
        int id = Integer.parseInt(session.getAttribute("formId").toString());
        int age = Integer.parseInt(session.getAttribute("age").toString());
        String ageString = "" + age;
        if (ageString.equals("-1")) {
            ageString = "unknown";
        }
        String sex = session.getAttribute("sex").toString();
        PhysicianStationAdapter adapter = new PhysicianStationAdapter(id);
        DentalAdapter dentalAdapter = new DentalAdapter(id);
        BPAdapter bpAdapter = new BPAdapter(id);
        DemographicsAdapter demographicsAdapter = new DemographicsAdapter(id);
        LabAdapter labAdapter = new LabAdapter(id);
        MeasurementAdapter measurementAdapter = new MeasurementAdapter(id);
        boolean isChild = age < 16;
        boolean isFemale = sex.equals("F");
        int pregnancies = age - 1, dead = -1;
        String reasons = "";
        if (isFemale && age > 13) {
            pregnancies = adapter.getNumberPregnancies();
            dead = adapter.getNumberDeaths();
            reasons = "";
            if (dead != 0) {
                reasons = adapter.getDeaths();
            }
        }
    %>
    <head>
        <title>Physician Station</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
        <script type="text/javascript" src="JavaScript/PhysicianStation.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
    </head>
    <body class="content">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=Physician.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="CheckIn.jsp">Check In Station</option>
                <option value="Demographics.jsp">Demographics Station</option>
                <option value="Dental.jsp">Dental Station</option>
                <option value="Lab.jsp">Lab Station</option>
                <option value="Measurement.jsp">Measurement Station</option>
                <option value="Physician.jsp">Physician Station</option>
                <option value="Review.jsp">Review All Stations</option>
                <option value="Dump.jsp">View Data Dump</option>
            </select>
            <br />
            <br />
            <label for="keepPatientBox" style="float:right; font-size: 20pt">Keep Selected Patient</label>
            <input id="keepPatientBox" name="keepPatientBox" type="checkbox" style="float:right" value="keep"/>
        </form>
        <div class="title">
            <h2>Physician Station</h2>
            <label>Blood Pressure<input disabled type="checkbox"<% if (bpAdapter.getEditor().length() > 0 || age < 16) {%> checked <% }%>/></label>
            <label>Demographics<input disabled type="checkbox"<% if (demographicsAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Dental<input disabled type="checkbox"<% if (dentalAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Lab<input disabled type="checkbox"<% if (labAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Measurement<input disabled type="checkbox"<% if (measurementAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <br />
            <h2 id="patientID" style="float: right">ID#: <%= id%></h2>
            <h2 id="patientSex" style="float: right; margin-right: 75px;">Sex: <%= sex%></h2>
            <h2 id="patientAge" style="float: right; margin-right: 75px;">Age: <%= ageString%></h2>
            <h2 id="patientName" style="float: right; margin-right: 75px;">Name: <%= name%></h2>
        </div>
        <p id="savedNotification" style="color: red; font-size: 40pt; clear: both;">Loading...</p>
        <form action="" onsubmit="return false" method="POST" style="clear: both;">


            <% if (isChild) {
                    if (isFemale && age > 13) {%>
            <input type="button" value="Save" class="saveButton" onclick="saveTeenFemalePhysicianStation()"/><br /><br />
            <% } else {%>
            <input type="button" value="Save" class="saveButton" onclick="saveChildPhysicianStation()"/><br /><br />
            <% }%>
            <label>Were they born at home? <br /><br /></label>
            <input type="radio" name="bornHome" id="bornHomeYes" value="yes" <% if (adapter.getBornHome().contains("Yes: ")) {%> checked <% }%> onclick="validateBornHome()">Yes
            <input type="radio" name="bornHome" id="bornHomeNo" value="no" <% if (adapter.getBornHome().contains("No")) {%> checked <% }%> onclick="validateBornHome()">No<br />
            <p id="bornHomeError" class="errorText"></p>
            <div id="bornHomeSection">
                <select name="bornHomeHelp" class="dropdown" id="bornHomeHelp" onchange="validateBornHomeHelp()">
                    <option value="Attended">Who attended?</option>
                    <option value="Doctor">Doctor</option>
                    <option value="Nurse">Nurse</option>
                    <option value="Midwife">Midwife</option>
                    <option value="Family Member">Family Member</option>
                    <option value="Other">Other</option>
                </select>
                <p id="bornHomeSectionError" class="errorText"></p>
            </div>
            <div id="attendedOtherSection"><label>Other: <br />
                    <input type="text" name="attendedOtherField" id="attendedOtherField" onblur="validateAttendedOther()"/></label><br />
                <p id="attendedOtherError" class="errorText"></p><br />
            </div>
            <label>Were they born premature? <br /><br /></label>
            <input type="radio" name="premature" id="prematureYes" value="yes" <% if (adapter.getPremature().contains("Yes")) {%> checked <% }%> onclick="validatePremature()">Premature<br />
            <input type="radio" name="premature" id="prematureNo" value="no" <% if (adapter.getPremature().contains("No")) {%> checked <% }%> onclick="validatePremature()">Full term
            <p id="prematureError" class="errorText"></p>
            <div id="prematureWeeksSection"><label>Number of weeks: <br />
                    <input type="text" name="prematureWeeks" id="prematureWeeks" size="2" maxlength="2" onblur="validatePrematureWeeks()"/></label><br />
                <p id="prematureWeeksError" class="errorText"></p><br />
            </div>
            <div id="helpAfterBirthSection">
                <label>Did they need help at birth? <br /><br /></label>
                <input type="radio" name="helpAfterBirth" id="helpAfterBirthYes" value="yes" <% if (adapter.getHelpAfterBirth().equals("Yes")) {%> checked <% }%> onclick="validateHelpAfterBirth()">Yes
                <input type="radio" name="helpAfterBirth" id="helpAfterBirthNo" value="no" <% if (adapter.getHelpAfterBirth().equals("No")) {%> checked <% }%> onclick="validateHelpAfterBirth()">No<br />
                <p id="helpAfterBirthError" class="errorText"></p>
            </div>
            <div id="diarrheaSection">
                <label>Has your child had diarrhea in the last month? <br /><br /></label>
                <input type="radio" name="diarrhea" id="diarrheaYes" value="yes" <% if (adapter.getDiarrhea().equals("Yes")) {%> checked <% }%> onclick="validateDiarrhea()">Yes
                <input type="radio" name="diarrhea" id="diarrheaNo" value="no" <% if (adapter.getDiarrhea().equals("No")) {%> checked <% }%> onclick="validateDiarrhea()">No<br />
                <p id="diarrheaError" class="errorText"></p>
            </div>
            <label>Have you ever been told by a doctor or nurse that your child has asthma?<br /><br /></label>
            <input type="radio" name="asthma" id="asthmaYes" value="yes" <% if (adapter.getAsthma().equals("Yes")) {%> checked <% }%> onclick="validateAsthma()">Yes
            <input type="radio" name="asthma" id="asthmaNo" value="no" <% if (adapter.getAsthma().equals("No")) {%> checked <% }%> onclick="validateAsthma()">No<br />
            <p id="asthmaError" class="errorText"></p>
            <!--            <label>Ha tenido su nino EN ALGUN MOMENTO respiracin sibilante (silbido en el pecho)?<br /><br /></label>
                        <input type="radio" name="wheezing" id="wheezingYes" value="yes" <% //if (adapter.getWheezing().equals("Yes")) {%> checked <% //}%> onclick="validateWheezing()">Yes
                        <input type="radio" name="wheezing" id="wheezingNo" value="no" <% //if (adapter.getWheezing().equals("No")) {%> checked <% //}%> onclick="validateWheezing()">No<br />
                        <p id="wheezingError" class="errorText"></p>-->
            <label>Has your child had a cough that lasts for more than 1 month?<br /><br /></label>
            <input type="radio" name="couging" id="coughingYes" value="yes" <% if (adapter.getCoughing().equals("Yes")) {%> checked <% }%> onclick="validateCoughing()">Yes
            <input type="radio" name="coughing" id="coughingNo" value="no" <% if (adapter.getCoughing().equals("No")) {%> checked <% }%> onclick="validateCoughing()">No<br />
            <p id="coughingError" class="errorText"></p>
            <label>Has your child had a cough at night that lasts longer than 2 weeks?<br /><br /></label>
            <input type="radio" name="nightCoughing" id="nightCoughingYes" value="yes" <% if (adapter.getNightCoughing().equals("Yes")) {%> checked <% }%> onclick="validateNightCoughing()">Yes
            <input type="radio" name="nightCoughing" id="nightCoughingNo" value="no" <% if (adapter.getNightCoughing().equals("No")) {%> checked <% }%> onclick="validateNightCouging()">No<br />
            <p id="nightCoughingError" class="errorText"></p>
            <label>Has your child had times when it's difficult to breathe?<br /><br /></label>
            <input type="radio" name="breathing" id="breathingYes" value="yes" <% if (adapter.getBreathing().equals("Yes")) {%> checked <% }%> onclick="validateBreathing()">Yes
            <input type="radio" name="breathing" id="breathingNo" value="no" <% if (adapter.getBreathing().equals("No")) {%> checked <% }%> onclick="validateBreathing()">No<br />
            <p id="breathingError" class="errorText"></p>
            <label>Abdominal distention?<br /><br /></label>
            <input type="radio" name="abdominal" id="abdominalYes" value="yes" <% if (adapter.getAbdominal().equals("Yes")) {%> checked <% }%> onclick="validateAbdominal()">Yes
            <input type="radio" name="abdominal" id="abdominalNo" value="no" <% if (adapter.getAbdominal().equals("No")) {%> checked <% }%> onclick="validateAbdominal()">No<br />
            <p id="abdominalError" class="errorText"></p>
            <label>Evidence of scars or injuries?<br /><br /></label>
            <input type="radio" name="scars" id="scarsYes" value="yes" <% if (adapter.getScars().equals("Yes")) {%> checked <% }%> onclick="validateScars()">Yes
            <input type="radio" name="scars" id="scarsNo" value="no" <% if (adapter.getScars().equals("No")) {%> checked <% }%> onclick="validateScars()">No<br />
            <p id="scarsError" class="errorText"></p>


            <% if (isFemale && age > 13) {%>
            <label>Have you ever been pregnant? <br /><br /></label>
            <input type="radio" name="pregnant" id="pregnantYes" value="yes" onclick="validatePregnant()">Yes
            <input type="radio" name="pregnant" id="pregnantNo" value="no" onclick="validatePregnant()">No<br />
            <p id="pregnantError" class="errorText"></p>
            <label>Do you use contraception? <br /><br /></label>
            <input type="radio" name="contraception" id="contraceptionYes" value="yes" onclick="validateContraception()">Yes
            <input type="radio" name="contraception" id="contraceptionNo" value="no" onclick="validateContraception()">No<br />
            <p id="contraceptionError" class="errorText"></p>
            <div id="contraceptionSection">
                <select name="contraceptionType" class="dropdown" id="contraceptionType" onchange="validateContraceptionType()">
                    <option value="Type">Type</option>
                    <option value="Depo">Depo</option>
                    <option value="BCP">BCP</option>
                    <option value="IUD">IUD</option>
                    <option value="Sterilization">Sterilization</option>
                    <option value="Other">Other</option>
                </select>
                <p id="contraceptionSectionError" class="errorText"></p>
            </div>
            <div id="otherSection"><label>Other: <br />
                    <input type="text" name="otherField" id="otherField" onblur="validateOther()"/></label><br />
                <p id="otherError" class="errorText"></p><br />
            </div>
            <div id="femaleSection">
                <label>How many times have you been pregnant? <br /><br /></label>
                <select name="numberPregnancies" class="dropdown" id="numberPregnancies" onchange="updateNumberPregnancies('teen')">
                    <option value="Number">Number</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
                <p id="numberPregnanciesError" class="errorText"></p>
                <div id="deadSection"><label>How many children died before age 16? <br /><br /></label>
                    <select name="numberDead" class="dropdown" id="numberDead" onchange="validateNumberDead()">
                        <option value="Number">Number</option>
                    </select>
                    <p id="numberDeadError" class="errorText"></p>
                </div>
                <div id="deathsSection"><label>Please list the age and reason for each child:<br />
                        <textarea cols="30" rows="3" name="deathsField" id="deathsField" onblur="validateDeaths()"></textarea></label>
                    <p id="deathsError" class="errorText"></p><br />
                </div>
                <br /><label>Do you want more Children? <br /><br /></label>
                <input type="radio" name="moreChildren" id="moreChildrenYes" value="yes" <% if (adapter.getMoreChildren().equals("Yes")) {%> checked <% }%> onclick="validateMoreChildren()">Yes
                <input type="radio" name="moreChildren" id="moreChildrenNo" value="no" <% if (adapter.getMoreChildren().equals("No")) {%> checked <% }%> onclick="validateMoreChildren()">No<br />
                <p id="moreChildrenError" class="errorText"></p>
                <br /><label>Would you use contraception?<br /><br /></label>
                <input type="radio" name="wantContraception" id="wantContraceptionYes" value="yes" <% if (adapter.getWantContraception().equals("Yes")) {%> checked <% }%> onclick="validateWantContraception()">Yes
                <input type="radio" name="wantContraception" id="wantContraceptionNo" value="no" <% if (adapter.getWantContraception().equals("No")) {%> checked <% }%> onclick="validateWantContraception()">No<br />
                <p id="wantContraceptionError" class="errorText"></p>
                <br /><label>Is it easily available to you?<br /><br /></label>
                <input type="radio" name="available" id="availableYes" value="yes" <% if (adapter.getAvailable().equals("Yes")) {%> checked <% }%> onclick="validateAvailable()">Yes
                <input type="radio" name="available" id="availableNo" value="no" <% if (adapter.getAvailable().equals("No")) {%> checked <% }%> onclick="validateAvailable()">No<br />
                <p id="availableError" class="errorText"></p>
            </div>

            <% }%>





            <% } else {%>


            <input type="button" value="Save" class="saveButton" onclick="saveAdultPhysicianStation()"/><br /><br />
            <label>Tobacco Use: <br /><br /></label>
            <input type="radio" name="tobacco" id="tobaccoYes" value="yes" <% if (!adapter.getTobacco().equals("None") && !adapter.getTobacco().equals("")) {%> checked <% }%> onclick="validateTobacco()">Yes
            <input type="radio" name="tobacco" id="tobaccoNo" value="no" <% if (adapter.getTobacco().equals("None")) {%> checked <% }%> onclick="validateTobacco()">No<br />
            <p id="tobaccoError" class="errorText"></p>
            <div id="tobaccoSection">
                <select name="tobaccoAmount" class="dropdown" id="tobaccoAmount" onchange="validateTobaccoAmount()">
                    <option value="Amount">Amount</option>
                    <option value="< 1/2 ppd">&lt; 1/2 pack per day</option>
                    <option value="1/2 ppd">1/2 pack per day</option>
                    <option value="1 ppd">1 pack per day</option>
                    <option value="2 ppd">2 packs per day</option>
                    <option value="3 ppd">3 packs per day</option>
                </select>
                <p id="tobaccoSectionError" class="errorText"></p>
            </div>
            <div id="femaleSection">
                <label>How many times have you been pregnant? <br /><br /></label>
                <select name="numberPregnancies" class="dropdown" id="numberPregnancies" onchange="updateNumberPregnancies()">
                    <option value="Number">Number</option>
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                </select>
                <p id="numberPregnanciesError" class="errorText"></p>
                <div id="deadSection"><label>How many children died before age 16? <br /><br /></label>
                    <select name="numberDead" class="dropdown" id="numberDead" onchange="validateNumberDead()">
                        <option value="Number">Number</option>
                    </select>
                    <p id="numberDeadError" class="errorText"></p>
                </div>
                <div id="deathsSection"><label>Please list the age and reason for each child:<br />
                        <textarea cols="30" rows="3" name="deathsField" id="deathsField" onblur="validateDeaths()"></textarea></label>
                    <p id="deathsError" class="errorText"></p><br />
                </div>
                <label>Do you use contraception? <br /><br /></label>
                <input type="radio" name="contraception" id="contraceptionYes" value="yes" onclick="validateContraception()">Yes
                <input type="radio" name="contraception" id="contraceptionNo" value="no" onclick="validateContraception()">No
                <input type="radio" name="contraception" id="contraceptionNA" value="na" onclick="validateContraception()">N/A<br />
                <p id="contraceptionError" class="errorText"></p>
                <div id="contraceptionSection">
                    <select name="contraceptionType" class="dropdown" id="contraceptionType" onchange="validateContraceptionType()">
                        <option value="Type">Type</option>
                        <option value="Depo">Depo</option>
                        <option value="BCP">BCP</option>
                        <option value="IUD">IUD</option>
                        <option value="Sterilization">Sterilization</option>
                        <option value="Other">Other</option>
                    </select>
                    <p id="contraceptionSectionError" class="errorText"></p>
                </div>
                <div id="otherSection"><label>Other: <br />
                        <input type="text" name="otherField" id="otherField" onblur="validateOther()"/></label><br />
                    <p id="otherError" class="errorText"></p><br />
                </div>
                <div id="contraceptionNASection">
                    <input type="text" name="contraceptionNAField" id="contraceptionNAField" onblur="validateContraceptionNA()"/><br />
                    <p id="contraceptionNAError" class="errorText"></p>
                </div>
                <br /><label>Do you want more Children? <br /><br /></label>
                <input type="radio" name="moreChildren" id="moreChildrenYes" value="yes" <% if (adapter.getMoreChildren().equals("Yes")) {%> checked <% }%> onclick="validateMoreChildren()">Yes
                <input type="radio" name="moreChildren" id="moreChildrenNo" value="no" <% if (adapter.getMoreChildren().equals("No")) {%> checked <% }%> onclick="validateMoreChildren()">No<br />
                <p id="moreChildrenError" class="errorText"></p>
                <br /><label>Would you use contraception?<br /><br /></label>
                <input type="radio" name="wantContraception" id="wantContraceptionYes" value="yes" <% if (adapter.getWantContraception().equals("Yes")) {%> checked <% }%> onclick="validateWantContraception()">Yes
                <input type="radio" name="wantContraception" id="wantContraceptionNo" value="no" <% if (adapter.getWantContraception().equals("No")) {%> checked <% }%> onclick="validateWantContraception()">No<br />
                <p id="wantContraceptionError" class="errorText"></p>
                <div id="availableSection">
                    <label>Is it easily available to you?<br /><br /></label>
                    <input type="radio" name="available" id="availableYes" value="yes" <% if (adapter.getAvailable().equals("Yes")) {%> checked <% }%> onclick="validateAvailable()">Yes
                    <input type="radio" name="available" id="availableNo" value="no" <% if (adapter.getAvailable().equals("No")) {%> checked <% }%> onclick="validateAvailable()">No<br />
                    <p id="availableError" class="errorText"></p>
                </div>
            </div>

            <% }%>


            <label>Appears healthy? <br /><br /></label>
            <input type="radio" name="healthy" id="healthyYes" value="yes" <% if (adapter.getAppearsHealthy().contains("Yes")) {%> checked <% }%> onclick="validateHealthy()">Yes
            <input type="radio" name="healthy" id="healthyNo" value="no" <% if (adapter.getAppearsHealthy().contains("No")) {%> checked <% }%> onclick="validateHealthy()">No
            <p id="healthyError" class="errorText"></p>
            <div id="healthyReasonSection"><label>Why not?<br />
                    <textarea cols="30" rows="3" name="healthyReasonField" id="healthyReasonField" onblur="validateHealthyReason()"><% if (adapter.getAppearsHealthy().contains("No")) {%> <%= adapter.getAppearsHealthy().substring(4)%> <% }%></textarea></label><br />
                <p id="healthyReasonError" class="errorText"></p><br />
            </div>
            <label>Heart normal? <br /><br /></label>
            <input type="radio" name="heart" id="heartYes" value="yes" <% if (adapter.getHeart().contains("Yes")) {%> checked <% }%> onclick="validateHeart()">Yes
            <input type="radio" name="heart" id="heartNo" value="no" <% if (adapter.getHeart().contains("No")) {%> checked <% }%> onclick="validateHeart()">No
            <p id="heartError" class="errorText"></p>
            <div id="heartReasonSection"><label>Why not?<br />
                    <textarea cols="30" rows="3" name="heartReasonField" id="heartReasonField" onblur="validateHeartReason()"><% if (adapter.getHeart().contains("No")) {%> <%= adapter.getHeart().substring(4)%> <% }%></textarea></label><br />
                <p id="heartReasonError" class="errorText"></p><br />
            </div>
            <label>Lungs normal? <br /><br /></label>
            <input type="radio" name="lungs" id="lungsYes" value="yes" <% if (adapter.getLungs().contains("Yes")) {%> checked <% }%> onclick="validateLungs()">Yes
            <input type="radio" name="lungs" id="lungsNo" value="no" <% if (adapter.getLungs().contains("No")) {%> checked <% }%> onclick="validateLungs()">No
            <p id="lungsError" class="errorText"></p>
            <div id="lungsReasonSection"><label>Why not?<br />
                    <textarea cols="30" rows="3" name="lungsReasonField" id="lungsReasonField" onblur="validateLungsReason()"><% if (adapter.getLungs().contains("No")) {%> <%= adapter.getLungs().substring(4)%> <% }%></textarea></label><br />
                <p id="lungsReasonError" class="errorText"></p><br />
            </div>
            <label>Comments:<br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><%= adapter.getComment()%></textarea></label><p id="commentError" class="errorText"></p>
                <% if (isChild && isFemale && age > 13) {%>
            <input type="button" value="Save" class="saveButton" onclick="saveTeenFemalePhysicianStation()"/><br /><br />
            <% } else if (isChild) {%>
            <input type="button" value="Save" class="saveButton" onclick="saveChildPhysicianStation()"/><br /><br />
            <% } else {%>
            <input type="button" value="Save" class="saveButton" onclick="saveAdultPhysicianStation()"/>
            <%  }%>
        </form>
        <script type="text/javascript">
            $("#savedNotification").hide();
            var warnMessage = "You have unsaved changes!";
            $(document).ready(function() {
                $('input:not(:button,:submit),textarea,select').change(function () {
                    window.onbeforeunload = function () {
                        if (warnMessage != null) return warnMessage;
                    }
                });
                $('#SaveButton').click(function(e) {
                    warnMessage = null;
                });

            <% if (isChild) {
                    String bornHome = adapter.getBornHome();
                    if (bornHome.contains("Yes: ")) {
                        if (bornHome.contains(" Other-")) {%>
                                document.getElementById('attendedOtherField').value = <%= "\"" + bornHome.substring(11) + "\""%>;
                                document.getElementById('bornHomeHelp').value = "Other";
            <%          } else {%>
                    document.getElementById('bornHomeHelp').value = <%= "\"" + bornHome.substring(5) + "\""%>;
                    $("#attendedOtherSection").hide();
            <%          }
            } else if (bornHome.contains("No")) {%>
                    $("#attendedOtherSection").hide();
                    $("#helpAfterBirthSection").hide();
                    $("#bornHomeSection").hide();
            <%      } else {%>
                    $("#helpAfterBirthSection").hide();
                    $("#bornHomeSection").hide();
                    $("#attendedOtherSection").hide();
            <%      }
                if (adapter.getPremature().contains("Yes")) {
                    Scanner scanner = new Scanner(adapter.getPremature());
                    scanner.next();
                    int weeks = scanner.nextInt();%>
                            document.getElementById('prematureWeeks').value = <%= "\"" + weeks + "\""%>;
            <%      } else if (adapter.getPremature().contains("No")) {%>
                    $("#prematureWeeksSection").hide();
            <%      } else {%>
                    $("#prematureWeeksSection").hide();
            <%      }
                if (age >= 7) {%>
                        $("#diarrheaSection").hide();
            <%      }
                if (isFemale && age > 13) {
                    String contraception = adapter.getContraception();
                    if (contraception.contains("Yes: ")) {%>
                            document.getElementById('contraceptionYes').checked = true;
            <%              if (contraception.contains(" Other-")) {%>
                    document.getElementById('otherField').value = <%= "\"" + contraception.substring(11) + "\""%>;
                    document.getElementById('contraceptionType').value = "Other";
            <%              } else {%>
                    document.getElementById('contraceptionType').value = <%= "\"" + contraception.substring(5) + "\""%>;
                    $("#otherSection").hide();
            <%              }
            } else if (contraception.contains("No")) {%>
                    document.getElementById('contraceptionNo').checked = true;
                    $("#contraceptionSection").hide();
                    $("#otherSection").hide();
            <%          } else {%>
                    $("#contraceptionSection").hide();
                    $("#otherSection").hide();
            <%          }
                if (pregnancies == -1) {%>
                        $("#femaleSection").hide();
            <%          } else {
                if (pregnancies > 0) {%>
                        document.getElementById('pregnantYes').checked = true;
                        $("#femaleSection").show();
                        document.getElementById('numberPregnancies').value = <%= pregnancies%>;
            <% String options = "<option value=\\\"Number\\\">Number</option>";%>
                    document.getElementById('numberDead').innerHTML = <%= "\"" + options + "\""%>;
                    document.getElementById('numberDead').value = <%= dead%>;
                    document.getElementById('deathsField').value = <%= "\"" + reasons + "\""%>;

            <% } else if (pregnancies == 0) {%>
                    document.getElementById('pregnantNo').checked = true;
                    document.getElementById('numberPregnancies').value = 0;
                    $("#femaleSection").hide();
            <% } else {%>
                    $("#deadSection").hide();
                    $("#deathsSection").hide();
            <% }
                    }
                }
            } else {
                if (age >= 50) {%>
                        $("#availableSection").hide();
            <%      }
                if (adapter.getTobacco().equals("None")) {%>
                        $("#tobaccoSection").hide();
            <% } else if (!adapter.getTobacco().equals("")) {%>
                    document.getElementById('tobaccoAmount').value = <%= "\"" + adapter.getTobacco() + "\""%>;
            <% } else {%>
                    $("#tobaccoSection").hide();
            <% }
                if (isFemale) {
                    if (pregnancies > 0) {%>
                            document.getElementById('numberPregnancies').value = <%= "\"" + pregnancies + "\""%>;
            <% String options = "<option value=\\\"Number\\\">Number</option>";
                for (int ndx = 0; ndx <= 15; ndx++) {
                    options += "<option value=\\\"" + ndx + "\\\">" + ndx + "</option>";
                }%>
                        document.getElementById('numberDead').innerHTML = <%= "\"" + options + "\""%>;
                        document.getElementById('numberDead').value = <%= "\"" + dead + "\""%>;
                        document.getElementById('deathsField').value = <%= "\"" + reasons + "\""%>;
            <% if (dead == 0) {%>
                    $("#deathsSection").hide();
            <%  }
            } else if (pregnancies == 0) {%>
                    document.getElementById('numberPregnancies').value = 0;
                    $("#deadSection").hide();
                    $("#deathsSection").hide();
            <% } else {%>
                    $("#deadSection").hide();
                    $("#deathsSection").hide();
            <% }
                String contraception = adapter.getContraception();
                if (contraception.contains("Yes: ")) {%>
                        $("#contraceptionNASection").hide();
                        document.getElementById('contraceptionYes').checked = true;
            <%              if (contraception.contains(" Other-")) {%>
                    document.getElementById('otherField').value = <%= "\"" + contraception.substring(11) + "\""%>;
                    document.getElementById('contraceptionType').value = "Other";
            <%              } else {%>
                    document.getElementById('contraceptionType').value = <%= "\"" + contraception.substring(5) + "\""%>;
                    $("#otherSection").hide();
            <%              }
            } else if (contraception.equals("No")) {%>
                    document.getElementById('contraceptionNo').checked = true;
                    $("#contraceptionSection").hide();
                    $("#otherSection").hide();
                    $("#contraceptionNASection").hide();
            <%          } else if (contraception.contains("N/A: ")) {%>
                    document.getElementById('contraceptionNA').checked = true;
                    $("#contraceptionNASection").show();
                    $("#contraceptionSection").hide();
                    $("#otherSection").hide();
                    document.getElementById('contraceptionNAField').value = <%= "\"" + contraception.substring(5) + "\""%>;
            <%     } else {%>
                    $("#contraceptionSection").hide();
                    $("#otherSection").hide();
                    $("#contraceptionNASection").hide();
            <%          }
            } else {%>
                    $("#femaleSection").hide();
            <% }
                }
                if (adapter.getAppearsHealthy().equals("Yes") || adapter.getAppearsHealthy().equals("")) {%>
                        $("#healthyReasonSection").hide();
            <% }
                if (adapter.getHeart().equals("Yes") || adapter.getHeart().equals("")) {%>
                        $("#heartReasonSection").hide();
            <% }
                if (adapter.getLungs().equals("Yes") || adapter.getLungs().equals("")) {%>
                        $("#lungsReasonSection").hide();
            <% }%>
                });
        </script>
    </body>
</html>