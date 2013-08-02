<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Check In</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/main.js"></script>
        <script type="text/javascript" src="JavaScript/search.js"></script>
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
    </head>
    <body class="content" onload="document.getElementById('idField').focus();">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="Demographics.jsp">Demographics Station</option>
                <option value="Dental.jsp">Dental Station</option>
                <option value="Lab.jsp">Lab Station</option>
                <option value="Measurement.jsp">Measurement Station</option>
                <option value="Physician.jsp">Physician Station</option>
                <option value="Review.jsp">Review All Stations</option>
                <option value="Dump.jsp">View Data Dump</option>
            </select>
        </form>
        <div class="title">
            <h2>Check In Station</h2>
        </div>
        <form action="CheckInServlet?newPatient=true" method="POST">
            <p class="instructions">Click the New Patient button or search for and select an existing patient.</p>
            <input type="submit" value="New Patient" id="button" class="saveButton"/><br /><br />
            <label>ID Number: <input type="text" class="textBox" maxlength="3" name="idField" size="3" autocomplete="off" id="idField" onkeyup="validateSearch()"/>   </label>
            <label>Name: <input type="text" class="textBox" size="10" maxlength="75" name="nameField" autocomplete="off" id="nameField" onkeyup="validateSearch()"/>   </label>
            <label>Age: <input type="text" class="textBox" maxlength="3" size="3" name="ageField" autocomplete="off" id="ageField" onkeyup="validateSearch()"/>   </label><br />
            <span id="idError" class="errorText left"></span>
            <span id="ageError" class="errorText right"></span><br />
        </form>
        <br />

        <table id="table" border="0" cellspacing="0" class="visible">


        </table>


    </body>
</html>