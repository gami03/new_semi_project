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
					<c:set var="dto" value="${UserInfo}" />
						<h2>프로필</h2>
						<div align="center">
							<h4>${dto.getUser_nickname()} 님</h4>
							<br>
							<p>유저명 : ${dto.getUser_nickname() }</p>
							<p>아이디 : ${dto.getUser_id() }</p>
							<p>이메일 : ${dto.getUser_email() }</p>
							<p>연락처 : ${dto.getUser_phone() }</p>
						</div>
					
				</header>
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
								<c:set var="list" value="${OrderList}" />
									<tbody>
									<c:if test="${!empty list }">
										<c:forEach var="i" begin="0" end="${Count-1 }">
											<div class="col-md-4">
												<div class="product">
													<a href="product_detail.do?no=${dto[i].getSale_no() }&user=${User_no}">
														<div class="product-img">
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