<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = (String) session.getAttribute("id");
	int random = 0;
	int code = 0;

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
<title>쿠폰 뽑기</title>
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
	background: url("image/lot.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

h4 {
	text-align: center;
}

.container {
	width: 500px;
	background-color: rgba(255, 255, 255, 0.8);
}
</style>
<script type="text/javascript">
	function selectLots() {
		var element = document.getElementById('id');
		element.style.opacity = "0.9";
		element.style.filter = 'alpha(opacity=90)'; // IE fallback
	}
</script>
</head>
<body>
	<div class="container">
		<h4>다양한 금액대의 쿠폰을 뽑아보세요!!</h4>
		<p>
		<div class="row">
			<div class="col-sm-3" onclick="selectLots()" align="center">
				<img src="image/lots.png" width="100px;" height="150px"
					value="finish"> <input type="radio" name="lots" />
			</div>
			<div class="col-sm-3" onclick="selectLots()" align="center">
				<img src="image/lots2.png" width="100px;" height="150px"
					value="finish"> <input type="radio" name="lots" />
			</div>
			<div class="col-sm-3" onclick="selectLots()" align="center">
				<img src="image/lots3.png" width="100px;" height="150px"
					value="finish"> <input type="radio" name="lots" />
			</div>
			<div class="col-sm-3" onclick="selectLots()" align="center">
				<img src="image/lots4.png" width="100px;" height="150px"> <input
					type="radio" name="lots" value="finish" />
			</div>
			<p>
		</div>
		<p>
		<div align="center">
			<button type="button" class="btn btn-warning" id="myBtn">결과
				확인하기</button>
		</div>

		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<div class="modal-header">
						<h4 class="modal-title">쿠폰뽑기 이벤트 당첨!</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>

					<%
						String sql = "select * from lotstbl where coupon_code=(select round(dbms_random.value(500,514)) random from dual)";
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							while (rs.next()) {
								out.println("<div class='modal-body'>" + rs.getInt("price") + "</div>");
								random = rs.getInt("price");
								code = rs.getInt("coupon_code");
								System.out.println(random + ", " + code);
							}
					%>
					<!-- Modal footer -->
					<div class="modal-footer">
						<a href="couponEvent.jsp?price=<%=random%>&code=<%=code%>" type="button"
							class="btn btn-danger">Close </a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			$("#myBtn").click(function() {
				$("#myModal").modal();
			});
		});
	</script>

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