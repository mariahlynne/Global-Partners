
package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class LabAdapter {
    private int formID;
    Connection con;
    Statement st;
    ResultSet resultSet;

    public LabAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setGlucose(int val) {
        try {
            st.executeUpdate("UPDATE data SET GLUC = " + val + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getGlucose() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT GLUC FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("GLUC");
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

    public void setHemoglobin(double val) {
        try {
            st.executeUpdate("UPDATE data SET HBG = " + val + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getHemoglobin() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HBG FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HBG");
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
            st.executeUpdate("UPDATE comments SET LAB_STATION = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT LAB_STATION FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("LAB_STATION");
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
            st.executeUpdate("UPDATE editors SET LAB_STATION = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT LAB_STATION FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("LAB_STATION");
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
