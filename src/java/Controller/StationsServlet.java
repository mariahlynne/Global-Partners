package Controller;

import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Date;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class StationsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/xml");
        response.setHeader("Cache-Control", "no-cache");
        String station = request.getParameter("station");
        HttpSession userSession = request.getSession(true);
        PrintWriter out = response.getWriter();


        if (station.equals("BloodPressure")) {
            String sysString = request.getParameter("systolicField");
            String diaString = request.getParameter("diastolicField");
            String comment = request.getParameter("comment");
            Scanner scanner = new Scanner(sysString);
            int sys = scanner.nextInt();
            scanner = new Scanner(diaString);
            int dia = scanner.nextInt();
            String editor = userSession.getAttribute("editor").toString();
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            BPAdapter bpAdapt = new BPAdapter(formId);
            bpAdapt.setBP(sys, dia);
            bpAdapt.setComment(comment);
            bpAdapt.setEditor(editor);

        } else if (station.equals("Basics")) {
            String name = request.getParameter("nameField");
            String comment = request.getParameter("comment");
            String yearString = request.getParameter("year");
            String monthString = request.getParameter("month");
            String dayString = request.getParameter("day");
            String sex = request.getParameter("sexField");
            Scanner scanner = new Scanner(yearString);
            int year = scanner.nextInt();
            scanner = new Scanner(monthString);
            int month = scanner.nextInt();
            scanner = new Scanner(dayString);
            int day = scanner.nextInt();
            String editor = userSession.getAttribute("editor").toString();
            String newPatient = userSession.getAttribute("newPatient").toString();
            int id;
            BasicsAdapter adapter;
            if (newPatient.equals("true")) {
                userSession.setAttribute("newPatient", "false");
                adapter = new BasicsAdapter();
                id = adapter.generateID();
            } else {
                String idString = userSession.getAttribute("formId").toString();
                scanner = new Scanner(idString);
                id = scanner.nextInt();
                adapter = new BasicsAdapter(id);

            }
            adapter.setYear(year);
            adapter.setMonth(month);
            adapter.setDay(day);
            adapter.setName(name);
            adapter.setSex(sex);
            adapter.setComment(comment);
            adapter.setEditor(editor);
            out.println(id + " and they are " + getAge(year, month, day) + " years old.");
            userSession.setAttribute("formId", id);

        } else if (station.equals("Dental")) {
            int present = Integer.parseInt(request.getParameter("present"));
            int missing = Integer.parseInt(request.getParameter("missing"));
            int decayed = Integer.parseInt(request.getParameter("decayed"));
            int filled = Integer.parseInt(request.getParameter("filled"));
            String comment = request.getParameter("comment");
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            String editor = userSession.getAttribute("editor").toString();
            DentalAdapter adapter = new DentalAdapter(formId);
            adapter.setPresent(present);
            adapter.setMissing(missing);
            adapter.setDecayed(decayed);
            adapter.setFilled(filled);
            adapter.setComment(comment);
            adapter.setEditor(editor);

        } else if (station.equals("Measurement")) {
            String weightString = request.getParameter("weightField");
            String comment = request.getParameter("comment");
            Scanner scanner = new Scanner(weightString);
            double weight = scanner.nextDouble();
            String heightString = request.getParameter("heightField");
            scanner = new Scanner(heightString);
            double height = scanner.nextDouble();
            String headString = request.getParameter("headField");
            double head = 0;
            if (headString != null) {
                scanner = new Scanner(headString);
                head = scanner.nextDouble();
            }
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            String editor = userSession.getAttribute("editor").toString();
            MeasurementAdapter adapter = new MeasurementAdapter(formId);
            adapter.setWeight(weight);
            adapter.setHeight(height);
            adapter.setHead(head);
            adapter.setComment(comment);
            adapter.setEditor(editor);

        } else if (station.equals("BMI")) {
            String bmiString = request.getParameter("bmi");
            double bmi = 0;
            if (bmiString != null) {
                Scanner scanner = new Scanner(bmiString);
                bmi = scanner.nextDouble();
            }
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            BasicsAdapter adapter = new BasicsAdapter(formId);
            int months = getAgeMonths(adapter.getYear(), adapter.getMonth(), adapter.getDay());
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
                out.println("BMI: " + bmi + "<br />"
                        + "Classification: " + classification + "<br />");
            } else {
                int zscore = adapter.getZscore(months, adapter.getSex().contains("F"), bmi);
                out.println("BMI: " + bmi + "<br />"
                        + "Z-Score: " + zscore + "<br />");
            }

        } else if (station.equals("LabStation")) {
            String hbgString = request.getParameter("hemoglobinField");
            String glucString = request.getParameter("glucoseField");
            String comment = request.getParameter("comment");
            Scanner scanner = new Scanner(hbgString);
            double hbg = scanner.nextDouble();
            int gluc = 0;
            if (glucString != null) {
                scanner = new Scanner(glucString);
                gluc = scanner.nextInt();
            }
            String editor = userSession.getAttribute("editor").toString();
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            LabAdapter adapt = new LabAdapter(formId);
            adapt.setHemoglobin(hbg);
            adapt.setGlucose(gluc);
            adapt.setComment(comment);
            adapt.setEditor(editor);

        } else if (station.equals("AdultDemographics")) {
            String houseNumber = request.getParameter("houseNumber");
            String partner = request.getParameter("partner");
            String partnerName = "";
            if (partner.equals("Y")) {
                partnerName = request.getParameter("partnerName");
            }
            String community = request.getParameter("community");
            String communityName = "Santa Marta";
            String communityLengthString = "";
            int years = 0;
            if (community.equals("N")) {
                communityName = request.getParameter("communityName");
            } else {
                communityLengthString = request.getParameter("communityLength");
                Scanner scanner = new Scanner(communityLengthString);
                years = scanner.nextInt();
            }
            String job = request.getParameter("job");
            String comment = request.getParameter("comment");
            String editor = userSession.getAttribute("editor").toString();
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            DemographicsAdapter demAdapt = new DemographicsAdapter(formId);
            demAdapt.setHouseNumber(houseNumber);
            demAdapt.setPartner(partner);
            demAdapt.setPartnerName(partnerName);
            demAdapt.setCommunity(community);
            demAdapt.setCommunityName(communityName);
            demAdapt.setCommunityLength(years);
            demAdapt.setJob(job);
            demAdapt.setComment(comment);
            demAdapt.setEditor(editor);

        } else if (station.equals("ChildDemographics")) {
            String houseNumber = request.getParameter("houseNumber");
            String dadName = request.getParameter("dadName");
            String momName = request.getParameter("momName");
            String secondary = request.getParameter("secondary");
            String primary = request.getParameter("primary");
            String reason = request.getParameter("reason");
            String comment = request.getParameter("comment");
            String editor = userSession.getAttribute("editor").toString();
            String level = "";
            if (reason != null) {
                if (reason.length() > 0) {
                    if (!reason.equals("Too young")) {
                        level = "Not in school: ";
                    }
                }
            }
            if (primary != null) {
                if (primary.equals("Completed")) {
                    level += "Primary=Completed; Secondary=" + secondary;
                } else {
                    level += "Primary=" + primary + ";";
                }
            } else {
                level = "Not in school";
            }

            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            DemographicsAdapter demAdapt = new DemographicsAdapter(formId);
            demAdapt.setHouseNumber(houseNumber);
            demAdapt.setMomName(momName);
            demAdapt.setDadName(dadName);
            demAdapt.setComment(comment);
            demAdapt.setSchoolReason(reason);
            demAdapt.setSchoolLevel(level);
            demAdapt.setEditor(editor);

        } else if (station.equals("AdultPhysician")) {
            String sex = request.getParameter("sex");
            boolean isFemale = sex != null;
            String tobacco = request.getParameter("tobacco");
            String healthy = request.getParameter("healthy");
            String heart = request.getParameter("heart");
            String lungs = request.getParameter("lungs");
            if (healthy.equals("No")) {
                healthy = "No: " + request.getParameter("healthyReason");
            }
            if (heart.equals("No")) {
                heart = "No: " + request.getParameter("heartReason");
            }
            if (lungs.equals("No")) {
                lungs = "No: " + request.getParameter("lungsReason");
            }

            String comment = request.getParameter("comment");
            String editor = userSession.getAttribute("editor").toString();
            String tobaccoAmount = "None";
            if (tobacco.equals("Yes")) {
                tobaccoAmount = request.getParameter("tobaccoAmount");
            }
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            PhysicianStationAdapter adapter = new PhysicianStationAdapter(formId);
            adapter.setTobacco(tobaccoAmount);
            adapter.setAppearsHealthy(healthy);
            adapter.setHeart(heart);
            adapter.setLungs(lungs);
            if (isFemale) {
                String pregnanciesString = request.getParameter("pregnancies");
                String deadString = request.getParameter("dead");
                Scanner scanner = new Scanner(pregnanciesString);
                int pregnancies = scanner.nextInt();
                int dead = -1;
                if (deadString.length() != 0) {
                    scanner = new Scanner(deadString);
                    dead = scanner.nextInt();
                }
                String reasons = request.getParameter("reasons");
                String contraception = request.getParameter("contraception");
                if (contraception.equals("Yes")) {
                    contraception += ": " + request.getParameter("type");
                }
                if (contraception.contains("Other")) {
                    contraception += "-" + request.getParameter("other");
                }
                String moreChildren = request.getParameter("moreChildren");
                String wantContraception = request.getParameter("wantContraception");
                String available = request.getParameter("available");
                adapter.setNumberPregnancies(pregnancies);
                adapter.setNumberDeaths(dead);
                adapter.setDeaths(reasons);
                adapter.setContraception(contraception);
                adapter.setMoreChildren(moreChildren);
                adapter.setWantContraception(wantContraception);
                adapter.setAvailable(available);
            }
            adapter.setComment(comment);
            adapter.setEditor(editor);

        } else if (station.equals("ChildPhysicianStation")) {
            String healthy = request.getParameter("healthy");
            String heart = request.getParameter("heart");
            String lungs = request.getParameter("lungs");
            if (healthy.equals("No")) {
                healthy = "No: " + request.getParameter("healthyReason");
            }
            if (heart.equals("No")) {
                heart = "No: " + request.getParameter("heartReason");
            }
            if (lungs.equals("No")) {
                lungs = "No: " + request.getParameter("lungsReason");
            }
            String bornHome = request.getParameter("bornHome");
            String premature = request.getParameter("premature");
            String helpAfterBirth = request.getParameter("helpAfterBirth");
            String diarrhea = request.getParameter("diarrhea");
            String asthma = request.getParameter("asthma");
            String coughing = request.getParameter("coughing");
            String nightCoughing = request.getParameter("nightCoughing");
            String breathing = request.getParameter("breathing");
            String abdominal = request.getParameter("abdominal");
            String scars = request.getParameter("scars");
            String comment = request.getParameter("comment");
            String editor = userSession.getAttribute("editor").toString();
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            PhysicianStationAdapter adapter = new PhysicianStationAdapter(formId);
            adapter.setBornHome(bornHome);
            adapter.setPremature(premature);
            adapter.setHelpAfterBirth(helpAfterBirth);
            adapter.setDiarrhea(diarrhea);
            adapter.setAsthma(asthma);
            adapter.setCoughing(coughing);
            adapter.setNightCoughing(nightCoughing);
            adapter.setBreathing(breathing);
            adapter.setAbdominal(abdominal);
            adapter.setScars(scars);
            adapter.setAppearsHealthy(healthy);
            adapter.setHeart(heart);
            adapter.setLungs(lungs);
            adapter.setComment(comment);
            adapter.setEditor(editor);

        } else if (station.equals("TeenFemalePhysicianStation")) {
            String healthy = request.getParameter("healthy");
            String heart = request.getParameter("heart");
            String lungs = request.getParameter("lungs");
            if (healthy.equals("No")) {
                healthy = "No: " + request.getParameter("healthyReason");
            }
            if (heart.equals("No")) {
                heart = "No: " + request.getParameter("heartReason");
            }
            if (lungs.equals("No")) {
                lungs = "No: " + request.getParameter("lungsReason");
            }
            String bornHome = request.getParameter("bornHome");
            String premature = request.getParameter("premature");
            String helpAfterBirth = request.getParameter("helpAfterBirth");
            String diarrhea = request.getParameter("diarrhea");
            String asthma = request.getParameter("asthma");
            String coughing = request.getParameter("coughing");
            String nightCoughing = request.getParameter("nightCoughing");
            String breathing = request.getParameter("breathing");
            String abdominal = request.getParameter("abdominal");
            String scars = request.getParameter("scars");
            String comment = request.getParameter("comment");
            String editor = userSession.getAttribute("editor").toString();
            int formId = ((Number) userSession.getAttribute("formId")).intValue();
            PhysicianStationAdapter adapter = new PhysicianStationAdapter(formId);
            adapter.setBornHome(bornHome);
            adapter.setPremature(premature);
            adapter.setHelpAfterBirth(helpAfterBirth);
            adapter.setDiarrhea(diarrhea);
            adapter.setAsthma(asthma);
            adapter.setCoughing(coughing);
            adapter.setNightCoughing(nightCoughing);
            adapter.setBreathing(breathing);
            adapter.setAbdominal(abdominal);
            adapter.setScars(scars);
            adapter.setAppearsHealthy(healthy);
            adapter.setHeart(heart);
            adapter.setLungs(lungs);
            adapter.setComment(comment);
            adapter.setEditor(editor);

            String contraception = request.getParameter("contraception");
            if (contraception.equals("Yes")) {
                contraception += ": " + request.getParameter("type");
            }
            if (contraception.contains("Other")) {
                contraception += "-" + request.getParameter("other");
            }
            adapter.setContraception(contraception);
            if (request.getParameter("pregnant").equals("Yes")) {
                String pregnanciesString = request.getParameter("pregnancies");
                String deadString = request.getParameter("dead");
                Scanner scanner = new Scanner(pregnanciesString);
                int pregnancies = scanner.nextInt();
                if (pregnancies == -1) {
                    pregnancies = 0;
                }
                int dead = -1;
                if (deadString.length() != 0) {
                    scanner = new Scanner(deadString);
                    dead = scanner.nextInt();
                }
                String reasons = request.getParameter("reasons");
                String moreChildren = request.getParameter("moreChildren");
                String wantContraception = request.getParameter("wantContraception");
                String available = request.getParameter("available");
                adapter.setNumberPregnancies(pregnancies);
                adapter.setNumberDeaths(dead);
                adapter.setDeaths(reasons);

                adapter.setMoreChildren(moreChildren);
                adapter.setWantContraception(wantContraception);
                adapter.setAvailable(available);
            }

        } else if (station.equals("Search")) {
            Connection con;
            String criteria = null;
            boolean isCheckIn = false;
            try {
                out.println("<tr id=\"headerRow\" class=\"header\"><th >ID</th><th id=\"nameCol\">Name</th><th class=\"smallCol\">Age</th><th class=\"smallCol\">Sex</th></tr>");
                String page = userSession.getAttribute("destination").toString();
                if (page.equals("CheckIn.jsp")) {
                    isCheckIn = true;
                }
                String name = request.getParameter("nameField");
                String formId = request.getParameter("idField");
                String ageString = request.getParameter("ageField");
                String sex;
                int age = -1, year = 0, month = 0, day = 0;
                if (formId.length() != 0) {
                    criteria = "FORMID like '%" + formId + "%'";
                }
                if (name.length() != 0) {
                    if (criteria != null) {
                        criteria = criteria + "AND NAME like '%" + name + "%'";
                    } else {
                        criteria = "NAME like '%" + name + "%'";
                    }
                }
                if (ageString.length() != 0) {
                    age = Integer.parseInt(ageString);
                    int yearToday = new Date().getYear() + 1900;
                    int minYear = yearToday - (int) (age * .15 + age);
                    int maxYear = yearToday + (int) (age * .15 - age);
                    if (criteria != null) {
                        criteria = criteria + "AND BIRTH_YEAR >= " + minYear + " AND BIRTH_YEAR <= " + maxYear + " ";
                    } else {
                        criteria = "BIRTH_YEAR >= " + minYear + " AND BIRTH_YEAR <= " + maxYear + " ";
                    }
                }
                if (criteria != null) {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
                    Statement st = con.createStatement();
                    ResultSet resultSet = st.executeQuery("SELECT FORMID, NAME, BIRTH_YEAR, BIRTH_MONTH, BIRTH_DAY, SEX FROM data WHERE " + criteria + "ORDER BY "
                            + "FORMID ASC;");
                    boolean oddRow = true;
                    String[] className = {"oddRow", "evenRow"};
                    String row;
                    while (resultSet.next()) {
                        if (oddRow) {
                            row = className[0];
                            oddRow = false;
                        } else {
                            row = className[1];
                            oddRow = true;
                        }
                        formId = resultSet.getString("FORMID");
                        name = resultSet.getString("NAME");
                        sex = resultSet.getString("SEX");
                        year = resultSet.getInt("BIRTH_YEAR");
                        month = resultSet.getInt("BIRTH_MONTH");
                        day = resultSet.getInt("BIRTH_DAY");
                        if (year == 0) {
                            age = -1;
                            ageString = "?";
                        } else {
                            age = getAge(year, month, day);
                            ageString = "" + age;
                        }
                        out.println("<tr class=\"row " + row + "\">");
                        if (isCheckIn) {
                            out.println("<td><a href=\"CheckInServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + formId + "</a></td>");
                            out.println("<td><a href=\"CheckInServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + name + "</a></td>");
                            out.println("<td><a href=\"CheckInServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + ageString + "</a></td>");
                            out.println("<td><a href=\"CheckInServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + sex + "</a></td>");
                        } else {
                            out.println("<td><a href=\"ResultsServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + formId + "</a></td>");
                            out.println("<td><a href=\"ResultsServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + name + "</a></td>");
                            out.println("<td><a href=\"ResultsServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + ageString + "</a></td>");
                            out.println("<td><a href=\"ResultsServlet?name=" + name + "&sex=" + sex + "&formId=" + formId + "&age=" + age + "\">" + sex + "</a></td>");
                        }
                        out.println("</tr>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public int getAge(int year, int month, int day) {
        Date now = new Date();
        int nowMonth = now.getMonth() + 1;
        int nowYear = now.getYear() + 1900;
        int result = nowYear - year;

        if (month > nowMonth) {
            result--;
        } else if (month == nowMonth) {
            int nowDay = now.getDate();

            if (day > nowDay) {
                result--;
            }
        }
        return result;
    }

    public int getAgeMonths(int year, int month, int day) {
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
        return result;
    }
}