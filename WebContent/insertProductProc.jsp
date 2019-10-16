<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("id");
	String name = request.getParameter("name");
	String price = request.getParameter("price");
	String image = request.getParameter("image");
	
	System.out.println("name : " + name + ", price : " + price + ", image : " + image);
	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "EVENT";
	String pass = "1234";

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = "insert into producttbl (name, price, image) values ('"+name + "', '" + price + "', '"+image +"')";
		System.out.println(sql);

		pstmt = conn.prepareStatement(sql);
/* 		pstmt.setString(1, name);
		pstmt.setString(2, price);
		pstmt.setString(3, image); */
		pstmt.executeUpdate();

		out.println("<script>alert('상품을 등록하였습니다!');location.href='index.jsp';</script>");
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