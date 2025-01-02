<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer FAQ</title>
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

        header {
            width: 100%;
            text-align: right;
            padding: 10px 20px;
        }

        .back-btn {
            background-color: #6a0dad;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .back-btn:hover {
            background-color: #4b0082;
        }

        main {
            width: 100%;
            max-width: 1000px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin: 20px;
        }

        h1 {
            font-size: 32px;
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 20px;
        }

        form input[type="text"] {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            flex: 1;
            margin-right: 10px;
        }

        form button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #6a0dad;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        form button:hover {
            background-color: #4b0082;
        }

        .faq-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .faq-list {
            width: 100%;
        }

        .faq-item {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .faq-item p {
            font-size: 16px;
            color: #333;
            margin: 10px 0;
        }

        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
            margin-bottom: 10px;
            font-family: Arial, sans-serif;
            font-size: 14px;
        }

        button[type="submit"], input[type="submit"] {
            background-color: #6a0dad;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover, input[type="submit"]:hover {
            background-color: #4b0082;
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 24px;
            }

            .faq-item {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <header>
        <a href="customer_rep_homepage.jsp" class="back-btn">Back to Homepage</a>
    </header>
    <main>
        <div class="faq-container">
            <h1>Customer FAQ</h1>
            <form method="GET" action="cust_rep_faq.jsp">
                <input type="text" name="search" placeholder="Search questions..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>" />
                <button type="submit">Search</button>
            </form>

            <div class="faq-list">
                <%
                    Connection conn = null;
                    PreparedStatement stmt = null, updateStmt = null;
                    ResultSet rs = null;
                    String searchQuery = request.getParameter("search");

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/railwaysystem", "root", "abccba123!");

                        if (request.getParameter("replySubmit") != null) {
                            String reply = request.getParameter("reply");
                            int questionId = Integer.parseInt(request.getParameter("questionId"));
                            String username = (String) session.getAttribute("username");

                            String updateQuery = "UPDATE questions SET reply = ?, cust_rep_username = ? WHERE question_id = ?";
                            updateStmt = conn.prepareStatement(updateQuery);
                            updateStmt.setString(1, reply);
                            updateStmt.setString(2, username);
                            updateStmt.setInt(3, questionId);
                            updateStmt.executeUpdate();

                            out.println("<p style='color:green;'>Reply submitted successfully!</p>");
                        }

                        String query = "SELECT * FROM questions";
                        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                            query += " WHERE question LIKE ? OR reply LIKE ?";
                            stmt = conn.prepareStatement(query);
                            stmt.setString(1, "%" + searchQuery + "%");
                            stmt.setString(2, "%" + searchQuery + "%");
                        } else {
                            stmt = conn.prepareStatement(query);
                        }
                        rs = stmt.executeQuery();

                        boolean hasResults = false;
                        while (rs.next()) {
                            hasResults = true;
                            int id = rs.getInt("question_id");
                            String question = rs.getString("question");
                            String reply = rs.getString("reply");
                            String customerUsername = rs.getString("customer_username");
                            String custRepUsername = rs.getString("cust_rep_username");

                            out.println("<div class='faq-item'>");
                            out.println("<p><strong>Customer:</strong> " + customerUsername + "</p>");
                            out.println("<p><strong>Question:</strong> " + question + "</p>");
                            if (reply == null || reply.trim().isEmpty()) {
                                out.println("<form method='POST' action='cust_rep_faq.jsp'>");
                                out.println("<textarea name='reply' placeholder='Write your reply here...' required></textarea>");
                                out.println("<input type='hidden' name='questionId' value='" + id + "' />");
                                out.println("<button type='submit' name='replySubmit'>Submit Reply</button>");
                                out.println("</form>");
                            } else {
                                out.println("<p><strong>Answer:</strong> " + reply + "</p>");
                                out.println("<p><strong>Answered by:</strong> " + custRepUsername + "</p>");
                            }
                            out.println("</div>");
                        }

                        if (!hasResults) {
                            out.println("<p>No questions found.</p>");
                        }
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<p style='color:red;'>JDBC Driver not found. Ensure MySQL connector is in the classpath.</p>");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (updateStmt != null) updateStmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                            out.println("<p style='color:red;'>Error closing database resources: " + e.getMessage() + "</p>");
                        }
                    }
                %>
            </div>
        </div>
    </main>
</body>
</html>
