<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("id");

	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "EVENT";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<style>
body {
	background: url("image/home.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.card {
	width: 350px;
	display: inline-block;
}
</style>
</head>
<body>
	<div class="container">
		<%
			String sql = "SELECT NAME, TO_CHAR(PRICE, '999,999,999,999,999'),price, IMAGE FROM PRODUCTTBL";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					out.println("<div class='card'>");
					out.println("<img class='card-img-top' src='" + rs.getString("IMAGE") + "' alt='"
							+ rs.getString("NAME") + "' style='width:100%'>");
					out.println("<div class='card-body'>");
					out.println("<h5 class='card-title'>" + rs.getString("NAME") + "</h5>");
					out.println("<p class='card-text'>&#8361; " + rs.getString(2) + "</p>");
					out.println("<a href='payment.jsp?name=" + rs.getString("NAME") + "&price=" + rs.getString(2).trim()
							+ "&image=" + rs.getString("IMAGE")
							+ "' class='btn btn-primary stretched-link'>BUY NOW</a>");
					out.println("</div>");
					out.println("</div>");
				}
		%>
	</div>
</body>
</html>
<%
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		try {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
			if (rs != null)
				rs.close();
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
	}
%>