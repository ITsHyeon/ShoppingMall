<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("id");
	String price = request.getParameter("price");
	String code = request.getParameter("code");

	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "EVENT";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = "insert into couponlisttbl (coupon_code, name, price, id) values (?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, code);
		pstmt.setString(2, "제비뽑기 이벤트!");
		pstmt.setString(3, price);
		pstmt.setString(4, id);	
		pstmt.executeUpdate();
		
		out.println("<script>alert('당첨 축하드립니다!');location.href='coupon.jsp'</script>");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

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