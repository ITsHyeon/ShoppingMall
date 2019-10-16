<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "EVENT";
		String pass = "1234";
		Connection conn;
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;

		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
		stmt = conn.createStatement();
		pstmt = conn.prepareStatement("select * from coupontbl");
		rs = pstmt.executeQuery();
		out.println("<table border=\"1\">");
		while (rs.next()) {
			out.println("<tr>");
			out.println("<td>" + rs.getString("name") + "</td>");
			/* out.println("<td><img src='" + rs.getString("image") + "' width='50px' height='70px'></td>"); */
			out.println("<td>" + rs.getString("price") + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");

		conn.close();
	%>
</body>
</html>