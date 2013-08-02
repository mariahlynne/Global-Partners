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
        BPAdapter adapter = new BPAdapter(id);
        DentalAdapter dentalAdapter = new DentalAdapter(id);
        DemographicsAdapter demographicsAdapter = new DemographicsAdapter(id);
        LabAdapter labAdapter = new LabAdapter(id);
        MeasurementAdapter measurementAdapter = new MeasurementAdapter(id);
        PhysicianStationAdapter physicianAdapter = new PhysicianStationAdapter(id);
    %>
    <head>
        <title>Blood Pressure Station</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
        <script type="text/javascript" src="JavaScript/stations.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
    </head>
    <body class="content" id="body" onload="document.getElementById('systolicField').focus();">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=BloodPressure.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
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
            <h2>Blood Pressure</h2>
            <label>Demographics<input disabled type="checkbox"<% if (demographicsAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
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
        <% if (age >= 16) {%>
        <p id="savedNotification" style="color: red; font-size: 40pt; clear: both;">Loading...</p>
        <form action="" onsubmit="return false" method="POST" style="clear: both;">
            <input type="button" value="Save" class="saveButton" onclick="saveBP()"/><br />
            <label>Systolic (60-220)<br />
                <input type="text" maxlength="3" size="3" name="systolicField" id="systolicField" value="<%= adapter.getSystolic()%>" onblur="validateSystolic()"/></label>
            <p id="systolicError" class="errorText"></p>
            <label>Diastolic (40-140)<br />
                <input type="text" maxlength="3" size="3" name="diastolicField" id="diastolicField" value="<%= adapter.getDiastolic()%>" onblur="validateDiastolic()"/></label>
            <p id="diastolicError" class="errorText"></p>
            <label>Comments:<br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><%= adapter.getComment()%></textarea></label><p id="commentError" class="errorText"></p>
            <input type="button" value="Save" class="saveButton" onclick="saveBP()"/>
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
        <% } else {%>
        <p style="font-size: 40pt; clear: both;">Because this child is less than 16 years old, they do not need their blood pressure taken today.</p>
        <% }%>
    </body>
</html>
