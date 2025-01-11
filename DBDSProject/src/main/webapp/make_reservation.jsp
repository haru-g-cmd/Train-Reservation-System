<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Make a Reservation</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f9;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .reserve-container {
                background: #ffffff;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                padding: 20px;
                width: 100%;
                max-width: 500px;
            }

            h2 {
                text-align: center;
                color: #333;
                font-weight: 900;
                font-size: 1.8rem;
                margin-bottom: 20px;
            }
			.reserve-container h2 {
    			text-align: center;
    			margin: 0 auto;
    			color: #333;
    			font-size: 1.8rem;
    			text-shadow: none;
			}
            label {
                display: block;
                margin-top: 15px;
                color: #555;
                font-weight: bold;
            }

            input, select, button {
                width: 100%;
                padding: 10px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            input[type="radio"] {
                width: auto;
                margin-right: 10px;
            }

            input[type="checkbox"] {
                width: auto;
                margin-right: 10px;
            }

            button {
                background-color: #6a0dad; 
                color: white;
                font-weight: bold;
                border: none;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #4b0082; 
            }

            #discountField {
                margin-top: 10px;
            }

            .form-section {
                margin-bottom: 20px;
            }

            .trip-type {
                display: flex;
                gap: 15px;
                align-items: center;
                margin-top: 10px;
                padding: 10px;
                background-color: #f9f9f9;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .view-reservations {
                text-align: center;
                margin-top: 20px;
            }

            .view-reservations button {
                width: auto;
                padding: 10px 20px;
                background-color: #6a0dad; 
                color: white;
                font-weight: bold;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .view-reservations button:hover {
                background-color: #4b0082; 
            }
        </style>
        <script>
            function toggleDiscountField() {
                const discountCheckbox = document.getElementById("discountCheckbox");
                const discountField = document.getElementById("discountField");

                if (discountCheckbox.checked) {
                    discountField.style.display = "block";
                } else {
                    discountField.style.display = "none";
                    document.getElementById("discountCount").value = 0;
                }
            }

            function validateCounts() {
                const totalTickets = parseInt(document.getElementById("tickets").value || 0, 10);
                const discountCount = parseInt(document.getElementById("discountCount").value || 0, 10);

                if (discountCount > totalTickets) {
                    alert("The number of discounted passengers cannot exceed the total number of tickets.");
                    return false;
                }

                return true;
            }
        </script>
    </head>
    <body>
        <div class="reserve-container">
            <h2>Make a Reservation</h2>

            <%
                String username = (String) session.getAttribute("username");

                if (username == null) {
                    response.sendRedirect("login.jsp");
                }

                String URL = "jdbc:mysql://localhost:3306/railwaysystem";
                String User = "root";
                String Password = "abccba123!";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                String passengerName = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);
                    stmt = conn.createStatement();

                    String sql = "SELECT Firstname, lastname FROM customer WHERE username = '" + username + "'";
                    rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        passengerName = rs.getString("FirstName") + " " + rs.getString("LastName");
                    } else {
                        response.sendRedirect("login.jsp");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException ex) {
                        out.println("<p style='color:red;'>Error closing resources: " + ex.getMessage() + "</p>");
                    }
                }
            %>

            <form action="processReservation.jsp" method="post" onsubmit="return validateCounts()">
                <div class="form-section">
                    <input type="hidden" name="passengerName" value="<%= passengerName %>">
                    <p>Passenger Name: <%= passengerName %></p>
                </div>

                <div class="form-section">
    <label for="route">Select Route (December 2024):</label>
    <select name="route" required>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, User, Password);
                stmt = conn.createStatement();

                String routeQuery = "SELECT Train_No, Transit_Line_Name, Destination, Fare, Departure_Datetime " +
                                    "FROM Train_Schedule " +
                                    "WHERE Departure_Datetime >= '2024-12-01 00:00:00' AND Departure_Datetime < '2025-01-01 00:00:00'";
                rs = stmt.executeQuery(routeQuery);

                while (rs.next()) {
                    String trainNo = rs.getString("Train_No");
                    String transitLine = rs.getString("Transit_Line_Name");
                    String destination = rs.getString("Destination");
                    float fare = rs.getFloat("Fare");
                    String departureDatetime = rs.getString("Departure_Datetime");

                    out.println("<option value='" + trainNo + "|" + fare + "|" + departureDatetime + "'>" +
                                transitLine + " to " + destination + " ($" + fare + ") - " + departureDatetime + "</option>");
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error loading routes: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    out.println("<p style='color:red;'>Error closing resources: " + ex.getMessage() + "</p>");
                }
            }
        %>
    </select>
</div>

                <div class="form-section">
                    <label for="tickets">Number of Tickets:</label>
                    <input type="number" name="tickets" id="tickets" min="1" required>
                </div>

                <div class="form-section">
                    <label for="discountCheckbox">
                        <input type="checkbox" id="discountCheckbox" name="applyDiscount" onchange="toggleDiscountField()"> Apply Discount (Child/Senior/Disabled)
                    </label>

                    <div id="discountField" style="display: none;">
                        <label for="discountCount">Number of Discounted Passengers:</label>
                        <input type="number" id="discountCount" name="discountCount" min="0" value="0">
                    </div>
                </div>

                <div class="form-section">
                    <label for="tripType">Trip Type:</label>
                    <div class="trip-type">
                        <label><input type="radio" name="tripType" value="0" required> One Way</label>
                        <label><input type="radio" name="tripType" value="1" required> Round Trip</label>
                    </div>
                </div>

                <div class="form-section">
                    <button type="submit">Make Reservation</button>
                </div>
            </form>

            <div class="view-reservations">
                <form action="viewReservations.jsp" method="get">
                    <button type="submit">View My Reservations</button>
                </form>
            </div>
        </div>
    </body>
</html>
