package Model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class DentalAdapter {
    private int formID;
Connection con;
    Statement st;
    ResultSet resultSet;

    public DentalAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setPresent(int number) {
        try {
            st.executeUpdate("UPDATE data SET TEETH_PRESENT = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setMissing(int number) {
        try {
            st.executeUpdate("UPDATE data SET TEETH_MISSING = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDecayed(int number) {
        try {
            st.executeUpdate("UPDATE data SET TEETH_DECAYED = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setFilled(int number) {
        try {
            st.executeUpdate("UPDATE data SET TEETH_FILLED = " + number + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getPresent() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT TEETH_PRESENT FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("TEETH_PRESENT");
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

    public String getMissing() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT TEETH_MISSING FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("TEETH_MISSING");
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

    public String getDecayed() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT TEETH_DECAYED FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("TEETH_DECAYED");
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

    public String getFilled() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT TEETH_FILLED FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("TEETH_FILLED");
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
            st.executeUpdate("UPDATE comments SET DENTAL = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DENTAL FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DENTAL");
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
            st.executeUpdate("UPDATE editors SET DENTAL = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT DENTAL FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("DENTAL");
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