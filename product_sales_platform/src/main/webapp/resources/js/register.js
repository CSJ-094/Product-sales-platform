function check_ok(){
	if(reg_frm.member_id.value.length==0){
		alert("아이디를 써주세요.");
		reg_frm.member_id.focus();
		return;
	}
	if(reg_frm.member_id.value.length < 4){
		alert("아이디는 4글자 이상이여야 합니다.");
		reg_frm.member_id.focus();
		return;
	}
	if(reg_frm.member_pw.value.length==0){
		alert("비밀번호를 써주세요.");
		reg_frm.member_pw.focus();
		return;
	}
	if(reg_frm.pwd_chk.value!=reg_frm.member_pw.value){
		alert("비밀번호를 제대로 확인해주세요.");
		reg_frm.pwd_chk.focus();
		return;
	}
	if(reg_frm.member_name.value.length==0){
		alert("이름을 써주세요.");
		reg_frm.member_name.focus();
		return;
	}
	if(reg_frm.member_email.value.length==0){
		alert("이메일을 써주세요.");
		reg_frm.member_email.focus();
		return;
	}
	if(reg_frm.member_phone.value.length==0){
		alert("폰 번호를 써주세요.");
		reg_frm.member_phone.focus();
		return;
	}
	if(reg_frm.member_zipcode.value.length==0){
		alert("우편 번호가 비었습니다.");
		return;
	}
	if(reg_frm.member_addr2.value.length==0){
		alert("상세 주소가 비었습니다.");
		return;
	}
	if(reg_frm.idCheck.value=="N"){
		alert("아이디 중복 체크를 해주세요.");
		return;
	}
	if(reg_frm.emailCheck.value=="N"){
		alert("이메일 중복 체크를 해주세요.");
		return;
	}
	reg_frm.submit();
}

function fn_idCheck(){
		if($("#member_id").val() == ""){
			alert("아이디가 공백입니다.");
		}else if($("#member_id").val().length < 4){
			alert("아이디가 4글자 이상이어야 합니다.");
		}else{
		var params = {
	                member_id : $("#member_id").val()
	                }

	                $.ajax({
	                    url : "idCheck", 
	                    type : "post", 
	                    dataType : 'json', 
	                    data : params, 

	                    

	                    success : function(result){
	                   	console.log(result);
	                    
	                        if(result == false){
	                            $("#idCheck").attr("value", "N");
	                            alert("중복된 아이디입니다.");

	                        }else if(result == true){
	                            $("#idCheck").attr("value", "Y");
	                            alert("사용가능한 아이디입니다.");
	                            

	                        }else if(member_id == ""){
	                            alert("아이디가 확인되지 않았습니다. 다시 시도해주세요");
	                        }
	                    },error: function() {
					alert("오류입니다.");
				}
		 });
	 }
}
function fn_emailCheck(){
		if($("#member_email").val() == ""){
			alert("이메일이 공백입니다.");
		}else{
		var params = {
	                member_email : $("#member_email").val()
	                }

	                $.ajax({
	                    url : "emailCheck", 
	                    type : "post", 
	                    dataType : 'json', 
	                    data : params, 

	                    

	                    success : function(result){
	                   	console.log(result);
	                    
	                        if(result == false){
	                            $("#emailCheck").attr("value", "N");
	                            alert("중복된 이메일 입니다.");

	                        }else if(result == true){
	                            $("#emailCheck").attr("value", "Y");
	                            alert("사용가능한 이메일입니다.");

	                        }else if(result == ""){
	                            alert("이메일이 확인되지 않았습니다. 다시 시도해주세요");
	                        }
	                    },error: function() {
					alert("오류입니다.");
				}
	 	});
	 }
}
