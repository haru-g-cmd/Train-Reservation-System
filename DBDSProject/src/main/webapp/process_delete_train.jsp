<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Train Schedule Deletion</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://i.redd.it/u6rxthrum7c61.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            background: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 20px;
            width: 90%;
            max-width: 500px;
            box-sizing: border-box;
            text-align: center;
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: 900;
            margin-bottom: 20px;
        }

        p {
            margin-top: 20px;
            font-size: 16px;
        }

        a, button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border-radius: 4px;
        }

        a:hover, button:hover {
            background-color: #4b0082;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Update Train Schedule</h2>
        <%
            try {
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");
				String query = "DELETE FROM train_schedule WHERE Departure_Datetime = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                
                String departureDatetimeStr = request.getParameter("departureDatetime");
                long departureDatetimeMillis = Long.parseLong(departureDatetimeStr);
                Timestamp departureDatetime = new Timestamp(departureDatetimeMillis);
                
                ps.setTimestamp(1, departureDatetime);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Train schedule deleted successfully.</p>");
                } else {
                    out.println("<p style='color: red;'>Failed to delete train schedule. Please try again.</p>");
                }
                
                
                ps.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            }
        %>
        <a href="edit_train_schedule.jsp">Back to Train Schedules</a>
    </div>
</body>
</html>
