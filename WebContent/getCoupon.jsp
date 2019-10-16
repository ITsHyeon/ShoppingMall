<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("id");
	String name = request.getParameter("name");
	String code = request.getParameter("code");
	String price = request.getParameter("price");

	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "EVENT";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		if (id != null) {
			String sql = "insert into couponlisttbl (coupon_code, name, price, id) values (?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			pstmt.setString(2, name);
			pstmt.setString(3, price);
			pstmt.setString(4, id);	
			pstmt.executeUpdate();
			out.println("<script>alert('쿠폰이 등록되었습니다!');location.href='index.jsp'</script>");
		} else {
			out.println("<script>alert('로그인이 필요한 서비스 입니다.');location.href='log.jsp'</script>");

		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 등록</title>

</head>
<body>
	<h1><%=name%></h1>
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