<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sales Report</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Monthly Sales Report</h2>

        <form method="post" action="salesReport.jsp">
            <div class="form-group">
                <label for="month">Select Month:</label>
                <input type="month" name="month" required>
            </div>
            <button type="submit">Generate Report</button>
        </form>

        <%
            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String selectedMonth = request.getParameter("month");
            if (selectedMonth != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);

                    String sqlSalesReport = "SELECT DATE_FORMAT(r.Date, '%Y-%m') AS Month, SUM(r.Total_Fare) AS MonthlyRevenue " +
                                            "FROM Reservations r " +
                                            "WHERE DATE_FORMAT(r.Date, '%Y-%m') = ? " +
                                            "GROUP BY Month";
                    pstmt = conn.prepareStatement(sqlSalesReport);
                    pstmt.setString(1, selectedMonth);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        out.println("<p>Month: " + selectedMonth + "</p>");
                        out.println("<p>Total Revenue: $" + rs.getDouble("MonthlyRevenue") + "</p>");
                    } else {
                        out.println("<p>No sales data available for the selected month.</p>");
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
