<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <title>Process Reservation</title>
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
            height: 100vh;
        }

        .response-container {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 20px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            color: #333;
            font-weight: 900;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        p {
            color: #555;
            margin: 10px 0;
            font-size: 16px;
        }

        a, button {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #6a0dad;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
            border: none;
        }

        a:hover, button:hover {
            background-color: #4b0082;
        }
    </style>
</head>
<body>
    <div class="response-container">
        <%
            try {
                String passengerName = request.getParameter("passengerName");
                String route = request.getParameter("route");
                int tickets = Integer.parseInt(request.getParameter("tickets"));
                int discountCount = request.getParameter("discountCount") != null ? Integer.parseInt(request.getParameter("discountCount")) : 0;
                String tripType = request.getParameter("tripType");
                boolean oneWay = "0".equals(tripType);
                boolean roundTrip = "1".equals(tripType);

                String[] routeDetails = route.split("\\|");
                if (routeDetails.length < 3) {
                    throw new IllegalArgumentException("Invalid route format. Expected trainNo|fare|departureDatetime.");
                }

                String trainNo = routeDetails[0];
                float fare = Float.parseFloat(routeDetails[1]);
                String departureDatetime = routeDetails[2];

                float discountedFare = fare * 0.7f; 
                float totalFare = (discountCount * discountedFare) + ((tickets - discountCount) * fare);

                if (roundTrip) {
                    totalFare *= 2;
                }

                String reservationDate = "";

                String URL = "jdbc:mysql://localhost:3306/railwaysystem";
                String User = "root";
                String Password = "abccba123!";
                Connection conn = DriverManager.getConnection(URL, User, Password);

                String sqlGetDate = "SELECT DATE(Departure_Datetime) AS ReservationDate FROM Train_Schedule WHERE Train_No = ? AND Departure_Datetime = ?";
                PreparedStatement psGetDate = conn.prepareStatement(sqlGetDate);
                psGetDate.setString(1, trainNo);
                psGetDate.setString(2, departureDatetime);
                ResultSet rsGetDate = psGetDate.executeQuery();

                if (rsGetDate.next()) {
                    reservationDate = rsGetDate.getString("ReservationDate");
                } else {
                    throw new Exception("Unable to retrieve reservation date. Check the Train_No and Departure_Datetime.");
                }

                rsGetDate.close();
                psGetDate.close();

                String lastReservationNo = "";
                String sqlLastReservation = "SELECT Reservation_No FROM reservations ORDER BY Reservation_No DESC LIMIT 1";
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sqlLastReservation);

                if (rs.next()) {
                    lastReservationNo = rs.getString("Reservation_No");
                }

                int nextReservationNo = lastReservationNo.isEmpty() ? 1 : Integer.parseInt(lastReservationNo.substring(3)) + 1;
                String reservationNo = "RES" + String.format("%04d", nextReservationNo);

                String sqlInsert = "INSERT INTO reservations (Reservation_No, Date, Total_Fare, Passenger, One_Way, Round_Trip, No_of_Tickets) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
                psInsert.setString(1, reservationNo);
                psInsert.setString(2, reservationDate); 
                psInsert.setFloat(3, totalFare);
                psInsert.setString(4, passengerName);
                psInsert.setBoolean(5, oneWay);
                psInsert.setBoolean(6, roundTrip);
                psInsert.setInt(7, tickets);

                int rowsInserted = psInsert.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<h2>Reservation Successful</h2>");
                    out.println("<p>Reservation No: " + reservationNo + "</p>");
                    out.println("<p>Total Fare: $" + String.format("%.2f", totalFare) + "</p>");
                    out.println("<p>Passenger Name: " + passengerName + "</p>");
                    out.println("<p>Reservation Date: " + reservationDate + "</p>");
                } else {
                    out.println("<h2 style='color: red;'>Reservation Failed</h2>");
                    out.println("<p>Please try again later.</p>");
                }

                rs.close();
                stmt.close();
                psInsert.close();
                conn.close();

            } catch (Exception e) {
                out.println("<h2 style='color: red;'>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
            }
        %>
        <a href="make_reservation.jsp">Make Another Reservation</a>
    </div>
</body>
</html>
