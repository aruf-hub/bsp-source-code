<%@ page import="java.sql.*, org.json.JSONObject" %>
<%@ include file="DBcon.jsp" %>
<%
    String sector = request.getParameter("sector");
    String plot = request.getParameter("plot");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    JSONObject jsonResponse = new JSONObject();

    try {
        conn = getConnection();

        // Check if record exists in ELEC_MASTER
        String sqlCheckELEC = "SELECT * FROM C##ESTATE.ELEC_MASTER WHERE SECTOR = ? AND PLOT = ?";
        stmt = conn.prepareStatement(sqlCheckELEC);
        stmt.setString(1, sector);
        stmt.setString(2, plot);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Record exists in ELEC_MASTER
            jsonResponse.put("sourceTable", "ELEC_MASTER");
            jsonResponse.put("sector", rs.getString("SECTOR"));
            jsonResponse.put("plot", rs.getString("PLOT"));
            jsonResponse.put("consumerNo", rs.getString("CONSUMER_NO"));
            jsonResponse.put("location", rs.getString("LOCATION"));
            jsonResponse.put("addressL1", rs.getString("ADDRESS_L1"));
            jsonResponse.put("addressL2", rs.getString("ADDRESS_L2"));
            jsonResponse.put("addressL3", rs.getString("ADDRESS_L3"));
            jsonResponse.put("meterNo", rs.getString("METER_NO"));
            jsonResponse.put("meterMake", rs.getString("METER_MAKE"));
            jsonResponse.put("meterKW", rs.getString("METER_KW"));
            jsonResponse.put("name", rs.getString("NAME"));
            jsonResponse.put("consumerType", rs.getString("CONSUMER_TYPE"));
            jsonResponse.put("phase", rs.getString("PHASE"));
            jsonResponse.put("supplyPur", rs.getString("SUPPLY_PUR"));
            jsonResponse.put("tariffCatg", rs.getString("TARIFF_CATG"));
            jsonResponse.put("consumerCatg", rs.getString("CONSUMER_CATG"));
            jsonResponse.put("loadSanc", rs.getString("LOAD_SANC"));
            jsonResponse.put("multFactor", rs.getString("MULT_FACTOR"));
            jsonResponse.put("assdConsp", rs.getString("ASSD_CONSPN"));
            jsonResponse.put("status", rs.getString("STATUS"));
            jsonResponse.put("remarks", rs.getString("REMARKS"));
            jsonResponse.put("solarMeterMake", rs.getString("SOLAR_METER_MAKE"));
            jsonResponse.put("solarMeterKW", rs.getString("SOLAR_METER_KW"));
            jsonResponse.put("solarLoadSanc", rs.getString("SOLAR_LOAD_SANC"));
            jsonResponse.put("solarPhase", rs.getString("SOLAR_PHASE"));
            jsonResponse.put("solarMultFactor", rs.getString("SOLAR_MULT_FACTOR"));
            jsonResponse.put("solarMeterStatus", rs.getString("SOLAR_METER_STATUS"));
            jsonResponse.put("solarMeterNo", rs.getString("SOLAR_METER_NO"));

            jsonResponse.put("enableFields", true);

            System.out.println("Debug: SECTOR value is " + rs.getString("SECTOR"));
            System.out.println("Debug: LOCATION value is " + rs.getString("LOCATION"));
        } else {
            // Record does not exist in ELEC_MASTER, check TP_MAS   
            rs.close();
            stmt.close();
            String sqlCheckTPMas = "SELECT SECTOR, PLOT, SECTOR || '/' || PLOT AS CONSUMER_NO, LOCATION, NAME, ELEC_CODE, STD_LUNITS, STD_PUNITS, LOAD_KW, STATUS, DECODE(SECTOR, 'AB', NULL, TRADE) AS TRADE, SUBSTR(NATURE, 1, 4) AS NATURE FROM C##ESTATE.TP_MAS WHERE SECTOR = ? AND PLOT = ?";
            stmt = conn.prepareStatement(sqlCheckTPMas);
            stmt.setString(1, sector);
            stmt.setString(2, plot);
            rs = stmt.executeQuery();

            if (rs.next()) {
                jsonResponse.put("sourceTable", "TP_MAS");
                jsonResponse.put("sector", rs.getString("SECTOR"));
                jsonResponse.put("plot", rs.getString("PLOT"));
                jsonResponse.put("consumerNo", rs.getString("CONSUMER_NO"));
                jsonResponse.put("location", rs.getString("LOCATION"));
                jsonResponse.put("name", rs.getString("NAME"));
                jsonResponse.put("elecCode", rs.getString("ELEC_CODE"));
                jsonResponse.put("stdLightUnits", rs.getString("STD_LUNITS"));
                jsonResponse.put("stdPowerUnits", rs.getString("STD_PUNITS"));
                jsonResponse.put("loadKW", rs.getString("LOAD_KW"));
                jsonResponse.put("status", rs.getString("STATUS"));
                jsonResponse.put("trade", rs.getString("TRADE") != null ? rs.getString("TRADE") : "");
                jsonResponse.put("nature", rs.getString("NATURE"));

                if ("D".equals(rs.getString("STATUS"))) {
                    jsonResponse.put("message", "This is a terminated party. Please check.");
                    out.print(jsonResponse.toString());
                    return;
                }

                if ("N".equals(rs.getString("ELEC_CODE"))) {
                    jsonResponse.put("message", "No electricity billing for this party.");
                    out.print(jsonResponse.toString());
                    return;
                }

                String sectorValue = rs.getString("SECTOR");
                String locationValue = rs.getString("LOCATION");
                if ("01,02,04,05,06,07,08,09,10,RS,CC,HS,MS".contains(sectorValue)) {
                    jsonResponse.put("addressL1", sectorValue);
                } else if ("LN".equals(sectorValue)) {
                    if (locationValue != null && locationValue.length() >= 2) {
                        jsonResponse.put("addressL1", locationValue.substring(0, 2));
                    } else {
                        jsonResponse.put("addressL1", "");
                    }
                }

                String elecCode = rs.getString("ELEC_CODE");
                String tariffCatg = "";
                if ("3,4,5,6,7".contains(elecCode)) {
                    tariffCatg = "LT1";
                } else if ("0,2,9,8".contains(elecCode)) {
                    tariffCatg = "LT2";
                } else if ("1".equals(elecCode)) {
                    tariffCatg = "LT3";
                }
                jsonResponse.put("tariffCatg", tariffCatg);

                if ("HOUS,LEAS,LICE".contains(rs.getString("NATURE"))) {
                    String sqlMeter = "SELECT METER_NO, METER_MAKE, METER_KW FROM C##ESTATE.ELEC_METER_MASTER_CURR WHERE SECTOR || STREET || QRNO || QRTYPE = ?";
                    PreparedStatement meterStmt = conn.prepareStatement(sqlMeter);
                    meterStmt.setString(1, rs.getString("LOCATION"));
                    ResultSet meterRs = meterStmt.executeQuery();

                    if (meterRs.next()) {
                        jsonResponse.put("meterNo", meterRs.getString("METER_NO"));
                        jsonResponse.put("meterMake", meterRs.getString("METER_MAKE"));
                        jsonResponse.put("meterKW", meterRs.getString("METER_KW"));
                    } else {
                        jsonResponse.put("meterNo", "");
                        jsonResponse.put("meterMake", "");
                        jsonResponse.put("meterKW", "");
                    }
                    meterRs.close();
                    meterStmt.close();
                }
            } else {
                jsonResponse.put("message", "No such master exists.");
                jsonResponse.put("clearFields", true);  // Add this line
            }
        }
    } catch (Exception e) {
        jsonResponse.put("error", e.getMessage());
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            jsonResponse.put("error", e.getMessage());
        }
    }

    out.print(jsonResponse.toString());
%>
