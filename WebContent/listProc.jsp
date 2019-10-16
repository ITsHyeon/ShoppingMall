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
<title>이벤트 리스트 페이지</title>
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
	background: url("image/event.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.container {
	background-color: rgba(255, 255, 255);
}
</style>
</head>
<body>

	<div class="container">
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>이벤트명</th>
					<th>할인가</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%
					String sql = "select * from coupontbl";

						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();

						while (rs.next()) {
							out.println("<tr>");
							out.println("<td>" + rs.getString("COUPON_CODE") + "</td>");
							out.println("<td>" + rs.getString("NAME") + "</td>");
							out.println("<td>" + rs.getString("PRICE") + "</td>");
							if (rs.getString("name").equals("제비뽑기 이벤트!")) {
								out.println("<td><a href='lot.jsp' class='btn btn-warning'>받기</a></td>");
							} else {
								if (id.equals("admin")) {
									out.println("<td><a href='getCoupon.jsp?name=" + rs.getString("NAME") + "&code="
											+ rs.getString("COUPON_CODE") + "' class='btn btn-warning'>받기</a></td>");
									out.println("<td><a href='deleteCoupon.jsp?name=" + rs.getString("NAME") + "&code="
											+ rs.getString("COUPON_CODE") + "' class='btn btn-danger'>삭제</a></td>");
								} else {
									out.println("<td><a href='getCoupon.jsp?name=" + rs.getString("NAME") + "&code="
											+ rs.getString("COUPON_CODE") + "&price=" + rs.getString("PRICE") + "' class='btn btn-warning'>받기</a></td>");
								}
								
							}
							out.println("</tr>");
						}
				%>
			</tbody>
		</table>
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