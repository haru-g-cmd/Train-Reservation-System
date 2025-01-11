<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Customer FAQ</title>
    <link rel="stylesheet" type="text/css" href="css/faq.css">
</head>
<body>
    <div class="container">
        <h1>Customer FAQ</h1>

        <%
            String customerName = (String) session.getAttribute("username");
            if (customerName == null) {
                response.sendRedirect("login.jsp");
            }
        %>

        <form method="POST" action="customer_faq.jsp">
            <div class="form-group">
                <label for="question">Your Question:</label>
                <textarea id="question" name="question" rows="4" required></textarea>
            </div>
            <button type="submit">Submit Question</button>
        </form>

        <form method="GET" action="customer_faq.jsp" style="margin-top: 20px;">
            <div class="form-group">
                <label for="search">Search Questions:</label>
                <input type="text" id="search" name="search_query">
            </div>
            <button type="submit">Search</button>
        </form>

        <h2>Frequently Asked Questions</h2>

        <table>
            <thead>
                <tr>
                    <th>Question</th>
                    <th>Reply</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String dbURL = "jdbc:mysql://localhost:3306/railwaysystem";
                    String dbUser = "root";
                    String dbPassword = "abccba123!";
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        stmt = conn.createStatement();

                        if (request.getMethod().equalsIgnoreCase("POST")) {
                            String question = request.getParameter("question");

                            if (question != null) {
                                String insertSQL = "INSERT INTO questions (customer_username, question) VALUES (?, ?)";
                                PreparedStatement pstmt = conn.prepareStatement(insertSQL);
                                pstmt.setString(1, customerName);
                                pstmt.setString(2, question);
                                pstmt.executeUpdate();
                            }
                        }

                        String searchQuery = request.getParameter("search_query");
                        String querySQL;

                        if (searchQuery != null && !searchQuery.isEmpty()) {
                            querySQL = "SELECT question, reply FROM questions WHERE question LIKE ?";
                            PreparedStatement pstmt = conn.prepareStatement(querySQL);
                            pstmt.setString(1, "%" + searchQuery + "%");
                            rs = pstmt.executeQuery();
                        } else {
                            querySQL = "SELECT question, reply FROM questions";
                            rs = stmt.executeQuery(querySQL);
                        }

                        while (rs.next()) {
                            String question = rs.getString("question");
                            String reply = rs.getString("reply");
                %>
                            <tr>
                                <td><%= question %></td>
                                <td><%= (reply != null && !reply.isEmpty()) ? reply : "No reply yet" %></td>
                            </tr>
                <%
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
