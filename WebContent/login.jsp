<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<!-- <link rel="stylesheet" href="index.css">
 -->
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
	background: url("image/join.jpg") no-repeat fixed center;
	background-size: 100% 100%;
}

.container {
	width: 300px;
	background-color: rgba(255, 255, 255, 0.8);
}
</style>
</head>
<body>
	<div class="container">
		<p>
		<form action="loginProc.jsp" method="post" class="form-inline">
			<table align="center">
				<tr>
					<td>아이디</td>
				</tr>
				<tr>
					<td><input type="text" name="id" class="form-control">
						<p></td>
				</tr>
				<tr>
					<td>비밀번호</td>
				</tr>
				<tr>
					<td><input type="password" name="password"
						class="form-control">
					<p></td>
				</tr>
				<tr>
					<td><p>
							<input type="submit" value="로그인" class="btn btn-success"
								style="width: 200px;"></td>
				</tr>
				<tr>
					<td><p onclick="location.href='join.jsp'" align="center">회원가입</p></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>