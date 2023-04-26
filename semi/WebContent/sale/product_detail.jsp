<%@page import="com.sale.model.SaleDAO"%>
<%@page import="com.sale.model.UpperDTO"%>
<%@page import="com.sale.model.SaleDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   SaleDAO dao = SaleDAO.getInstance();
%>

<!DOCTYPE HTML>
<!--
   Phantom by HTML5 UP
   html5up.net | @ajlkn
   Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Phantom by HTML5 UP</title>

<link rel="stylesheet" href="./assets/css/fontawesome-all.min.css">

<link rel="stylesheet" href="./assets/css/product_view.css">
<link rel="stylesheet" href="./assets/css/product.css" />
<%-- 아코디언 게시판 부트스트랩 쓰기위한 cdn 불러오기 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">




 <!-- <link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
   crossorigin="anonymous"> -->
 
<link type="text/css" rel="stylesheet" href="./assets/css/slick.css" />
<link type="text/css" rel="stylesheet"
	href="./assets/css/slick-theme.css" />
	
<link rel="stylesheet" href="assets/css/index.css" />
	<style type="text/css">
		.way_status {
			display: flex;
			margin-top: 10px;
		}
		
		.accordion-body p {
			font-family: 'LINESeedKR-Bd';
			font-size: 15px;
		}
		
		.guide_item {
			display: flex;
			font-family: 'LINESeedKR-Bd';
		}
		
		.desc {
			font-size: 15px;
		}
		
		.guide_list {
			padding-left: 0;
			margin-top: 50px;
			align: center;
		}
		
		.point_guide {
			border-bottom: 1px solid lightgrey;
		}
		
		.product_image {
			height: 300px;
		}
		
		.home_products {
			padding-bottom: 40px;
		}
	</style>

<!-- jQuery first, then Popper.js, then Bootstrap JS 
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
-->


</head>
   <c:set var="count" value="${Count }"/>
   <c:set var="dto" value="${Dto }"/>
   <c:set var="upper" value="${Upper }"/>
   <c:set var="udto" value="${Udto }"/>
   <c:set var="user_money" value="${User_money }"/>
   <c:set var="date_check" value="${Date_check }"/>

<jsp:include page="/include/main_top.jsp" />
		<!-- Main -->
		<div id="main" style="padding-top: 200px;">
			<div class="shop_board_banner" style="padding-bottom: 100px; display: flex; justify-content: space-around;">
				<img src="./images/shop_title.png" style="width: 460px;">
			</div>
			
			<div class="inner">
				<header></header>
				<section>
					<div class="container">
						<div class="row" style=" padding-bottom: 51px;">
							<!-- /Product preview imgs -->
							<div class="col-2">
								<div id="product-imgs">
		                          	<div style="height: 156.6px" class="product-preview">
		                             	<img style="height: 156.6px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file1() }" alt="">
		                          	</div>
		
		                          	<div style="height: 156.6px" class="product-preview">
		                             	<img style="height: 156.6px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file2() }" alt="">
		                          	</div>
		                          
		                          	<div style="height: 156.6px" class="product-preview">
										<img style="height: 156.6px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file3() }" alt="">									
								  	</div>
								  	
								  	<div style="height: 156.6px" class="product-preview">
									  	<img style="height: 156.6px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file4() }" alt="">									
								  	</div>
                        		</div>
                     		</div>
                     
                     <!— Product main img —>
                     <div class="col-md-5">
                        <div id="product-main-img">
                        
                           <div style="height: 470px" class="product-preview">
                              <img style="height: 470px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file1() }" alt="">
                           </div>

                           <div style="height: 470px" class="product-preview">
                              <img style="height: 470px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file2() }" alt="">
                           </div>

                           <div style="height: 470px" class="product-preview">
                              <img style="height: 470px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file3() }" alt="">
                           </div>

                           <div style="height: 470px" class="product-preview">
                              <img style="height: 470px" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file4() }" alt="">
                           </div>
                        </div>
                     </div>

                     <div class="col-md-5">
                        
                        <div>
                           <table border="1" cellspacing="0" class="list" style="margin: 0 0 16px 0; width: 443px;">
                              <tr>
                                 <td align="center" colspan="2"><h5>${dto.getSale_title() }의 현재 경매 정보</h5></td>
                              </tr>
                              
                              <tr>
                                 <th bgcolor="#F6F6F6">남은 시간 </td>
                                 <td><span class="countdown"></span></td>
                              </tr>
                              
                              <tr>
                                 <th bgcolor="#F6F6F6">시작 입찰가</th>
                                 <td bgcolor="white"><fmt:formatNumber> ${dto.getSale_price() }</fmt:formatNumber>원</td>
                              </tr>
                           </table>
                           
                           
                           
                        </div>
                        
                        <!-- Button trigger modal -->
                        <button type="button" id="modalbutton" class="button" data-toggle="modal" data-target="#myModal" style="width: 443px; font-size: 20px;">
                          입찰 / 구매
                        </button>
								
								<%-- 관심상품에 추가 안되있을 때 --%>
								<c:if test="${wishlistCheck == 0 }">
									<button style="margin-top: 10px; width: 443px; font-size: 18px;" onclick="location.href='wish_list_click.do?user_no=${User_no }&sale_no=${dto.getSale_no() }&sale_content=${dto.getSale_content() }'">
										<img style="vertical-align: middle;" src="images/bookmark.png" width="20px;" height="20px;" style="vertical-align: center;">
										관심상품
									</button>
								</c:if>
								
								<%-- 관심상품에 들어가 있을 때 --%>
								<c:if test="${wishlistCheck > 0 }">
									<button style="margin-top: 10px; width: 443px; font-size: 18px; background-color: lightsteelblue;" onclick="location.href='wish_list_click.do?user_no=${User_no }&sale_no=${dto.getSale_no() }&sale_content=${dto.getSale_content() }'">
										<img style="vertical-align: middle;" src="images/bookmark_blue.png" width="20px;" height="20px;" style="vertical-align: center;">
										관심상품
									</button>
								</c:if>
								
								
							</div>
						</div>
						
						<script type="text/javascript">
					
							var sale_category = ${dto.getUpload_category() }
						
						</script>
				
						<div class="home_products" style="border-bottom: 1px solid #ebebeb">
				            <div class="product_title">
				               <div>
				                  <div class="div_title">
				                     <p style="font-family: 'LINESeedKR-Bd'; font-size: 25px; margin-bottom: 0px;">동일 카테고리 상품</p>
				                  </div>
				               </div>
				            </div>
				            <div class="product_list_wrap lg">
				               <div class="product_list list_first horizontal_product_collection">
				                  
				                  <script src="assets/js/samecategoryproduct.js">
				                  
				                  
				                  </script>
				                  
				               </div>
				            </div>
				         </div>
				         
						
						<div class="product_detail_ex" style="font-family: 'LINESeedKR-Bd';">
						<div style="margin-bottom: 20px; margin-top: 20px;">
							<span>배송 정보</span>
						</div>
							<div class="delivary_way" style="border-bottom: 1px solid lightgray;">
								<div class="way_info">
									<div class="way_status">
										<img src="./images/delivery_icon.png" width="60px" height="60px" style="margin-right: 10px;">
										<div class="way_desc">
											<p class="company">
												<span class="badge_title">일반 배송</span>
												<span class="title">3,000원</span>
											</p>
											<p style="font-size: 15px;">검수 후 배송 ・ 5-7일 내 도착 예정</p>
										</div>
									</div>
								</div>
							</div>
							
							
							<div class="delivary_way">
								<div class="way_info">
									<div class="way_status">
										<img src="./images/container_icon.png" width="60px" height="60px" style="margin-right: 10px;">
										<div class="way_desc">
											<p class="company">
												<span class="badge_title">창고 보관</span>
												<span class="title">첫 30일 무료</span>
											</p>
											<p style="font-size: 15px;">
												배송 없이 창고에 보관 ・ 빠르게 판매 가능
											</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						<br>
						<div class="confirm_wrap" style="margin-top: 10px;">
							<h3 style="font-family: 'LINESeedKR-Bd'; letter-spacing: 2px; margin-bottom: 5px;">입찰 전 꼭 확인해주세요!</h3>
							<div class="accordion accordion-flush" id="accordionFlushExample">
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="flush-headingOne">
							      <button style="box-shadow: none; padding-left: 2px;" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
							        	배송 기간 안내
							      </button>
							    </h2>
							    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
							      <div class="accordion-body">
							      	<p>garlicAuction은 최대한 빠르게 모든 상품을 배송하기 위해 노력하고 있습니다. 배송 시간은 판매자가 검수를 위하여 상품을 검수센터로 보내는 속도에 따라 차이가 있습니다.</p>
									<p>[빠른배송 구매]</p>
									<br>
									<p>- 판매자가 보관 신청한 상품 중 검수에 합격한 상품을 KREAM의 전용 창고에 보관합니다. 보관 상품에 한하여 바로 구매와 95점 구매가 가능합니다.</p>
									<p>- 오늘(오후 11:59까지) 결제하면 내일 바로 출고되어 빠른 배송이 가능합니다. (연휴 및 공휴일, 천재지변, 택배사 사유 등 예외적으로 출고일이 변경될 수 있습니다. 빠른배송 안내</p>
									<br>
									<p>[일반 구매]</p>
									<br>
									<p>- 거래가 체결된 시점부터 48시간(일요일•공휴일 제외) 내에 판매자가 상품을 발송해야 하며, 통상적으로 발송 후 1-2일 내에 KREAM 검수센터에 도착합니다.</p>
									<p>- 검수센터에 도착한 상품은 입고 완료 후 3영업일 이내에 검수를 진행합니다. 검수 합격시 배송을 준비합니다.</p>
									<p>* 상품 종류 및 상태에 따라 검수 소요 시간은 상이할 수 있으며, 구매의사 확인에 해당할 경우 구매자와 상담 진행으로 인해 지연이 발생할 수 있습니다.</p>
									<br>
									<p>- 검수센터 출고는 매 영업일에 진행하고 있으며, 출고 마감시간은 오후 5시입니다. 출고 마감시간 이후 검수 완료건은 운송장번호는 입력되지만 다음 영업일에 출고됩니다.</p>
							      </div>
							    </div>
							  </div>
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="flush-headingTwo">
							      <button style="box-shadow: none; padding-left: 2px;" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
							       	 검수 안내
							      </button>
							    </h2>
							    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
							      <div class="accordion-body">
							      	<p>판매자의 상품이 검수센터에 도착하면 전담 검수팀이 철저한 분석과 검사로 정가품 확인을 진행합니다.</p>
									<p>- 검수센터에서는 정가품 여부를 확인하기 위하여, 지속적으로 데이터를 쌓고 분석하여 기록하고 있습니다.</p>
									<p>- 업계 전문가로 구성된 검수팀은 박스와 상품의 라벨에서 바느질, 접착, 소재 등 모든 것을 검수합니다.</p>
									<p>검수 결과는 불합격•검수 보류•합격의 세가지 상태로 결과가 변경됩니다. 검수기준 보기</p>
									<p>* 검수 합격: KREAM 검수택(Tag)이 부착되어 배송을 준비함</p>
									<br>
									<p>* 검수 보류: 앱에서 사진으로 상품의 상태 확인 및 구매 여부를 선택. (24시간 이후 자동 검수 합격)</p>
									<br>
									<p>* 검수 불합격: 즉시 거래가 취소되고 구매하신 금액을 환불 처리함.(환불 수단은 결제 수단과 동일)</p>
							      </div>
							    </div>
							  </div>
							  <div class="accordion-item">
							    <h2 class="accordion-header" id="flush-headingThree">
							      <button style="box-shadow: none; padding-left: 2px; border-bottom: 1px solid lightgrey;" class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
							        	구매 환불/취소/교환 안내
							      </button>
							    </h2>
							    <div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
							      <div class="accordion-body">
							      	<p>garlicAuction은 익명 거래를 기반으로 판매자가 판매하는 상품을 구매자가 실시간으로 구매하여 거래를 체결합니다.</p>
									<p>- 단순 변심이나 실수에 의한 취소/교환/반품이 불가능합니다. 상품을 원하지 않으시는 경우 언제든지 KREAM에서 재판매를 하실 수 있습니다.</p>
									<p>- 상품 수령 후, 이상이 있는 경우 KREAM 고객센터로 문의해주시기 바랍니다.</p>
							      </div>
							    </div>
							  </div>
							</div>
						</div>
						
						<div class="point_guide md">
							<ul class="guide_list">
								<li class="guide_item">
									<div class="thumb_area">
										<img src="./images/3x_icon.png" width="60px" height="60px">
									</div>
									<div class="thumb_area">
										<span class="title">100% 정품 보증</span>
										<p class="desc">garlicAuction에서 검수한 상품이 정품이 아닐 경우, 구매가의 3배를 보상합니다.</p>
									</div>
								</li>
								<li class="guide_item">
									<div class="thumb_area">
										<img src="./images/check_icon.png" width="60px" height="60px">
									</div>
									<div class="thumb_area">
										<span class="title">엄격한 다중 검수</span>
										<p class="desc">모든 상품은 검수센터에 도착한 후, 상품별 전문가 그룹의 체계적인 시스템을 거쳐 검수를 진행합니다.</p>
									</div>
								</li>
								<li class="guide_item">
									<div class="thumb_area">
										<img src="./images/jungpum_icon.png" width="60px" height="60px">
									</div>
									<div class="thumb_area">
										<span class="title">정품 인증 패키지</span>
										<p class="desc">검수에 합격한 경우에 한하여 garlicAuction의 정품 인증 패키지가 포함된 상품이 배송됩니다.</p>
									</div>
								</li>
							</ul>
						</div>
						<p style="font-family: 'LINESeedKR-Bd'; font-size:15px; margin-top: 10px;">갈릭옥션(주)는 통신판매 중개자로서 통신판매의 당사자가 아닙니다. 본 상품은 개별판매자가 등록한 상품으로 상품, 상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다. 단, 이용약관 및 정책, 기타 거래 체결 과정에서 고지하는 내용 등에 따라 검수하고 보증하는 내용에 대한 책임은 갈릭옥션(주)에 있습니다</p>
						
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
	var sale_category = "${dto.getUpload_category() }";
</script>


   <!-- Modal -->
   <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" style="z-index: 3000">
     <div class="modal-dialog modal-lg">
       <div class="modal-content" style="width: 1029px;">
         <div class="modal-header">
           <h5 class="modal-title" id="exampleModalLabel">경매 상세페이지</h5>
         </div>
         <div class="modal-body">
          <%-- 경매내역 상세 정보 및 입찰 관련 코드 --%>
          <div class="container-fluid">
               <div class="row">
                  <div class="col-md-5 ml-auto">
                     <table border="1" cellspacing="0" style="background: #F6F6F6">
                        <tr>
                           <td> <img style="width: 100%; height: 100%" src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${dto.getSale_file1() }" alt=""></td>
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
      
<script>

    // 서버에서 전달된 남은 시간 정보를 가져옵니다.
    
    var hours = <%= request.getAttribute("hours") %>;
    var minutes = <%= request.getAttribute("minutes") %>;
    var seconds = <%= request.getAttribute("seconds") %>;
    
    
    $(function(){
    	saleDeatailHit();
    	
    	
        // 페이지 로드 시에 남은 시간 표시를 시작합니다.
        displayCountdown();
        
        // 남은 시간을 표시하는 함수
        function displayCountdown() {
            // 남은 시간을 계산하여 표시합니다.
            var countdownElement = document.getElementById("countdown"); // 요소의 ID를 사용하여 선택
            if (hours == 0 && minutes < 5 && seconds > 0) {
                countdownElement.innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
                countdownElement.style.cssText = "color: red; font-weight: bold;";
                document.getElementsByClassName("countdown")[0].innerHTML = hours + "시간 " + minutes + "분 " + seconds + "초";
                document.getElementsByClassName("countdown")[0].style.cssText = "color: red; font-weight: bold;";
            } else if (hours <= 0 && minutes <= 0 && seconds <= 0 || ${Upper} == ${Dto.getSale_end_price()}) {
                countdownElement.innerHTML = "마감 되었습니다.";
                countdownElement.style.cssText = "color: red; font-weight: bold;";
                document.getElementsByClassName("countdown")[0].innerHTML = "마감 되었습니다.";
                document.getElementsByClassName("countdown")[0].style.cssText = "color: red; font-weight: bold;";
                date = 3;
                getList();
                input_bid();
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


      
<jsp:include page="/include/main_bottom.jsp"/>