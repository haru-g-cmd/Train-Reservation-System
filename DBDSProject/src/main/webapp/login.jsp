<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://i.redd.it/u6rxthrum7c61.jpg') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            padding: 20px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }

        h2, h3 {
            color: #333;
            font-weight: 900;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-spacing: 0 10px;
        }

        td {
            text-align: left;
            color: #555;
            font-weight: bold;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #4b0082;
        }

        .section {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login Page</h2>

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

                if (request.getParameter("customerSubmit") != null) {
                    boolean custFlag = false;
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    String customerSQL = "SELECT * FROM customer WHERE username = ? AND pswd = ?";
                    PreparedStatement ps = conn.prepareStatement(customerSQL);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        custFlag = true;

                        session.setAttribute("username", username);
                    }

                    if (custFlag) {
                        response.sendRedirect("customer_homepage.jsp");
                    } else {
                        out.println("<p style='color:red;'>Invalid customer username or password. Please try again.</p>");
                    }
                }

                if (request.getParameter("employeeSubmit") != null) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");

                    // Check for admin credentials
                    if ("manager1".equals(username) && "m1pass".equals(password)) {
                        session.setAttribute("username", username);
                        response.sendRedirect("admin_homepage.jsp");
                    } else {
                        boolean empFlag = false;

                        String employeeSQL = "SELECT * FROM employee WHERE username = ? AND pswd = ?";
                        PreparedStatement ps = conn.prepareStatement(employeeSQL);
                        ps.setString(1, username);
                        ps.setString(2, password);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            empFlag = true;

                            session.setAttribute("username", username);
                        }

                        if (empFlag) {
                            response.sendRedirect("customer_rep_homepage.jsp");
                        } else {
                            out.println("<p style='color:red;'>Invalid employee username or password. Please try again.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Database connection error: " + e.getMessage() + "</p>");
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

        <div class="section">
            <h3>Customer Login</h3>
            <form method="post" action="login.jsp">
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                </table>
                <input type="submit" name="customerSubmit" value="Customer Login">
            </form>
            <form action="signup.jsp" method="get" style="margin-top: 10px;">
		        <input type="submit" value="Register">
		    </form>
        </div>

        <div class="section">
            <h3>Employee Login</h3>
            <form method="post" action="login.jsp">
                <table>
                    <tr>
                        <td>Username:</td>
                        <td><input type="text" name="username" required></td>
                    </tr>
                    <tr>
                        <td>Password:</td>
                        <td><input type="password" name="password" required></td>
                    </tr>
                </table>
                <input type="submit" name="employeeSubmit" value="Employee Login">
            </form>
        </div>
    </div>
</body>
</html>
