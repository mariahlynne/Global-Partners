package Model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DemographicsAdapter {

    private int formID;
    Connection con;
    Statement st;
    ResultSet resultSet;

    public DemographicsAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setHouseNumber(String houseNumber) {
        try {
            st.executeUpdate("UPDATE data SET HOUSE = '" + houseNumber + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setJob(String job) {
        try {
            st.executeUpdate("UPDATE data SET JOB = '" + job + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPartner(String partner) {
        try {
            st.executeUpdate("UPDATE data SET PARTNER = '" + partner + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPartnerName(String partnerName) {
        try {
            st.executeUpdate("UPDATE data SET PARTNER_NM = '" + partnerName + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setMomName(String momName) {
        try {
            st.executeUpdate("UPDATE data SET MOM_NAME = '" + momName + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDadName(String dadName) {
        try {
            st.executeUpdate("UPDATE data SET DAD_NAME = '" + dadName + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setSchoolLevel(String level) {
        try {
            st.executeUpdate("UPDATE data SET ATT_SCHL = '" + level + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setSchoolReason(String reason) {
        if (reason == null) {
            reason = "N/A";
        }
        try {
            st.executeUpdate("UPDATE data SET SCHL_WHY = '" + reason + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setCommunityName(String name) {
        try {
            st.executeUpdate("UPDATE data SET COMMUNITY_NAME = '" + name + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setCommunity(String name) {
        try {
            st.executeUpdate("UPDATE data SET COMMUNITY = '" + name + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setCommunityLength(int years) {
        try {
            st.executeUpdate("UPDATE data SET COMMUNITY_LENGTH = " + years + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getHouseNumber() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HOUSE FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HOUSE");
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

    public String getJob() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT JOB FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("JOB");
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

    public String getPartner() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT PARTNER FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("PARTNER");
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

    public String getPartnerName() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT PARTNER_NM FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("PARTNER_NM");
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

    public String getMomName() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT MOM_NAME FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("MOM_NAME");
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

    public String getDadName() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DAD_NAME FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DAD_NAME");
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

    public String getSchoolLevel() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT ATT_SCHL FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("ATT_SCHL");
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

    public String getSchoolReason() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT SCHL_WHY FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("SCHL_WHY");
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

    public String getCommunity() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT COMMUNITY FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("COMMUNITY");
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

    public String getCommunityName() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT COMMUNITY_NAME FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("COMMUNITY_NAME");
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

    public int getCommunityLength() {
        int result = 0;
        try {
            resultSet = st.executeQuery("SELECT COMMUNITY_LENGTH FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("COMMUNITY_LENGTH");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void setComment(String comment) {
        try {
            st.executeUpdate("UPDATE comments SET DEMOGRAPHICS = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DEMOGRAPHICS FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DEMOGRAPHICS");
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
            st.executeUpdate("UPDATE editors SET DEMOGRAPHICS = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DEMOGRAPHICS FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DEMOGRAPHICS");
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
