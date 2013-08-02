<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        DemographicsAdapter adapter = new DemographicsAdapter(id);
        DentalAdapter dentalAdapter = new DentalAdapter(id);
        BPAdapter bpAdapter = new BPAdapter(id);
        LabAdapter labAdapter = new LabAdapter(id);
        MeasurementAdapter measurementAdapter = new MeasurementAdapter(id);
        PhysicianStationAdapter physicianAdapter = new PhysicianStationAdapter(id);
        boolean isChild = true;
        if (age >= 16) {
            isChild = false;
        }
        boolean inSchool = true, notInSchool = false, tooYoung = false;
        if (adapter.getSchoolLevel().contains("Not in school")) {
            notInSchool = true;
        }
        if (adapter.getSchoolLevel().length() == 0) {
            inSchool = false;
        }
        if (adapter.getSchoolReason().equals("Too young")) {
            tooYoung = true;
        }
    %>
    <head>
        <title>Demographics Station</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
        <script type="text/javascript" src="JavaScript/DemographicsStation.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
    </head>
    <body class="content">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=Demographics.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="CheckIn.jsp">Check In Station</option>
                <option value="DentalStation.jsp">Dental Station</option>
                <option value="LabStation.jsp">Lab Station</option>
                <option value="HeightWeight.jsp">Measurement Station</option>
                <option value="PhysicianStation.jsp">Physician Station</option>
                <option value="Review.jsp">Review All Stations</option>
                <option value="Dump.jsp">View Data Dump</option>
            </select>
            <br />
            <br />
            <label for="keepPatientBox" style="float:right; font-size: 20pt">Keep Selected Patient</label>
            <input id="keepPatientBox" name="keepPatientBox" type="checkbox" style="float:right" value="keep"/>
        </form>
        <div class="title">
            <h2>Demographics Station</h2>
            <label>Blood Pressure<input disabled type="checkbox"<% if (bpAdapter.getEditor().length() > 0 || age < 16) {%> checked <% }%>/></label>
            <label>Dental<input disabled type="checkbox"<% if (dentalAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Lab<input disabled type="checkbox"<% if (labAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Measurement<input disabled type="checkbox"<% if (measurementAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Physician<input disabled type="checkbox"<% if (physicianAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <br />
            <h2 id="patientID" style="float: right">ID#: <%= id%></h2>
            <h2 id="patientSex" style="float: right; margin-right: 75px;">Sex: <%= sex%></h2>
            <h2 id="patientAge" style="float: right; margin-right: 75px;">Age: <%= ageString%></h2>
            <h2 id="patientName" style="float: right; margin-right: 75px;">Name: <%= name%></h2>
        </div>
        <p id="savedNotification" style="color: red; font-size: 40pt; clear: both;">Loading...</p>
        <form action="" onsubmit="return false" method="POST" style="clear: both;">
            <% if (!isChild) {%>
            <input type="button" value="Save" class="saveButton" onclick="saveAdultDemographics()"/><br /><br />
            <label>Do you live in this community? <br /><br /></label>
            <input type="radio" name="community" id="communityYes" value="yes" <% if (adapter.getCommunity().equals("Y")) {%> checked <% }%> onclick="validateCommunity()">Yes
            <input type="radio" name="community" id="communityNo" value="no" <% if (adapter.getCommunity().equals("N")) {%> checked <% }%> onclick="validateCommunity()">No<br />
            <p id="communityError" class="errorText"></p>
            <div id="CommunityLengthSection"><label>How many years have you lived here?<br />
                    <input type="text" maxlength="2" size="2" name="communityLengthField" id="communityLengthField" value="<%= adapter.getCommunityLength()%>"/></label><br />
                <p id="communityLengthError" class="errorText"></p><br /></div>
            <div id="CommunityNameSection"><label>Where do you live?<br />
                    <input type="text" maxlength="45" size="20" name="communityNameField" id="communityNameField" value="<%= adapter.getCommunityName()%>"/></label><br />
                <p id="communityNameError" class="errorText"></p><br /></div>
            <label>House Number<br />
                <input type="text" maxlength="45" size="20" name="houseNumberField" id="houseNumberField" value="<%= adapter.getHouseNumber()%>" onblur="validateHouseNumber()"/></label><br />
            <input type="checkbox" onclick="houseNA()" name="houseNumberNA" id="houseNumberNA"/>
            <label for="houseNumberNA">N/A</label>
            <p id="houseNumberError" class="errorText"></p>
            <label>Lives with Partner: <br /><br /></label>
            <input type="radio" name="partner" id="partnerYes" value="yes" <% if (adapter.getPartner().equals("Y")) {%> checked <% }%> onclick="validatePartner()">Yes
            <input type="radio" name="partner" id="partnerNo" value="no" <% if (adapter.getPartner().equals("N")) {%> checked <% }%> onclick="validatePartner()">No<br />
            <p id="partnerError" class="errorText"></p>
            <div id="PartnerNameSection"><label>Partner's Full Name<br />
                    <input type="text" maxlength="75" size="20" name="partnerNameField" id="partnerNameField" value="<%= adapter.getPartnerName()%>"/></label><br />
                <p id="partnerNameError" class="errorText"></p><br /></div>

            <label>What is your job?<br />
                <input type="text" maxlength="45" size="20" name="jobField" id="jobField" value="<%= adapter.getJob()%>" onblur="validateJob()"/></label><br />
            <p id="jobError" class="errorText"></p>
            <label>Comments:<br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><%= adapter.getComment()%></textarea></label><p id="commentError" class="errorText"></p>
            <input type="button" value="Save" class="saveButton" onclick="saveAdultDemographics()"/>
            <% } else {%>
            <input type="button" value="Save" class="saveButton" onclick="saveChildDemographics()"/><br /><br />
            <label>House Number<br />
                <input type="text" maxlength="45" size="20" name="houseNumberField" id="houseNumberField" value="<%= adapter.getHouseNumber()%>" onblur="validateHouseNumber()"/></label><br />
            <input type="checkbox" onclick="houseNA()" name="houseNumberNA" id="houseNumberNA"/>
            <label for="houseNumberNA">N/A</label>
            <p id="houseNumberError" class="errorText"></p>
            <label>Father's complete name:<br />
                <input type="text" maxlength="45" size="20" name="dadNameField" id="dadNameField" value="<%= adapter.getDadName()%>" onblur="validateDadName()"/></label><br />
            <p id="dadNameError" class="errorText"></p>
            <label>Mother's complete name:<br />
                <input type="text" maxlength="45" size="20" name="momNameField" id="momNameField" value="<%= adapter.getMomName()%>" onblur="validateMomName()"/></label><br />
            <p id="momNameError" class="errorText"></p>
            <label>Is child attending school? <br /><br /></label>
            <input type="radio" name="school" id="schoolYes" value="yes" <% if (inSchool) {%> checked <% }%> onclick="validateSchool()">Yes
            <input type="radio" name="school" id="schoolNo" value="no" <% if (notInSchool && !tooYoung) {%> checked <% }%> onclick="validateSchool()">No
            <input type="radio" name="school" id="schoolYoung" value="too young" <% if (!inSchool && tooYoung || age < 3) {%> checked <% }%>  onclick="validateSchool()">Too young<br />
            <p id="schoolError" class="errorText"></p>
            <div id="PrimaryLevelSection"><label id="primaryLabel">Current primary school status: </label><br />
                <select name="primaryLevel" class="dropdown" id="primaryLevel" onchange="validatePrimaryLevel()">
                    <option value="Primary">Primary</option>
                    <option value="Preschool">Preschool</option>
                    <option value="1st Grade">1st Grade</option>
                    <option value="2nd Grade">2nd Grade</option>
                    <option value="3rd Grade">3rd Grade</option>
                    <option value="4th Grade">4th Grade</option>
                    <option value="5th Grade">5th Grade</option>
                    <option value="6th Grade">6th Grade</option>
                    <option value="Completed">Completed</option>
                </select>
                <p id="primaryLevelError" class="errorText"></p><br />
            </div>
            <div id="SecondaryLevelSection"><label id="secondaryLabel">Current secondary school status: </label><br />
                <select name="secondaryLevel" class="dropdown" id="secondaryLevel" onchange="validateSecondaryLevel()">
                    <option value="Secondary">Secondary</option>
                    <option value="1st Year">1st Year</option>
                    <option value="2nd Year">2nd Year</option>
                    <option value="3rd Year">3rd Year</option>
                    <option value="4th Year">4th Year</option>
                    <option value="5th Year">5th Year</option>
                </select>
                <p id="secondaryLevelError" class="errorText"></p><br />
            </div>
            <div id="ReasonSection"><label>Why not?<br />
                    <input type="text" maxlength="255" size="20" name="reasonField" id="reasonField" onblur="validateReason()"/></label><br />
                <p id="reasonError" class="errorText"></p><br />
            </div>
            <label>Comments:<br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><%= adapter.getComment()%></textarea></label><p id="commentError" class="errorText"></p>
            <input type="button" value="Save" class="saveButton" onclick="saveChildDemographics()"/>
            <% }%>
        </form>
        <script type="text/javascript">$("#savedNotification").hide();
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
            <% String houseNum = adapter.getHouseNumber();
                if (houseNum.equalsIgnoreCase("na") || houseNum.equalsIgnoreCase("n/a") || houseNum.equalsIgnoreCase("none")) {%>
                        document.getElementById("houseNumberNA").checked = true;
                        houseNA();
            <% }
                if (isChild) {
                    if (tooYoung) {%>
                            $("#PrimaryLevelSection").hide();
                            $("#SecondaryLevelSection").hide();
                            $("#ReasonSection").hide();
            <% } else if (inSchool || notInSchool) {
                String level = adapter.getSchoolLevel();
                level = level.substring(8);
                if (notInSchool) {
                    if (level.length() > 15) {
                        level = level.substring(15);
                    } else {
                        level = level.substring(4);
                    }%>
                            document.getElementById('reasonField').value = <%= "\"" + adapter.getSchoolReason() + "\""%>;
            <% } else {%>
                    $("#ReasonSection").hide();
            <% }
                String primary = "";
                String secondary = "";
                char c = level.charAt(0);
                int ndx = 1;
                while (c != ';' && ndx < level.length()) {
                    primary += c;
                    c = level.charAt(ndx);
                    ndx++;
                }
                c = 'x';
                ndx = ndx + 11;
                while (c != ';' && ndx < level.length()) {
                    c = level.charAt(ndx);
                    secondary = secondary + c;
                    ndx++;
                }
                if (!(primary.length() > 0)) {
                    primary = "Primary";
                }
                if (!(secondary.length() > 1)) {
                    secondary = "Secondary";%>
                            $("#SecondaryLevelSection").hide();

            <% }%>
                    document.getElementById('primaryLevel').value = <%= "\"" + primary + "\""%>;
                    document.getElementById('secondaryLevel').value = <%= "\"" + secondary + "\""%>;
            <%} else {%>
                    $("#PrimaryLevelSection").hide();
                    $("#SecondaryLevelSection").hide();
                    $("#ReasonSection").hide();
            <% }
            } else {
                if (!adapter.getPartner().equals("Y")) {%> $("#PartnerNameSection").hide();
            <% }%>
            <% if (adapter.getCommunity().equals("Y")) {%> $("#CommunityNameSection").hide();
            <% } else if (adapter.getPartner().equals("N")) {%> $("#CommunityLengthSection").hide();
            <% } else {%> $("#CommunityNameSection").hide();
                    $("#CommunityLengthSection").hide();
            <% }
                }%>
                    });
        </script>
    </body>
</html>