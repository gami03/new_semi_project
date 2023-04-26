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
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />
<!-- Main -->
<div id="main">
    <div class="inner">
        <header>
            <c:set var="dto" value="${UserInfo}" />
            <h2>회원정보</h2>
        </header>
        <section>
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
						    <td><input type="text" name="user_birth" value="${dto.getUser_birth()}"/></td>
						</tr>
                        <tr>
							<th>소지금</th>
							<td><input type="text" name="user_money" value="<fmt:formatNumber value="${dto.getUser_money()}" type="number" pattern="#,###"/>원" readonly /></td>
						</tr>
						<tr>
							<th>승급 신청</th>
							<td><button type="button" name="user_request" onclick="request_approve()">요청하기</button></td>
						</tr>
                    </table>
                    <div class="text-center">
                        <button type="submit" class="btn btn-light" id="userUpdateButton" >회원정보 수정</button>
						<button type="button" onclick="openPasswordPopup()">비밀번호 변경</button>


                    </div>
                </form>
            </div>
        </section>
        



							
				<section>
					<c:set var="nickname" value="${user_nickname}" />
					<c:set var="mypage" value="${mypage_id}" />
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
											<h3>자유게시판 게시물 리스트가 없습니다</h3>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
							
							<div align="right">
								<h4><a href="<%=request.getContextPath() %>/user_board_all.do?id=${user_id }&searchId=${mypage }">작성 글 목록 전체보기 >> </a></h4>										</div>
							
						</div>
						
						<hr>
						
					<h2>구매/판매 목록</h2>
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
								<c:set var="orderList" value="${OrderList}" />
									<tbody>
									<c:if test="${!empty list }">
										<c:forEach var="i" begin="0" end="${Count-1 }">
										    <div class="col-md-4">
										        <div class="product">
										            <a href="product_detail.do?no=${orderList[i].getSale_no() }&user=${User_no}">
															<img style="height: 300px"
																src="./images/${dto[i].getSale_file1() }" alt="" />
															<hr style="margin: 0px" width="black" color="100%">
															<div class="product-label">
																<span class="sale">-30%</span>
															</div>
														</div>
														<div class="product-body">
															<h3 class="product-name">${dto[i].getSale_title() }</h3>
														</div>
														<div class="product-btns"></div>
												</div>
												</a>
											</div>
										</c:forEach>
									</c:if>
								
								<c:if test="${empty list }">
									<tr>
										<td colspan="5" align="center">
											<h3>자유게시판 게시물 리스트가 없습니다</h3>
										</td>
									</tr>
								</c:if>
								</tbody>
							</table>
						</div>
						
				</section>
			</div>
		</div>
		<jsp:include page="../include/main_bottom.jsp" />
	</body>
</html>