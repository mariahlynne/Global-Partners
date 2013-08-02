<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Scanner"%>
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
        <title>Data Dump</title>
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
            <input type="button" onclick="location.href='NavigateServlet?navigate=Dump.jsp'" value="Next Patient" id="nextPatientButton"/>
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
            </select>
            <br />
            <br />
            <label for="keepPatientBox" style="float:right; font-size: 20pt">Keep Selected Patient</label>
            <input id="keepPatientBox" name="keepPatientBox" type="checkbox" style="float:right" value="keep"/>
        </form>
        <div class="title">
            <h2>Database Dump</h2>
        </div>
        <br />
        <br />
        <br />
        <div style="text-align: left; margin-left: auto; margin-right: auto; max-width: 70%;">
            <div><%= name%> ID#: <%= id%> , <%= sex%></div>
            <div>Age: <%= ageString%> Birthday: <div id="picker"></div></div>
            <p>UPDATE_DATE: <%= basicsAdapter.getUpdateDate()%></p>
            <h3>Blood Pressure Station</h3>
            <p>BP_SYS: <%= bpAdapter.getSystolic()%></p>
            <p>BP_DIAS: <%= bpAdapter.getDiastolic()%></p>
            <p>Comments: <%= bpAdapter.getComment()%></p>
            <p>Editor: <%= bpAdapter.getEditor()%></p>


            <h3>Demographics Station</h3>
            <p>HOUSE: <%= demographicsAdapter.getHouseNumber()%></p>
            <p>MOM_NAME: <%= demographicsAdapter.getMomName()%></p>
            <p>DAD_NAME: <%= demographicsAdapter.getDadName()%></p>
            <p>ATT_SCHL: <%= demographicsAdapter.getSchoolLevel()%></p>
            <p>SCHL_WHY: <%= demographicsAdapter.getSchoolReason()%></p>
            <p>COMMUNITY: <%= demographicsAdapter.getCommunity()%></p>
            <p>COMMUNITY_NAME: <%= demographicsAdapter.getCommunityName() %></p>
            <p>COMMUNITY_LENGTH: <%= demographicsAdapter.getCommunityLength()%></p>
            <p>PARTNER: <%= demographicsAdapter.getPartner()%></p>
            <p>PARTNER_NM: <%= demographicsAdapter.getPartnerName()%></p>
            <p>JOB: <%= demographicsAdapter.getJob()%></p>
            <p>Comments: <%= demographicsAdapter.getComment()%></p>
            <p>Editor: <%= demographicsAdapter.getEditor() %></p>

            
            
            <h3>Dental Station</h3>
            <p>TEETH_PRESENT: <%= dentalAdapter.getPresent()%></p>
            <p>TEETH_DECAYED: <%= dentalAdapter.getDecayed()%></p>
            <p>TEETH_MISSING: <%= dentalAdapter.getMissing()%></p>
            <p>TEETH_FILLED: <%= dentalAdapter.getFilled()%></p>
            <p>Comments: <%= dentalAdapter.getComment()%></p>
            <p>Editor: <%= dentalAdapter.getEditor()%></p>

            
            
            <h3>Lab Station</h3>
            <p>HBG: <%= labAdapter.getHemoglobin()%></p>
            <p>GLUC:<%= labAdapter.getGlucose()%></p>
            <p>Comments: <%= labAdapter.getComment()%></p>
            <p>Editor: <%= labAdapter.getEditor()%></p>
           
            
            
            <h3>Measurement Station</h3>
            <p>HEIGHT: <%= measurementAdapter.getHeight()%></p>
            <p>WEIGHT: <%= measurementAdapter.getWeight()%></p>
            <p>HEAD_CIRC: <%= measurementAdapter.getHead()%></p>
            <p>Comments: <%= measurementAdapter.getComment()%></p>
            <p>Editors: <%= measurementAdapter.getEditor()%></p>



            <h3>Physician Station</h3>
            <p>TOBAC: <%= physicianAdapter.getTobacco()%></p>
            <p>PREG_CT: <%= physicianAdapter.getNumberPregnancies()%></p>
            <p>CHILD_DEATHS_CT: <%= physicianAdapter.getNumberDeaths()%></p>
            <p>CHILD_DEATHS: <%= physicianAdapter.getDeaths()%></p>
            <p>CONTRACEPTION: <%= physicianAdapter.getContraception()%></p>
            <p>CONT_DESIR: <%= physicianAdapter.getWantContraception()%></p>
            <p>CONT_AVAIL: <%= physicianAdapter.getAvailable()%></p>
            <p>MORE_KIDS: <%= physicianAdapter.getMoreChildren()%></p>
            <p>BORN_HOME: <%= physicianAdapter.getBornHome()%></p>
            <p>HELP_AT_BIRTH: <%= physicianAdapter.getHelpAfterBirth()%></p>
            <p>PREMATURE: <%= physicianAdapter.getPremature()%></p>
            <p>ASTHMA: <%= physicianAdapter.getAsthma()%></p>
            <p>BREATH_TEMP: <%= physicianAdapter.getBreathing()%></p>
            <p>COUGH_STAY: <%= physicianAdapter.getCoughing()%></p>
            <p>COUGH_NIGHT: <%= physicianAdapter.getNightCoughing()%></p>
            <p>ABDOMINAL_DIST: <%= physicianAdapter.getAbdominal()%></p>
            <p>SCARS_INJURIES: <%= physicianAdapter.getScars()%></p>
            <p>DIARRHEA: <%= physicianAdapter.getDiarrhea()%></p>
            <p>APPEARS_HEALTHY: <%= physicianAdapter.getAppearsHealthy()%></p>
            <p>HEART: <%= physicianAdapter.getHeart()%></p>
            <p>LUNGS: <%= physicianAdapter.getLungs()%></p>
            <p>Comments: <%= physicianAdapter.getComment()%></p>
            <p>Editor: <%= physicianAdapter.getEditor()%></p>
            
            
            <h3>Basics (Check-in Station)</h3>
            <p>Comments: <%= basicsAdapter.getComment()%></p>
            <p>Editor: <%= basicsAdapter.getEditor()%></p>
            <p>CREATE_DATE: <%= basicsAdapter.getCreateDate() %></p>
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