var sale_no = window.sale_no;
var sale_price = window.sale_price;
var end_price = window.end_price;
var user_id = window.user_id;
var user_money = window.money;
var user_no = window.user_no;
var date = window.date;


// 숫자를 세 자리마다 콤마(,)로 구분하는 함수
function formatNumber(num) {
  var formatted = num.toString().replace(/\.\d*/, "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
  return formatted.replace(/\.$/, '');
}

function formatNumberCount(num) {
  var formatted = num.toString().replace(/\.\d*/, "");
  return formatted.replace(/\.$/, '');
}

function checkNumber() {
    var inputText = document.getElementById("inputText").value; // 입력된 문자열
    var inputNumber = parseInt(inputText); // 입력된 문자열을 정수로 변환

    var maxNumber = end_price; // 설정한 최대 숫자

    if (isNaN(inputNumber)) {
        // 입력된 값이 숫자가 아닐 경우 처리 (예: 숫자가 아닌 문자가 입력된 경우)
        document.getElementById("inputText").value = ""; // 입력 필드를 비워줌
    } else if (inputNumber > maxNumber) {
        inputNumber = maxNumber; // 입력된 숫자가 최대 숫자를 초과할 경우 최대 숫자로 고정
        document.getElementById("inputText").value = inputNumber; // 입력 필드에 최대 숫자로 고정된 값을 설정
    }

}


  
var sale_value = formatNumber(sale_price);

var end_value = formatNumber(end_price);

// 회원이 입찰한 가격의의 소수점을 제거하고 세 자리수 마다 컴마(,)를 넣어준 1.1을 곱해준 변수
var user_value;

var user_success;
  
$(function () {
	
  $.ajaxSetup({
    ContentType: "application/x-www-form-urlencoded;charset=UTF-8",
    type: "post",
	cache : "false"
  });


 getList =  function () {
	
    $.ajax({
      url: "/semi/product_detail_ajax.do",
      data: { no: sale_no },
      datatype: "xml",
      success: function (data) {
	  
    	  
    	// 메인창 list 테이블의 현재 입찰가 즉시 입찰가를 ajax를 통해 갱신 시켜주는 코드
        $(".list tr:gt(2)").remove();

        let table = "";

        $(data).find("upper").each(function () {
		  user_up = formatNumberCount($(this).find("user_upper").text());
  		  user_success = formatNumberCount($(this).find("user_upper").text());
    	  user_value = formatNumber($(this).find("user_upper").text() * 1.1);
		  user_count = formatNumberCount($(this).find("user_upper").text() * 1.1);
          console.log($(this).find("user_upper").text());
          console.log("usercount >>> " + user_count);
		  
    	  
          table += "<tr>";
          table += "<th bgcolor='#F6F6F6'>현재 입찰가</th>";
          if ($(this).find("user_upper").text() != 0) {
            table += "<td>" + formatNumber($(this).find("user_upper").text()) + "원</td>";
          } else {
            table += "<td> 0원</td>";
          }
          table += "</tr>";
          table += "<tr>";
          table += "<th bgcolor='#F6F6F6'>즉시 입찰가</th>";
          if ($(this).find("user_upper").text() != 0) {
			  if(user_count > end_price){
			  	  table += "<td bgcolor='white'>" + end_value + "원</td>";
				} else {
    	          table += "<td bgcolor='white'>" + user_value + "원</td>";
				}
          } else {
            table += "<td bgcolor='white'>" + formatNumber(sale_price) + "원</td>";
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
            table += "<td bgcolor='white'>0 원</td>";
          }
          table += "</tr>";
       
        });
        $(".list_modal tr:eq(1)").after(table);
        
        // list_modal end
        
        
        // list_modal_detail 테이블의 최소 입찰가, 입찰가 입력, 즉시 구매가를 ajax를 통해 갱신 시켜주는 코드
        $(".list_modal_detail").empty();
        
        table = "";
        
			
        $(data).find("upper").each(function () {
			if(date != 3){	
				if(user_id != ""){	// 유저가 로그인을 했을 경우
					if($(this).find("user_upper").text() != end_price){	// 입찰된 금액이 즉시 입찰가와 같지 않을 경우
		            table += "<tr>";
		            table += "<th bgcolor='#F6F6F6'>즉시 입찰가</th>";
		            if ($(this).find("user_upper").text() >= sale_price) {
			
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
		            if ($(this).find("user_upper").text() >= sale_price) {
		              	
						if(user_count >= end_price){
		               		 table += "<td bgcolor='white'> <input type='text' name='user_bid' value='" + end_value + "'></td>";
						} else{
		                	table += "<td bgcolor='white'> <input type='text' id='inputText' oninput='checkNumber()' name='user_bid' placeholder='" + user_value + " 원' pattern='[0-9]+')'></td>";
						}
						
					} else {
		                table += "<td bgcolor='white'> <input type='text' id='inputText' oninput='checkNumber()' name='user_bid' placeholder='" + formatNumber(sale_price) + " 원' pattern='[0-9]+'  ></td>";
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
				    table += "<td bgcolor='white'> <input type='button' value ='즉시 구매' class='primary' onclick=\"if(confirm('즉시 구매 하시겠습니까?')){ location.href='update_end.do?no="+sale_no+"&id="+user_id+"'; } else {return; }\">";
		            table += "</tr>";
	
					table += "<tr>";
					table += "<th bgcolor='#F6F6F6' width='123px;'>소지금<span style='font-size: 13px;'>(입찰금)</span></th>";
					if($(this).find("user_no").text() == user_no){
							table += "<td bgcolor='white'>"+formatNumber(user_money)+"원</td>";
							table += "<td bgcolor='white'>"+formatNumber($(this).find("user_upper").text())+"원</td>";
						} else {
							table += "<td bgcolor='white'>"+formatNumber(user_money)+"원</td>";
						}
					table += "</tr>";
					
					} else {
						table += "<tr>";
						
						table += "<td bgcolor='white'> <h5>da경매가 낙찰 되었습니다.</h5></td>";
						
						table += "</tr>";
						
					}	// if($(this).find("user_upper").text() != end_price) end
	            } else {	// 유저가 로그인을 안했을경우
					table += "<tr>";
					
					table += "<td bgcolor ='white'> <h5>로그인 후 이용 가능합니다</h5></td>";
					
					table += "</tr>";
				} // if(user_id != "") end
			} else if(date == 3 && sale_price > user_count) {
				
				table += "<tr>";
				table += "<td><h5>경매가 유찰 되었습니다.</h5></td>";
				table += "<tr>";
			} else {
				table += "<tr>";
				table += "<td><h5>경매가 낙찰 되었습니다.</h5></td>";
				table += "<tr>";
				console.log("user_success" + user_success);
			}
          });

          $(".list_modal_detail").append(table);
        
      },
      
      error: function () {
        alert("데이터 통신 오류 입니다.");
      }
    });
  } // getList() 함수 end


	getList();
 

	input_bid = function() {
	    console.log("userval >>> " + user_success);
		if(date == 3)
	    setTimeout(function() {
	        $.ajax({
	            url: "/semi/success_bid.ajax.do",
	            data: { 
	                upper_val: user_success,
	                no: sale_no
	            }
	        });
	    }, 300); // 0.3초 딜레이
	}

			
			
	  
 });