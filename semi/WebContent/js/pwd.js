 $(function() {
  $.ajaxSetup({
    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
    type : "post"
  });


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
    let warningTxt = '<font color="black">영문+숫자 조합 8-16자.'
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
