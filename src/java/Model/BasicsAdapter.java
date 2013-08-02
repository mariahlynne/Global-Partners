package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BasicsAdapter {

    private int formID;
    Connection con, zcon;
    Statement st, zst;
    ResultSet resultSet;

    public BasicsAdapter(int id) {
        formID = id;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public BasicsAdapter() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients", "root", "password");
            st = con.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int generateID() {
        int result = 0;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        try {
            resultSet = st.executeQuery("SELECT MAX(FORMID) FROM data WHERE NOT FORMID = 999;");
            if (resultSet.first()) {
                result = resultSet.getInt(1) + 1;
                formID = result;
            }
            st.executeUpdate("INSERT INTO data (FORMID) values (" + result + ");");
            st.executeUpdate("INSERT INTO comments (FORMID) values (" + result + ");");
            st.executeUpdate("INSERT INTO editors (FORMID) values (" + result + ");");
            st.executeUpdate("UPDATE editors SET CREATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public void setName(String name) {
        try {
            st.executeUpdate("UPDATE data SET NAME = '" + name + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setYear(int year) {
        try {
            st.executeUpdate("UPDATE data SET BIRTH_YEAR = " + year + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setMonth(int month) {
        try {
            st.executeUpdate("UPDATE data SET BIRTH_MONTH = " + month + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setDay(int day) {
        try {
            st.executeUpdate("UPDATE data SET BIRTH_DAY = " + day + " WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setComment(String comment) {
        try {
            st.executeUpdate("UPDATE comments SET BASICS = '" + comment + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setEditor(String name) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        try {
            st.executeUpdate("UPDATE editors SET BASICS = '" + name + "' WHERE FORMID = " + formID + ";");
            st.executeUpdate("UPDATE editors SET UPDATE_DATE = '" + dateFormat.format(date) + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void setSex(String sex) {
        try {
            st.executeUpdate("UPDATE data SET SEX = '" + sex + "' WHERE FORMID = " + formID + ";");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String getName() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT NAME FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("NAME");
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
    
    public String getCreateDate() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT CREATE_DATE FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("CREATE_DATE");
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
    
    public String getUpdateDate() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT UPDATE_DATE FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("UPDATE_DATE");
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

    public int getYear() {
        int result = 0;
        try {
            resultSet = st.executeQuery("SELECT BIRTH_YEAR FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("BIRTH_YEAR");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int getMonth() {
        int result = 0;
        try {
            resultSet = st.executeQuery("SELECT BIRTH_MONTH FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("BIRTH_MONTH");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int getDay() {
        int result = 0;
        try {
            resultSet = st.executeQuery("SELECT BIRTH_DAY FROM data WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getInt("BIRTH_DAY");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getComment() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT BASICS FROM comments WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("BASICS");
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

    public String getEditor() {
        String result = "";
        try {
            resultSet = st.executeQuery("SELECT BASICS FROM editors WHERE FORMID = " + formID + ";");
            if (resultSet.first()) {
                result = resultSet.getString("BASICS");
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

    public int getZscore(int months, boolean isFemale, double bmi) {
        double mean = 0;
        double std = 0;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            zcon = DriverManager.getConnection("jdbc:mysql://localhost:3306/Patients_Static", "root", "password");
            zst = zcon.createStatement();
            if (isFemale) {
                resultSet = zst.executeQuery("SELECT MEAN, STD_DEV FROM bmi_girls WHERE MONTHS = " + months + ";");
            } else {
                resultSet = zst.executeQuery("SELECT MEAN, STD_DEV FROM bmi_boys WHERE MONTHS = " + months + ";");
            }
            if (resultSet.first()) {
                mean = resultSet.getDouble("MEAN");
                std = resultSet.getDouble("STD_DEV");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return (int) ((bmi - mean)/(std * mean));
    }
}