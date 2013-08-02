package Model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class MeasurementAdapter {
    private int formID;
    Connection con;
    Statement st;
    ResultSet resultSet;

    public MeasurementAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public void setWeight(double val) {
        try {
            st.executeUpdate("UPDATE data SET WEIGHT = " + val + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getWeight() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT WEIGHT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("WEIGHT");
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

    public void setHeight(double val) {
        try {
            st.executeUpdate("UPDATE data SET HEIGHT = " + val + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getHeight() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HEIGHT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HEIGHT");
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

    public void setHead(double d) {
        try {
            st.executeUpdate("UPDATE data SET HEAD_CIRC = " + d + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getHead() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HEAD_CIRC FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HEAD_CIRC");
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

    public String getSex() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT SEX FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("SEX");
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
            st.executeUpdate("UPDATE comments SET HEIGHTWEIGHT = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HEIGHTWEIGHT FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HEIGHTWEIGHT");
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
            st.executeUpdate("UPDATE editors SET HEIGHTWEIGHT = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT HEIGHTWEIGHT FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("HEIGHTWEIGHT");
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