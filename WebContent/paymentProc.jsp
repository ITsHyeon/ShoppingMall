<%@page
	import="com.sun.org.apache.xerces.internal.impl.dv.dtd.NMTOKENDatatypeValidator"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%!int friendDC = 0;
	int couponDC = 0;%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");

	String name = request.getParameter("name");
	String price = request.getParameter("price");
	String image = request.getParameter("image");

	int testPrice = 0;

	try {
		int test = Integer.parseInt(price);
		out.println(test);
	} catch (Exception e) {
		e.printStackTrace();
	}

	String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
	String user = "EVENT";
	String pass = "1234";

	ArrayList idList = new ArrayList();

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(url, user, pass);

		String sql = "select id from membertbl";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			idList.add(rs.getString(1));
		}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
var friendDC=0;
var couponDC=0;
var code="";
var coupon="";
var resultPrice =0;
	var id = <%=id%>;
	if (id == null) {
		alert("로그인이 필요한 서비스 입니다.");
		location.href = "log.jsp";
	} else {
	}

	function checkCode() {
		var idArr = new Array();
		code = document.getElementById("code").value;
		// DB의 아이디들을 배열에 배치하기
		<%for (int i = 0; i < idList.size(); i++) {%>
		idArr[<%=i%>]="<%=idList.get(i)%>";
<%}%>

	for (var i = 0; i < <%=idList.size()%>; i++) {
			if (idArr[i] == code) {
				document.getElementById('friendcode').innerHTML = code
						+ "님의 친구할인 코드가 적용되었습니다.";
				document.getElementById('friendprice').innerHTML = "친구할인 : -10,000원";
				friendDC = 10000;
				alert("친구 할인코드가 적용됩니다!");
				return false;
			} 
		}
		alert("친구코드가 존재하지 않습니다");
	

	}
	function checkCoupon(price) {
		coupon = document.getElementById('coupon').value;
		document.getElementById('couponPrice').innerHTML = "쿠폰할인 : " + "-"
				+ price + "원";
		couponDC = price;
	}
	function checkResult() {
		
		<%sql = "select * from producttbl where name='" + name + "'";
				System.out.println(sql);
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					System.out.println(rs.getString("Price"));
					testPrice = rs.getInt("PRICE");
				}%>
		
		var price = <%=testPrice%>;
		resultPrice = price - friendDC - couponDC;
		document.getElementById('result').innerHTML = "최종 결제금액은 " + resultPrice + "원 입니다.";
		}
	
	function result(){
		checkResult();
 		location.href="buy.jsp?resultPrice=" + resultPrice + "&code=" + code + "&coupon=" + coupon + "&name=<%=name%>&price=<%=price%>";

	}
</script>
<style>
body {
	background: url("image/payment.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.container {
	background-color: rgba(255, 255, 255, 0.8);
}

.payinfo {
	
}

.infoimg {
	display: inline-block;
}

.infotext {
	float: right;
}

.input {
	margin: auto 0px;
}

.coupon {
	width: 300px;
}
</style>
</head>
<body>
	<div class="container">
		<h4>결제</h4>
		<h7>주문상품정보</h7>
		<div class="payinfo">
			<div class="infoimg">
				<img src="<%=image%>" width="300px" height="300px"
					style="margin: 10px;">
				<div class="infotext" style="margin: 10px;">
					<p>
					<h4><%=name%></h4>
					<h4 id="price" value="<%=price%>">
						&#8361;<%=price%></h4>
				</div>
			</div>
		</div>
		<hr color="black">

		<div>
			<h7>주문자 정보</h7>
			<h5 align="center"><%=session.getAttribute("name")%></h5>
			<h5 align="center"><%=session.getAttribute("tel")%></h5>
		</div>

		<hr color="black">
		<div class="code">
			<h7>친구 할인코드</h7>
			<p>
			<div class="form-inline input" align="center">
				<input type="text" id="code" class="form-control"
					placeholder="친구의 아이디를 입력하고 추가 할인 받으세요"
					style="width: 500px; margin-left: 280px;"> &nbsp;<input
					type="button" value="확인" class="btn btn-success"
					onclick="checkCode()">
				<p id="friendcode" style="color: gray;"></p>
				<br>
				<p id="friendprice" style="color: red;"></p>
			</div>
		</div>
		<hr color="black">
		<div class="coupon">
			<h7>이벤트 쿠폰 사용</h7>
			<p>
				<%
					/* sql = "select l.coupon_code, l.name, TO_CHAR(l.price, '999,999,999,999,999'), l.id, m.name from coupontbl c, couponlisttbl l, membertbl m where c.coupon_code=l.coupon_code and l.id=m.id and l.id='"
								+ id + "'"; */
								sql = "select * from couponlisttbl where id='" + id +"'";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							out.println("<div class='coupon'>");
							out.println("<h4>" + rs.getString("name") + "</h4>");
							out.println("<p style='color:red;'>" + rs.getString("price") + "&#8361;</p>");
							out.println("<button value='"+ rs.getString("name") + "' class='btn btn-success' id='coupon' onclick='checkCoupon("
									+ rs.getString("price") + ");'>사용하기</button>");
							out.println("</div><p>");
						}
				%>
			
			<p style="color: red;" id="couponPrice"></p>
		</div>

		<hr color="black">
		<button class="btn btn-warning" onclick="checkResult()">결제금액
			확인하기</button>
		<p>
		<h1 style="color: red;" id="result"></h1>
		<button class='btn btn-primary' onclick="result()">결제하기</button>
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