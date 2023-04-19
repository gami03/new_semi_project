<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.1.js"></script>
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<header></header>
				<section>
					<div class="Board_table">
						<div id="table-wrapper">
							<table border="1" cellspacing="0" width="50%" class="alt col-9" id="Board_table">
								<thead>
									<tr align="center" id="title_tr">
										<th>게시판 명</th>
										<th>카테고리명</th>
										<th>제목</th>
										<th>조회수</th>
										<th>작성 일자</th> 
									</tr>
								</thead>
								
								<c:set var="list" value="${BoardList }"/>
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
						</div>
						
						<%-- 페이징 처리 영역 --%>
						<div style="margin-left: 30%;">
						   <nav style ="float:left; width: 55%;">
						      <ul class="pagination">
							      <li class="page-item">
							         <a class="page-link" href="board_list.do?page=1&board_name=${board_name }">처음</a>
							      </li>
							      <li>
							      	<c:if test="${page > 1 }">
							         <a class="page-link" href="board_list.do?page=${page-1 }&board_name=${board_name }">이전</a>
							        </c:if>
							        <c:if test="${page <= 1 }">
							         <a class="page-link">이전</a>
							        </c:if>
							      </li>
							      
							      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
							      <c:if test="${ i == page }">
							         <li class="page-item active" aria-current="page">
							         <a class="page-link" href="board_list.do?page=${i }&board_name=${board_name }">${i }</a>
							         </li>   
							      </c:if>
							      
							      <c:if test="${ i != page }">
							         <li class="page-item">
							         <a class="page-link" href="board_list.do?page=${i }&board_name=${board_name }">${i }</a>
							         </li>   
							      </c:if>
							      </c:forEach>
							      
							      <c:if test="${endBlock < allPage }">
							         <li class="page-item">
							            <a class="page-link" href="board_list.do?page=${page+1 }&board_name=${board_name }">다음</a>
							         </li>   
							      </c:if>
							      
							      <c:if test="${page < allPage }">
							      <li class="page-item">
							            <a class="page-link" href="board_list.do?page=${allPage }&board_name=${board_name }">끝</a>
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
	
	  function getUserList(page) {
			
			$.ajax({
				type : "get",
				url : "admin_ajax.do",
				data : {
					approve: "${dto.getUser_approve()}",
					board_name : "${board_name }",
				    page : page,
				    field : "${field}"
				},
				datatype : "json",
				success : function(response) {
					
					// 데이터가 있을 때만 테이블 생성
					if(response.list.length > 0) {
						
						// 기존 테이블 데이터 삭제
						$("#Board_table tr:gt(0)").remove();
						
						// 동적으로 데이터 생성
						var html = "";
						// var no = response.totalEndNo + 1;
						$.each(response.list, function(index, board) {
							html += "<tr id='cont_tr'>"
									+ '<td>'+${dto.getUser_id()}+'</td>'
		                          	+ '<td>'+user_name+'</td>'
		                          	+ '<td>'+user_nickname+'</td>'
		                          	+ '<td>'+user_approve+'</td>'
		                          	+ '<td><button type="button" class="blueS" onclick="printPopUp(\''+resv_name+'\',\''+resv_birth+'\');">인쇄</button></td>'
								+ "</tr>";
						});
						$("#Board_table tr:eq(0)").after(html);
					
				},
				error : function() {
					alert("통신에러가 발생했습니다.");
				}
			});
			
		} // getUserList() 함수 end
		
		getUserList(page);
	
</script>  

	<jsp:include page="../include/main_bottom.jsp" />

</body>
</html>