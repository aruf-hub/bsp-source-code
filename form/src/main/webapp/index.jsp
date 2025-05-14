<!DOCTYPE html>
<%@ include file="DBcon.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="styles.css">
<title>Electricity Data</title>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        function fetchData() {
            var sector = document.getElementById("sector").value;
            var plot = document.getElementById("plot").value;

            if (sector.length === 2 && plot.length === 3) {
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        var data = JSON.parse(xhr.responseText);

                        console.log("Response received: ", data);

                        if (data.error) {
                            alert(data.error);
                        } else if (data.message) {
                            alert(data.message);
                        } else {
                            document.getElementById("consumerNo").value = data.consumerNo || '';
                            document.getElementById("location").value = data.location || '';
                            document.getElementById("name").value = data.name || '';
                            document.getElementById("physector").value = data.addressL1 || '';
                            document.getElementById("street").value = data.addressL1 || '';
                            document.getElementById("qrno").value = data.addressL2 || '';
                            document.getElementById("type").value = data.consumerType || '';
                            document.getElementById("addressL1").value = data.addressL1 || '';
                            document.getElementById("addressL2").value = data.addressL2 || '';
                            document.getElementById("addressL3").value = data.addressL3 || '';
                            document.getElementById("status").value = data.status || '';
                            document.getElementById("meterno").value = data.meterNo || '';
                            document.getElementById("metermake").value = data.meterMake || '';
                            document.getElementById("meterKW").value = data.meterKW || '';
                            document.getElementById("sancload").value = data.loadSanc || '';
                            document.getElementById("phase").value = data.phase || '';
                            document.getElementById("multifactor").value = data.multFactor || '';
                            document.getElementById("solarmeterno").value = data.solarMeterNo || '';
                            document.getElementById("solarmetermake").value = data.solarMeterMake || '';
                            document.getElementById("solarMeterKW").value = data.solarMeterKW || '';
                            document.getElementById("solarsancload").value = data.solarLoadSanc || '';
                            document.getElementById("solarphase").value = data.solarPhase || '';
                            document.getElementById("solarmultifactor").value = data.solarMultFactor || '';
                            document.getElementById("solarmeterstatus").value = data.solarMeterStatus || '';
                            document.getElementById("solarAmp").value = data.solarAmp || '';
                            document.getElementById("elecCode").value = data.elecCode || '';
                            document.getElementById("stdLightUnits").value = data.stdLightUnits || '';
                            document.getElementById("stdPowerUnits").value = data.stdPowerUnits || '';
                            document.getElementById("loadKW").value = data.loadKW || '';
                            document.getElementById("consumerType").value = data.consumerType || '';
                            document.getElementById("tariffCatg").value = data.tariffCatg || '';
                            document.getElementById("supplyPur").value = data.supplyPur || '';
                            document.getElementById("consumerCatg").value = data.consumerCatg || '';
                            document.getElementById("assdConsp").value = data.assdConsp || '';
                            document.getElementById("remarks").value = data.remarks || '';
                            document.getElementById("sourceTable").value = data.sourceTable || '';

                            if (data.meterNo) {
                                document.getElementById("meterno").disabled = true;
                                document.getElementById("metermake").disabled = true;
                                document.getElementById("meterKW").disabled = true;
                            }

                            if (data.enableFields) {
                                document.getElementById("street").disabled = false;
                                document.getElementById("qrno").disabled = false;
                                document.getElementById("qrtype").disabled = false;
                            }

                            console.log("Populated data in form:", {
                                consumerNo: data.consumerNo,
                                location: data.location,
                                name: data.name,
                                physector: data.addressL1,
                                street: data.addressL1,
                                qrno: data.addressL2,
                                type: data.consumerType,
                                addressL1: data.addressL1,
                                addressL2: data.addressL2,
                                addressL3: data.addressL3,
                                status: data.status,
                                meterno: data.meterNo,
                                metermake: data.meterMake,
                                meterKW: data.meterKW,
                                sancload: data.loadSanc,
                                phase: data.phase,
                                multifactor: data.multFactor,
                                solarmeterno: data.solarMeterNo,
                                solarmetermake: data.solarMeterMake,
                                solarMeterKW: data.solarMeterKW,
                                solarsancload: data.solarLoadSanc,
                                solarphase: data.solarPhase,
                                solarmultifactor: data.solarMultFactor,
                                solarmeterstatus: data.solarMeterStatus,
                                solarAmp: data.solarAmp,
                                elecCode: data.elecCode,
                                stdLightUnits: data.stdLightUnits,
                                stdPowerUnits: data.stdPowerUnits,
                                loadKW: data.loadKW,
                                consumerType: data.consumerType,
                                tariffCatg: data.tariffCatg,
                                supplyPur: data.supplyPur,
                                consumerCatg: data.consumerCatg,
                                assdConsp: data.assdConsp,
                                remarks: data.remarks,
                                sourceTable: data.sourceTable
                            });
                        }
                    }
                };
                xhr.open("GET", "fetchData.jsp?sector=" + sector + "&plot=" + plot, true);
                xhr.send();
            }
        }

        document.getElementById("sector").addEventListener("input", fetchData);
        document.getElementById("plot").addEventListener("input", fetchData);

        document.getElementById("clearButton").addEventListener("click", function() {
            var inputs = document.querySelectorAll("input[type='text']");
            inputs.forEach(function(input) {
                input.value = "";
            });
            document.getElementById("street").disabled = true;
            document.getElementById("qrno").disabled = true;
            document.getElementById("qrtype").disabled = true;
        });

        document.getElementById("exitButton").addEventListener("click", function() {
            window.close();
        });

        document.querySelector("form").addEventListener("submit", function(event) {
            // Form validation before submission
            var requiredFields = ["sector", "plot", "consumerNo", "location", "name"];
            for (var i = 0; i < requiredFields.length; i++) {
                if (document.getElementById(requiredFields[i]).value === "") {
                    alert("Please fill all required fields.");
                    event.preventDefault();
                    return;
                }
            }
        });
    });
</script>
</head>
<body>
    <div class="heading">
        <h2>Electricity Master Data Entry</h2>
    </div>
    <form method="post" action="SaveDataServlet.jsp">
        <div class="form-header">
            <div class="inline-container">
                <label for="sector">Sector</label>
                <input type="text" id="sector" class="small-input" name="sector" maxlength="2" required>
                <label for="plot">Plot</label>
                <input type="text" id="plot" class="small-input" name="plot" maxlength="3" required>
                <input type="checkbox" id="bspqtr">
                <label class="checkbox-label" for="bspqtr">BSP qtr</label>
            </div>
            <div class="buttons">
                <button type="submit" class="button-70">Save</button>
                <button type="button" id="clearButton" class="button-70">Clear</button>
                <button type="button" id="exitButton" class="button-70">Exit</button>
            </div>
        </div>
        <input type="hidden" id="sourceTable" name="sourceTable" />
        <div id="upper">
            <div id="container">
                <div id="topleft">
                    <div class="form-grid">
                        <div>
                            <label for="consumerNo">Consumer No</label>
                            <input type="text" id="consumerNo" class="small-input" name="consumerNo" required>
                        </div>
                        <div>
                            <label for="location">Location</label>
                            <input type="text" id="location" class="small-input" name="location" required>
                        </div>
                        <div>
                            <label for="name">Name</label>
                            <input type="text" id="name" class="small-input" name="name" required>
                        </div>
                        <div>
                            <label for="physector">Physical Sector</label>
                            <input type="text" id="physector" class="small-input" name="physector">
                        </div>
                        <div>
                            <label for="street">Street</label>
                            <input type="text" id="street" class="small-input" name="street" disabled>
                        </div>
                        <div>
                            <label for="qrno">QR No</label>
                            <input type="text" id="qrno" class="small-input" name="qrno" disabled>
                        </div>
                        <div>
                            <label for="qrtype">QR Type</label>
                            <input type="text" id="qrtype" class="small-input" name="qrtype" disabled>
                        </div>
                        <div>
                            <label for="type">Type</label>
                            <input type="text" id="type" class="small-input" name="type" pattern="[a-zA-Z]*" disabled>
                        </div>
                        <div>
                            <label for="addressL1">Address L1</label>
                            <input type="text" id="addressL1" class="small-input" name="addressL1">
                        </div>
                        <div>
                            <label for="addressL2">Address L2</label>
                            <input type="text" id="addressL2" class="small-input" name="addressL2">
                        </div>
                        <div>
                            <label for="addressL3">Address L3</label>
                            <input type="text" id="addressL3" class="small-input" name="addressL3">
                        </div>
                        <div>
                            <label for="status">Status</label>
                            <input type="text" id="status" class="small-input" name="status">
                        </div>
                    </div>
                </div>
                <div class="tp-master">
                    <h3>From TP Master</h3>
                    <div class="form-grid">
                        <div>
                            <label for="meterno">Meter No</label>
                            <input type="text" id="meterno" name="meterno">
                        </div>
                        <div>
                            <label for="metermake">Meter Make</label>
                            <input type="text" id="metermake" name="metermake">
                        </div>
                        <div>
                            <label for="meterKW">Meter KW</label>
                            <input type="text" id="meterKW" name="meterKW" pattern="[0-9]*">
                        </div>
                        <div>
                            <label for="sancload">Sanc Load (KW)</label>
                            <input type="text" id="sancload" name="sancload" pattern="[0-9]*">
                        </div>
                        <div>
                            <label for="phase">Phase</label>
                            <input type="text" id="phase" name="phase">
                        </div>
                        <div>
                            <label for="multifactor">Multi Factor</label>
                            <input type="text" id="multifactor" name="multifactor">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="fle">
            <div class="solar">
                <h3>Solar</h3>
                <div class="form-grid">
                    <div>
                        <label for="solarmeterno">Solar Meter No</label>
                        <input type="text" id="solarmeterno" class="small-input" name="solarmeterno">
                    </div>
                    <div>
                        <label for="solarmetermake">Solar Meter Make</label>
                        <input type="text" id="solarmetermake" class="small-input" name="solarmetermake">
                    </div>
                    <div>
                        <label for="solarMeterKW">Solar Meter KW</label>
                        <input type="text" id="solarMeterKW" class="small-input" name="solarMeterKW" pattern="[0-9]*">
                    </div>
                    <div>
                        <label for="solarsancload">Solar Sanc Load (KW)</label>
                        <input type="text" id="solarsancload" class="small-input" name="solarsancload" pattern="[0-9]*">
                    </div>
                    <div>
                        <label for="solarphase">Solar Phase</label>
                        <input type="text" id="solarphase" class="small-input" name="solarphase">
                    </div>
                    <div>
                        <label for="solarmultifactor">Solar Multi Factor</label>
                        <input type="text" id="solarmultifactor" class="small-input" name="solarmultifactor">
                    </div>
                    <div>
                        <label for="solarmeterstatus">Solar Meter Status</label>
                        <input type="text" id="solarmeterstatus" class="small-input" name="solarmeterstatus">
                    </div>
                    <div>
                        <label for="solarAmp">Solar AMP</label>
                        <input type="text" id="solarAmp" class="small-input" name="solarAmp">
                    </div>
                </div>
            </div>
            <div class="lastdiv">
                <div class="form-grid">
                    <div>
                        <label for="elecCode">Elec Code</label>
                        <input type="text" id="elecCode" class="small-input" name="elecCode">
                    </div>
                    <div>
                        <label for="stdLightUnits">Std Light Units</label>
                        <input type="text" id="stdLightUnits" class="small-input" name="stdLightUnits">
                    </div>
                    <div>
                        <label for="stdPowerUnits">Std Power Units</label>
                        <input type="text" id="stdPowerUnits" class="small-input" name="stdPowerUnits">
                    </div>
                    <div>
                        <label for="loadKW">Load KW</label>
                        <input type="text" id="loadKW" class="small-input" name="loadKW">
                    </div>
                    <div>
                        <label for="consumerType">Consumer Type</label>
                        <input type="text" id="consumerType" class="small-input" name="consumerType">
                    </div>
                    <div>
                        <label for="tariffCatg">Tariff Category</label>
                        <input type="text" id="tariffCatg" class="small-input" name="tariffCatg">
                    </div>
                    <div>
                        <label for="supplyPur">Supply Purpose</label>
                        <input type="text" id="supplyPur" class="small-input" name="supplyPur">
                    </div>
                    <div>
                        <label for="consumerCatg">Consumer Category</label>
                        <input type="text" id="consumerCatg" class="small-input" name="consumerCatg">
                    </div>
                    <div>
                        <label for="assdConsp">Assd Consumption</label>
                        <input type="text" id="assdConsp" class="small-input" name="assdConsp">
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="fle">
            <div class="remarks">
                <label for="remarks">Remarks</label>
                <input type="text" id="remarks" name="remarks">
            </div>
        </div>
    </form>
</body>
</html>
