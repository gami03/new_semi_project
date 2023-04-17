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
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
		
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

<style type="text/css">

	#nav_form {
    float: right;
}

	#header nav {
		width: 90%;
	}

</style>
	</head>
	<body class="is-preload">
		<!-- Wrapper -->
			<div id="wrapper">
	
				<!-- Header -->
					<header id="header">
						<div class="inner">


							<!-- Nav -->
								<nav>
								
								<!-- Logo -->
								<a href="index.jsp" class="logo">
									<span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">Phantom</span>
								</a>
								
									<form id="nav_form" method="post" name="f"  action="<%=request.getContextPath()%>/login_check.do" onsubmit="return check()" align="center">
										
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
							<li><a href="<%=request.getContextPath() %>/sale_index_list.do">판매게시판</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=free_board">자유게시판</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=notice_board">공지사항</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=FAQ_board">고객지원</a></li>
							<li><a href="">마이페이지</a></li>
						</ul>
					</nav>