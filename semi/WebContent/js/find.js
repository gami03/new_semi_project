$(function() {
  $.ajaxSetup({
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    type: "post"
  });

  // '아이디 찾기' 버튼 클릭 이벤트
  $("#find_id_btn").click(function() {
    // 기존 모달 창 닫기
    $("#findIdModal").modal("hide");

    let find_email = $("#id_find_email").val();
    console.log(find_email);

    // Ajax로 아이디 찾기 요청
    $.ajax({
      url: "idFind.do",
      dataType: "json",
      data: {
        email: find_email
      },
      success: function(data) {
        console.log("Data received:", data);

        if (data.status === "not_found") {
          // 아이디가 없는 경우
          $("#foundId").text("해당 이메일로 가입된 아이디는 없습니다.");
        } else if (data.status === "found") {
          // 아이디가 있는 경우
          $("#foundId").text(
            "해당 이메일로 가입된 아이디는 " + data.id + " 입니다."
          );

          // 이벤트 핸들러 정의
          $("#IdModal").one("hidden.bs.modal", function() {
            // 로그인 창 열기
            $("#id_find_email").val("");
            $("#boardModal").modal("show");
            $("#login_id").val(data.id);
          });
        }
        // 모달 창 열기
        $("#IdModal").modal("show");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.error("Error:", textStatus, errorThrown);
        alert("데이터 통신 오류");
      }
    });
  });



$("#FindPwdBtn").on(
         "click",
         function() { //회원가입 페이지에서 입력창에서 시점이 옮겨 갔을때  호출되는 무명함수.
         
            let userName = $("#recover-pwd-name").val(); //signup-id의 value값을 뽑아와라.
            let userEmail = $("#recover-pwd-email").val(); //signup-id의 value값을 뽑아와라.
            let userId = $("#recover-pwd-id").val(); //signup-id의 value값을 뽑아와라.

            //아이디 중복 여부 확인
            $.ajax({
               type: "post",
               url: "find_pwd.do",
               data: {
                  paramName: userName,
                  paramEmail: userEmail,
                  paramId: userId
               },
               datatype: "json",
               success: function(data) {
                  if (data == -1) { //DB에 아이디가 없을경우
                     $(".alert-success").hide(); //div태그 영역을 숨겨라.
                     $(".alert-danger").hide(); //div태그 영역을 숨겨라.
                     
                     $("#recover-pwd-name").val('');
                     $("#recover-pwd-id").val('');
                     $("#recover-pwd-email").val('');
                     
                     $(".alert-danger").show();
                  } else {
                     $(".alert-success").hide(); //div태그 영역을 숨겨라.
                     $(".alert-danger").hide(); //div태그 영역을 숨겨라.
                     
                     $("#recover-pwd-name").val('');
                     $("#recover-pwd-id").val('');
                     $("#recover-pwd-email").val('');

                     $(".alert-success").show();
                  }
               },
               error: function(data) {
                  alert("통신오류");
               }
            });
         });
         
         
		        $(document).ready(function () {
		  $('#reset_pwd_btn').on('click', function (event) {
  event.preventDefault();
		
		    var resetPwdId = $('#reset_pwd_id').val();
		    var resetPwdName = $('#reset_pwd_name').val();
		    var resetPwdEmail = $('#reset_pwd_email').val();
		
		    console.log("resetPwdId: " + resetPwdId);
		    console.log("resetPwdName: " + resetPwdName);
		    console.log("resetPwdEmail: " + resetPwdEmail);
		
		    $.ajax({
		      url: 'pwdFind.do',
		      type: 'POST',
		      data: {
		        paramId: resetPwdId,
		        paramName: resetPwdName,
		        paramEmail: resetPwdEmail,
		      },
		      success: function (response) {
		        if (parseInt(response.trim()) === 1) {
		          alert('비밀번호가 이메일로 전송되었습니다.');
		          $('#findPwdModal').modal('hide');
		        } else {
		          alert('일치하는 정보가 없습니다. 입력정보 확인 바랍니다. ');
		        }
		      },
		      error: function () {
		        alert('비밀번호 재발급에 실패했습니다. 다시 시도해주세요.');
		      },
		    });
		  });
		});


});