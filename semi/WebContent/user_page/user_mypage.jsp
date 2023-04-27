<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="js/modify_user.js"></script>
<script>
function openAddressPopup() {
	  var addressPopup = window.open("user_page/user_addr_modify.jsp", "주소변경", "width=500,height=400");
	}

	function setAddress(fullAddress) {
	  document.getElementById("addr_modify").value = fullAddress;
	}

function request_approve() {
	  var user_request = window.open("user_page/user_addr_modify.jsp", "주소변경", "width=500,height=500");
	}
	

</script>
<script>
function openPasswordPopup() {
  var passwordPopup = window.open("user_page/user_pwd_modify.jsp", "비밀번호 변경", "width=500,height=500");
}

function closePasswordPopup() {
  var passwordPopup = document.getElementById("passwordPopup");
  passwordPopup.style.display = "none";
}

function changePassword() {
  var newPwd = document.getElementById("new_pwd").value;
  var modifyPwd = document.getElementById("modify_pwd");
  modifyPwd.value = newPwd;
  closePasswordPopup();
}
</script>
<meta charset="UTF-8" />
<link rel="stylesheet" href="./assets/css/product.css" />
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />
	
	<c:set var="mypage" value="${mypage_id}" />
<!-- Main -->
<div id="main">
    <div class="inner" style="margin-top: -118px;">
        <header>
            <h2>회원정보</h2>
        </header>
        <section>
        	<c:set var="dto" value="${UserInfo}" />
            <div align="center">
                <h2>${dto.getUser_nickname()} 님 회원정보 수정</h2>
                <br>
                <form action="update_profile.do" method="post" id="updateForm" name="m">
                    <table class="table table-bordered" width="1000">
                        <tr>
                            <th>아이디</th>
                            <td><input type="text" name="user_id" value="${dto.getUser_id()}" readonly /></td>
                        </tr>
					     <tr>
							  <th>비밀번호</th>
							  <td>
							    <input type="hidden" id="modify_id" name="user_id" value="${dto.getUser_id()}" />
							    <input type="password" id="modify_pwd" name="user_pwd" required />
							    <span id="modify_pwdcheck"></span>
							  </td>
						</tr>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="user_name" value="${dto.getUser_name()}" readonly /></td>
                        </tr>
                       <tr>
						    <th>닉네임</th>
						    <td>
						        <input type="text" id="modify_nickname" name="user_nickname" value="${dto.getUser_nickname()}" required/>
						        <span id="modify_nickcheck"></span>
						    </td>
						</tr>
                        <tr>
                            <th>연락처</th>
                            <td><input type="text" id="modify_phone" name="user_phone" value="${dto.getUser_phone()}" required/>
                            <span id="modify_phonecheck"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><input type="email" id="modify_email" name="user_email" value="${dto.getUser_email()}" required/>
                            <span id="modify_emailcheck"></span>
                            </td>
                        </tr>
                        <tr>
						    <th>주소</th>
						    <td>
						        <input type="text" id="addr_modify" name="user_addr" value="${dto.getUser_addr()}" readonly/>
						        <button type="button" onclick="openAddressPopup()">주소변경</button>
						    </td>
						</tr>
                        <tr>
						    <th>생일</th>
						    <td><input type="text" id="modify_birth" name="modify_birth" value="${dto.getUser_birth()}" readonly/>
						    <span id="modifybirth"></span>
						    </td>
						</tr>
                        <tr>
							<th>소지금</th>
							<td>
								<input type="text" name="user_money" value="<fmt:formatNumber value="${dto.getUser_money()}" type="number" pattern="#,###"/>원" readonly />
							</td>
						</tr>
						<tr>
							<th>승급 신청</th>
							<td><button type="button" id="execute-servlet">요청하기</button></td>
						</tr>
                    </table>
                    <div class="text-center">
                        <button type="submit" class="btn btn-light" id="userUpdateButton" >회원정보 수정</button>
						<button type="button" onclick="openPasswordPopup()">비밀번호 변경</button>


                    </div>
                </form>
            </div>
        </section>
        
			<div class="moneyplus" style="margin-top: 80px;">
				<h2>소지금 추가</h2>
				<form action="<%=request.getContextPath() %>/user_money_plus.do" style="display: flex;">
					<input type="hidden" name="user_id" value="${user_id }">
					<input type="text" name="money" placeholder="숫자만 입력해주세요." style="width: 320px;">
					<input type="submit" value="추가">
				</form>
			</div>

	<hr>
							
				<section>
					<c:set var="nickname" value="${user_nickname}" />
						<h2><a href="<%=request.getContextPath() %>/user_info_detail.do?searchId=${mypage }">${nickname} 회원의 게시글 목록</a></h2>
							<div class="table-wrapper"> 
								<table class="alt">
									<thead>
										<tr>
											<th>게시판 명</th>
											<th>카테고리명</th>
											<th>제목</th>
											<th>조회수</th>
											<th>작성 일자</th> 
										</tr>
									</thead>
									<tbody>
									<c:set var="list" value="${BoardList }" />
									<c:if test="${!empty list }">
										<c:forEach var="i" begin="0" end="5">
											
											<tr>
												<td>${list[i].getBoard_name() }</td>
												<td>${list[i].getBoard_category() }</td>
												<td>${list[i].getBoard_title() }</td>
												<td>${list[i].getBoard_hit() }</td>
												
												<c:if test="${empty list[i].getBoard_update() }">
													<td> ${list[i].getBoard_date().substring(0, 10) }</td>
												</c:if>
			
												<c:if test="${!empty list[i].getBoard_update() }">
													<td> ${list[i].getBoard_update().substring(0, 10) }</td>
												</c:if>
												
											</tr>

									</c:forEach>
								</c:if>
								
								<c:if test="${empty list }">
									<tr>
										<td colspan="5" align="center">
											<h3>게시판 게시물 리스트가 없습니다</h3>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
							
							<div align="right">
								<h4><a href="<%=request.getContextPath() %>/user_board_all.do?id=${user_id }&searchId=${mypage }">작성 글 목록 전체보기 >> </a></h4>										</div>
							
						</div>
						
						<hr>
						
						<h2>판매/구매 목록</h2>
						<div class="row">
						<div class="col-6" style="border-right : 1px solid black">
						<c:set var="sList" value="${SaleList }" />
							<c:if test="${!empty sList}">
								<h3>판매 상품 목록</h3>
								<c:forEach var="i" begin="0" end="${SCount-1 }">
									<div class="product_list_wrap col-6">
										<div class="product">
											<a href="product_detail.do?no=${sList[i].getSale_no() }&user=${User_no}">
												<div class="product-img">
													<img style="height: 300px"
														src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${sList[i].getSale_file1() }" alt="" />
													<hr style="margin: 0px" width="black" color="100%">
												</div>
												<div class="product-body" style="height: 86px;">
													<h3 class="product-name">${sList[i].getSale_title() }</h3>
												</div>
												<div class="product-btns"></div>
										</div>
										</a>
									</div>
								</c:forEach>
							</c:if>
							
							<c:if test="${empty sList }">
								<h3>판매 상품 페이지가 없습니다.</h3>
							</c:if>
						</div>
						<div class="col-6">
						<c:set var="bList" value="${BuyList }" />
							<c:if test="${!empty bList}">
								<h3>구매 상품 목록</h3>							
								<c:forEach var="i" begin="0" end="${BCount-1 }">
									<div class="product_list_wrap col-6">
										<div class="product">
											<a href="product_detail.do?no=${bList[i].getSale_no() }&user=${User_no}">
												<div class="product-img">
													<img style="height: 300px"
														src="<%=request.getContextPath() %>/./board/sale_board/sale_board_file_upload${bList[i].getSale_file1() }" alt="" />
													<hr style="margin: 0px" width="black" color="100%">
												</div>
												<div class="product-body" style="height: 86px;">
													<h3 class="product-name">${bList[i].getSale_title() }</h3>
												</div>
												<div class="product-btns"></div>
										</div>
										</a>
									</div>
								</c:forEach>
							</c:if>
							
							<c:if test="${empty bList }">
								<h3>구매 상품 페이지가 없습니다.</h3>
							</c:if>
						</div>
						</div>
				</section>
			</div>
		</div>
		<br>
		<script>
function openAddressPopup() {
	  var addressPopup = window.open("user_page/user_addr_modify.jsp", "주소변경", "width=500,height=500");
	}

	function setAddress(fullAddress) {
	  document.getElementById("addr_modify").value = fullAddress;
	}

	
$(document).ready(function() {
    // 버튼 클릭 이벤트를 등록합니다.
    $('#execute-servlet').on('click', function() {
      // AJAX 요청을 보냅니다.
      var id = "${mypage}";
      $.ajax({
    	contentType : "application/x-www-form-urlencoded;charset=UTF-8",
        method: 'POST',
        url: 'user_request.do',
	    data: { id: id },
	    success: function(response) {
	      	// 요청이 성공적으로 처리되면 실행될 코드를 작성합니다.
	    	console.log('응답:', response); // 응답 값을 콘솔에 출력합니다.
	      	alert('요청이 성공적으로 전송되었습니다.');
	    },
	    error: function(error) {
	      // 요청이 실패한 경우 실행될 코드를 작성합니다.
	      console.error(error);
	    }
      });
    });
 });

</script>
		
		<jsp:include page="../include/main_bottom.jsp" />
	</body>
</html>