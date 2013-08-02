package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PhysicianStationAdapter {

    private int formID;
    Connection con;
    Statement st;
    ResultSet resultSet;

    public PhysicianStationAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setBornHome(String bornHome) {
        try {
            st.executeUpdate("UPDATE data SET BORN_HOME = '" + bornHome + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPremature(String premature) {
        try {
            st.executeUpdate("UPDATE data SET PREMATURE = '" + premature + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setHelpAfterBirth(String helpAfterBirth) {
        try {
            st.executeUpdate("UPDATE data SET HELP_AT_BIRTH = '" + helpAfterBirth + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setAsthma(String asthma) {
        try {
            st.executeUpdate("UPDATE data SET ASTHMA = '" + asthma + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setBreathing(String breathing) {
        try {
            st.executeUpdate("UPDATE data SET BREATH_TEMP = '" + breathing + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setCoughing(String coughing) {
        try {
            st.executeUpdate("UPDATE data SET COUGH_STAY = '" + coughing + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setNightCoughing(String nightCoughing) {
        try {
            st.executeUpdate("UPDATE data SET COUGH_NIGHT = '" + nightCoughing + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    public void setWheezing(String wheezing) {
//        try {
//            st.executeUpdate("UPDATE data SET WHEEZE = '" + wheezing + "' WHERE FORMID = " + formID + ";");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    public void setAbdominal(String abdominal) {
        try {
            st.executeUpdate("UPDATE data SET ABDOMINAL_DIST = '" + abdominal + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setScars(String scars) {
        try {
            st.executeUpdate("UPDATE data SET SCARS_INJURIES = '" + scars + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDiarrhea(String diarrhea) {
        try {
            st.executeUpdate("UPDATE data SET DIARRHEA = '" + diarrhea + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setTobacco(String tobacco) {
        try {
            st.executeUpdate("UPDATE data SET TOBAC = '" + tobacco + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setNumberPregnancies(int number) {
        try {
            st.executeUpdate("UPDATE data SET PREG_CT = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setNumberDeaths(int number) {
        try {
            st.executeUpdate("UPDATE data SET CHILD_DEATHS_CT = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDeaths(String reasons) {
        try {
            st.executeUpdate("UPDATE data SET CHILD_DEATHS = '" + reasons + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setContraception(String reasons) {
        try {
            st.executeUpdate("UPDATE data SET CONTRACEPTION = '" + reasons + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setMoreChildren(String more) {
        try {
            st.executeUpdate("UPDATE data SET MORE_KIDS = '" + more + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setWantContraception(String want) {
        try {
            st.executeUpdate("UPDATE data SET CONT_DESIR = '" + want + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setAvailable(String available) {
        try {
            st.executeUpdate("UPDATE data SET CONT_AVAIL = '" + available + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setAppearsHealthy(String healthy) {
        try {
            st.executeUpdate("UPDATE data SET APPEARS_HEALTHY = '" + healthy + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setHeart(String heart) {
        try {
            st.executeUpdate("UPDATE data SET HEART = '" + heart + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setLungs(String lungs) {
        try {
            st.executeUpdate("UPDATE data SET LUNGS = '" + lungs + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getBornHome() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT BORN_HOME FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("BORN_HOME");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getPremature() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT PREMATURE FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("PREMATURE");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getHelpAfterBirth() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HELP_AT_BIRTH FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HELP_AT_BIRTH");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getAsthma() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT ASTHMA FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("ASTHMA");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getBreathing() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT BREATH_TEMP FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("BREATH_TEMP");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getCoughing() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT COUGH_STAY FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("COUGH_STAY");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getNightCoughing() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT COUGH_NIGHT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("COUGH_NIGHT");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getTobacco() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT TOBAC FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("TOBAC");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

//    public String getWheezing() {
//        String result = "";
//        try {
//            resultSet = st.executeQuery("SELECT WHEEZE FROM data WHERE FORMID = " + formID + ";");
//            if (resultSet.first()) {
//                result = resultSet.getString("WHEEZE");
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        if (result == null) {
//            return "";
//        } else {
//            return result;
//        }
//    }

    public String getAbdominal() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT ABDOMINAL_DIST FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("ABDOMINAL_DIST");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getScars() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT SCARS_INJURIES FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("SCARS_INJURIES");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getDiarrhea() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DIARRHEA FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DIARRHEA");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public int getNumberPregnancies() {
        int result = -1;
        try {
            resultSet = st.executeQuery("SELECT PREG_CT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("PREG_CT");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }


    public int getNumberDeaths() {
        int result = -1;
        try {
            resultSet = st.executeQuery("SELECT CHILD_DEATHS_CT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("CHILD_DEATHS_CT");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getDeaths() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT CHILD_DEATHS FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("CHILD_DEATHS");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getContraception() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT CONTRACEPTION FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("CONTRACEPTION");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getMoreChildren() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT MORE_KIDS FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("MORE_KIDS");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getWantContraception() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT CONT_DESIR FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("CONT_DESIR");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getAvailable() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT CONT_AVAIL FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("CONT_AVAIL");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getAppearsHealthy() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT APPEARS_HEALTHY FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("APPEARS_HEALTHY");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getHeart() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HEART FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HEART");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public String getLungs() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT LUNGS FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("LUNGS");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public void setComment(String comment) {
        try {
            st.executeUpdate("UPDATE comments SET PHYSICIAN = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT PHYSICIAN FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("PHYSICIAN");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }

    public void setEditor(String name) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        try {
            st.executeUpdate("UPDATE editors SET PHYSICIAN = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT PHYSICIAN FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("PHYSICIAN");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == null) {
            return "";
        } else {
            return result;
        }
    }
}
