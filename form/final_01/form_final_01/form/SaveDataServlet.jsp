<%@ page import="java.sql.*, java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ include file="DBcon.jsp" %>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
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
        int rowsUpdated = stmt.executeUpdate();
%>
        <!DOCTYPE html>
        <html>
        <head>
            <title>Save Data</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }
                .container {
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 5px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    text-align: center;
                }
                .container p {
                    font-size: 18px;
                    margin: 20px 0;
                }
                .button {
                    background-color: #007BFF;
                    color: white;
                    padding: 10px 20px;
                    text-decoration: none;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }
                .button:hover {
                    background-color: #0056b3;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <p><%= (rowsUpdated > 0) ? "Data updated successfully" : "No data was updated." %></p>
                <a href="javascript:window.history.back();" class="button">Back</a>
            </div>
        </body>
        </html>
<%
    } catch (Exception e) {
        e.printStackTrace();
%>
        <!DOCTYPE html>
        <html>
        <head>
            <title>Error</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                    margin: 0;
                }
                .container {
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 5px;
                    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    text-align: center;
                }
                .container p {
                    font-size: 18px;
                    margin: 20px 0;
                    color: #e74c3c;
                }
                .button {
                    background-color: #007BFF;
                    color: white;
                    padding: 10px 20px;
                    text-decoration: none;
                    border-radius: 5px;
                    transition: background-color 0.3s ease;
                }
                .button:hover {
                    background-color: #0056b3;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <p>Error: <%= e.getMessage() %></p>
                <a href="javascript:window.history.back();" class="button">Back</a>
            </div>
        </body>
        </html>
<%
    } finally {
        // Close resources
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
} else {
%>
    <!DOCTYPE html>
    <html>
    <head>
        <title>Error</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }
            .container p {
                font-size: 18px;
                margin: 20px 0;
                color: #e74c3c;
            }
            .button {
                background-color: #007BFF;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
            .button:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <p>Invalid request method.</p>
            <a href="javascript:window.history.back();" class="button">Back</a>
        </div>
    </body>
    </html>
<%
}
%>
