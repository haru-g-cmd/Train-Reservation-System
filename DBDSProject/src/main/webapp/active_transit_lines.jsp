<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Top 5 Most Active Transit Lines</title>
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
            max-width: 600px;
            text-align: center;
        }

        h2 {
            color: #333;
            font-weight: 900;
            margin-bottom: 20px;
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
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Top 5 Most Active Transit Lines</h2>
        <%
            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, User, Password);

                String sqlActiveLines = "SELECT ts.Transit_Line_Name, COUNT(r.Reservation_No) AS ReservationCount " +
                                        "FROM Reservations r " +
                                        "JOIN Train_Schedule ts ON DATE(r.Date) = DATE(ts.Departure_Datetime) " +
                                        "GROUP BY ts.Transit_Line_Name " +
                                        "ORDER BY ReservationCount DESC " +
                                        "LIMIT 5";

                pstmt = conn.prepareStatement(sqlActiveLines);
                rs = pstmt.executeQuery();

                out.println("<table>");
                out.println("<tr><th>Transit Line</th><th>Number of Reservations</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("Transit_Line_Name") + "</td>");
                    out.println("<td>" + rs.getInt("ReservationCount") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>
