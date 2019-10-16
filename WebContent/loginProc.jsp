<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
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
	<%!int n = 0;
	String dbNAME = "";%>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String dbPW = "";
		String dbNAME = "";
		String dbTel = "";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		Class.forName("oracle.jdbc.driver.OracleDriver");

		try {
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
			String user = "EVENT";
			String pass = "1234";

			conn = DriverManager.getConnection(url, user, pass);
			pstmt = conn.prepareStatement("SELECT * FROM MEMBERTBL WHERE id='" + id + "'");
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dbPW = rs.getString("password");
				dbNAME = rs.getString("name");
				dbTel = rs.getString("tel");
				
				if (dbPW.equals(password))
					n = 1;
				else
					n = 0;
			} else {
				n = -1;
			}
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
		if (<%=n%>== 1) {
			alert("<%=dbNAME%>님 환영합니다.");
		<%
			session.setAttribute("id", id);
			session.setAttribute("name", dbNAME);
			session.setAttribute("tel", dbTel);

		%>
		location.href = "index.jsp";
		} else if (<%=n%>== 0) {
			alert("비밀번호를 다시 확인해주세요.");
			history.go(-1);
		} else if (<%=n%>== -1) {
			alert("존재하지 않는 회원입니다.");
			history.go(-1);
		} else {
			alert("로그인 실패");
			history.go(-1);
		}
	</script>
</body>
</html>