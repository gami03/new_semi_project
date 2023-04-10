<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.pagination{
justify-content: center;
}
</style>

<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
</script>

</head>

	<jsp:include page="/include/main_top.jsp" />

	<!-- Main -->
	<div align="center">
		<hr width="50%" color="marmoon">
			<h3>자유게시판</h3>
		<hr width="50%" color="marmoon">
		<br>
		
		<table border="1" cellspacing="0" width="50%" class="col-9">
			<tr align="center">
				<th>번호</th> <th width="60%">제목</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
			</tr>
			
			<c:set var="list" value="${List }"/>
			<c:set var="session" value="${user_id }" />
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					
					<tr>
						<c:set var="totalEndNo" value="${totalEndNo -1 }" />
								<td> ${totalEndNo + 1 } </td>
						<td>
							<a href="<%=request.getContextPath() %>/free_board_content.do?no=${dto.getBoard_no() }
																						  &page=${page }&id=${user_id }&nickname=${dto.getUser_nickname() }&field=${field }&keyword=${keyword }">
								[${dto.getBoard_category() }]&nbsp;${dto.getBoard_title() }
							</a>
						</td>
						<td> ${dto.getUser_nickname() } </td>
	      				<td> ${dto.getBoard_date().substring(0,10) }</td>
	      				<td> ${dto.getBoard_hit() }</td>
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
		</table>
		<br>
		
		<%-- 페이징 처리 영역 --%>
		<div style="margin-left: 35%;">
	   <nav style ="float:left; width: 35%;">
	      <ul class="pagination">
		      <li class="page-item">
		         <a class="page-link" href="free_board_list.do?page=1">처음</a>
		      </li>
		      <li>
		         <a class="page-link" href="free_board_list.do?page=${page-1 }">이전</a>
		      </li>
		      
		      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
		      <c:if test="${ i == page }">
		         <li class="page-item active" aria-current="page">
		         <a class="page-link" href="free_board_list.do?page=${i }">${i }</a>
		         </li>   
		      </c:if>
		      
		      <c:if test="${ i != page }">
		         <li class="page-item">
		         <a class="page-link" href="free_board_list.do?page=${i }">${i }</a>
		         </li>   
		      </c:if>
		      </c:forEach>
		      
		      <c:if test="${endBlock < allPage }">
		         <li class="page-item">
		            <a class="page-link" href="free_board_list.do?page=${page+1 }">다음</a>
		         </li>   
		      </c:if>
		      
		      <li class="page-item">
		            <a class="page-link" href="free_board_list.do?page=${allPage }">끝</a>
		      </li>
	      </ul>
	   </nav>
	</div>
		
			<div style ="float:left; width:20%; margin-left: 16%">
				<%-- 글쓰기 폼 처리 --%>
				<c:set var="id" value="${user_id }" />
				<c:if test="${!empty id }">
					<input type="button" name="write" value="글쓰기" onclick="location.href='free_board_write.do'">
				</c:if>
				
				<c:if test="${empty id }">
					<input type="button" name="write" value="글쓰기" onclick="writeCheck()">
				</c:if>
			</div>
			<br>
			<br>
			<br>
			<br>
			<%-- 검색 폼 페이지 처리 영역 --%>
			<div align="center" style="margin-bottom: 100px;">
			   <form method="post" action="<%=request.getContextPath() %>/free_board_search.do">
			   		<select name="field" style="width:10%;">
			   			<option value="title">제목</option>
			   			<option value="cont">내용</option>
			   			<option value="title_cont">제목+내용</option>
			   			<option value="writer">작성자</option>
			   			<option value="category">카테고리</option>
			   		</select>
			   		
			   		<input type="text" name="keyword" style="width:20%;">&nbsp;&nbsp;
			   		<input type="submit" value="검색">
			   		<input type="button" name="gototalList" value="전체목록" onclick="location.href='free_board_list.do'">
			   </form>
			   <br>
			</div>
		</div>
		
	
	<jsp:include page="/include/main_bottom.jsp" />