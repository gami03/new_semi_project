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
					<h2>작성 게시글 목록</h2>
						<div align="right"><input type="button" ></div>
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
								<c:set var="list" value="${BoardList }" />
									<tbody>
									<c:if test="${!empty list }">
										
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
		<br>

	<jsp:include page="../include/main_bottom.jsp" />

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
						$("#Board_table tr:gt(0)").remove();
						
						// 동적으로 데이터 생성
						var html = "";
						var no = response.totalEndNo + 1;
						$.each(response.list, function(index, board) {
							html += "<tr id='cont_tr'>"
										+ "<td>";
							no--;
										
							html += no;
							
							html += "</td>"
								+ "<td style='text-align: left;'><a href='<%=request.getContextPath() %>/board_content.do?no=" + board.board_no + "&page=" + response.page + "&id=${user_id }&nickname=" + board.user_nickname + "&orderBy=hit&board_name="+ board.board_name +"'>"+"["+board.board_category+"]"+"&nbsp;"+ board.board_title + "</a></td>"
										+ "<td>"+board.user_nickname+"</td>"
										+ "<td>"+board.board_date.substring(0,10)+"</td>"
										+ "<td>"+board.board_hit+"</td>"
										+ "</tr>";
						});
						$("#Board_table tr:eq(0)").after(html);
						
						// 페이징처리
				        var htmlStr = "";
				        htmlStr = pageLink(response.page, response.allPage, "getHitSortList");
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
			
		} // getHitSortList() 함수 end
	
   $(function() {
      
      // ajax에서 동일하게 사용되는 속성 설정
      $.ajaxSetup({
         // ajax에서 한글 깨짐 문제 해결
         ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
         type : "post"
      });
      
      // TBL_BOARD 테이블의 전체 데이터를 가져오는 함수.
      function getList() {
         
         $.ajax({
            url : "admin_ajax.do",
            data : {
            	id: ${dto.getUser_id()},
            	name: ${dto.getUser_name()},
            	nickname: ${dto.getUser_nickname()},
            	approve: ${dto.getUser_approve()},
            },
            datatype : "xml",
            success : function(response) {
            	
            	// 리스트 초기화
                $("data.list tr:gt(1)").remove();
                
                let table = "";
                
                $(data).find("reply").each(function() {
                   table += "<tr>";
                   table += "<td colspan='2'>"+$(this).find("rewriter").text()+"</td>";
                   table += "</tr>";
                   
                   table += "<tr>";
                   table += "<td>"+$(this).find("recont").text()+"</td>";
                   table += "<td>"+$(this).find("redate").text()+"</td>";
                   table += "</tr>";
                   
                   table += "<tr>";
                   table += "<td colspan='2'>&nbsp;</td>";
                   table += "</tr>";
                });
                
                $(".list tr:eq(1)").after(table);
                
                var addTag = "";
                for(var k in data.reserveData){
               
                 var user_id = ${dto.getUser_id()};
                 var user_name = ${dto.getUser_name()};
                 var user_nickname = ${dto.getUser_nickname()};
                 var user_approve = ${dto.getUser_approve()};
                 
                 addTag = '<tr class="tagDel">'
                          + '<td>'+${dto.getUser_id()}+'</td>'
                          + '<td>'+user_name+'</td>'
                          + '<td>'+user_nickname+'</td>'
                          + '<td>'+user_approve+'</td>'
                          + '<td><button type="button" class="blueS" onclick="printPopUp(\''+resv_name+'\',\''+resv_birth+'\');">인쇄</button></td>'
                          + '</tr>';
                 $("#addTable").append(addTag);
                }
            },
            
            error : function() {
               alert("데이터 통신 오류입니다!!!");
            }
         });
      } // getList() 함수 end
   });
</script>  

</body>
</html>