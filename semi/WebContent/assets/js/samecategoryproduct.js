var user_no = window.user_no;
var sale_category = window.sale_category;


$(function() {
	
	$.ajaxSetup({
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
    });

	function sameCategoryProductList() {
		setTimeout(function() {
			$.ajax({
				type: "get",
	            url: "same_category_product_list.do",
				data: {
					user_no: user_no,
					sale_category: sale_category
				},
				dataType: "json",
				success: function(response) {
					
					// each() 함수를 사용하여 productList를 반복하면서 product_item 생성
					$.each(response.productList, function(index, product) {
						
					  var productItem = '<div class="product_item">\
					                      <a class="item_inner" href=\"product_detail.do?no='+product.sale_no+'&user='+user_no+'">\
					                        <div class="thumb_box">\
					                          <div class="product">\
					                            <img src="images/'+ product.sale_file1 +'" class="product_image" width="100%" height="auto">\
					                          </div>\
					                        </div>\
					                        <div class="info_box">\
					                          <div class="brand">\
					                            <p class="brand-text">' + product.sale_title + '</p>\
					                          </div>\
					                          <p class="name">' + product.sale_content + '</p>\
					                          <div class="price">\
					                            <div class="amount">\
					                              <em class="num">' + product.sale_end_price + '</em>\
					                            </div>\
					                            <div class="desc">\
					                              <p>즉시 구매가</p>\
					                            </div>\
					                          </div>\
					                        </div>\
					                      </a>\
					                    </div>';
					  // 생성한 productItem을 적절한 위치에 추가
					  $('.product_list').append(productItem);

					
					});
					
				},
				error: function() {
					alert("최고가 상품을 불러오는 도중 오류가 발생했습니다.");
				}
			});
		}, 100); // 0.8초(800밀리초) 딜레이
	}
	
	// 페이지가 열리면 자동으로 sameCategoryProductList() 함수를 실행
	sameCategoryProductList();
	
	
});