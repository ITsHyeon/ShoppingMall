<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String result = request.getParameter("resultPrice");
	result = result.replace(",", "");
	String productName = request.getParameter("name");
	String friendCode = request.getParameter("code");
	String couponName = request.getParameter("coupon");
	String productPrice = request.getParameter("price");
	productPrice = productPrice.replace(",", "");

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

		String sql = "insert into ordertbl (product_name, product_price, order_id, friend_code, coupon, price) values (?,?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productName);
		pstmt.setInt(2, Integer.parseInt(productPrice));
		pstmt.setString(3, id);
		pstmt.setString(4, friendCode);
		pstmt.setString(5, couponName);
		pstmt.setInt(6, Integer.parseInt(result));
		pstmt.executeUpdate();

		out.println("<script>alert('�ֹ��� ���������� �Ϸ�Ǿ����ϴ�.')</script>");
		out.println("location.href='orderList.jsp'</script>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �Ϸ�</title>
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
		<h2>���� �ֹ� ����</h2>
		<table class="table">
			<thead>
				<tr>
					<th>��ȣ</th>
					<th>��ǰ��</th>
					<th>��ǰ����</th>
					<th>ģ���ڵ�</th>
					<th>�������</th>
					<th>���ΰ���</th>
				</tr>
			</thead>
			<tbody>
				<%
					sql = "select * from ordertbl where order_id='" + id + "'";
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
		<a href='index.jsp' class='btn btn-warning'>Ȩ����</a>
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