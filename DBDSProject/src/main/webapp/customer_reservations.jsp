<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Reservations</title>
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

        .container {
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 1000px;
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: 900;
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

        select, input[type="date"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
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

        p {
            color: #333;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Customer Reservations</h2>

        <form action="customer_reservations.jsp" method="GET">
            <label for="transit_line">Select Transit Line:</label>
            <select name="transit_line" id="transit_line" required>
                <option value="">-- Select Transit Line --</option>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");
                        String query = "SELECT DISTINCT Transit_Line_Name FROM train_schedule";
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery(query);
                        while (rs.next()) {
                            String transitLineName = rs.getString("Transit_Line_Name");
                            out.println("<option value='" + transitLineName + "'>" + transitLineName + "</option>");
                        }
                    } catch (SQLException e) {
                        out.println("<p>Error fetching transit lines: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
                        }
                    }
                %>
            </select>

            <label for="date">Select Date:</label>
            <input type="date" name="date" id="date" required>

            <input type="submit" value="Search">
        </form>

        <%
            String transitLine = request.getParameter("transit_line");
            String date = request.getParameter("date");

            if (transitLine != null && date != null) {
                conn = null;
                PreparedStatement ps = null;
                rs = null;
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");
                    String query = "SELECT DISTINCT r.Reservation_No, r.Passenger, r.Date, r.Total_Fare, r.No_of_Tickets, ts.Transit_Line_Name " +
                                   "FROM reservations r " +
                                   "JOIN train_schedule ts ON r.Date = DATE(ts.Departure_Datetime) " +
                                   "WHERE ts.Transit_Line_Name = ? AND r.Date = ?";
                    ps = conn.prepareStatement(query);
                    ps.setString(1, transitLine);
                    ps.setString(2, date);

                    rs = ps.executeQuery();

                    boolean hasResults = false;
                    out.println("<table>");
                    out.println("<tr><th>Transit Line</th><th>Passenger</th><th>Reservation No</th><th>Reservation Date</th><th>Total Fare ($)</th><th>No. of Tickets</th></tr>");

                    while (rs.next()) {
                        hasResults = true;
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Transit_Line_Name") + "</td>");
                        out.println("<td>" + rs.getString("Passenger") + "</td>");
                        out.println("<td>" + rs.getString("Reservation_No") + "</td>");
                        out.println("<td>" + rs.getDate("Date") + "</td>");
                        out.println("<td>" + rs.getFloat("Total_Fare") + "</td>");
                        out.println("<td>" + rs.getInt("No_of_Tickets") + "</td>");
                        out.println("</tr>");
                    }

                    out.println("</table>");

                    if (!hasResults) {
                        out.println("<p>No reservations found for this transit line on the selected date.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p>Error connecting to the database: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </div>
</body>
</html>
