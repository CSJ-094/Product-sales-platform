<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 신청</title>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript" src="resources/js/register.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function daumZipCode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("member_addr1").value = extraAddr;

						} else {
							document.getElementById("member_addr2").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('member_zipcode').value = data.zonecode;
						document.getElementById("member_addr1").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("member_addr2").focus();
					}
				}).open();
	}

</script>
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
		<form name="reg_frm" method="post" action="registerOk">
			<div class="form-title">
				<h1>회원 가입 신청</h1>
			</div>

			<div class="form-group">
				<label for="member_id">User ID</label> 
				<input type="text" id="member_id" name="member_id" size="20" placeholder="아이디를 입력하세요.(4글자 이상))">
				<button type="button" onclick="fn_idCheck()" id="idCheck" name="idCheck" value="N">중복 확인</button>
				
			</div>

			<div class="form-group">
				<label for="member_pw">비밀번호</label> <input type="password" id="member_pw"
					name="member_pw" size="20" placeholder="비밀번호를 입력하세요.">
			</div>

			<div class="form-group">
				<label for="pwd_chk">비밀번호 확인</label> <input type="password" id="pwd_chk"
					name="pwd_chk" size="20" placeholder="비밀번호를 한번 더 입력하세요.">
			</div>

			<div class="form-group">
				<label for="member_name">이름</label> <input type="text"
					id="member_name" name="member_name" size="20" placeholder="이름을 입력하세요.">
			</div>

			<div class="form-group">
				<label for="member_email">이메일</label> 
				<input type="text" id="member_email" name="member_email" size="20" placeholder="이메일을 입력하세요.">
				<button type="button" onclick="fn_emailCheck()" id="emailCheck" value="N">중복 확인</button>
			</div>

			<div class="form-group">
				<label for="member_phone">휴대폰</label> <input type="text"
					id="member_phone" name="member_phone" size="20" placeholder="휴대폰 번호를 입력하세요.">
			</div>

			<div class="form-group">
				<label for ="address">주소</label> <br> <input class="form-control"
					style="width: 40%; display: inline;" placeholder="우편번호"
					name="member_zipcode" id="member_zipcode" type="text" readonly>
				<button type="button" class="btn btn-default"
					onclick="daumZipCode()">
					<i class="fa fa-search"></i> 우편번호 찾기
				</button>
			</div>
			<div class="form-group">
				<input class="form-control" style="top: 5px;" placeholder="도로명 주소"
					name="member_addr1" id="member_addr1" type="text" readonly>
			</div>
			<div class="form-group">
				<input class="form-control" placeholder="상세 주소" name="member_addr2"
					id="member_addr2" type="text">
			</div>

			<div class="form-actions">
				<input type="button" value="등록" onclick="check_ok()">
				<input type="reset" value="초기화">
				<input type="button" value="돌아가기" onclick="location.href='login'">
			</div>
		</form>
	</div>
</body>
</html>