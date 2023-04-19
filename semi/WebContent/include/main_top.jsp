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

	body {
		overflow-x: hidden;
	}

	#wrapper {
		margin: auto;
	}

	#nav_form {
	}

	#header {
    padding: 0;
    background-color: white;
    height: 8em;
    margin-bottom: 8em;
    position: fixed;
    }
    
	#wrapper > * > .inner {
    width: 60%;
    max-width: 90em;
    margin: 0 auto;
	padding: 0;
	}
	
	#top_inner {
    display: flex;
    padding: 3px 19% 30px;
    height: 22px;
    justify-content: flex-end
	}

	#top_inner a{
		font-size: 13px;
		color: gray;
		margin-left: 35px;
	}
    
	#header nav {
		padding-top: 10px;
		right: 0;
		top: 0;
		border-bottom: 2px solid orange;
		background-color: white;
	}
	
	#topnav {
		width: 100% !important;
		margin: auto;
	}
	
	input[type="button"].btn {
		box-shadow: revert;
	}
	
    
	
	#nav ul {
		justify-content: space-around; 
		background-color: #fda6a5;
		height: 70px;
	}
	
	#footer {
		margin-left: calc(-50vw + 50%);
		width: 100vw;
	
	}
	
	#navdiv {
		width: 60%;
	}
	
	#header .logo {
		margin-left: 20%;
	}
	
	#header .logo .logotitle img {
    display: block;
    width: 15em;
    height: auto;
	}
	
	.topbutton {
		box-shadow: none;
	}
	
	.topbyttondiv {
	float: right;
	clear: both;
	}
	
	#header nav ul {
		justify-content: flex-end;
		margin-right: 75%;
	}
	
	#main {
		padding-top: 15em;
	}
	
	.modal-header .close {
    	box-shadow: none;
	}
	
</style>
	</head>
	<body class="is-preload">
	<form id="nav_form" method="post" name="f"  action="<%=request.getContextPath()%>/login_check.do" onsubmit="return check()" align="center">
	<c:set var="id" value="${user_id }" />
	<c:set var="user_approve" value="${user_approve }" />
	<c:if test="${empty id }">
		<!-- Modal -->
		<div class="modal fade" id="boardModal" tabindex="-1" aria-labelledby="boardModalLabel" aria-hidden="true" style="z-index: 3000;">
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
	
	</form>
		<!-- Wrapper -->
			<div id="wrapper">
				<!-- Header -->
					<header id="header" style=" z-index: 2000;">
					
						<div class="inner">

							<!-- Nav -->
							<div id="navdiv">
								<nav id="topnav"style=" z-index: 1050;">
								<div id="top_inner">
									<a href="<%=request.getContextPath() %>/board_list.do?board_name=FAQ_board">고객센터</a>
									<a>관심상품</a>
									<c:if test="${empty id }">
										<a data-toggle="modal" data-target="#boardModal">로그인</a>
									</c:if>
									<c:if test="${!empty id }">
										<a href="logintest/logout.jsp">로그아웃</a>
									</c:if>
									
								
							</div>
								<div class="topimage">
								<!-- Logo -->
								<a href="index.jsp" class="logo">
									<span class="logotitle"><img src="./images/galicaction_logotitle.png" /></span>
								</a>
								<c:if test="${empty user_id }">
								<div class="topbyttondiv" style="margin-right: 4.2%;">
									<ul>
											<li><button class="topbutton" name="home" onclick="location.href='index.jsp'">HOME</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><a href="#menu">Menu</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${!empty user_id and user_approve <= 1 }">
								<div class="topbyttondiv" style="margin-right: 1.2%;">
									<ul>
											<li><button class="topbutton" name="home" onclick="location.href='index.jsp'">HOME</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><button class="topbutton" name="MY" onclick="location.href='admin_page.do?id=${user_id }'">MY</button></li>
											<li><a href="#menu">Menu</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${!empty user_id and user_approve > 1 }">
								<div class="topbyttondiv" style="margin-right: -0.5%;">
									<ul>
											<li><button class="topbutton" name="home" onclick="location.href='index.jsp'">HOME</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><button class="topbutton" name="ADMIN" onclick="location.href='admin_page.do?id=${user_id }'">ADMIN</button></li>
											<li><a href="#menu">Menu</a></li>
									</ul>
								</div>
								</c:if>
								</div>
									
							</nav>
							</div>
						</div>
					

				<!-- Menu -->
					<nav id="menu">
						<h2>Menu</h2>
						<ul>
							<li><a href="index.jsp">Home</a></li>
							<li><a href="<%=request.getContextPath() %>/sale_index_list.do">판매게시판</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=free_board">자유게시판</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=notice_board">공지사항</a></li>
							<li><a href="<%=request.getContextPath() %>/board_list.do?board_name=FAQ_board">고객지원</a></li>
							<c:if test="${user_approve == 1 }">
							<li><a href="<%=request.getContextPath() %>/user_mypage.do?id=${user_id }">마이페이지</a></li>							
							</c:if>					
							<c:if test="${user_approve > 1 }">
							<li><a href="<%=request.getContextPath() %>/admin_page.do?id=${user_id }">관리자 페이지</a></li>
							</c:if>
						</ul>
					</nav>
					
					</header>
					
