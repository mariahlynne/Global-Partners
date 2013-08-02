<%@page import="java.util.Date"%>
<%@page import="java.util.Scanner"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.BasicsAdapter"%>
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
        BasicsAdapter basicsAdapter = new BasicsAdapter(id);
        DentalAdapter dentalAdapter = new DentalAdapter(id);
        BPAdapter bpAdapter = new BPAdapter(id);
        DemographicsAdapter demographicsAdapter = new DemographicsAdapter(id);
        LabAdapter labAdapter = new LabAdapter(id);
        MeasurementAdapter measurementAdapter = new MeasurementAdapter(id);
        PhysicianStationAdapter physicianAdapter = new PhysicianStationAdapter(id);


    %>
    <head>
        <title>Review</title>
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <link href="main.css" rel="stylesheet" type="text/css" />
        <link rel="shortcut icon" href="applicationIcon.jpg" />
        <script type="text/javascript" src="JavaScript/stations.js"></script>
        <script type="text/javascript" src="JavaScript/main.js"></script>
        <script type="text/javascript" src="JavaScript/jquery.js"></script>
        <script type="text/javascript" src="JavaScript/bday-picker.js"></script>
    </head>
    <body class="content">
        <form action="NavigateServlet" onsubmit="return checkNavigate()" method="POST">
            <input type="button" onclick="location.href='NavigateServlet?navigate=Review.jsp'" value="Next Patient" id="nextPatientButton"/>
            <input type="submit" value="Go" id="navigateButton"/>
            <select name="navigate" class="dropdown" id="navigate">
                <option value="Navigate">Navigate</option>
                <option value="BloodPressure.jsp">Blood Pressure Station</option>
                <option value="Home.jsp">Change User</option>
                <option value="CheckIn.jsp">Check In Station</option>
                <option value="Demographics.jsp">Demographics Station</option>
                <option value="Dental.jsp">Dental Stations</option>
                <option value="Lab.jsp">Lab Station</option>
                <option value="Measurement.jsp">Measurement Station</option>
                <option value="Physician.jsp">Physician Station</option>
                <option value="Dump.jsp">View Data Dump</option>
            </select>
            <br />
            <br />
            <label for="keepPatientBox" style="float:right; font-size: 20pt">Keep Selected Patient</label>
            <input id="keepPatientBox" name="keepPatientBox" type="checkbox" style="float:right" value="keep"/>
        </form>
        <div class="title">
            <h2>Review</h2>
            <label>Blood Pressure<input disabled type="checkbox"<% if (bpAdapter.getEditor().length() > 0 || age < 16) {%> checked <% }%>/></label>
            <label>Demographics<input disabled type="checkbox"<% if (demographicsAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Dental<input disabled type="checkbox"<% if (dentalAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Lab<input disabled type="checkbox"<% if (labAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Measurement<input disabled type="checkbox"<% if (measurementAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <label>Physician<input disabled type="checkbox"<% if (physicianAdapter.getEditor().length() > 0) {%> checked <% }%>/></label>
            <br />
        </div>
        <br />
        <br />
        <br />
        <div style="text-align: left; margin-left: auto; margin-right: auto; max-width: 70%;">
            <div><%= name%> ID#: <%= id%> , <%= sex%></div>
            <div>Age: <%= ageString%> Birthday: <div id="picker"></div></div>
            <%  if (age >= 16 && bpAdapter.getEditor().length() > 0) {%>
            <h3>Blood Pressure Station</h3>
            <p <% if (Integer.parseInt(bpAdapter.getDiastolic()) > 89) {%> style="color:red;" <% }%> >Blood Pressure: <%= bpAdapter.getSystolic() + "/" + bpAdapter.getDiastolic()%></p>
            <p>Comments: <%= bpAdapter.getComment()%></p>
            <% }
                if (demographicsAdapter.getEditor().length() > 0) {%>
            <h3>Demographics Station</h3>
            <p>House Number: <%= demographicsAdapter.getHouseNumber()%></p>
            <% if (age < 16) {%>
            <p>Mother's Name: <%= demographicsAdapter.getMomName()%></p>
            <p>Father's Name: <%= demographicsAdapter.getDadName()%></p>
            <p>School status: <%= demographicsAdapter.getSchoolLevel() + " " + demographicsAdapter.getSchoolReason()%></p>
            <% } else {%>
            <p>Community: <%= demographicsAdapter.getCommunityName()%></p>
            <p>Community Length: <%= demographicsAdapter.getCommunityLength() + " years"%></p>
            <p>Partner: <% if (demographicsAdapter.getPartner().equals("Y")) {%> <%= demographicsAdapter.getPartnerName()%>
                <% } else {%> None <% }%></p>
            <p>Job: <%= demographicsAdapter.getJob()%></p>
            <%}%>
            <p>Comments: <%= demographicsAdapter.getComment()%></p>
            <% }
                if (dentalAdapter.getEditor().length() > 0) {%>
            <h3>Dental Station</h3>
            <p>Teeth Present: <%= dentalAdapter.getPresent()%></p>
            <p>Teeth Decayed: <%= dentalAdapter.getDecayed()%></p>
            <p>Teeth Missing: <%= dentalAdapter.getMissing()%></p>
            <p>Teeth Filled: <%= dentalAdapter.getFilled()%></p>
            <p>Comments: <%= dentalAdapter.getComment()%></p>
            <% }
                if (labAdapter.getEditor().length() > 0) {%>
            <h3>Lab Station</h3>
            <p>Hemoglobin: <%= labAdapter.getHemoglobin() + " gm/dL"%></p>
            <p <% if (Integer.parseInt(labAdapter.getGlucose()) > 120) {%> style="color:red" <% }%> >Glucose: <%= labAdapter.getGlucose() + "mg/dL"%></p>
            <p>Comments: <%= labAdapter.getComment()%></p>
            <% }
                if (measurementAdapter.getEditor().length() > 0) {
                    double height = Double.parseDouble(measurementAdapter.getHeight()) * .01;
                    double weight = Double.parseDouble(measurementAdapter.getWeight());
                    double bmi = weight / (height * height);
                    bmi = (double) Math.round(bmi * 100) / 100;
                    String bmiString = "";
                    int year = basicsAdapter.getYear();
                    int month = basicsAdapter.getMonth();
                    int day = basicsAdapter.getDay();
                    Date now = new Date();
                    int nowDay = now.getDate();
                    int nowMonth = now.getMonth() + 1;
                    int nowYear = now.getYear() + 1900;
                    int result = nowYear - year;
                    if (month > nowMonth) {
                        result--;
                    } else if (month == nowMonth) {
                        if (day > nowDay) {
                            result--;
                        }
                    }
                    result *= 12;
                    if (nowMonth > month) {
                        result += nowMonth - month;
                        if (day < nowDay) {
                            result--;
                        }
                    } else if (nowMonth < month) {
                        result += 12 - (month - nowMonth);
                        if (day < nowDay) {
                            result--;
                        }
                    } else {
                        result += nowMonth;
                        if (day < nowDay) {
                            result--;
                        }
                    }
                    int months = result;
                    int zscore = 0;
                    if (months > 228) {
                        String classification;
                        if (bmi < 18.5) {
                            classification = "underweight";
                        } else if (bmi < 25) {
                            classification = "normal";
                        } else if (bmi < 30) {
                            classification = "overweight";
                        } else {
                            classification = "obese";
                        }
                        bmiString = "BMI: " + bmi + "<br />" + "Classification: " + classification + "<br />";
                    } else {
                        zscore = basicsAdapter.getZscore(months, basicsAdapter.getSex().contains("F"), bmi);
                        bmiString = "BMI: " + bmi + "<br />" + "Z-Score: " + zscore + "<br />";
                    }%>
            <h3>Measurement Station</h3>
            <p>Height: <%= measurementAdapter.getHeight() + " cm"%></p>
            <p>Weight: <%= measurementAdapter.getWeight() + " kg"%></p>
            <p <%if (zscore < -1 || zscore > 1) {%> style="color:red;" <% }%>><%= bmiString%></p>
            <% if (age < 2) {%>
            <p>Head Circumference: <%= measurementAdapter.getHead() + " cm"%></p>

            <% }%>
            <p>Comments: <%= measurementAdapter.getComment()%></p>
            <%}
                if (physicianAdapter.getEditor().length() > 0) {%>
            <h3>Physician Station</h3>
            <% if (age >= 16) {%>
            <p>Tobacco Use: <%= physicianAdapter.getTobacco()%></p>

            <%  if (sex.equals("F")) {%>
            <p>Number of Pregnancies: <%= physicianAdapter.getNumberPregnancies()%></p>
            <p>Number of Children Died before 16: <%= physicianAdapter.getNumberDeaths()%></p>
            <p>Ages and Reasons: <%= physicianAdapter.getDeaths()%></p>
            <p>Contraception Use: <%= physicianAdapter.getContraception()%></p>
            <p>Contraception Desired: <%= physicianAdapter.getWantContraception()%></p>
            <p>Contraception Easily Available: <%= physicianAdapter.getAvailable()%></p>
            <p>Want More Children: <%= physicianAdapter.getMoreChildren()%></p>
            <% }
            } else {%>
            <p>Born at Home: <%= physicianAdapter.getBornHome()%></p>
            <p>Help After Birth: <%= physicianAdapter.getHelpAfterBirth()%></p>
            <p>Born Premature: <%= physicianAdapter.getPremature()%></p>
            <p>Asthma: <%= physicianAdapter.getAsthma()%></p>
            <p>Persistent Cough: <%= physicianAdapter.getCoughing()%></p>
            <p>Night Cough: <%= physicianAdapter.getNightCoughing()%></p>
            <p>Difficulty Breathing: <%= physicianAdapter.getBreathing()%></p>
            <p>Abdominal Distention: <%= physicianAdapter.getAbdominal()%></p>
            <p>Scars/Injuries: <%= physicianAdapter.getScars()%></p>
            <%  if (age < 7) {%>
            <p>Diarrhea: <%= physicianAdapter.getDiarrhea()%></p>
            <% } else if (age >= 14 && sex.equals("F")) {%>
            <p>Contraception Use: <%= physicianAdapter.getContraception()%></p>
            <% int pregnancies = physicianAdapter.getNumberPregnancies();
                if (pregnancies > 0) {%>
            <p>Number of Pregnancies: <%= pregnancies%></p>
            <p>Number of Children Died before 16: <%= physicianAdapter.getNumberDeaths()%></p>
            <p>Ages and Reasons: <%= physicianAdapter.getDeaths()%></p>
            <p>Contraception Use: <%= physicianAdapter.getContraception()%></p>
            <p>Contraception Desired: <%= physicianAdapter.getWantContraception()%></p>
            <p>Contraception Easily Available: <%= physicianAdapter.getAvailable()%></p>
            <p>Want More Children: <%= physicianAdapter.getMoreChildren()%></p>
            <% } else {%>
            <p>Number of Pregnancies: <%= pregnancies%></p>
            <%}
                    }
                }%>
            <p <% if (physicianAdapter.getAppearsHealthy().length() > 3) {%> style="color:red;" <% }%> >Appears Healthy: <%= physicianAdapter.getAppearsHealthy()%></p>
            <p <% if (physicianAdapter.getHeart().length() > 3) {%> style="color:red;" <% }%>>Heart Normal: <%= physicianAdapter.getHeart()%></p>
            <p <% if (physicianAdapter.getLungs().length() > 3) {%> style="color:red;" <% }%>>Lungs Normal: <%= physicianAdapter.getLungs()%></p>
            <p>Comments: <%= physicianAdapter.getComment()%></p>
            <% }
            %>
        </div>
        <script type="text/javascript">
            $(document).ready(function(){
                $("#picker").birthdaypicker({
                    maxAge: 115,
                    monthFormat: "long",
                    dateFormat: "bigEndian"
                });
                document.getElementById('birth[year]').value = <%= basicsAdapter.getYear()%>;
                document.getElementById('birth[month]').value = <%= basicsAdapter.getMonth()%>;
                document.getElementById('birth[day]').value = <%= basicsAdapter.getDay()%>;
                document.getElementById('birth[year]').disabled = true;
                document.getElementById('birth[month]').disabled = true;
                document.getElementById('birth[day]').disabled = true;
            });
        </script>
    </body>
</html>