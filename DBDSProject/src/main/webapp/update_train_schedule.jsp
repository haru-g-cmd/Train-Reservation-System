<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Train Schedule</title>
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
        }

        h2 {
            text-align: center;
            color: #333;
            font-weight: 900;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #555;
            display: block;
            margin-top: 10px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button:hover {
            background-color: #4b0082;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Train Schedule</h2>
        <%
            String trainNo = request.getParameter("trainNo");
            String departureDatetimeParam = request.getParameter("departureDatetime");
			Timestamp departureDatetime = null;

			try {
			    long departureDatetimeMillis = Long.parseLong(departureDatetimeParam);
			    departureDatetime = new Timestamp(departureDatetimeMillis);
			} catch (NumberFormatException e) {
			    out.println("<p class='error'>Invalid departure datetime value: " + e.getMessage() + "</p>");
			}
			
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            String origin = "", destination = "", stops = "";
            float fare = 0.0f;

            try {
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");
                String query = "SELECT * FROM train_schedule WHERE Train_No = ? AND Departure_Datetime = ?";
                ps = conn.prepareStatement(query);
                ps.setString(1, trainNo);
                ps.setTimestamp(2, departureDatetime);
                rs = ps.executeQuery();

                if (rs.next()) {
                    origin = rs.getString("Origin");
                    destination = rs.getString("Destination");
                    fare = rs.getFloat("Fare");
                    stops = rs.getString("Stops");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>Error loading train schedule: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p class='error'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>
        <form action="process_update_train_schedule.jsp" method="POST">
            <input type="hidden" name="trainNo" value="<%= trainNo %>">
            <input type="hidden" name="departureDatetime" value="<%= departureDatetime %>">

            <label for="origin">Origin:</label>
            <input type="text" id="origin" name="origin" value="<%= origin %>" required>

            <label for="destination">Destination:</label>
            <input type="text" id="destination" name="destination" value="<%= destination %>" required>

            <label for="stops">Stops:</label>
            <input type="text" id="stops" name="stops" value="<%= stops %>">
            
            <label for="departureDatetime">Departure Datetime:</label>
			<input type="datetime-local" id="departureDatetime" name="newDepartureDatetime">
			
			<label for="arrivalDatetime">Arrival Datetime:</label>
			<input type="datetime-local" id="arrivalDatetime" name="arrivalDatetime">
			
			<label for="travelTime">Travel Time:</label>
            <input type="text" id="fare" name="travelTime">

            <label for="fare">Fare:</label>
            <input type="number" id="fare" name="fare" step="0.01" value="<%= fare %>" required>

            <button type="submit">Update Schedule</button>
        </form>
    </div>
</body>
</html>
