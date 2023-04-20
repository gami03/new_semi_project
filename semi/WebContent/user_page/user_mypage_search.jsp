<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
<head>
<title>Phantom by HTML5 UP</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8" />
</head>
	
	<jsp:include page="../include/main_top.jsp" />
	
	<!-- Main -->
		<div id="main">
			<div class="inner">

				<header></header>
				<section>
					<c:set var="nickname" value="${user_nickname}" />
					<c:set var="mypage" value="${mypage_id}" />
					<h2>작성 게시글 목록</h2>
						<%-- 검색 폼 페이지 처리 영역 --%>
						<div align="right" style="margin-bottom: 10px;">
							<form method="post" action="<%=request.getContextPath() %>/user_board_search.do?&searchId=${mypage }">
							   	<select name="field" style="width:10%;">
						   			<option value="title">제목</option>
						   			<option value="cont">내용</option>
						   			<option value="title_cont">제목+내용</option>
						   			<option value="category">카테고리</option>
						   		</select>
						   		
						   		<input type="text" name="keyword" style="width:20%;">&nbsp;&nbsp;
						   		<input type="submit" value="검색">
						   </form>
						</div>
					   	<br>
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
								<c:set var="list" value="${SearchList }" />
									<tbody>
									<c:if test="${!empty list }">
										<c:forEach items="${list}" var="dto">
											
											<tr>
												<td>${dto.getBoard_name() }</td>
												<td>${dto.getBoard_category() }</td>
												<td>${dto.getBoard_title() }</td>
												<td>${dto.getBoard_hit() }</td>
												
												<c:if test="${empty dto.getBoard_update() }">
													<td> ${dto.getBoard_date().substring(0, 10) }</td>
												</c:if>
			
												<c:if test="${!empty dto.getBoard_update() }">
													<td> ${dto.getBoard_update().substring(0, 10) }</td>
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
							<br>
							
							<%-- 페이징 처리 영역 --%>
							<div style="margin-left: 30%;">
							   <nav style ="float:left; width: 55%;">
							      <ul class="pagination">
								      <li class="page-item">
								         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=1">처음</a>
								      </li>
								      <li>
								      	<c:if test="${page > 1 }">
								         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${page-1 }">이전</a>
								        </c:if>
								        <c:if test="${page <= 1 }">
								         <a class="page-link">이전</a>
								        </c:if>
								      </li>
								      
								      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
								      <c:if test="${ i == page }">
								         <li class="page-item active" aria-current="page">
								         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${i }">${i }</a>
								         </li>   
								      </c:if>
								      
								      <c:if test="${ i != page }">
								         <li class="page-item">
								         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${i }">${i }</a>
								         </li>   
								      </c:if>
								      </c:forEach>
								      
								      <c:if test="${endBlock < allPage }">
								         <li class="page-item">
								            <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${page+1 }">다음</a>
								         </li>   
								      </c:if>
								      
								      <c:if test="${page < allPage }">
								      <li class="page-item">
								            <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${allPage }">끝</a>
								      </li>
								      </c:if>
							      </ul>
							   </nav>
							</div>
						</div>
				</section>
			</div>
		</div>
	<br>
	
	<script type="text/javascript">
	
	$(function() {
		
		// ajax에서 동일하게 사용되는 속성 설정
		$.ajaxSetup({
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		});
	});

	</script>
	
	<jsp:include page="../include/main_bottom.jsp" />
</body>
</html>