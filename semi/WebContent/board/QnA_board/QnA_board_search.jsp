<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <%-- 폰트어썸 4 --%>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />

<style type="text/css">
.pagination{
	justify-content: center;
}


.fa-eye {
	color: #77767c;
	font-size: 14px;
}

.fa-clock-o {
	color: #77767c;
	font-size: 14px;
}

table td {
	vertical-align: middle;
}
</style>


<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
	
</script>

	<jsp:include page="/include/main_top.jsp" />

	<!-- Main -->
	<div align="center" id="main" style="padding-top: 0;">
	
		<div class="QnAFAQ_board_banner">
			<p style="font-family: 'Cafe24Ssurround'; font-size: 45px;">묻고 답하기(Q&A)</p>
		</div>
		
		<div align="center">
		<br>
			<input type="button" value="자주 묻는 질문(F&Q)" style="margin-right: 3%;" onclick="location.href='board_list.do?board_name=FAQ_board'">
			<input type="button" value="묻고 답하기(Q&A)" onclick="location.href='board_list.do?board_name=${board_name }'">
		</div>
		<br>
		<br>
		<%-- 테이블 위쪽 --%>
		<div id="table_top" align="left">
			<%-- 검색 폼 페이지 처리 영역 --%>
			<div>
			   <form method="post" action="<%=request.getContextPath() %>/board_search.do?board_name=${board_name }" style="display: flex;
																												    justify-content: space-between;">
			   		<span style="font-size: 19px; padding-top: 10px;">전체 ${totalRecord }건 | 페이지 ${page }/${allPage }</span>
			   		<div align="right" style="width: 400px;">
				   		<select name="field" style="width:25%; font-size: initial"">
				   			<option value="writer">작성자</option>
				   		</select>
				   		<input type="text" name="keyword" placeholder="닉네임을 입력해주세요" style="width:45%; font-size: initial"">&nbsp;&nbsp;
				   		<input type="submit" value="검색">
			   		</div>
			   </form>
			</div>
		</div>
		<br>
		<c:set var="listCount" value="${listCount }" />
		<c:set var="list" value="${List }"/>
		<c:set var="session" value="${user_id }" />
   		<div id="Board_table">
	   		<%-- 자유게시판 테이블 --%>
			<table border="1" cellspacing="0">
				
				<tbody>
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="dto" >
						<tr style="height: 70px;" id="cont_tr">
							<c:set var="totalEndNo" value="${totalEndNo -1 }" />
									<td> ${totalEndNo + 1 } </td>
							<td>
								<c:if test="${dto.getUser_no() == session_user_no }">
									<a href="<%=request.getContextPath() %>/board_content.do?no=${dto.getBoard_no() }
																								  &page=${page }&id=${user_id }&nickname=${dto.getUser_nickname() }&field=${field }&keyword=${keyword }&board_name=${dto.getBoard_name() }">
										[${dto.getBoard_category() }]&nbsp;${dto.getBoard_title() }
									</a>
								</c:if>
								<c:if test="${dto.getUser_no() ne session_user_no || empty user_id}">
								    <a onclick="alert('로그인 후 본인글만 확인 가능합니다.')">
								        [${dto.getBoard_category()}]&nbsp;${dto.getBoard_title()}
								    </a>
								</c:if>


							</td>
							<td> ${dto.getUser_nickname() } </td>
		      				<td> <i class="fa fa-clock-o" aria-hidden="true"></i> ${dto.getBoard_date().substring(0,10) }</td>
		      				<td> <i class="fa fa-eye" aria-hidden="true"></i> ${dto.getBoard_hit() }</td>
		      				<%-- 답변여부 들어갈 값 --%>
		      				<td>
		      					<c:if test="${dto.getBoard_reply() > 0 }">
		      						답변완료
		      					</c:if>
		      					<c:if test="${dto.getBoard_reply() == 0 }">
		      						답변대기
		      					</c:if>
		      				</td>
		      				
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
				
				
				<c:if test="${empty list }">
					<tr>
						<td colspan="6" align="center">
							<h3>묻고 답하기(Q&A) 게시물 리스트가 없습니다</h3>
						</td>
					</tr>
				</c:if>
			</table>
			<br>
			
			<%-- 페이징 처리 영역 --%>
			<div style="margin-left: 30%;">
		   <nav style ="float:left; width: 55%;">
		      <ul class="pagination">
			      <li class="page-item">
			         <a class="page-link" href="board_search.do?page=1&field=${field }&keyword=${keyword }&board_name=${board_name }">처음</a>
			      </li>
			      <li>
			      	<c:if test="${page > 1 }">
			         <a class="page-link" href="board_search.do?page=${page-1 }&field=${field }&keyword=${keyword }&board_name=${board_name }">이전</a>
			        </c:if>
			        <c:if test="${page <= 1 }">
			         <a class="page-link">이전</a>
			        </c:if>
			      </li>
			      
			      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
			      <c:if test="${ i == page }">
			         <li class="page-item active" aria-current="page">
			         <a class="page-link" href="board_search.do?page=${i }&field=${field }&keyword=${keyword }&board_name=${board_name }">${i }</a>
			         </li>   
			      </c:if>
			      
			      <c:if test="${ i != page }">
			         <li class="page-item">
			         <a class="page-link" href="board_search.do?page=${i }&field=${field }&keyword=${keyword }&board_name=${board_name }">${i }</a>
			         </li>   
			      </c:if>
			      </c:forEach>
			      
			      <c:if test="${endBlock < allPage }">
			         <li class="page-item">
			            <a class="page-link" href="board_search.do?page=${page+1 }&field=${field }&keyword=${keyword }&board_name=${board_name }">다음</a>
			         </li>   
			      </c:if>
			      
			      <c:if test="${page < allPage }">
			      <li class="page-item">
			            <a class="page-link" href="board_search.do?page=${allPage }&field=${field }&keyword=${keyword }&board_name=${board_name }">끝</a>
			      </li>
			      </c:if>
		      </ul>
		   </nav>
		</div>
	</div>
		
			<div class="write">
				<%-- 글쓰기 폼 처리 --%>
				<c:set var="id" value="${user_id }" />
				<c:if test="${!empty id }">
					<input type="button" name="write" value="글쓰기" onclick="location.href='QnA_board_write.do'">
				</c:if>
			</div>
			<br>
			<br>
			<br>
			<br>
			
			<input type="button" name="gototalList" value="전체목록" onclick="location.href='board_list.do?board_name=${board_name }'" style="margin-bottom: 50px;">
		</div>
		
		
		
	
	<jsp:include page="/include/main_bottom.jsp" />