<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

	<jsp:include page="/include/main_top.jsp" />


	<!-- Main -->
	<div align="center">
		<hr width="50%" color="marmoon">
			<h3>공지사항</h3>
		<hr width="50%" color="marmoon">
		<br>
		
		
		<%-- 게시판 테이블 게시물 정렬 기능 --%>
		<div id="freeBoard_order_list">
			<select name="field" style="width:10%; margin-left: 65%;" onchange="onOrderChange(this.value)">
				<option value="time">시간순</option>
	   			<option value="hit">인기순</option>
	   			<option value="look">조회순</option>
	   		</select>
   		</div>
   		<br>
   		
<script type="text/javascript">

	$(function() {
		
		// ajax에서 동일하게 사용되는 속성 설정
		$.ajaxSetup({
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
		});
		
	});
	
	
	// orderBy 파라미터 값을 확인하여, 해당 옵션이 선택된 경우에만 각각 맞는 함수를 호출하도록 처리
	function onOrderChange(orderBy) {
	    if (orderBy === 'hit') {
	      getHitSortList();
	    }else if(orderBy === 'time') {
	      getTimeSortList();
	    }else if(orderBy === 'look') {
	      getLookSortList();
	    }
	  } // onOrderChange() 함수 end
	
	  function getHitSortList(page) {
			
			$.ajax({
				type : "get",
				url : "board_Hit_list.do",
				data : {
					board_name : "${board_name }",
				    page : page
				},
				datatype : "json",
				success : function(response) {
					
					// 데이터가 있을 때만 테이블 생성
					if(response.list.length > 0) {
						
						// 기존 테이블 데이터 삭제
						$("#freeBoard_table tr:gt(0)").remove();
						
						// 동적으로 데이터 생성
						var html = "";
						var no = response.totalEndNo + 1;
						$.each(response.list, function(index, board) {
							html += "<tr>"
										+ "<td>";
							no--;
										
							html += no;
							
							html += "</td>"
								+ "<td><a href='<%=request.getContextPath() %>/board_content.do?no=" + board.board_no + "&page=" + response.page + "&id=${user_id }&nickname=" + board.user_nickname + "&orderBy=hit&board_name="+ board.board_name +"'>"+ board.board_title + "</a></td>"
										+ "<td>"+board.user_nickname+"</td>"
										+ "<td>"+board.board_date.substring(0,10)+"</td>"
										+ "<td>"+board.board_hit+"</td>"
										+ "</tr>";
						});
						$("#freeBoard_table tr:eq(0)").after(html);
						
						// 페이징처리
				        var htmlStr = "";
				        htmlStr = pageLink(response.page, response.allPage, "getHitSortList");
				        // common.js - pageLink
				        
				        // 기존에 추가된 페이지 링크를 삭제
				        $("#freeBoard_table .pagination").remove();

				        // 수정된 코드로 페이지 링크 추가
				        $("#freeBoard_table").append(htmlStr);
					}
					
				},
				error : function() {
					alert("통신에러가 발생했습니다.");
				}
			});
			
		} // getHitSortList() 함수 end
	
	function getTimeSortList(page) {
		
		$.ajax({
			type : "get",
			url : "board_time_list.do",
			data : {
				board_name : "${board_name }",
			    page : page
			},
			datatype : "json",
			success : function(response) {
				
				// 데이터가 있을 때만 테이블 생성
				if(response.list.length > 0) {
					
					// 기존 테이블 데이터 삭제
					$("#freeBoard_table tr:gt(0)").remove();
					
					// 동적으로 데이터 생성
					var html = "";
					var no = response.totalEndNo + 1;
					$.each(response.list, function(index, board) {
						html += "<tr>"
									+ "<td>";
						no--;
									
						html += no;
						
						html += "</td>"
							+ "<td><a href='<%=request.getContextPath() %>/board_content.do?no=" + board.board_no + "&page=" + response.page + "&id=${user_id }&nickname=" + board.user_nickname + "&orderBy=time&board_name="+ board.board_name +"'>"+ board.board_title + "</a></td>"
									+ "<td>"+board.user_nickname+"</td>"
									+ "<td>"+board.board_date.substring(0,10)+"</td>"
									+ "<td>"+board.board_hit+"</td>"
									+ "</tr>";
					});
					$("#freeBoard_table tr:eq(0)").after(html);
					
					// 페이징처리
			        var htmlStr = "";
			        htmlStr = pageLink(response.page, response.allPage, "getTimeSortList");
			        // common.js - pageLink
			        
			        // 기존에 추가된 페이지 링크를 삭제
			        $("#freeBoard_table .pagination").remove();

			        // 수정된 코드로 페이지 링크 추가
			        $("#freeBoard_table").append(htmlStr);
				}
				
			},
			error : function() {
				alert("통신에러가 발생했습니다.");
			}
		});
		
	} // getTimeSortList() 함수 end
	
	function getLookSortList(page) {
		  $.ajax({
		    type: "get",
		    url: "board_look_list.do",
		    data: {
		      board_name: "${board_name}",
		      page: page
		    },
		    datatype: "json",
		    success: function(response) {

		      // 데이터가 있을 때만 테이블 생성
		      if (response.list.length > 0) {

		        // 기존 테이블 데이터 삭제
		        $("#freeBoard_table tr:gt(0)").remove();

		        // 동적으로 데이터 생성
		        var html = "";
		        var no = response.totalEndNo +1;
		        $.each(response.list, function(index, board) {
		          html += "<tr>" + "<td>";
		          no--;

		          html += no;

		          html += "</td>" +
		            "<td><a href='<%=request.getContextPath() %>/board_content.do?no=" + board.board_no + "&page=" + response.page + "&id=${user_id }&nickname=" + board.user_nickname +"&orderBy=look&board_name="+ board.board_name + "'>"+ board.board_title + "</a></td>" +
		            "<td>" + board.user_nickname + "</td>" +
		            "<td>" + board.board_date.substring(0, 10) + "</td>" +
		            "<td>" + board.board_hit + "</td>" +
		            "</tr>";
		        });

		        $("#freeBoard_table tr:eq(0)").after(html);
				
		     	// 페이징처리
		        var htmlStr = "";
		        htmlStr = pageLink(response.page, response.allPage, "getLookSortList");
		        // common.js - pageLink
		        
		        // 기존에 추가된 페이지 링크를 삭제
		        $("#freeBoard_table .pagination").remove();

		        // 수정된 코드로 페이지 링크 추가
		        $("#freeBoard_table").append(htmlStr);
		      }

		    },
		    error: function() {
		      alert("통신에러가 발생했습니다.");
		    }
		  });
		} // getLookSortList() 함수 end

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

<script type="text/javascript">
    $(document).ready(function() {
        // orderBy 값에 따라 적절한 함수 호출
        function onOrderChange(orderBy) {
            if (orderBy === 'hit') {
                getHitSortList(${page});
            } else if (orderBy === 'time') {
                getTimeSortList(${page});
            } else if (orderBy === 'look') {
                getLookSortList(${page});
            }
        }
        
        // select 태그의 value 값을 기준으로 함수 호출 및 옵션 선택
        var selectedOrder = "${orderBy}";
        onOrderChange(selectedOrder);
        $("select[name='field'] option[value='" + selectedOrder + "']").attr('selected', true);
    });
</script>

   		<div id="freeBoard_table">
   		<%-- 공지사항 테이블 --%>
		<table border="1" cellspacing="0" width="50%" class="col-9">
			<tr align="center">
				<th>번호</th> <th width="60%">제목</th> <th>작성자</th> <th>작성일</th> <th>조회수</th>
			</tr>
			
			<c:set var="list" value="${List }"/>
			<c:set var="session" value="${user_id }" />
			<tbody>
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="dto">
						<tr>
							<c:set var="totalEndNo" value="${totalEndNo -1 }" />
									<td> ${totalEndNo + 1 } </td>
							<td>
								<a href="<%=request.getContextPath() %>/board_content.do?no=${dto.getBoard_no() }
																							  &page=${page }&id=${user_id }&nickname=${dto.getUser_nickname() }&board_name=${dto.getBoard_name() }">
									${dto.getBoard_title() }
								</a>
							</td>
							<td> ${dto.getUser_nickname() } </td>
		      				<td> ${dto.getBoard_date().substring(0,10) }</td>
		      				<td> ${dto.getBoard_hit() }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
			
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
	
		
			<div style ="float:left; width:20%; margin-left: 6%">
				<%-- 글쓰기 폼 처리 --%>
				<c:if test="${user_approve == 3 }">
					<input type="button" name="write" value="글쓰기" onclick="location.href='notice_board_write.do'">
				</c:if>
			</div>
			<br>
			<br>
			<br>
			<br>
			<%-- 검색 폼 페이지 처리 영역 --%>
			<div align="center" style="margin-bottom: 100px;">
			   <form method="post" action="<%=request.getContextPath() %>/board_search.do?board_name=${board_name }">
			   		<select name="field" style="width:10%;">
			   			<option value="title">제목</option>
			   			<option value="cont">내용</option>
			   			<option value="title_cont">제목+내용</option>
			   			<option value="writer">작성자</option>
			   		</select>
			   		
			   		<input type="text" name="keyword" style="width:20%;">&nbsp;&nbsp;
			   		<input type="submit" value="검색">
			   </form>
			   <br>
			</div>
		</div>
		
	
	<jsp:include page="/include/main_bottom.jsp" />