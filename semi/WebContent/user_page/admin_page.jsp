<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8" />
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />

				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
								<h1>This is Phantom, a free, fully responsive site<br />
								template designed by <a href="http://html5up.net">HTML5 UP</a>.</h1>
								<p>Etiam quis viverra lorem, in semper lorem. Sed nisl arcu euismod sit amet nisi euismod sed cursus arcu elementum ipsum arcu vivamus quis venenatis orci lorem ipsum et magna feugiat veroeros aliquam. Lorem ipsum dolor sit amet nullam dolore.</p>
								<div><img src="./images/pic13.jpg" alt="" /></div>
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
											<c:set var="list" value="${UserList }" />
												<tbody>
												<c:if test="${!empty list }">
													<c:forEach items="${list }" var="dto">
														
														<tr>
															<td>${dto.getUser_id() }</td>
															<td>${dto.getUser_nickname() }</td>
															<td>${dto.getUser_name() }</td>
															<td>${dto.getUser_approve() }</td>
															<td>
																<a href="<%=request.getContextPath() %>/user_search_page.do?id=${user_id }&searchId=${dto.getUser_id() }&total=0">회원 글 목록</a>
																	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
																<a href="#">등급 변경</a>
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
		<jsp:include page="../include/main_bottom.jsp" />
	</body>
</html>