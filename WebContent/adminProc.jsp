<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>관리자 페이지</title>
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
	background: url("image/admin.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.container {
width:300px;

	background-color: rgba(255, 255, 255, 0.8);
}
</style>
</head>
<body>
	<div class="container" align="center">
		<h3>관리자 메뉴입니다.</h3>
		<a href="insertProduct.jsp" class="btn btn-primary">상품 추가</a><p><p> <a
			href="insertEvent.jsp" class="btn btn-success">이벤트 추가</a><br><br>
	</div>
</body>
</html>