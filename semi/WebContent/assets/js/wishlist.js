var user_no = window.user_no;
var sale_no = window.sale_no;

$(function() {
    $.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    });

	function wishListClick() {
		
		if(user_no != "") {
			
			$.ajax({
				
				type: "post",
                url: "wish_list_click.do",
				data: {
                    user_no: user_no,
					sale_no: sale_no
                },
				success: function(data) {
					alert(data);
					
				},
				error: function() {
					alert("관심상품 등록 또는 삭제하는 도중 통신오류 발생했습니다.");
				}

			});
			
			
		}else {
			alert("관심상품 등록은 로그인 후 이용해 주세요.")
		}
		
	}

});