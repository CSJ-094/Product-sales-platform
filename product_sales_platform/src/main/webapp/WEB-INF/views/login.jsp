<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container {
	width: 400px;
	margin: 0 auto;
	border: 1px solid #ccc;
	padding: 20px;
	box-shadow: 0px 0px 10px #ccc;
	border-radius: 8px;
	font-family: Arial, sans-serif;
}

.form-group {
	margin-bottom: 15px;
	display: flex;
	align-items: center;
}

.form-group label {
	width: 100px;
	font-weight: bold;
}

.form-group input {
	flex: 1;
	padding: 5px;
}

.form-title {
	text-align: center;
	margin-bottom: 20px;
}

.form-actions {
	text-align: center;
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="container">
		<form method="post" action="login_yn">
			<div class="form-title">
				<h1>로그인</h1>
			</div>
			<div class="form-group">
				<label for="member_id">ID</label>
				<input class="form-control" type="text" id="memberId" name="memberId" size="20" placeholder="아이디">
			</div>
			<div class="form-group">
				<label for="member_pw">비밀번호</label>
				<input class="form-control" type="password" id="memberPw" name="memberPw" size="20" placeholder="비밀번호">
			</div>
			<div class="form-actions">
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='register'">
			</div>
		</form>
	</div>
</body>
</html>




