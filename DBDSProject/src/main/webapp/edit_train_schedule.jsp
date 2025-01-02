<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date, java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Train Schedules</title>
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

        h2, h3 {
            text-align: center;
            color: #333;
            font-weight: 900;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
        }

        select {
            padding: 10px;
            width: 50%;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            padding: 10px 20px;
            border-radius: 4px;
            margin-top: 10px;
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

        a {
            color: #6a0dad;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            color: #4b0082;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Manage Train Schedules</h2>

        <form action="edit_train_schedule.jsp" method="GET">
            <label for="transit_line">Select Transit Line:</label>
            <select name="transit_line" id="transit_line">
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
            <input type="submit" value="Search">
        </form>

        <%
            String transitLine = request.getParameter("transit_line");

            if (transitLine != null && !transitLine.isEmpty()) {
                out.println("<h3>Schedules for Transit Line: " + transitLine + "</h3>");

                conn = null;
                PreparedStatement ps = null;
                rs = null;
                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");
                    String query = "SELECT * FROM train_schedule WHERE Transit_Line_Name = ?";
                    ps = conn.prepareStatement(query);
                    ps.setString(1, transitLine);
                    rs = ps.executeQuery();

                    out.println("<table>");
                    out.println("<tr><th>Train No</th><th>Origin</th><th>Departure Datetime</th><th>Destination</th><th>Fare</th><th>Action</th></tr>");

                    while (rs.next()) {
                        String trainNo = rs.getString("Train_No");
                        String origin = rs.getString("Origin");
                        Timestamp departureDatetime = rs.getTimestamp("Departure_Datetime");
                        String destination = rs.getString("Destination");
                        float fare = rs.getFloat("Fare");

                        out.println("<tr>");
                        out.println("<td>" + trainNo + "</td>");
                        out.println("<td>" + origin + "</td>");
                        out.println("<td>" + departureDatetime + "</td>");
                        out.println("<td>" + destination + "</td>");
                        out.println("<td>" + fare + "</td>");
                        out.println("<td>");
                        out.println("<a href='update_train_schedule.jsp?trainNo=" + trainNo + "&departureDatetime=" + departureDatetime.getTime() + "'>Edit</a> | ");
                        out.println("<a href='process_delete_train.jsp?action=delete&departureDatetime=" + departureDatetime.getTime() + "'>Delete</a>");
                        out.println("</td>");
                        out.println("</tr>");
                    }

                    out.println("</table>");

                } catch (SQLException e) {
                    out.println("<p>Error fetching train schedules: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
                    }
                }
                
                if (false) {
                    String departureDatetimeStr = request.getParameter("departureDatetime");
                    if (departureDatetimeStr != null) {
                        long departureDatetimeMillis = Long.parseLong(departureDatetimeStr);
                        Timestamp departureDatetime = new Timestamp(departureDatetimeMillis);

                        conn = null;
                        ps = null;

                        try {
                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "fl3xwm3");
                            String query = "DELETE FROM train_schedule WHERE Departure_Datetime = ?";
                            ps = conn.prepareStatement(query);
                            ps.setTimestamp(1, departureDatetime);
                            int rowsAffected = ps.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p>Train schedule deleted successfully.</p>");
                            } else {
                                out.println("<p>Error deleting train schedule.</p>");
                            }
                        } catch (SQLException e) {
                            out.println("<p>Error deleting train schedule: " + e.getMessage() + "</p>");
                        } finally {
                            try {
                                if (ps != null) ps.close();
                                if (conn != null) conn.close();
                            } catch (SQLException e) {
                                out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
                            }
						}
					}
				}
            }
        %>
    </div>
</body>
</html>
