<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Search Train Schedules</title>
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
                font-size: 1.8rem;
                margin-bottom: 20px;
            }

            h3 {
                color: #555;
                font-weight: bold;
                margin-top: 20px;
            }

            form {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
                color: #555;
            }

            input, select, button {
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
            <h2>Search Train Schedules</h2>

            <form method="post" action="search.jsp">
                <label>Origin:</label>
                <input type="text" name="origin">
                <label>Destination:</label>
                <input type="text" name="destination">
                <label>Date:</label>
                <input type="date" name="travel_date">
                <label>Sort By:</label>
                <select name="sort_by">
                    <option value="Departure_Datetime">Departure Time</option>
                    <option value="Arrival_Datetime">Arrival Time</option>
                    <option value="Fare">Fare</option>
                </select>
                <label>Order:</label>
                <select name="sort_order">
                    <option value="ASC">Ascending</option>
                    <option value="DESC">Descending</option>
                </select>
                <button type="submit">Search</button>
            </form>

            <h3>Available Train Schedules</h3>

            <%
                String URL = "jdbc:mysql://localhost:3306/railwaysystem";
                String User = "root";  
                String Password = "abccba123!";  

                String origin = request.getParameter("origin");
                String destination = request.getParameter("destination");
                String travelDate = request.getParameter("travel_date");
                String sortBy = request.getParameter("sort_by");
                String sortOrder = request.getParameter("sort_order");

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);

                    String sql = "SELECT Train_No, Transit_Line_Name, Origin, Destination, Departure_Datetime, Arrival_Datetime, Fare, Stops " +
                                 "FROM Train_Schedule";

                    if (origin != null && destination != null && travelDate != null && !origin.isEmpty() && !destination.isEmpty() && !travelDate.isEmpty()) {
                        sql += " WHERE Origin = ? AND Destination = ? AND DATE(Departure_Datetime) = ?";
                    }

                    if (sortBy != null && !sortBy.isEmpty() && sortOrder != null && !sortOrder.isEmpty()) {
                        sql += " ORDER BY " + sortBy + " " + sortOrder;
                    }

                    stmt = conn.prepareStatement(sql);

                    if (origin != null && destination != null && travelDate != null && !origin.isEmpty() && !destination.isEmpty() && !travelDate.isEmpty()) {
                        stmt.setString(1, origin);
                        stmt.setString(2, destination);
                        stmt.setString(3, travelDate);
                    }

                    rs = stmt.executeQuery();

                    out.println("<table>");
                    out.println("<tr><th>Train No</th><th>Transit Line</th><th>Origin</th><th>Destination</th><th>Departure</th><th>Arrival</th><th>Fare</th><th>Stops</th></tr>");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("Train_No") + "</td>");
                        out.println("<td>" + rs.getString("Transit_Line_Name") + "</td>");
                        out.println("<td>" + rs.getString("Origin") + "</td>");
                        out.println("<td>" + rs.getString("Destination") + "</td>");
                        out.println("<td>" + rs.getString("Departure_Datetime") + "</td>");
                        out.println("<td>" + rs.getString("Arrival_Datetime") + "</td>");
                        out.println("<td>$" + rs.getFloat("Fare") + "</td>");
                        out.println("<td>" + rs.getString("Stops") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } catch (Exception e) {
                    out.println("<p class='error'>Database error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </div>
    </body>
</html>
