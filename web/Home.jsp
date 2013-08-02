<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Global Partners</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/main.js"></script>
    </head>
    <body class="content" onload="document.getElementById('nameField').focus();">
        <div class="title">
            <h1 class="gp">Global Partners</h1>
            <h2>Welcome</h2>
        </div>
        <div class="main">
            <form action="HomeServlet" id="form" onsubmit="return checkHome()" method="POST">
                <label>Please enter your name, then select a station <br /><br />
                    <input type="text" maxlength="45" size ="20" autocomplete="off" name ="nameField" id="nameField" onblur="validateName()"/>
                </label><p id="nameError" class="errorText"></p><br />
                <select name="navigate" class="dropdown" id="navigate" style="float: none">
                    <option value="Navigate">Navigate</option>
                    <option value="BloodPressure.jsp">Blood Pressure Station</option>
                    <option value="CheckIn.jsp">Check In Station</option>
                    <option value="Demographics.jsp">Demographics Station</option>
                    <option value="Dental.jsp">Dental Station</option>
                    <option value="Lab.jsp">Lab Station</option>
                    <option value="Measurement.jsp">Measurement Station</option>
                    <option value="Physician.jsp">Physician Station</option>
                    <option value="Review.jsp">Review All Stations</option>
                    <option value="Dump.jsp">View Data Dump</option>
                </select>
                <input type="submit" value="Go" id="goButton" />
            </form>
        </div>
    </body>
</html>
