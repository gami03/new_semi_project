<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<head>
	<title>Phantom by HTML5 UP</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="assets/css/main.css" />
	<link rel="stylesheet" href="assets/css/product.css" />
	<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
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
								<ul>
									<li><input type="button" name="login" value="로그인"></li>
									<li><a href="#menu">Menu</a></li>
								</ul>
							</nav>

					</div>
				</header>

			<!-- Menu -->
				<nav id="menu">
					<h2>Menu</h2>
					<ul>
						<li><a href="index.html">Home</a></li>
						<li><a href="">자유게시판</a></li>
						<li><a href="">판매게시판</a></li>
						<li><a href="">Q&A</a></li>
						<li><a href="">마이페이지</a></li>
					</ul>
				</nav>

			<!-- Main -->
				<div id="main">
					<div class="inner">
						<header></header>
						<section>
							<div class="container">
								<div class="row">
									<c:set var="count" value="${Count }" />
									<c:set var="dto" value="${Index }" />
									<c:if test="${!empty count}">
										<c:forEach var="i" begin="0" end="${Count-1 }" >
											<div class="col-md-4">
												<div class="product">
													<div class="product-img">
														<img src="images/pic14.jpg" alt="" />
														<div class="product-label">
															<span class="sale">-30%</span>
														</div>
													</div>
													<div class="product-body"><h3 class="product-name"><a href="#">${dto[i].getSale_title() }</a></h3></div>
													<div class="product-btns"></div>
												</div>
											</div>
										</c:forEach>
									</c:if>
									
									<div class="col-md-4">
										<div class="product">
											<div class="product-img"><span class="image fit"><img src="images/pic07.jpg" alt="" /></span></div>
											<div class="product-body"><h3 class="product-name"><a href="#">product name goes here</a></h3></div>
											<div class="product-btns"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="product">
											<div class="product-img"><span class="image fit"><img src="images/pic14.jpg" alt="" /></span></div>
											<div class="product-body"><h3 class="product-name"><a href="#">product name goes here</a></h3></div>
											<div class="product-btns"></div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="product">
											<div class="product-img"><span class="image fit"><img src="images/pic14.jpg" alt="" /></span></div>
											<div class="product-body"><h3 class="product-name"><a href="#">product name goes here</a></h3></div>
											<div class="product-btns"></div>
										</div>
									</div>
								</div>
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
		
	<!-- bootstrap js -->
   		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	</body>
</html>