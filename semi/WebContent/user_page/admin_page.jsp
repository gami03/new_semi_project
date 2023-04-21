<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8" />
<script>
  $('#approveModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var userNickname = button.data('book-id');
    $('#user-nickname').text(userNickname);
  });
</script>
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />

	<c:set var="userlist" value="${UserList }" />

				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
							</header>
							<section>
								<c:set var="nickname" value="${user_nickname}" />
								<h2>${nickname} 회원의 게시글 목록</h2>
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
										<h4><a href="<%=request.getContextPath() %>/user_board_all.do?id=${user_id }&searchId=${mypage }">작성 글 목록 전체보기 >> </a></h4>
									</div>
									
								</div>
								<h3>회원 목록</h3>
								<br>
									<div class="table-wrapper"> 
										<table class="alt">
											<thead>
												<tr>
													<th>회원 닉네임</th>
													<th>회원 아이디</th>
													<th>회원명</th>
													<th>회원 등급</th>
													<th>회원 등급 변경</th>
												</tr>
											</thead>
												<tbody>
												<c:if test="${!empty userlist }">
													<c:forEach items="${userlist }" var="dto">
														
														<tr>
															<td>${dto.getUser_id() }</td>
															<td>${dto.getUser_nickname() }</td>
															<td>${dto.getUser_name() }</td>
															<td>${dto.getUser_approve() }</td>
															<td>
																<a href="<%=request.getContextPath() %>/user_search_page.do?id=${user_id }&searchId=${dto.getUser_id() }&total=0">회원 글 목록</a>
																	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
																<a data-toggle="modal" data-target="#approveModal" data-book-id="${dto.getUser_nickname() }">등급 변경</a>
																	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
																<a href="#">회원 삭제</a>
															</td>
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
									</div>
							</section>
						</div>
					</div>
					
						<!-- Modal -->
						<div class="modal fade" id="approveModal" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true" style="z-index: 3000;">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="approveModalLabel">등업 신청</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						      	<p>User nickname: ${userlist[i].getUser_nickname() }</p>
							
								<table border="1" cellspacing="0" width="400">
									<tr>
										<th>유저명</th>
										<td>${dto.getUser_nickname() }</td>
									</tr>
								
									<tr>
										<th>비밀번호</th>
										<td> <input type="password" name="user_pwd"></td>
									</tr>
								
									
								
								</table>
								<br>
								<div class="submit1" align="center">
									<input class="submit_btn btn-primary" type="submit" value="로그인" >
								</div>
					
					
					      </div>
					    </div>
					  </div>
					</div>
		<jsp:include page="../include/main_bottom.jsp" />
	</body>
</html>