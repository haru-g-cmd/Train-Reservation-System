<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Cancel Reservation</title>
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
            String reservationNo = request.getParameter("reservationNo");

            if (reservationNo == null || reservationNo.isEmpty()) {
                out.println("<h2 style='color:red;'>Invalid Reservation Number</h2>");
                out.println("<form action='viewReservations.jsp' method='get'>");
                out.println("<button type='submit'>Back to My Reservations</button>");
                out.println("</form>");
                return;
            }

            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, User, Password);

                String deleteQuery = "DELETE FROM Reservations WHERE Reservation_No = ?";
                pstmt = conn.prepareStatement(deleteQuery);
                pstmt.setString(1, reservationNo);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<h2>Reservation Canceled</h2>");
                    out.println("<p>Reservation <strong>" + reservationNo + "</strong> has been successfully canceled.</p>");
                } else {
                    out.println("<h2 style='color:red;'>Cancellation Failed</h2>");
                    out.println("<p>Unable to cancel reservation. Please try again later.</p>");
                }
            } catch (Exception e) {
                out.println("<h2 style='color:red;'>Error</h2>");
                out.println("<p>" + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    out.println("<p style='color:red;'>Error closing resources: " + ex.getMessage() + "</p>");
                }
            }
        %>
        <form action="viewReservations.jsp" method="get">
            <button type="submit">Back to My Reservations</button>
        </form>
    </div>
</body>
</html>
