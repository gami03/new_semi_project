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
					<h2>판매 승인 요청 게시글 목록</h2>
					   	<br>
						<div class="table-wrapper"> 
							<table class="alt">
								<thead>
									<tr>
										<th>카테고리명</th>
										<th>닉네임</th>
										<th>제목</th>
										<th>작성 일자</th>
										<th>경매 기간</th>
										<th>승인</th>
										<th>거부</th>
									</tr>
								</thead>
								<c:set var="list" value="${List }" />
									<tbody>
									<c:if test="${!empty list }">
										<c:forEach items="${list}" var="dto">
											
											<tr>
												<td>${dto.getUpload_category() }</td>
												<td>${dto.getUser_nickname() }</td>
												<td>${dto.getSale_title() }</td>
												<td>${dto.getSale_date().substring(0, 19) }</td>
												<td>${dto.getAuction_period() }</td>
												<td style="text-align: center;"><button onclick="location.href='sale_product_approve_ok.do?sale_no=${dto.getSale_no() }&user_id=${user_id }&nickname=${dto.getUser_nickname() }'">승인</button></td>
												<td style="text-align: center;"><button onclick="location.href='sale_product_approve_delete.do?sale_no=${dto.getSale_no() }&user_id=${user_id }&nickname=${dto.getUser_nickname() }'">거부</button></td>
												
											</tr>

									</c:forEach>
								</c:if>
								
								<c:if test="${empty list }">
									<tr>
										<td colspan="7" align="center">
											<h3>판매 승인 요청 게시물 리스트가 없습니다</h3>
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
								         <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=1">처음</a>
								      </li>
								      <li>
								      	<c:if test="${page > 1 }">
								         <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=${page-1 }">이전</a>
								        </c:if>
								        <c:if test="${page <= 1 }">
								         <a class="page-link">이전</a>
								        </c:if>
								      </li>
								      
								      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
								      <c:if test="${ i == page }">
								         <li class="page-item active" aria-current="page">
								         <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=${i }">${i }</a>
								         </li>   
								      </c:if>
								      
								      <c:if test="${ i != page }">
								         <li class="page-item">
								         <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=${i }">${i }</a>
								         </li>   
								      </c:if>
								      </c:forEach>
								      
								      <c:if test="${endBlock < allPage }">
								         <li class="page-item">
								            <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=${page+1 }">다음</a>
								         </li>   
								      </c:if>
								      
								      <c:if test="${page < allPage }">
								      <li class="page-item">
								            <a class="page-link" href="sale_approve_list.do?user_id=${user_id }&page=${allPage }">끝</a>
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