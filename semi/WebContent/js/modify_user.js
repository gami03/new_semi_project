 $(function() {
  $.ajaxSetup({
    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
    type : "post"
  });

 // 아이디 중복 + 유효성 검사

  
  // 닉네임 중복+유효성검사
  $('#modify_nickname').on('keyup', function() {
    checkDuplicateNick();
  });
    function checkDuplicateNick() {
		    var userNick = $('#modify_nickname').val();
		
			    $.ajax({
			      type: 'POST',
			      url: 'nickcheck.do',
			      data: { paramNick: userNick },
			      dataType: 'json',
			      success: function(data) {
			        if (data == -1) { // DB에 아이디가 존재.중복된 경우.
			          let warningTxt = '<font color="orange"> 중복된 닉네임 입니다.'
			          $("#modify_nickcheck").text(""); // span 태그 영역 초기화
			          $("#modify_nickcheck").show();
			          $("#modify_nickcheck").append(warningTxt);
			        } else { //DB에 아이디값이 없음.사용가능.
			          let warningTxt = '<font color="green">사용 가능한 닉네임 입니다.'
			          $("#modify_nickcheck").text(""); // span 태그 영역 초기화
			          $("#modify_nickcheck").show();
			          $("#modify_nickcheck").append(warningTxt);
			        }
			      },
			      error: function(data) {
			        alert('데이터 통신 오류2');
			      }
			});	
			}		  
	// 연락처 중복+유효성검사
   $('#modify_phone').on('keyup', function() {
    checkDuplicatePhone();
  });
    function checkDuplicatePhone() {
			    var userPhone = $('#modify_phone').val();
			    if (userPhone) {
				  if (!/^[0-9]*$/.test(userPhone)) {
				      let warningTxt = '<font color="black">숫자만 입력 가능합니다.'
				      $("#modify_phonecheck").text(""); // span 태그 영역 초기화
				      $("#modify_phonecheck").show();
				      $("#modify_phonecheck").append(warningTxt);
				      return false;
				    }
				
			      if ($.trim($("#modify_phone").val()).length < 10) {
			        let warningTxt = '<font color="black">연락처는 10~11자 입니다.'
			        $("#modify_phonecheck").text(""); // span 태그 영역 초기화
			        $("#modify_phonecheck").show();
			        $("#modify_phonecheck").append(warningTxt);
			        return false;
			      }
			      if ($.trim($("#modify_phone").val()).length > 11) {
			        let warningTxt = '<font color="black">연락처는 10~11자 입니다.'
			        $("#modify_phonecheck").text(""); // span 태그 영역 초기화
			        $("#modify_phonecheck").show();
			        $("#modify_phonecheck").append(warningTxt);
			        return false;
			      }

			      $.post('phonecheck.do', { paramPhone: userPhone }, function(data) {
			        if (data == -1) { // DB에 아이디가 존재.중복된 경우.
			          let warningTxt = '<font color="pink"> 중복된 연락처입니다.'
			          $("#modify_phonecheck").text(""); // span 태그 영역 초기화
			          $("#modify_phonecheck").show();
			          $("#modify_phonecheck").append(warningTxt);
			        } else { //DB에 아이디값이 없음.사용가능.
			          let warningTxt = '<font color="green">사용 가능한 연락처입니다.'
			          $("#modify_phonecheck").text(""); // span 태그 영역 초기화
			          $("#modify_phonecheck").show();
			          $("#modify_phonecheck").append(warningTxt);
			        }
			      });
			    }
			  }
			
//이메일 중복+유효성검사  
$('#modify_email').on('keyup', function() {
  checkDuplicateEmail();
});

function checkDuplicateEmail() {
  var userEmail = $('#modify_email').val();
  if (userEmail) {
    if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(userEmail)) {
      let warningTxt = '<font color="black"> - 유효한 이메일 형식으로 입력해주세요.'
      $("#modify_emailcheck").text(""); // span 태그 영역 초기화
      $("#modify_emailcheck").show();
      $("#modify_emailcheck").append(warningTxt);
      return false;
    }
  }

  $.post('emailcheck.do', { paramEmail: userEmail }, function(data) {
    if (data == -1) { // DB에 이메일이 존재. 중복된 경우.
      let warningTxt = '<font color="pink"> 중복된 이메일입니다.'
      $("#modify_emailcheck").text(""); // span 태그 영역 초기화
      $("#modify_emailcheck").show();
      $("#modify_emailcheck").append(warningTxt);
    } else { // DB에 이메일값이 없음. 사용가능.
      let warningTxt = '<font color="green">사용 가능한 이메일입니다.'
      $("#modify_emailcheck").text(""); // span 태그 영역 초기화
      $("#modify_emailcheck").show();
      $("#modify_emailcheck").append(warningTxt);

			        }
			      });
			    }
		
		
	//비밀번호 유효성 검사
		
$(function () {
  $("#updateForm").on("submit", function (e) {
    e.preventDefault(); // 폼 전송 기본 동작을 중단

    var userId = $("#modify_id").val(); // userId 변수 선언 및 값 할당
    var password = $("#modify_pwd").val();

    $.ajax({
      type: "POST",
      url: "passwordCheck.do",
      data: {
        user_id: userId, 
        password: password,
      },
      dataType: "json",
      success: function (data) {
        if (data.result === "error") {
          let warningTxt = '<font color="red"> 비밀번호 오류. 수정불가.';
          $("#modify_pwdcheck").text("");
          $("#modify_pwdcheck").show();
          $("#modify_pwdcheck").append(warningTxt);
        } else {
          $("#modify_pwdcheck").hide();
          $("#updateForm").off("submit").submit(); // 이벤트 핸들러를 제거하고 폼을 전송
        }
      },
      error: function (data) {
        alert("데이터 통신 오류");
      },
    });
  });
});
/*
function openAddressPopup() {
  // 팝업 창을 띄우는 코드 작성
  new daum.Postcode({
    oncomplete: function(data) {
      var fullAddr = ''; // 최종 주소 변수
      var extraAddr = ''; // 참고항목 변수

      // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 변수에 저장
      if (data.userSelectedType === 'R') {
        fullAddr = data.roadAddress;
      } else {
        fullAddr = data.jibunAddress;
      }

      // 사용자가 추가 입력한 내용이 있으면 해당 내용을 참고항목 변수에 추가
      if (data.userLanguageType === 'HANGEUL' && data.hname !== '') {
        extraAddr += data.hname;
      }
      if (data.userSelectedType === 'R' && data.buildingName !== '') {
        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }

      // 최종 주소와 참고항목이 있는 경우 참고항목을 괄호로 묶어서 최종 주소에 추가
      if (extraAddr !== '') {
        extraAddr = ' (' + extraAddr + ')';
        fullAddr += extraAddr;
      }

      // 선택한 주소 정보를 기존 주소 입력란에 자동 입력
      document.getElementById('sample_postcode').value = data.zonecode;
      document.getElementById('sample_roadAddress').value = data.roadAddress;
      document.getElementById('sample_jibunAddress').value = data.jibunAddress;
      document.getElementById('sample_detailAddress').value = data.buildingName;
      document.getElementById('sample_extraAddress').value = extraAddr;
    }
  }).open();
}
*/
$(document).ready(function() {
  $("#new_password").on("keyup", function() {
    newcheckPassword();
  });

  $("#confirm_new_password").on("keyup", function() {
    newcheckConfirmPassword();
  });
});

function newcheckPassword() {
  var password = $('#new_password').val();
  var regex = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
  
  if (!regex.test(password)) {
    let warningTxt = '<font color="black">영문+숫자 조합 8-16자`.'
    $("#newpwdcheck").text(""); 
    $("#newpwdcheck").show();
    $("#newpwdcheck").append(warningTxt);
    return false;
  } else {
    $("#newpwdcheck").hide();
    return true;
  }
}

function newcheckConfirmPassword() {
  var password = $('#new_password').val();
  var confirm_password = $('#confirm_new_password').val();

  if (password != confirm_password) {
    let warningTxt = '<font color="red">비밀번호가 일치하지 않습니다.'
    $("#newconfirm_pwdcheck").text(""); 
    $("#newconfirm_pwdcheck").show();
    $("#newconfirm_pwdcheck").append(warningTxt);
    return false;
  } else {
    $("#newconfirm_pwdcheck").hide();
    return true;
  }
}


});

	
		
