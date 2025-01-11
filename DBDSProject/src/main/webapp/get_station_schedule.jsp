<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Train Schedules</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://i.redd.it/u6rxthrum7c61.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .reservation-container {
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 1000px;
        }

        h1 {
            text-align: center;
            color: #333;
            font-weight: 900;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        select, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background-color: #f9f9f9;
            font-weight: bold;
        }

        th, td {
            padding: 10px;
        }

        .error {
            color: red;
            text-align: center;
        }

        .no-results {
            text-align: center;
            font-weight: bold;
            color: #555;
        }
    </style>
</head>
<body>
    <main>
        <div class="reservation-container">
            <h1>Train Schedules</h1>
            <form method="GET">
                <label for="station">Select Station (Origin/Destination):</label>
                <select name="station" id="station" required>
                    <option value="">--Select a Station--</option>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");

                            String stationQuery = "SELECT Name FROM station";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(stationQuery);

                            while (rs.next()) {
                                String stationName = rs.getString("Name");
                                out.println("<option value=\"" + stationName + "\">" + stationName + "</option>");
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            e.printStackTrace();
                            out.println("<p style='color:red;'>Error loading station list.</p>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </select>
                <button type="submit">Search</button>
            </form>

            <div class="schedule-list">
                <%
                    String station = request.getParameter("station");
                    if (station != null && !station.isEmpty()) {
                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");

                            String query = "SELECT ts.Train_No, ts.Transit_Line_Name, ts.Origin, ts.Departure_Datetime, " +
                                           "ts.Arrival_Datetime, ts.Destination, ts.Fare " +
                                           "FROM train_schedule ts " +
                                           "WHERE ts.Origin = ? OR ts.Destination = ?";
                            PreparedStatement pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, station);
                            pstmt.setString(2, station);
                            rs = pstmt.executeQuery();

                            boolean hasResults = false;
                            out.println("<table>");
                            out.println("<tr><th>Train No</th><th>Transit Line</th><th>Origin</th><th>Destination</th><th>Departure Time</th><th>Arrival Time</th><th>Fare ($)</th></tr>");
                            while (rs.next()) {
                                hasResults = true;
                                String trainNo = rs.getString("Train_No");
                                String transitLine = rs.getString("Transit_Line_Name");
                                String origin = rs.getString("Origin");
                                Timestamp departureTime = rs.getTimestamp("Departure_Datetime");
                                Timestamp arrivalTime = rs.getTimestamp("Arrival_Datetime");
                                String destination = rs.getString("Destination");
                                float fare = rs.getFloat("Fare");

                                out.println("<tr>");
                                out.println("<td>" + trainNo + "</td>");
                                out.println("<td>" + transitLine + "</td>");
                                out.println("<td>" + origin + "</td>");
                                out.println("<td>" + destination + "</td>");
                                out.println("<td>" + departureTime + "</td>");
                                out.println("<td>" + arrivalTime + "</td>");
                                out.println("<td>" + fare + "</td>");
                                out.println("</tr>");
                            }
                            out.println("</table>");

                            if (!hasResults) {
                                out.println("<p class='no-results'>No train schedules found for the selected station.</p>");
                            }

                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p class='error'>Database error: " + e.getMessage() + "</p>");
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </div>
        </div>
    </main>
</body>
</html>
