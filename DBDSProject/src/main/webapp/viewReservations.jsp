<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>My Reservations</title>
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

        .reservations-container {
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            width: 100%;
            max-width: 800px;
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: 900;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        h3 {
            color: #555;
            font-weight: bold;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table, th, td {
            border: 1px solid #ccc;
            text-align: center;
        }

        th, td {
            padding: 10px;
        }

        button {
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            padding: 10px 20px;
            border-radius: 4px;
        }

        button:hover {
            background-color: #4b0082;
        }

        .back-menu {
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="reservations-container">
        <h2>My Reservations</h2>

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

        <h3>Passenger: <%= passengerName %></h3>

        <h3>Current Reservations</h3>
        <table>
            <tr>
                <th>Reservation No</th>
                <th>Date</th>
                <th>Tickets</th>
                <th>Total Fare</th>
                <th>Action</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);
                    stmt = conn.createStatement();

                    String currentReservationsQuery = "SELECT Reservation_No, Date, No_of_Tickets, Total_Fare " +
                                                      "FROM Reservations WHERE Passenger = '" + passengerName + "' " +
                                                      "AND Date >= '2024-12-01'";
                    rs = stmt.executeQuery(currentReservationsQuery);

                    while (rs.next()) {
                        String reservationNo = rs.getString("Reservation_No");
                        out.println("<tr>");
                        out.println("<td>" + reservationNo + "</td>");
                        out.println("<td>" + rs.getDate("Date") + "</td>");
                        out.println("<td>" + rs.getInt("No_of_Tickets") + "</td>");
                        out.println("<td>$" + rs.getFloat("Total_Fare") + "</td>");
                        out.println("<td>");
                        out.println("<form action='cancelReservation.jsp' method='post' style='display:inline;'>");
                        out.println("<input type='hidden' name='reservationNo' value='" + reservationNo + "'>");
                        out.println("<button type='submit'>Cancel</button>");
                        out.println("</form>");
                        out.println("</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading current reservations: " + e.getMessage() + "</p>");
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
        </table>

        <h3>Past Reservations</h3>
        <table>
            <tr>
                <th>Reservation No</th>
                <th>Date</th>
                <th>Tickets</th>
                <th>Total Fare</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);
                    stmt = conn.createStatement();

                    String pastReservationsQuery = "SELECT Reservation_No, Date, No_of_Tickets, Total_Fare " +
                                                   "FROM Reservations WHERE Passenger = '" + passengerName + "' " +
                                                   "AND Date < '2024-12-01'";
                    rs = stmt.executeQuery(pastReservationsQuery);

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Reservation_No") + "</td>");
                        out.println("<td>" + rs.getDate("Date") + "</td>");
                        out.println("<td>" + rs.getInt("No_of_Tickets") + "</td>");
                        out.println("<td>$" + rs.getFloat("Total_Fare") + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error loading past reservations: " + e.getMessage() + "</p>");
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
        </table>

        <div class="back-menu">
            <form action="make_reservation.jsp" method="get">
                <button type="submit">Back to Menu</button>
            </form>
        </div>
    </div>
</body>
</html>
