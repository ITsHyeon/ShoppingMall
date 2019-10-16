<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
<meta charset="EUC-KR">
<title>주문내역</title>
<style>
body {
	background: url("image/payment.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.container {
	background-color: rgba(255, 255, 255, 0.8);
}
</style>
</head>
<body>
	<div class="container">
		<h2>나의 주문 내역</h2>
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>제품명</th>
					<th>제품가격</th>
					<th>친구코드</th>
					<th>사용쿠폰</th>
					<th>할인가격</th>
				</tr>
			</thead>
			<tbody>
				<%
					String sql = "select * from ordertbl where order_id='" + id + "'";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();

						while (rs.next()) {
							out.println("<tr>");
							out.println("<td>" + rs.getString("num") + "</td>");
							out.println("<td>" + rs.getString("product_name") + "</td>");
							out.println("<td>" + rs.getString("product_price") + "</td>");
							out.println("<td>" + rs.getString("friend_code") + "</td>");
							out.println("<td>" + rs.getString("coupon") + "</td>");
							out.println("<td>" + rs.getString("price") + "</td>");
							out.println("</tr>");
						}
				%>
			</tbody>
		</table>
		<a href='index.jsp' class='btn btn-warning'>홈으로</a>
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