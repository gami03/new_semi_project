<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
<style type="text/css">
.pagination{
justify-content: center;
}
</style>
<script type="text/javascript">

	function check(){
		
		if(f.user_id.value==""){
			alert("아이디를 입력하세요.");
			f.user_id.focus();
			return false;
		}
		if(f.user_pwd.value==""){
			alert("비밀번호를 입력하세요.");
			f.user_pwd.focus();
			return false;
		}
	}

</script>

<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
</script>

</head>
<body class="is-preload">
	<!-- Wrapper -->
		<div id="wrapper">

			<!-- Header -->
				<header id="header">
					<div class="inner">

						<!-- Logo -->
							<a href="index.html" class="logo">
								<span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">Phantom</span>
							</a>

						<!-- Nav -->
							<nav>
								<form method="post" name="f"  action="<%=request.getContextPath()%>/login_check.do" onsubmit="return check()" align="center">
									
								<c:set var="id" value="${user_id }" />
								<c:if test="${empty id }">
									<ul>
										<li><input type="button" class="btn btn-primary" name="login" value="로그인" data-toggle="modal" data-target="#boardModal"></li>
										<li><a href="#menu">Menu</a></li>
									</ul>
									
									<!-- Modal -->
									<div class="modal fade" id="boardModal" tabindex="-1" aria-labelledby="boardModalLabel" aria-hidden="true">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title" id="boardModalLabel">로그인 모달창</h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
										
											<table border="1" cellspacing="0" width="400">
												<tr>
													<th>아이디</th>
													<td> <input type="text" name="user_id"></td>
												</tr>
											
												<tr>
													<th>비밀번호</th>
													<td> <input type="password" name="user_pwd"></td>
												</tr>
											
												
											
											</table>
											<br>
											<div class="submit1" align="center">
												<input class="submit_btn btn-primary" type="submit" value="로그인" >
											</div>
									      </div>
									    </div>
									  </div>
									</div>
								</c:if>
								<br>
								
								<c:if test="${!empty id }">
									<ul>
										<li><input type="button" name="login" value="로그아웃" onclick="location.href='logintest/logout.jsp'"></li>
										<li><a href="#menu">Menu</a></li>
									</ul>
								</c:if>
								</form>
							</nav>
						</div>
					</header>

			<!-- Menu -->
				<nav id="menu">
					<h2>Menu</h2>
					<ul>
						<li><a href="index.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath() %>/free_board_list.do">자유게시판</a></li>
						<li><a href="">판매게시판</a></li>
						<li><a href="">Q&A</a></li>
						<li><a href="">마이페이지</a></li>
					</ul>
				</nav>

	<!-- Main -->
	<div align="center">
		<hr width="50%" color="marmoon">
			<h3>자유게시판</h3>
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
	
	function getHitSortList() {
		
		$.ajax({
			type : "get",
			url : "board_Hit_list.do",
			data : {
				board_name : "${board_name }",
			    page : "${page }"
			},
			datatype : "json",
			success : function(response) {
				console.log(response);
				
				// 데이터가 있을 때만 테이블 생성
				if(response.list.length > 0) {
					
					// 기존 테이블 데이터 삭제
					$("#freeBoard_table tr:gt(0)").remove();
					
					// 동적으로 데이터 생성
					$.each(response.list, function(index, board) {
						var html = "<tr>"
									+ "<td>"+${totalEndNo }+"</td>"
									+ "<td>"+board.board_title+"</td>"
									+ "<td>"+board.user_nickname+"</td>"
									+ "<td>"+board.board_date.substring(0,10)+"</td>"
									+ "<td>"+board.board_hit+"</td>"
									+ "</tr>";
						$("#freeBoard_table tr:eq(0)").after(html);
					});
				}
				
			},
			error : function() {
				alert("통신에러가 발생했습니다.");
			}
		});
		
	} // getHitSortList() 함수 end
	
	function getTimeSortList() {
		
		$.ajax({
			type : "get",
			url : "board_time_list.do",
			data : {
				board_name : "${board_name }",
			    page : "${page }"
			},
			datatype : "json",
			success : function(response) {
				console.log(response);
				
				// 데이터가 있을 때만 테이블 생성
				if(response.list.length > 0) {
					
					// 기존 테이블 데이터 삭제
					$("#freeBoard_table tr:gt(0)").remove();
					
					// 동적으로 데이터 생성
					$.each(response.list, function(index, board) {
						var html = "<tr>"
									+ "<td>"+${totalEndNo }+"</td>"
									+ "<td>"+board.board_title+"</td>"
									+ "<td>"+board.user_nickname+"</td>"
									+ "<td>"+board.board_date.substring(0,10)+"</td>"
									+ "<td>"+board.board_hit+"</td>"
									+ "</tr>";
						$("#freeBoard_table tr:eq(0)").after(html);
					});
				}
				
			},
			error : function() {
				alert("통신에러가 발생했습니다.");
			}
		});
		
	} // getTimeSortList() 함수 end
	
	function getLookSortList() {
		
		$.ajax({
			type : "get",
			url : "board_look_list.do",
			data : {
				board_name : "${board_name }",
			    page : "${page }"
			},
			datatype : "json",
			success : function(response) {
				console.log(response);
				
				// 데이터가 있을 때만 테이블 생성
				if(response.list.length > 0) {
					
					// 기존 테이블 데이터 삭제
					$("#freeBoard_table tr:gt(0)").remove();
					
					// 동적으로 데이터 생성
					$.each(response.list, function(index, board) {
						var html = "<tr>"
									+ "<td>"+${totalEndNo }+"</td>"
									+ "<td>"+board.board_title+"</td>"
									+ "<td>"+board.user_nickname+"</td>"
									+ "<td>"+board.board_date.substring(0,10)+"</td>"
									+ "<td>"+board.board_hit+"</td>"
									+ "</tr>";
						$("#freeBoard_table tr:eq(0)").after(html);
					});
				}
				
			},
			error : function() {
				alert("통신에러가 발생했습니다.");
			}
		});
		
	} // getLookSortList() 함수 end
	
</script>
   		
   		<div id="freeBoard_table">
   		<%-- 자유게시판 테이블 --%>
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
							<a href="<%=request.getContextPath() %>/free_board_content.do?no=${dto.getBoard_no() }
																						  &page=${page }&id=${user_id }&nickname=${dto.getUser_nickname() }">
								[${dto.getBoard_category() }]&nbsp;${dto.getBoard_title() }
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
			   </form>
			   <br>
			</div>
		</div>
		
	
	<!-- Footer -->
	<footer id="footer">
		<div class="inner">
			<section>
				<h2>Get in touch</h2>
				<!-- form은 추후 삭제 또는 F&B 메시지 보내는 걸로 사용 -->
				<form method="post" action="#">
					<div class="fields">
						<div class="field half">
							<input type="text" name="name" id="name" placeholder="Name" />
						</div>
						<div class="field half">
							<input type="email" name="email" id="email" placeholder="Email" />
						</div>
						<div class="field">
							<textarea name="message" id="message" placeholder="Message"></textarea>
						</div>
					</div>
					<ul class="actions">
						<li><input type="submit" value="Send" class="primary" /></li>
					</ul>
				</form>
			</section>
			<section>
				<h2>Follow</h2>
				<ul class="icons">
					<li><a href="#" class="icon brands style2 fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="#" class="icon brands style2 fa-facebook-f"><span class="label">Facebook</span></a></li>
					<li><a href="#" class="icon brands style2 fa-instagram"><span class="label">Instagram</span></a></li>
					<li><a href="#" class="icon brands style2 fa-dribbble"><span class="label">Dribbble</span></a></li>
					<li><a href="#" class="icon brands style2 fa-github"><span class="label">GitHub</span></a></li>
					<li><a href="#" class="icon brands style2 fa-500px"><span class="label">500px</span></a></li>
					<li><a href="#" class="icon solid style2 fa-phone"><span class="label">Phone</span></a></li>
					<li><a href="#" class="icon solid style2 fa-envelope"><span class="label">Email</span></a></li>
				</ul>
			</section>
			<ul class="copyright">
				<li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
			</ul>
		</div>
	</footer>
	
	
	</div>
	
	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>