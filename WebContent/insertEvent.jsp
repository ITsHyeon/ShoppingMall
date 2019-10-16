<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 추가</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<h2>이벤트를 추가해주세요</h2>
		<form action="insertEventProc.jsp">
			<div class="form-group">
				<label for="name">이벤트명 : </label> <input type="text"
					class="form-control" id="name" name="name">
			</div>
			<div class="form-group">
				<label for="price">할인금액 : </label> <input type="text"
					class="form-control" id="price" name="price">
			</div>

			<button type="submit" class="btn btn-primary">등록하기</button>
		</form>
	</div>

</body>
</html>