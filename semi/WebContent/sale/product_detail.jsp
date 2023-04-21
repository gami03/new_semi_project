<%@page import="com.sale.model.UpperDTO"%>
<%@page import="com.sale.model.SaleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>
<!--
	Phantom by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Phantom by HTML5 UP</title>



<link rel="stylesheet" href="./assets/css/product_view.css">
<link rel="stylesheet" href="./assets/css/product.css" />

<jsp:include page="/include/main_top.jsp" />


 <!-- <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous"> -->
 
<link type="text/css" rel="stylesheet" href="./assets/css/slick.css" />
<link type="text/css" rel="stylesheet"
	href="./assets/css/slick-theme.css" />

<!-- jQuery first, then Popper.js, then Bootstrap JS 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
-->


<script>


    // 서버에서 전달된 남은 시간 정보를 가져옵니다.
    var hours = <%= request.getAttribute("hours") %>;
    var minutes = <%= request.getAttribute("minutes") %>;
    var seconds = <%= request.getAttribute("seconds") %>;
	var end = 0;
    $(function(){
        
        // 페이지 로드 시에 남은 시간 표시를 시작합니다.
        displayCountdown();
        
        // 남은 시간을 표시하는 함수
        function displayCountdown() {
            // 남은 시간을 계산하여 표시합니다.
            var countdownElement = document.getElementById("countdown"); // 요소의 ID를 사용하여 선택
            if (hours == 0 && minutes > 5) {
                countdownElement.innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
                document.getElementsByClassName("countdown")[0].innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
                countdownElement.style.cssText = "color: red; font-weight: bold;";
                document.getElementsByClassName("countdown")[0].style.cssText = "color: red; font-weight: bold;";
            } else if (hours <= 0 && minutes <= 0 && seconds <= 0 || ${Upper} == ${Dto.getSale_end_price()}) {
            	end = 1;
                countdownElement.innerHTML = "마감 되었습니다.";
                countdownElement.style.cssText = "color: red; font-weight: bold;";
                document.getElementsByClassName("countdown")[0].innerHTML = "마감 되었습니다.";
                document.getElementsByClassName("countdown")[0].style.cssText = "color: red; font-weight: bold;";
                return;
            } else {
                countdownElement.innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
                document.getElementsByClassName("countdown")[0].innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
            }
            // 1초마다 갱신
            setTimeout(updateCountdown, 1000);
        }
        
        // 남은 시간을 1초마다 갱신하는 함수
        function updateCountdown() {
            // 남은 시간을 1초 감소
            seconds--;
            if (seconds < 0) {
                minutes--;
                seconds = 59;
            }
            if (minutes < 0) {
                hours--;
                minutes = 59;
            }

            // 남은 시간이 0보다 작아지면 갱신을 멈춥니다.
            if (hours < 0) {
                hours = 0;
                minutes = 0;
                seconds = 0;
            }
            // 갱신된 남은 시간을 표시합니다.
            displayCountdown();

        }
    });

</script>


</head>
	<c:set var="count" value="${Count }"/>
	<c:set var="dto" value="${Dto }"/>
	<c:set var="upper" value="${Upper }"/>
	<c:set var="udto" value="${Udto }"/>
	<c:set var="user_money" value="${User_money }"/>
	<c:set var="date_check" value="${Date_check }"/>


		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header></header>
				<section>
					<div class="container">
						<div class="row">
							<!-- /Product preview imgs -->
							<div class="col-2">
								<div id="product-imgs">
									<div style="height: 123.89px" class="product-preview">
										<img style="height: 123.89px" src="./images/${dto.getSale_file1() }" alt="">
									</div>

									<div style="height: 123.89px" class="product-preview">
										<img style="height: 123.89px" src="./images/${dto.getSale_file2() }" alt="">
									</div>

									<div style="height: 123.89px" class="product-preview">
										<img style="height: 123.89px" src="./images/${dto.getSale_file3() }" alt="">
									</div>
									
									<div style="height: 123.89px" class="product-preview">
										<img style="height: 123.89px" src="./images/${dto.getSale_file4() }" alt="">
									</div>
								</div>
							</div>
							<!-- Product main img -->
							<div class="col-md-5">
								<div id="product-main-img">
								
									<div style="height: 370px" class="product-preview">
										<img style="height: 370px" src="./images/${dto.getSale_file1() }" alt="">
									</div>

									<div style="height: 370px" class="product-preview">
										<img style="height: 370px" src="./images/${dto.getSale_file2() }" alt="">
									</div>

									<div style="height: 370px" class="product-preview">
										<img style="height: 370px" src="./images/${dto.getSale_file3() }" alt="">
									</div>

									<div style="height: 370px" class="product-preview">
										<img style="height: 370px" src="./images/${dto.getSale_file4() }" alt="">
									</div>
								</div>
							</div>
							
							<div class="col-md-5">
								
								<div>
									<table border="1" cellspacing="0" class="list">
										<tr>
											<td align="center" colspan="2"><h5>${dto.getSale_title() }의 현재 경매 정보</h5></td>
										</tr>
										
										<tr>
											<th bgcolor="#F6F6F6">남은 시간 </td>
											<td><span class="countdown"></span></td>
										</tr>
										
										<tr>
											<th>시작 입찰가</th>
											<td bgcolor="white"><fmt:formatNumber> ${dto.getSale_price() }</fmt:formatNumber>원</td>
										</tr>
									</table>
									
									
									
								</div>
								
								<!-- Button trigger modal -->
								<button type="button" id="modalbutton" class="button" data-toggle="modal" data-target="#myModal">
								  Launch demo modal
								</button>
								
								
							</div>
						</div>
					</div>
				</section>
			</div>
		</div>
		
<script type="text/javascript">
	var sale_no = ${dto.getSale_no() };
	var sale_price = ${dto.getSale_price() };
	var end_price =${dto.getSale_end_price() };
	var user_id = "${user_id }";
	var money = ${user_money};
	var user_no = "${User_no}";
	var date = ${date_check};
	var end_date = end;
</script>


	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="z-index: 3000">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	      </div>
	      <div class="modal-body">
	       <%-- 경매내역 상세 정보 및 입찰 관련 코드 --%>
	       <div class="container-fluid">
	       	  <div class="row">
	       	  	<div class="col-md-5 ml-auto">
	       	  		<table border="1" cellspacing="0" style="background: #F6F6F6">
	       	  			<tr>
	       	  				<td> <img style="width: 100%; height: 100%" src="./images/${dto.getSale_file1() }" alt=""></td>
	       	  			</tr>
	       	  			
	       	  		</table>
	       	  		
	       	  		<table>
	       	  			
	       	  			<tr>
	       	  				<td style="text-align: center" colspan="2">판매자 정보</td>
	       	  			</tr>
	       	  			
	       	  			<tr>
	       	  				<th bgcolor="#F6F6F6">판매자 이름</th>
	       	  				<td bgcolor="white">${udto.getUser_nickname() }</td>
	       	  			</tr>
	       	  			
	       	  			<tr>
	       	  				<th bgcolor="#F6F6F6">판매자 이메일</th>
	       	  				<td bgcolor="white">${udto.getUser_email() }</td>
	       	  			</tr>
	       	  			
	       	  			<tr>
	       	  				<th bgcolor="#F6F6F6">경매품 판매 이력</th>
	       	  				<td bgcolor="white">${count }</td>
	       	  			</tr>
	       	  			
	       	  		</table>
	       	  	</div>
	       	  	<div class="col-md-7 ml">
	       	  		<h5>경매 정보</h5>
	       	  		<table border="1" cellspacing="0" class="list_modal"> 
	       	  			<tr>
	       	  				<th bgcolor="#F6F6F6">남은 시간</th>
	       	  				<td bgcolor="white"><span id="countdown"></span></td>
	       	  			</tr>
	       	  			
	       	  			<tr>
	       	  				<th bgcolor="#F6F6F6">시작 입찰가</th>
	       	  				<td bgcolor="white"><fmt:formatNumber> ${dto.getSale_price() }</fmt:formatNumber>원</td>
	       	  			</tr>
	       	  			
	       	  		</table>
	       	  		
	       	  		<br>
	       	  		
	       	  		<h5>경매 입찰 정보</h5>
	       	  		<form method="post" action="<%=request.getContextPath() %>/input_product_detail.do?id=${user_id}">
	       	  			<input type="hidden" name="product_no" value="${param.no }" >
		       	  		<table border="1" cellspacing="0" class="list_modal_detail">
		       	  				
		       	  		</table>
	       	  		</form>
	       	  	</div>
	       	  </div>
	       </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="button" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<%-- Modal end --%>


<script type="text/javascript" src= "./js/sale_upper.js"></script>		
		
		
<jsp:include page="/include/main_bottom.jsp"/>
