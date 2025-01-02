<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reservations List</title>
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Reservations List</h2>

        <form method="post" action="reservationsList.jsp">
            <label for="filterType">Select Filter Type:</label>
            <select name="filterType" required>
                <option value="transitLine">By Transit Line</option>
                <option value="customerName">By Customer</option>
            </select>
            <button type="submit">Generate List</button>
        </form>

        <%
            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String filterType = request.getParameter("filterType");

            if (filterType != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);

                    String sql = "";

                    if (filterType.equals("transitLine")) {
                        sql = "SELECT DISTINCT r.Reservation_No, ts.Transit_Line_Name, r.Passenger, r.Date, r.No_of_Tickets, r.Total_Fare " +
                              "FROM Reservations r " +
                              "JOIN Train_Schedule ts ON DATE(r.Date) = DATE(ts.Departure_Datetime) " +
                              "ORDER BY ts.Transit_Line_Name, r.Date";
                    } else if (filterType.equals("customerName")) {
                        sql = "SELECT r.Reservation_No, r.Passenger AS CustomerName, MIN(ts.Transit_Line_Name) AS Transit_Line_Name, " +
                              "r.Date, r.No_of_Tickets, r.Total_Fare " +
                              "FROM Reservations r " +
                              "JOIN Train_Schedule ts ON DATE(r.Date) = DATE(ts.Departure_Datetime) " +
                              "GROUP BY r.Reservation_No, r.Passenger, r.Date, r.No_of_Tickets, r.Total_Fare " +
                              "ORDER BY r.Passenger, r.Date";
                    }

                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    if (filterType.equals("transitLine")) {
                        out.println("<h3>Reservations by Transit Line</h3>");
                        out.println("<table>");
                        out.println("<tr><th>Transit Line</th><th>Reservation No</th><th>Passenger</th><th>Date</th><th>Tickets</th><th>Total Fare ($)</th></tr>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("Transit_Line_Name") + "</td>");
                            out.println("<td>" + rs.getString("Reservation_No") + "</td>");
                            out.println("<td>" + rs.getString("Passenger") + "</td>");
                            out.println("<td>" + rs.getDate("Date") + "</td>");
                            out.println("<td>" + rs.getInt("No_of_Tickets") + "</td>");
                            out.println("<td>" + rs.getDouble("Total_Fare") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    } else if (filterType.equals("customerName")) {
                        out.println("<h3>Reservations by Customer</h3>");
                        out.println("<table>");
                        out.println("<tr><th>Customer Name</th><th>Reservation No</th><th>Transit Line</th><th>Date</th><th>Tickets</th><th>Total Fare ($)</th></tr>");
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("CustomerName") + "</td>");
                            out.println("<td>" + rs.getString("Reservation_No") + "</td>");
                            out.println("<td>" + rs.getString("Transit_Line_Name") + "</td>");
                            out.println("<td>" + rs.getDate("Date") + "</td>");
                            out.println("<td>" + rs.getInt("No_of_Tickets") + "</td>");
                            out.println("<td>" + rs.getDouble("Total_Fare") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</table>");
                    }

                } catch (Exception e) {
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>
</body>
</html>
