<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML>
<!--
	Phantom by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Phantom by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="assets/css/main.css" />
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
									<c:set var="appr" value="${user_approve }" />
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
							<li><a href="index.html">Home</a></li>
							<li><a href="<%=request.getContextPath() %>/free_board_list.do">자유게시판</a></li>
							<li><a href="<%=request.getContextPath() %>/sale_index_list.do">판매게시판</a></li>
							<li><a href="">Q&A</a></li>
							<c:if test="${appr == 1 }">
							<li><a href="">마이페이지</a></li>							
							</c:if>					
							<c:if test="${appr > 1 }">
							<li><a href="">관리자 페이지</a></li>
							</c:if>
						</ul>
					</nav>

				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
								<h1>This is Phantom, a free, fully responsive site<br />
								template designed by <a href="http://html5up.net">HTML5 UP</a>.</h1>
								<p>Etiam quis viverra lorem, in semper lorem. Sed nisl arcu euismod sit amet nisi euismod sed cursus arcu elementum ipsum arcu vivamus quis venenatis orci lorem ipsum et magna feugiat veroeros aliquam. Lorem ipsum dolor sit amet nullam dolore.</p>
							</header>
							<section>
								<c:set var="nickname" value="${user_nickname}" />
								<c:set var="mypage" value="${mypage_id}" />
									<h2>${nickname} 회원의 게시글 목록</h2>
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
												<tbody>
												<c:set var="list" value="${BoardList }" />
												<c:if test="${!empty list }">
													<c:forEach var="i" begin="0" end="5">
														
														<tr>
															<td>${list[i].getBoard_name() }</td>
															<td>${list[i].getBoard_category() }</td>
															<td>${list[i].getBoard_title() }</td>
															<td>${list[i].getBoard_hit() }</td>
															
															<c:if test="${empty list[i].getBoard_update() }">
																<td> ${list[i].getBoard_date().substring(0, 10) }</td>
															</c:if>
						
															<c:if test="${!empty list[i].getBoard_update() }">
																<td> ${list[i].getBoard_update().substring(0, 10) }</td>
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
										
										<div align="right">
											<h4><a href="<%=request.getContextPath() %>/user_board_all.do?id=${user_id }&searchId=${mypage }">작성 글 목록 전체보기 >> </a></h4>										</div>
										
									</div>
									
									<hr>
									
								<h2>구매/판매 목록</h2>
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
													<c:forEach items="${list }" var="dto">
														
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
									
							</section>
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