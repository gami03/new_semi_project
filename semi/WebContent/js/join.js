// 로그인시 id pwd 입력 확인
function login_check(){
    var f = document.forms["f"];
    if(f.elements["login_id"].value==""){
        alert("아이디를 입력하세요.");
        f.elements["login_id"].focus();
        return false;
    }
    if(f.elements["login_pwd"].value==""){
        alert("비밀번호를 입력하세요.");
        f.elements["login_pwd"].focus();
        return false;
    }
}
	// 회원가입 정보 입력 확인
	function join_check(){
	    var j = document.forms["j"];

		if(j.user_id.value==""){
			alert("아이디가 입력되지 않았습니다. ")
			j.user_id.focus();
			return false;
		}
		
		if(j.user_password.value==""){
			alert("비밀번호가 입력되지 않았습니다. ")
			j.user_password.focus();
			return false;
		}
		
		if(j.confirm_password.value==""){
			alert("비밀번호 재입력 확인이 되지 않았습니다. ")
			j.confirm_password.focus();
			return false;
		}
		
		if(j.user_name.value==""){
			alert("이름이 입력되지 않았습니다. ")
			j.user_name.focus();
			return false;
		}
		
		if(j.user_nickname.value==""){
			alert("닉네임이 입력되지 않았습니다. ")
			j.user_nickname.focus();
			return false;
		}
		
		if(j.user_birth.value==""){
			alert("생년월일이 입력되지 않았습니다. ")
			j.user_birth.focus();
			return false;
		}
		
		if(j.user_phone.value==""){
			alert("연락처가 입력되지 않았습니다. ")
			j.user_phone.focus();
			return false;
		}
		
		if(j.user_addr.value==""){
			alert("주소가 입력되지 않았습니다. 상세주소 입력 확인 바랍니다. ")
			j.user_addr.focus();
			return false;
		}
		
		if(j.user_email.value==""){
			alert("이메일이 입력되지 않았습니다. ")
			j.user_email.focus();
			return false;
		}
		
	}