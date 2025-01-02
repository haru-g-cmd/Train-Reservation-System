<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Best Customer</title>
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

        p {
            font-size: 1.2rem;
            color: #555;
            margin: 10px 0;
        }

        .error {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Best Customer</h2>
        <%
            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(URL, User, Password);
                stmt = conn.createStatement();

                String sql = "SELECT Passenger, SUM(Total_Fare) AS TotalSpent " +
                             "FROM Reservations " +
                             "GROUP BY Passenger ORDER BY TotalSpent DESC LIMIT 1";
                rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    out.println("<p><strong>Best Customer:</strong> " + rs.getString("Passenger") + "</p>");
                    out.println("<p><strong>Total Spent:</strong> $" + rs.getDouble("TotalSpent") + "</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>
