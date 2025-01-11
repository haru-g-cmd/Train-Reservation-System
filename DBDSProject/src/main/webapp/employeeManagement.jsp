<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Rep Management</title>
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
            max-width: 500px;
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

        .success {
            color: green;
        }

        .error {
            color: red;
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
        <h2>Customer Rep Management</h2>
        <%
            String action = request.getParameter("action");
            String ssn = request.getParameter("ssn");
            String newSsn = request.getParameter("new_ssn");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            String URL = "jdbc:mysql://localhost:3306/railwaysystem";
            String User = "root";
            String Password = "abccba123!";

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                if (action != null && ssn != null && !ssn.isEmpty()) {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, User, Password);

                    if ("add".equals(action)) {
                        String sql = "INSERT INTO Employee (SSN, username, pswd, FirstName, LastName) VALUES (?, ?, ?, ?, ?)";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, ssn);
                        stmt.setString(2, username);
                        stmt.setString(3, password);
                        stmt.setString(4, firstName);
                        stmt.setString(5, lastName != null && !lastName.isEmpty() ? lastName : null);
                        stmt.executeUpdate();
                        out.println("<p class='success'>Rep added successfully.</p>");
                    } else if ("edit".equals(action)) {
                        String sql = "UPDATE Employee SET SSN = ?, username = ?, pswd = ?, FirstName = ?, LastName = ? WHERE SSN = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, newSsn != null && !newSsn.isEmpty() ? newSsn : ssn);
                        stmt.setString(2, username);
                        stmt.setString(3, password);
                        stmt.setString(4, firstName);
                        stmt.setString(5, lastName != null && !lastName.isEmpty() ? lastName : null);
                        stmt.setString(6, ssn);
                        stmt.executeUpdate();
                        out.println("<p class='success'>Rep information updated successfully.</p>");
                    } else if ("delete".equals(action)) {
                        String sql = "DELETE FROM Employee WHERE SSN = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, ssn);
                        stmt.executeUpdate();
                        out.println("<p class='success'>Rep deleted successfully.</p>");
                    } else {
                        out.println("<p class='error'>Invalid action specified.</p>");
                    }
                } else {
                    out.println("<p class='error'>SSN is required to perform this action.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        <form action="edit_customer_rep.jsp" method="get">
            <button type="submit">Back to Manage Customer Rep</button>
        </form>
    </div>
</body>
</html>
