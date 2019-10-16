<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!int n = 0;%>
	<%
		request.setCharacterEncoding("UTF-8");
		// 값 세팅
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");

		/* out.println("ID > " + id + "<br>");
		out.println("PW > " + password + "<br>");
		out.println("이름 > " + name + "<br>");
		out.println("생년월일 > " + birthday + "<br>");
		out.println("전화번호 > " + phoneNumber + "<br>"); */

		// JDBC
		Connection conn = null;
		PreparedStatement pstmt = null;
		// 1단계 : 드라이버 로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");

		try {
			// 2단계 : DB연결(Connection) 시작
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String user = "EVENT";
			String pass = "1234";

			conn = DriverManager.getConnection(url, user, pass);

			pstmt = conn.prepareStatement("INSERT INTO MEMBERTBL VALUES (?,?,?,?)");

			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, name);
			pstmt.setString(4, tel);
			
			n = pstmt.executeUpdate();
			//out.println("==> " + n);

		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException ex) {
				System.out.println(ex.getMessage());
			}
		}
	%>
	<script type="text/javascript">
		if (
	<%=n%>
		> 0) {
			alert("정상적으로 회원가입되었습니다.");
			location.href = "log.jsp";
		} else {
			alert("회원가입에 실패했습니다.");
			history.go(-1);
		}
	</script>
</body>
</html>