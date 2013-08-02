<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.BasicsAdapter"%>
<!DOCTYPE html>
<html>
    <%  session = request.getSession();
        int id = 0;
        BasicsAdapter adapter = null;
        String sex = "";
        boolean newPatient = true;
        if (session.getAttribute("newPatient").toString().equals("false")) {
            newPatient = false;
            id = Integer.parseInt(session.getAttribute("formId").toString());
            adapter = new BasicsAdapter(id);
            sex = adapter.getSex();
        }

    %>
    <head>
        <title>Check In</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/stations.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
        <script type="text/javascript" src="JavaScript/bday-picker.js"></script>
    </head>
    <body class="content" onload="document.getElementById('nameField').focus();">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=CheckIn.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="CheckIn.jsp">Check In Station</option>
                <option value="Demographics.jsp">Demographics Station</option>
                <option value="Dental.jsp">Dental Station</option>
                <option value="Measurement.jsp">Measurement Station</option>
                <option value="Lab.jsp">Lab Station</option>
                <option value="Physician.jsp">Physician Station</option>
                <option value="Review.jsp">Review All Stations</option>
                <option value="Dump.jsp">View Data Dump</option>
            </select>
            <br />
        </form>
        <div class="title">
            <h2 id="header">Basic Information</h2>
        </div>
        <span id="savedNotification" style="color: red; font-size: 40pt">Loading...</span>
        <form action="" onsubmit="return false" method="POST">
            <input type="button" value="Save" class="saveButton" onclick="saveBasics()"/><br /><br />
            <label>Name: <br /><br />
                <input type="text" size="25" maxlength="75" name="nameField" autocomplete="off" id="nameField" value="<% if (!newPatient) {%><%= adapter.getName()%> <% }%>" onblur="validateName()"/>
            </label>
            <p id="nameError" class="errorText"></p>
            <label>Age: <br /><br /></label>
            <div id="picker"></div>
            <p id="ageError" class="errorText"></p>
            <br /><label>Gender: <br /><br /></label>
            <input type="radio" name="gender" id="male" value="Male" <% if (sex.equals("M")) {%> checked <% }%> >Male
            <input type="radio" name="gender" id="female" value="Female" <% if (sex.equals("F")) {%> checked <% }%> >Female<br />
            <p id="sexError" class="errorText"></p>
            <label>Comments: <br />
                <textarea cols="30" rows="3" name="comment" id="commentField"><% if (!newPatient) {%><%= adapter.getComment()%> <% }%></textarea></label><p id="commentError" class="errorText"></p>
            <input type="button" value="Save" class="saveButton" onclick="saveBasics()"/>
        </form>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#picker").birthdaypicker({
                    maxAge: 115,
                    monthFormat: "long",
                    dateFormat: "bigEndian"
                });
                $("#savedNotification").hide();
                var warnMessage = "You have unsaved changes!";
                $('input:not(:button,:submit),textarea,select,.picker').change(function () {
                    window.onbeforeunload = function () {
                        if (warnMessage != null) return warnMessage;
                    }
                });
                $('#SaveButton').click(function(e) {
                    warnMessage = null;
                });
            <% if (!newPatient) {%>
                        document.getElementById('birth[year]').value = <%= adapter.getYear()%>;
                        document.getElementById('birth[month]').value = <%= adapter.getMonth()%>;
                        document.getElementById('birth[day]').value = <%= adapter.getDay()%>;
            <% }%>
                    });
        </script>
    </body>
</html>