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
        DentalAdapter adapter = new DentalAdapter(id);
        BPAdapter bpAdapter = new BPAdapter(id);
        DemographicsAdapter demographicsAdapter = new DemographicsAdapter(id);
        LabAdapter labAdapter = new LabAdapter(id);
        MeasurementAdapter measurementAdapter = new MeasurementAdapter(id);
        PhysicianStationAdapter physicianAdapter = new PhysicianStationAdapter(id);
    %>
    <head>
        <title>Dental Station</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/stations.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
    </head>
    <body class="content" onload="document.getElementById('presentField').focus();">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=Dental.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="CheckIn.jsp">Check In Station</option>
                <option value="Demographics.jsp">Demographics Station</option>
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
            <h2>Dental Station</h2>
            <label>Blood Pressure<input disabled type="checkbox"<% if (bpAdapter.getEditor().length() > 0 || age < 16) {%> checked <% }%>/></label>
            <label>Demographics<input disabled type="checkbox"<% if (demographicsAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
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
            <input type="button" value="Save" class="saveButton" onclick="saveDental()"/><br /><br />
            <label>Number of teeth present: <br /><br />
                <input type="text" maxlength="2" size ="2" name ="presentField" id="presentField" value="<%= adapter.getPresent()%>" onblur="validatePresent()"/>
            </label>
            <p id="presentError" class="errorText"></p>
            <label>Number of teeth missing<br /><br />
                <input type="text" maxlength="2" size ="2" name ="missingField" id="missingField" value="<%= adapter.getMissing()%>" onblur="validateMissing()"/>
            </label>
            <p id="missingError" class="errorText"></p>
            <label>Number of teeth decayed<br /><br />
                <input type="text" maxlength="2" size ="2" name ="decayedField" id="decayedField" value="<%= adapter.getDecayed()%>" onblur="validateDecayed()"/>
            </label>
            <p id="decayedError" class="errorText"></p>
            <label>Number of teeth filled<br /><br />
                <input type="text" maxlength="2" size ="2" name ="filledField" id="filledField" value="<%= adapter.getFilled()%>" onblur="validateFilled()"/>
            </label>
            <p id="filledError" class="errorText"></p>
            <label>Comments:<br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><%= adapter.getComment()%></textarea></label><p id="commentError" class="errorText"></p>
            <input type="button" value="Save" class="saveButton" onclick="saveDental()"/>
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
            });
        </script>
    </body>
</html>
