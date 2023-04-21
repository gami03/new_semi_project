 $(function() {
  $.ajaxSetup({
    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
    type : "post"
  });

 // 아이디 중복 + 유효성 검사
$('#user_id').on('keyup', function() {
checkDuplicateId();
});

function checkDuplicateId() {
var userId = $('#user_id').val();
var regex = /^[a-z0-9]{4,16}$/;

if (!regex.test($.trim($("#user_id").val()))) {
let warningTxt = '<font color="black">영문 소문자 + 숫자로 이루어진 4자 이상 16자 이하로 입력해주세요.'
$("#idcheck").text(""); // span 태그 영역 초기화
$("#idcheck").show();
$("#idcheck").append(warningTxt);
return false;
}

if (userId) {
$.ajax({
type: 'POST',
url: 'idcheck.do',
data: { paramId: userId },
dataType: 'json',
success: function(data) {
if (data == -1) { // DB에 아이디가 존재.중복된 경우.
let warningTxt = '<font color="pink"> 중복된 아이디입니다.'
$("#idcheck").text(""); // span 태그 영역 초기화
$("#idcheck").show();
$("#idcheck").append(warningTxt);
} else { //DB에 아이디값이 없음.사용가능.
let warningTxt = '<font color="green">사용 가능한 아이디입니다.'
$("#idcheck").text(""); // span 태그 영역 초기화
$("#idcheck").show();
$("#idcheck").append(warningTxt);
}
},
error: function(data) {
alert('데이터 통신 오류');
}
});
}
}
  
  // 닉네임 중복+유효성검사
  $('#user_nickname').on('keyup', function() {
    checkDuplicateNick();
  });
    function checkDuplicateNick() {
		    var userNick = $('#user_nickname').val();
		
			    $.ajax({
			      type: 'POST',
			      url: 'nickcheck.do',
			      data: { paramNick: userNick },
			      dataType: 'json',
			      success: function(data) {
			        if (data == -1) { // DB에 아이디가 존재.중복된 경우.
			          let warningTxt = '<font color="orange"> 중복된 닉네임 입니다.'
			          $("#nickcheck").text(""); // span 태그 영역 초기화
			          $("#nickcheck").show();
			          $("#nickcheck").append(warningTxt);
			        } else { //DB에 아이디값이 없음.사용가능.
			          let warningTxt = '<font color="green">사용 가능한 닉네임 입니다.'
			          $("#nickcheck").text(""); // span 태그 영역 초기화
			          $("#nickcheck").show();
			          $("#nickcheck").append(warningTxt);
			        }
			      },
			      error: function(data) {
			        alert('데이터 통신 오류2');
			      }
			});	
			}		  
	// 연락처 중복+유효성검사
   $('#user_phone').on('keyup', function() {
    checkDuplicatePhone();
  });
    function checkDuplicatePhone() {
			    var userPhone = $('#user_phone').val();
			    if (userPhone) {
				  if (!/^[0-9]*$/.test(userPhone)) {
				      let warningTxt = '<font color="black">숫자만 입력 가능합니다.'
				      $("#phonecheck").text(""); // span 태그 영역 초기화
				      $("#phonecheck").show();
				      $("#phonecheck").append(warningTxt);
				      return false;
				    }
				
			      if ($.trim($("#user_phone").val()).length < 10) {
			        let warningTxt = '<font color="black">연락처는 10~11자 입니다.'
			        $("#phonecheck").text(""); // span 태그 영역 초기화
			        $("#phonecheck").show();
			        $("#phonecheck").append(warningTxt);
			        return false;
			      }
			      if ($.trim($("#user_phone").val()).length > 11) {
			        let warningTxt = '<font color="black">연락처는 10~11자 입니다.'
			        $("#phonecheck").text(""); // span 태그 영역 초기화
			        $("#phonecheck").show();
			        $("#phonecheck").append(warningTxt);
			        return false;
			      }

			      $.post('phonecheck.do', { paramPhone: userPhone }, function(data) {
			        if (data == -1) { // DB에 아이디가 존재.중복된 경우.
			          let warningTxt = '<font color="pink"> 중복된 연락처입니다.'
			          $("#phonecheck").text(""); // span 태그 영역 초기화
			          $("#phonecheck").show();
			          $("#phonecheck").append(warningTxt);
			        } else { //DB에 아이디값이 없음.사용가능.
			          let warningTxt = '<font color="green">사용 가능한 연락처입니다.'
			          $("#phonecheck").text(""); // span 태그 영역 초기화
			          $("#phonecheck").show();
			          $("#phonecheck").append(warningTxt);
			        }
			      });
			    }
			  }
			
//이메일 중복+유효성검사  
$('#user_email').on('keyup', function() {
  checkDuplicateEmail();
});

function checkDuplicateEmail() {
  var userEmail = $('#user_email').val();
  if (userEmail) {
    if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(userEmail)) {
      let warningTxt = '<font color="black"> - 유효한 이메일 형식으로 입력해주세요.'
      $("#emailcheck").text(""); // span 태그 영역 초기화
      $("#emailcheck").show();
      $("#emailcheck").append(warningTxt);
      return false;
    }
  }

  $.post('emailcheck.do', { paramEmail: userEmail }, function(data) {
    if (data == -1) { // DB에 이메일이 존재. 중복된 경우.
      let warningTxt = '<font color="pink"> 중복된 이메일입니다.'
      $("#emailcheck").text(""); // span 태그 영역 초기화
      $("#emailcheck").show();
      $("#emailcheck").append(warningTxt);
    } else { // DB에 이메일값이 없음. 사용가능.
      let warningTxt = '<font color="green">사용 가능한 이메일입니다.'
      $("#emailcheck").text(""); // span 태그 영역 초기화
      $("#emailcheck").show();
      $("#emailcheck").append(warningTxt);

			        }
			      });
			    }
		
		
	//비밀번호 유효성 검사
		
	$(function() {
  $('#password').on('keyup', function() {
    checkPassword();
  });

  $('#confirm_password').on('keyup', function() {
    checkConfirmPassword();
  });
});

function checkPassword() {
  var password = $('#password').val();
  var regex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
  
  if (!regex.test(password)) {
    let warningTxt = '<font color="black">영문+숫자 조합으로 8자이상 16자이하 비밀번호를 입력하세요.'
    $("#pwdcheck").text(""); 
    $("#pwdcheck").show();
    $("#pwdcheck").append(warningTxt);
    return false;
  } else {
    $("#pwdcheck").hide();
    return true;
  }
}

function checkConfirmPassword() {
  var password = $('#password').val();
  var confirm_password = $('#confirm_password').val();

  if (password != confirm_password) {
    let warningTxt = '<font color="red">비밀번호가 일치하지 않습니다.'
    $("#confirm_pwdcheck").text(""); 
    $("#confirm_pwdcheck").show();
    $("#confirm_pwdcheck").append(warningTxt);
    return false;
  } else {
    $("#confirm_pwdcheck").hide();
    return true;
  }
}
});

	
		
