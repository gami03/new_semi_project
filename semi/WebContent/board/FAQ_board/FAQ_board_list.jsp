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
	box-sizing: border-box;
	padding: 30px 40px;
	background: antiquewhite;
	border-radius: 20px;
	border: 1px solid #e2e2e2;
	font-family: 'LINESeedKR-Bd';
}



.accordion-button {
	box-shadow: none;
	border-bottom: revert;
	border-bottom-color: #f8f8f8;
	height: 75px;
}

.accordion-body{
	border-bottom: solid;
	border-bottom-color: lightgray;
	height: 100%;
	font-size: 17px;
}

#category {
	box-shadow: none;
}


.accordion-item p{
	font-family: 'LINESeedKR-Bd';
}

.accordion-button {
	font-size: 17px;
	letter-spacing: 3px;
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
			<p style="font-family: 'Cafe24Ssurround'; font-size: 45px;">자주 묻는 질문(F&Q)</p>
		</div>
		
		<div align="center">
		<br>
			<input type="button" value="자주 묻는 질문(F&Q)" style="margin-right: 3%;" onclick="location.href='board_list.do?board_name=${board_name }'">
			<input type="button" value="묻고 답하기(Q&A)" onclick="location.href='board_list.do?board_name=QnA_board'">
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
		
   		<div align="right">
			<button id="category" onclick="getcategorySortAllList()" name="전체">전체</button>&nbsp;&nbsp;
	   		<button id="category" onclick="getcategorySortList(this)" name="홈페이지 이용">홈페이지 이용</button>&nbsp;&nbsp;
	   		<button id="category" onclick="getcategorySortList(this)" name="결제/영수증">결제/영수증</button>&nbsp;&nbsp;
	   		<button id="category" onclick="getcategorySortList(this)" name="회원정보">회원정보</button>&nbsp;&nbsp;
	   		<button id="category" onclick="getcategorySortList(this)" name="기타">기타</button>
   		</div>
   		
   		<%-- FAQ 테이블 카테고리 별 정렬 ajax --%>
	<script type="text/javascript">
   		$(function() {
		
			// ajax에서 동일하게 사용되는 속성 설정
			$.ajaxSetup({
				ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			});
			
		});
   		
		function getcategorySortList(button, page) {
			
			var category = button.name;
			
			$.ajax({
				type : "get",
				url : "board_category_sort_list.do",
				data : {
					board_name : "${board_name }",
				    page : page,
				    category: category
				},
				datatype : "json",
				success : function(response) {
					var newData = response.list;
					// 데이터가 있을 때만 테이블 생성
					if(newData.length > 0) {
						
						  // Board_table 내부의 모든 자식 노드를 삭제한다.
						  var boardTable = document.getElementById("Board_table");
						  while (boardTable.firstChild) {
						    boardTable.removeChild(boardTable.firstChild);
						  }
						  var no = response.totalEndNo + 1;
						  // 새로운 데이터를 기반으로 HTML을 생성하여 Board_table에 추가한다.
						  for (var i = 0; i < newData.length; i++) {
						    var dto = newData[i];
						    var totalEndNo = response.totalEndNo; // totalEndNo를 계산한다.

						    console.log(newData);
						    console.log(totalEndNo);
						    
						    var accordionDiv = document.createElement("div");
						    accordionDiv.classList.add("accordion", "accordion-flush");
						    accordionDiv.setAttribute("id", "accordionFlushExample");

						    var accordionItemDiv = document.createElement("div");
						    accordionItemDiv.classList.add("accordion-item");

						    var accordionHeader = document.createElement("h2");
						    accordionHeader.classList.add("accordion-header");
						    accordionHeader.setAttribute("id", "flush-heading" + i);

						    var accordionButton = document.createElement("button");
						    accordionButton.classList.add("accordion-button", "collapsed");
						    accordionButton.setAttribute("type", "button");
						    accordionButton.setAttribute("data-bs-toggle", "collapse");
						    accordionButton.setAttribute("data-bs-target", "#flush-collapse" + i);
						    accordionButton.setAttribute("aria-expanded", "false");
						    accordionButton.setAttribute("aria-controls", "flush-collapse" + i);

						    no--;
						    
						    var smallElement = document.createElement("small");
						    smallElement.innerText = "[" + no + "]";

						 	// 이렇게 설정하면 HTML에서 입력한 공백이 그대로 유지되어 출력됩니다.
							accordionButton.style.whiteSpace = "pre";
						    
						    var titleText = document.createTextNode("   " + dto.board_title);
						    accordionButton.appendChild(smallElement);
						    accordionButton.appendChild(titleText);

						    var accordionCollapseDiv = document.createElement("div");
						    accordionCollapseDiv.classList.add("accordion-collapse", "collapse");
						    accordionCollapseDiv.setAttribute("id", "flush-collapse" + i);
						    accordionCollapseDiv.setAttribute("aria-labelledby", "flush-heading" + i);
						    accordionCollapseDiv.setAttribute("data-bs-parent", "#accordionFlushExample");

						    var accordionBodyDiv = document.createElement("div");
						    accordionBodyDiv.classList.add("accordion-body");
						    accordionBodyDiv.setAttribute("align", "left");
						    accordionBodyDiv.innerHTML = dto.board_content; // innerText 대신 innerHTML을 사용

						    accordionCollapseDiv.appendChild(accordionBodyDiv);
						    accordionHeader.appendChild(accordionButton);
						    accordionItemDiv.appendChild(accordionHeader);
						    accordionItemDiv.appendChild(accordionCollapseDiv);
						    accordionDiv.appendChild(accordionItemDiv);

						    boardTable.appendChild(accordionDiv);
						  }
						  
							// boardTable 요소 마지막에 br 태그 3개 추가
						    var br1 = document.createElement("br");
						    var br2 = document.createElement("br");
						    boardTable.appendChild(br1);
						    boardTable.appendChild(br2);
						
						
						// 페이징처리
				        var htmlStr = "";
				        htmlStr = pageLink(response.page, response.allPage, "getcategorySortList");
				        // common.js - pageLink
				        
				        // 기존에 추가된 페이지 링크를 삭제
				        $("#Board_table .pagination").remove();

				        // 수정된 코드로 페이지 링크 추가
				        $("#Board_table").append(htmlStr);
					}
					
				},
				error : function() {
					alert("통신에러가 발생했습니다.");
				}
			});
			
		} // getcategorySortList() 함수 end
		
		
		// 전체 목록 불러오는 정렬 ajax
		function getcategorySortAllList(page) {
			
			$.ajax({
				type : "get",
				url : "board_time_list.do",
				data : {
					board_name : "${board_name }",
				    page : page
				},
				datatype : "json",
				success : function(response) {
					var newData = response.list;
					// 데이터가 있을 때만 테이블 생성
					if(newData.length > 0) {
						
						  // Board_table 내부의 모든 자식 노드를 삭제한다.
						  var boardTable = document.getElementById("Board_table");
						  while (boardTable.firstChild) {
						    boardTable.removeChild(boardTable.firstChild);
						  }
						  var no = response.totalEndNo + 1;
						  // 새로운 데이터를 기반으로 HTML을 생성하여 Board_table에 추가한다.
						  for (var i = 0; i < newData.length; i++) {
						    var dto = newData[i];
						    var totalEndNo = response.totalEndNo; // totalEndNo를 계산한다.

						    console.log(newData);
						    console.log(totalEndNo);
						    
						    var accordionDiv = document.createElement("div");
						    accordionDiv.classList.add("accordion", "accordion-flush");
						    accordionDiv.setAttribute("id", "accordionFlushExample");

						    var accordionItemDiv = document.createElement("div");
						    accordionItemDiv.classList.add("accordion-item");

						    var accordionHeader = document.createElement("h2");
						    accordionHeader.classList.add("accordion-header");
						    accordionHeader.setAttribute("id", "flush-heading" + i);

						    var accordionButton = document.createElement("button");
						    accordionButton.classList.add("accordion-button", "collapsed");
						    accordionButton.setAttribute("type", "button");
						    accordionButton.setAttribute("data-bs-toggle", "collapse");
						    accordionButton.setAttribute("data-bs-target", "#flush-collapse" + i);
						    accordionButton.setAttribute("aria-expanded", "false");
						    accordionButton.setAttribute("aria-controls", "flush-collapse" + i);

						    no--;
						    
						    var smallElement = document.createElement("small");
						    smallElement.innerText = "[" + no + "]";

						 	// 이렇게 설정하면 HTML에서 입력한 공백이 그대로 유지되어 출력됩니다.
							accordionButton.style.whiteSpace = "pre";
						    
						    var titleText = document.createTextNode("   " + dto.board_title);
						    accordionButton.appendChild(smallElement);
						    accordionButton.appendChild(titleText);

						    var accordionCollapseDiv = document.createElement("div");
						    accordionCollapseDiv.classList.add("accordion-collapse", "collapse");
						    accordionCollapseDiv.setAttribute("id", "flush-collapse" + i);
						    accordionCollapseDiv.setAttribute("aria-labelledby", "flush-heading" + i);
						    accordionCollapseDiv.setAttribute("data-bs-parent", "#accordionFlushExample");

						    var accordionBodyDiv = document.createElement("div");
						    accordionBodyDiv.classList.add("accordion-body");
						    accordionBodyDiv.setAttribute("align", "left");
						    accordionBodyDiv.innerHTML = dto.board_content; // innerText 대신 innerHTML을 사용

						    accordionCollapseDiv.appendChild(accordionBodyDiv);
						    accordionHeader.appendChild(accordionButton);
						    accordionItemDiv.appendChild(accordionHeader);
						    accordionItemDiv.appendChild(accordionCollapseDiv);
						    accordionDiv.appendChild(accordionItemDiv);
						    
						    boardTable.appendChild(accordionDiv);
						    
						  }
						  
							// boardTable 요소 마지막에 br 태그 3개 추가
						    var br1 = document.createElement("br");
						    var br2 = document.createElement("br");
						    boardTable.appendChild(br1);
						    boardTable.appendChild(br2);
						  
						// 페이징처리
				        var htmlStr = "";
				        htmlStr = pageLink(response.page, response.allPage, "getcategorySortAllList");
				        // common.js - pageLink
				        
				        // 기존에 추가된 페이지 링크를 삭제
				        $("#Board_table .pagination").remove();

				        // 수정된 코드로 페이지 링크 추가
				        $("#Board_table").append(htmlStr);
					}
					
				},
				error : function() {
					alert("통신에러가 발생했습니다.");
				}
			});
			
		} // getcategorySortAllList() 함수 end
		
		
		// 페이징처리 함수
		function pageLink(curPage, totalPages, funName) {
			
		    var pageLimit = 7;
		    var startPage = (((curPage - 1) / pageLimit) * pageLimit) + 1;
		  
		    var endPage = startPage + pageLimit - 1;
		    
		    if (totalPages < endPage) {
		        endPage = totalPages;
		    }
		    
		    var nextPage = endPage + 1;
		    
	    	var pageUrl = "<div style='margin-left: 30%;'><nav style='float:left; width: 55%;'><ul class='pagination'>";
	    	
	    	// 처음 버튼
	   		pageUrl +="<li class='page-item'><a class='page-link' href='javascript:"+ funName +"(" + 1 + ");'>처음</a></li>";
	   		
	   		// 이전 버튼
	   		if(curPage > 1) {
	   			pageUrl +="<li><a class='page-link' href='javascript:"+ funName +"(" + (parseInt(curPage) - 1) + ")'>이전</a></li>";
	   		}else {
	   			pageUrl +="<li><a class='page-link'>이전</a></li>";
	   		}
		   			
		    
		    //~pageLimit 맞게 페이지 수 보여줌
		    for (i = 1; i <= endPage; i++) {
		        //현재페이지면 진하게 표시
		        if (i == curPage) {
		            pageUrl += " <li class='page-item active' aria-current='page'><a class='page-link' href='javascript:" + funName + "(" + i + ");'>" + i + "</a></li>";
		        }else {
		            pageUrl += " <li class='page-item'><a class='page-link' href='javascript:" + funName + "(" + i + ");'> " + i + " </a></li>";
		        }
		    }
		    
		    //다음 페이지
		    if (nextPage <= totalPages) {
		        pageUrl += "<li class='page-item'><a class='page-link' href='javascript:" + funName + "(" + (nextPage < totalPages ? nextPage : totalPages) + ");'>다음</a></li>";
		    }
		    //맨 마지막 페이지
		    if (curPage < totalPages) {
		        pageUrl += "<li class='page-item'><a class='page-link' href='javascript:" + funName + "(" + totalPages + ");'>끝</a></li>";
		    }
		    pageUrl += "</ul></nav></div>"; // 마지막 태그를 추가
		    
		    
		    return pageUrl;
		    
		}
   		
   	</script>
   	<div id="Board_table">
   	<c:set var="list" value="${List }"/>
   	<c:if test="${!empty list }">
   		<%-- FAQ 테이블 --%>
			<c:forEach items="${list }" var="dto">
			<c:set var="totalEndNo" value="${totalEndNo -1 }" />
		   		<div class="accordion accordion-flush" id="accordionFlushExample">
				  <div class="accordion-item">
				    <h2 class="accordion-header" id="flush-heading${dto.getBoard_no() }">
				      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse${dto.getBoard_no() }" aria-expanded="false" aria-controls="flush-collapse${dto.getBoard_no() }">
				       <p><small>[${totalEndNo + 1 }]</small></p>&nbsp;&nbsp; <p>${dto.getBoard_title() }</p>
				      </button>
				    </h2>
				    <div id="flush-collapse${dto.getBoard_no() }" class="accordion-collapse collapse" aria-labelledby="flush-heading${dto.getBoard_no() }" data-bs-parent="#accordionFlushExample">
				      <div class="accordion-body" align="left"><p>${dto.getBoard_content() }</p></div>
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
		</c:if>
	</div>
	
		
			<div class="write">
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
		</div>
		
	
	<jsp:include page="/include/main_bottom.jsp" />