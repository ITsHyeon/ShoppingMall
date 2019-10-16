<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>
<link rel="stylesheet" href="index.css">
<script type="text/javascript">
	function toCheckPw() {
		var pw = document.getElementById("password").value;
		var pwch = document.getElementById("passwordCheck").value;

		if (pw != pwch) {
			document.getElementById('pwCheck').innerHTML = '비밀번호가 틀렸습니다. 다시 입력해주세요';
			return false;
		}
	}
</script>
</head>
<body>
	<h2>회원가입</h2>
	<form action="joinProc.jsp" method="post" onsubmit="return toCheckPw()">
		<table align="center">
			<tr>
				<td>아이디</td>
			</tr>
			<tr>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
			</tr>
			<tr>
				<td><input type="password" name="password" id="password"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
			</tr>
			<tr>
				<td><input type="password" name="passwordCheck"
					id="passwordCheck"><br>
					<p id="pwCheck" style="color: red;"></p></td>
			</tr>
			<tr>
				<td>이름</td>
			</tr>
			<tr>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>전화번호</td>
			</tr>
			<tr>
				<td><input type="text" name="tel" placeholder="010-1234-5678"></td>
			</tr>
			<tr>
				<td><input type="submit" value="확인"></td>
			</tr>
		</table>

	</form>
</body>
</html>