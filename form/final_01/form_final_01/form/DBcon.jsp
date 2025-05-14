<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<%! 
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String DB_USER = "C##ESTATE";
    private static final String DB_PASSWORD = "elec";

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
%>  