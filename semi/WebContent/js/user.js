 $(function() {
  $.ajaxSetup({
    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
    type : "post"
  });

  $('#user_id').on('keyup', function() {
    checkDuplicateId();
  });
 //아이디 중복+유효성검사
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
    $.post('idcheck.do', { paramId: userId }, function(data) {
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
    });
  }
}
  
  
  // 닉네임 중복+유효성검사
  $('#user_nickname').on('keyup', function() {
    checkDuplicateNick();
  });
    function checkDuplicateNick() {
			    var userNick = $('#user_nickname').val();
			    if (userNick) {
			      if ($.trim($("#user_nickname").val()).length < 2) {
			        let warningTxt = '<font color="black">닉네임은 2자 이상이어야 합니다.'
			        $("#nickcheck").text(""); // span 태그 영역 초기화
			        $("#nickcheck").show();
			        $("#nickcheck").append(warningTxt);
			        return false;
			      }
			      if ($.trim($("#user_nickname").val()).length > 16) {
			        let warningTxt = '<font color="black">닉네임은 16자 이하이어야 합니다.'
			        $("#nickcheck").text(""); // span 태그 영역 초기화
			        $("#nickcheck").show();
			        $("#nickcheck").append(warningTxt);
			        return false;
			      }

			      $.post('nickcheck.do', { paramNick: userNick }, function(data) {
			        if (data == -1) { // DB에 아이디가 존재.중복된 경우.
			          let warningTxt = '<font color="pink"> 중복된 닉네임입니다.'
			          $("#nickcheck").text(""); // span 태그 영역 초기화
			          $("#nickcheck").show();
			          $("#nickcheck").append(warningTxt);
			        } else { //DB에 아이디값이 없음.사용가능.
			          let warningTxt = '<font color="green">사용 가능한 닉네임입니다.'
			          $("#nickcheck").text(""); // span 태그 영역 초기화
			          $("#nickcheck").show();
			          $("#nickcheck").append(warningTxt);
			        }
			      });
			    }
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
		
});

	//아이디 중복+유효성검사
	function checkDuplicateId() {
		    var userId = $('#user_id').val();
		    return userId;
		}

		function ajaxCall() {
		    var userId = checkDuplicateId();

		    $.ajax({
		        type: 'POST',
		        url: 'js/user.js',
		        data: { paramId: userId },
		        dataType: 'json',
		        success: function(data) {
		            if (data == -1) { // DB에 아이디가 존재.중복된 경우.
		                let warningTxt = '<font color="orange"> 중복된 닉네임 입니다.'
		                $("#idcheck").text(""); // span 태그 영역 초기화
		                $("#idcheck").show();
		                $("#idcheck").append(warningTxt);
		            } else { //DB에 아이디값이 없음.사용가능.
		                let warningTxt = '<font color="green">사용 가능한 닉네임 입니다.'
		                $("#idcheck").text(""); // span 태그 영역 초기화
		                $("#idcheck").show();
		                $("#idcheck").append(warningTxt);
		            }
		        },
		        error: function(data) {
		            alert('데이터 통신 오류1');
		        }
		    });
		}
		
