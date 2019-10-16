<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String contentPage = request.getParameter("CONTENTPAGE");
	String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Event</title>
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
align {
	text-align: right;
}
</style>
</head>
<body>
<body style="height: 1500px">
	<nav class="navbar navbar-expand-sm bg-warning navbar-dark fixed-top">
		<a class="navbar-brand" href="index.jsp">Home</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#collapsibleNavbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="collapsibleNavbar">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="list.jsp">Event</a></li>
				<li class="nav-item"><a class="nav-link" href="lot.jsp">Lot</a></li>
				<li class="nav-item"><a class="nav-link" href="order.jsp">Order</a></li>
				<li class="nav-item"><a class="nav-link" href="coupon.jsp">Coupon</a></li>
			</ul>
		</div>

		<div align="right">
			<%
				String name = (String) session.getAttribute("name");

				if (id == null) {
					out.println("<a href='log.jsp' class='nav-link'>Login</a>");
				} else {
					if (name.equals("관리자")) {
						out.println("<span style='color:white;'><a href='admin.jsp'>" + name + "</a>님 환영합니다.</span>");
						out.println("<a href='logout.jsp'>로그아웃</a>");
					} else {
						out.println("<span style='color:white;'>" + name + "님 환영합니다.</span>");
						out.println("<a href='logout.jsp'>로그아웃</a>");
					}
				}
			%>
		</div>
	</nav>




	<div class="container-fluid" style="margin-top: 80px">
		<jsp:include page="<%=contentPage%>" flush="false" />
	</div>



</body>


</html>