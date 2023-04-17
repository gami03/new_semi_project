var sale_no = window.sale_no;
var sale_price = window.sale_price;
var end_price = window.end_price;
var user_id = window.user_id;

// 숫자를 세 자리마다 콤마(,)로 구분하는 함수
function formatNumber(num) {
  var formatted = num.toString().replace(/\.\d*/, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  return formatted.replace(/\.$/, '');
}

function formatNumberCount(num) {
  var formatted = num.toString().replace(/\.\d*/, "");
  return formatted.replace(/\.$/, '');
}

  
  
var sale_value = formatNumber(sale_price);

var end_value = formatNumber(end_price);

// 회원이 입찰한 가격의의 소수점을 제거하고 세 자리수 마다 컴마(,)를 넣어준 1.1을 곱해준 변수
var user_value;
  
$(function () {
  $.ajaxSetup({
    ContentType: "application/x-www-form-urlencoded;charset=UTF-8",
    type: "post",
	cache : "false"
  });

  function getList() {
    $.ajax({
      url: "/semi/product_detail_ajax.do",
      data: { no: sale_no },
      datatype: "xml",
      success: function (data) {
    	  
    	  
    	  
    	// 메인창 list 테이블의 현재 입찰가 즉시 입찰가를 ajax를 통해 갱신 시켜주는 코드
        $(".list tr:gt(2)").remove();

        let table = "";

        $(data).find("upper").each(function () {
        	
    	  user_value = formatNumber($(this).find("user_upper").text() * 1.1);
		  user_count = formatNumberCount($(this).find("user_upper").text() * 1.1);
          console.log($(this).find("user_upper").text());
          console.log("usercount >>> " + user_count);
    	  
          table += "<tr>";
          table += "<th bgcolor='#F6F6F6'>현재 입찰가</th>";
          if ($(this).find("user_upper").text() > user_value) {
            table += "<td>" + formatNumber($(this).find("user_upper").text()) + "원</td>";
          } else {
            table += "<td>" + sale_value + "원</td>";
          }
          table += "</tr>";
          table += "<tr>";
          table += "<th bgcolor='#F6F6F6'>즉시 입찰가</th>";
          if ($(this).find("user_upper").text()) {
			  if(user_count > end_price){
			  	  table += "<td bgcolor='white'>" + end_value + "원</td>";
				} else {
    	          table += "<td bgcolor='white'>" + user_value + "원</td>";
				}
          } else {
            table += "<td bgcolor='white'>" + sale_price * 1.1 + "원</td>";
          }
          table += "</tr>";
        });
        $(".list tr:eq(2)").after(table);
        // list end
      
        
      // list_modal 테이블에 ajax로 테이블을 값을 갱신 시켜주는코드
      $(".list_modal tr:gt(1)").remove();
      
      table = "";
      
      $(data).find("upper").each(function () {
          table += "<tr>";
          table += "<th bgcolor='#F6F6F6'>현재 입찰가</th>";
          if ($(this).find("user_upper").text() != 0) {
            table += "<td bgcolor='white'>" + formatNumber($(this).find("user_upper").text()) + "원</td>";
          } else {
            table += "<td bgcolor='white'>" + sale_price + "원</td>";
          }
          table += "</tr>";
       
        });
        $(".list_modal tr:eq(1)").after(table);
        
        // list_modal end
        
        
        // list_modal_detail 테이블의 최소 입찰가, 입찰가 입력, 즉시 구매가를 ajax를 통해 갱신 시켜주는 코드
        $(".list_modal_detail").empty();
        
        table = "";
        
        $(data).find("upper").each(function () {
            table += "<tr>";
            table += "<th bgcolor='#F6F6F6'>즉시 입찰가</th>";
            if ($(this).find("user_upper").text() > sale_price) {
	
				if(user_count > end_price){
			  	  table += "<td bgcolor='white'>" + end_value + "원</td>";
				} else {
    	          table += "<td bgcolor='white'>" + user_value + "원</td>";
				}
				
            } else {
              table += "<td bgcolor='white'>" + sale_value + "원</td>";
            }

			if(end_price == $(this).find("user_upper").text()){
				table += "<td>입찰 완료</td>";				
			} else{
            	table += "<td> <input type='button' value='즉시 입찰' class='primary' onclick=\"if(confirm('즉시 입찰 하시겠습니까?')){ location.href='update_mini.do?no="+sale_no+"&id="+user_id+"'; } else {return; }\"> </td>";
			}
            table += "</tr>";
            
            table += "<tr>";
            table += "<th bgcolor='#F6F6F6'>직접 입찰가</th>";
            if ($(this).find("user_upper").text() > sale_price) {
              	
				if(user_count >= end_price){
               		 table += "<td bgcolor='white'> <input type='text' name='user_bid' value='" + end_value + "'></td>";
				} else{
                	table += "<td bgcolor='white'> <input type='text' name='user_bid' value='" + formatNumber($(this).find("user_upper").text() * 1.1) + "'></td>";
				}
				
			} else {
                table += "<td bgcolor='white'> <input type='text' name='user_bid' value='" + formatNumber(sale_price * 1.1) + "'></td>";
              }
			
			if(end_price == $(this).find("user_upper").text()){
				table += "<td>입찰 완료</td>";
			} else{
	            table += "<td> <input type='submit' value='직접 입찰' class='primary' onclick=\"return confirm('입찰 하시겠습니까?')\"> </td>";
			}
            table += "</tr>"
            
            table += "<tr>";
            table += "<th bgcolor='#F6F6F6'>즉시 구매가</th>";
            table += "<td bgcolor='white'>" + formatNumber(end_price) + "원</td>";
			
			if(end_price == $(this).find("user_upper").text()){
				table += "<td>입찰 완료</td>";
			} else{
	            table += "<td bgcolor='white'> <input type='button' value ='즉시 구매' class='primary' onclick=\"if(confirm('즉시 구매 하시겠습니까?')){ location.href='update_end.do?no="+sale_no+"&id="+user_id+"'; } else {return; }\">";
			}
            table += "</tr>";
            
          });
          $(".list_modal_detail").append(table);
        
        
      },
      
      error: function () {
        alert("데이터 통신 오류 입니다.");
      }
    });
  } // getList() 함수 end


  getList();
  
  
  
  
});
