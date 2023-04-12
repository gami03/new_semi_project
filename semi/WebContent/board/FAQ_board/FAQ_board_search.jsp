<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 아코디언 게시판 부트스트랩 쓰기위한 cdn 불러오기 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<style type="text/css">
.pagination{
justify-content: center;
}

.faq_left {
	float : left;
	font-size: 30px;
	padding: 22px 0 0 0;
	width: 14%;
	align-content: center;
}

.word_search {
	width: 75%;
	box-sizing: border-box;
	padding: 30px 40px;
	background: #f8f8f8;
	border-radius: 20px;
	border: 1px solid #e2e2e2;
}

.accordion {
	width: 75%;
}

.accordion-button {
	box-shadow: none;
	border-bottom: revert;
	border-bottom-color: #f8f8f8;
}
</style>


<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
</script>

	<jsp:include page="/include/main_top.jsp" />


	<!-- Main -->
	<div align="center">
		<hr width="50%" color="marmoon">
			<h3>자주 묻는 질문(FAQ)</h3>
		<hr width="50%" color="marmoon">
		<div align="center">
		<br>
			<input type="button" value="자주 묻는 질문(F&Q)" style="margin-right: 3%;" onclick="location.href='board_list.do?board_name=FAQ_board'">
			<input type="button" value="묻고 답하기(Q&A)">
		</div>
		<br>
		<br>
		
		<%-- 검색 폼 페이지 처리 영역 --%>
			<div align="center" class="word_search">
			   <form method="post" action="<%=request.getContextPath() %>/board_search.do?board_name=${board_name }">
			   	<span class="faq_left">FAQ검색</span>
			   	<p class="word_intro">궁금하신 내용을 입력하시면 답변을 확인하실 수 있습니다.</p>
			   		<select name="field" style="width:15%;">
			   			<option value="title">제목</option>
			   			<option value="cont">내용</option>
			   			<option value="title_cont">제목+내용</option>
			   		</select>
			   		
			   		<input type="text" name="keyword" style="width:50%;">&nbsp;&nbsp;
			   		<input type="submit" value="검색">
			   </form>
			   <br>
			</div>
			<br>

   		<div id="Board_table">
	   		<%-- FAQ 테이블 --%>
	   		<c:set var="list" value="${List }"/>
	   		<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
				<c:set var="totalEndNo" value="${totalEndNo -1 }" />
			   		<div class="accordion accordion-flush" id="accordionFlushExample">
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="flush-heading${dto.getBoard_no() }">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${dto.getBoard_no() }" aria-expanded="false" aria-controls="flush-collapse${dto.getBoard_no() }">
					       [${totalEndNo + 1 }] ${dto.getBoard_title() }
					      </button>
					    </h2>
					    <div id="flush-collapse${dto.getBoard_no() }" class="accordion-collapse collapse" aria-labelledby="flush-heading${dto.getBoard_no() }" data-bs-parent="#accordionFlushExample">
					      <div class="accordion-body">${dto.getBoard_content() }</div>
					    </div>
					  </div>
					</div>
				</c:forEach>
			<br><br>
			
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
		</c:if>
	</div>
	
		
			<div style ="float:left; width:20%; margin-left: 6%;">
				<%-- 글쓰기 폼 처리 --%>
				<%-- user_approve 0: 일반사용자, 1: 판매 가능 사용자, 2: 관리자, 3: 총관리자 --%>
				<c:if test="${user_approve >= 2 }">
					<input type="button" name="write" value="글쓰기" onclick="location.href='FAQ_board_write.do'">
				</c:if>
			</div>
			<br>
			<br>
			<br>
			<br>
			<input type="button" name="gototalList" value="전체목록" onclick="location.href='board_list.do?board_name=${board_name }'" style="margin-bottom: 100px;">
		</div>
		
	
	<jsp:include page="/include/main_bottom.jsp" />