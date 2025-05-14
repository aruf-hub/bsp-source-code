<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ include file="DBcon.jsp" %>
<!--%@ page contentType="text/html;charset=ISO-8859-1" %-->
<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    // Retrieve form parameters
    String sector = request.getParameter("sector");
    String plot = request.getParameter("plot");
    String consumerNo = request.getParameter("consumerNo");
    String location = request.getParameter("location");
    String name = request.getParameter("name");
    String status = request.getParameter("status");
    String sancload = request.getParameter("sancload");
    String multifactor = request.getParameter("multifactor");
    String remarks = request.getParameter("remarks");
    String sourceTable = request.getParameter("sourceTable");

    // Initialize database resources
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        conn = getConnection();

        if ("ELEC_MASTER".equals(sourceTable)) {
            // Update ELEC_MASTER table
            String updateSql = "UPDATE ELEC_MASTER SET CONSUMER_NO = ?, LOCATION = ?, NAME = ?, STATUS = ?, METER_NO = ?, METER_MAKE = ?, METER_KW = ?, LOAD_SANC = ?, PHASE = ?, MULT_FACTOR = ?, SOLAR_METER_NO = ?, SOLAR_METER_MAKE = ?, SOLAR_METER_KW = ?, SOLAR_LOAD_SANC = ?, SOLAR_PHASE = ?, SOLAR_MULT_FACTOR = ?, SOLAR_METER_STATUS = ?, CONSUMER_TYPE = ?, TARIFF_CATG = ?, CONSUMER_CATG = ?, REMARKS = ? WHERE SECTOR = ? AND PLOT = ?";
            stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, consumerNo);
            stmt.setString(2, location);
            stmt.setString(3, name);
            stmt.setString(4, status);
            stmt.setString(5, request.getParameter("meterno"));
            stmt.setString(6, request.getParameter("metermake"));
            stmt.setString(7, request.getParameter("meterKW"));
            stmt.setString(8, sancload);
            stmt.setString(9, request.getParameter("phase"));
            stmt.setString(10, multifactor);
            stmt.setString(11, request.getParameter("solarmeterno"));
            stmt.setString(12, request.getParameter("solarmetermake"));
            stmt.setString(13, request.getParameter("solarMeterKW"));
            stmt.setString(14, request.getParameter("solarsancload"));
            stmt.setString(15, request.getParameter("solarphase"));
            stmt.setString(16, request.getParameter("solarmultifactor"));
            stmt.setString(17, request.getParameter("solarmeterstatus"));
            stmt.setString(18, request.getParameter("consumerType"));
            stmt.setString(19, request.getParameter("tariffCatg"));
            stmt.setString(20, request.getParameter("consumerCatg"));
            stmt.setString(21, remarks);
            stmt.setString(22, sector);
            stmt.setString(23, plot);
        } else if ("TP_MAS".equals(sourceTable)) {
            // Update TP_MAS table
            String updateSql = "UPDATE TP_MAS SET LOCATION = ?, NAME = ?, STATUS = ?, LOAD_KW = ?, STD_LUNITS = ?, STD_PUNITS = ?, REMARKS = ? WHERE SECTOR = ? AND PLOT = ?";
            stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, location);
            stmt.setString(2, name);
            stmt.setString(3, status);
            stmt.setString(4, sancload);
            stmt.setString(5, request.getParameter("stdLightUnits"));
            stmt.setString(6, request.getParameter("stdPowerUnits"));
            stmt.setString(7, remarks);
            stmt.setString(8, sector);
            stmt.setString(9, plot);
        } else {
            throw new SQLException("Invalid source table: " + sourceTable);
        }

        // Execute the statement
        stmt.executeUpdate();
%>
        <!DOCTYPE html>
        <html>
        <head>
        <title>Save Data</title>
        </head>
        <body>
        <p>Data updated successfully</p>
        <button onclick="window.history.back()">Back</button>
        </body>
        </html>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>

<%
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
}
%>
