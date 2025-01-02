<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Homepage</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://i.redd.it/u6rxthrum7c61.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        header {
            width: 100%;
            text-align: right;
            padding: 20px 40px;
        }

        .logout-btn {
            background-color: #6a0dad;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #4b0082;
        }

        main {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            width: 100%;
        }

        .welcome-container {
            margin-bottom: 30px;
            width: 100%;
            max-width: 800px;
        }

        .welcome-btn {
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
            padding: 20px;
            border-radius: 10px;
            font-size: 28px;
            font-weight: 700;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .button-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            max-width: 800px;
            width: 100%;
        }

        .btn {
            background-color: rgba(255, 255, 255, 0.9);
            color: #333;
            text-decoration: none;
            padding: 20px;
            text-align: center;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background-color: #6a0dad;
            color: white;
            transform: translateY(-5px);
        }

        .faq-btn {
            grid-column: span 2;
            text-align: center;
        }

        @media (max-width: 768px) {
            .button-container {
                grid-template-columns: 1fr;
            }

            .btn {
                font-size: 16px;
                padding: 15px;
            }
        }

        @media (max-width: 480px) {
            .btn {
                font-size: 14px;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <header>
        <a href="login.jsp" class="logout-btn">Logout</a>
    </header>
    
    <main>
        <div class="welcome-container">
            <%
                String username = (String) session.getAttribute("username");
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String fullName = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");

                    String sql = "SELECT FirstName, LastName FROM customer WHERE username = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        fullName = rs.getString("FirstName") + " " + rs.getString("LastName");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error fetching name: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
            %>
            <div class="welcome-btn">Welcome, <%= fullName %>!</div>
        </div>
        <div class="button-container">
            <a href="make_reservation.jsp" class="btn">Make a Train Reservation</a>
            <a href="search.jsp" class="btn">Search</a>
            <a href="customer_faq.jsp?username=<%= session.getAttribute("username") %>" class="btn faq-btn">FAQ</a>
        </div>
    </main>
</body>
</html>
