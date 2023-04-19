<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 슬라이드 부트스트랩 쓰기위한 cdn 불러오기 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

	<jsp:include page="/include/main_top.jsp" />
	
	<link rel="stylesheet" href="assets/css/index.css" />
	
		<!-- Main -->
			<div id="main">
				<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" style="z-index: 500;">
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
				    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
				  </div>
				  <div class="carousel-inner">
				    <div class="carousel-item active">
				      <img src="./images/sale_event_banner.PNG" class="d-block w-100" alt="..." height="45%">
				      <div class="carousel-caption d-none d-md-block">
				      </div>
				    </div>
				    <div class="carousel-item">
				      <img src="./images/style_event_banner.png" class="d-block w-100" alt="..." height="45%">
				      <div class="carousel-caption d-none d-md-block">
				       <h3 style="letter-spacing: inherit;color: black;font-weight: bold;">garlicAction 스타일 컬렉터 1기 모집</h3>
        			   <p style="letter-spacing: inherit;color: black;font-weight: bold;">활동비 40만P & 베스트 8 선택권</p>
				      </div>
				    </div>
				    <div class="carousel-item">
				      <img src="./images/kb_event_banner.PNG" class="d-block w-100" alt="..." height="45%">
				      <div class="carousel-caption d-none d-md-block">
				      </div>
				    </div>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev" style=" box-shadow: none; height: 100%;">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next" style=" box-shadow: none; height: 100%;">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
			</div>
			<br>
			
			<div class="shortcut_items_wrap">
				<div class="shortcut_item">
					<div class="shortcut_item_img_wrap">
						<img src="images/pic10.jpg" class="shortcut_image">
					</div>
					<br>
					<p>남성 추천</p>
				</div>
				<div class="shortcut_item">
					<div class="shortcut_item_img_wrap">
						<img src="images/pic11.jpg" class="shortcut_image">
					</div>
					<br>
					<p>여성 추천</p>
				</div>
				<div class="shortcut_item">
					<div class="shortcut_item_img_wrap">
						<img src="images/pic12.jpg" class="shortcut_image">
					</div>
					<br>
					<p>남성 추천</p>
				</div>
				<div class="shortcut_item">
					<div class="shortcut_item_img_wrap">
						<img src="images/pic13.jpg" class="shortcut_image">
					</div>
					<br>
					<p>남성 추천</p>
				</div>
				<div class="shortcut_item">
					<div class="shortcut_item_img_wrap">
						<img src="images/pic14.jpg" class="shortcut_image">
					</div>
					<br>
					<p>남성 추천</p>
				</div>
			</div>
			<br><br><br>
			<div align="center">
				<hr width="60%" style="border:0; height:1px; background: #bbb;">
			</div>
			
			<div class="home_products">
				<div class="product_title">
					<div style="margin-bottom: 15px;">
						<div class="div_title">
							Hot Action
						</div>
						<div class="sub_title">
							인기 경매
						</div>
					</div>
				</div>
				<div class="product_list_wrap lg">
					<div class="product_list list_first horizontal_product_collection">
						<div class="product_item">
							<a class="item_inner">
								<div class="thumb_box">
								 <div class="product">
								 	<img src="images/pic02.jpg" class="product_image" width="100%" height="auto">
								 	<span aria-label="관심상품" class="btn_wish"><img src="./images/bookmark.png" width="26px" height="24px" onclick=""></span>
								 </div>
								</div>
								<div class="info_box">
									<div class="brand">
										<p class="brand-text"> 샤넬 </p>
									</div>
									<p class="name"> 샤넬 백 </p>
									<div class="price">
										<div class="amount">
											<em class="num">
												1,300,000원
											</em>
										</div>
										<div class="desc">
											<p>즉시 구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="product_item">
							<a class="item_inner">
								<div class="thumb_box">
								 <div class="product">
								 	<img src="images/pic04.jpg" class="product_image" width="100%" height="auto">
								 	<span aria-label="관심상품" class="btn_wish"><img src="./images/bookmark.png" width="26px" height="24px"></span>
								 </div>
								</div>
								<div class="info_box">
									<div class="brand">
										<p class="brand-text"> 샤넬 </p>
									</div>
									<p class="name"> 샤넬 백 </p>
									<div class="price">
										<div class="amount">
											<em class="num">
												1,300,000원
											</em>
										</div>
										<div class="desc">
											<p>즉시 구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="product_item">
							<a class="item_inner">
								<div class="thumb_box">
								 <div class="product">
								 	<img src="images/pic05.jpg" class="product_image" width="100%" height="auto">
								 	<span aria-label="관심상품" class="btn_wish"><img src="./images/bookmark.png" width="26px" height="24px"></span>
								 </div>
								</div>
								<div class="info_box">
									<div class="brand">
										<p class="brand-text"> 샤넬 </p>
									</div>
									<p class="name"> 샤넬 백 </p>
									<div class="price">
										<div class="amount">
											<em class="num">
												1,300,000원
											</em>
										</div>
										<div class="desc">
											<p>즉시 구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
						<div class="product_item">
							<a class="item_inner">
								<div class="thumb_box">
								 <div class="product">
								 	<img src="images/pic06.jpg" class="product_image" width="100%" height="auto">
								 	<span aria-label="관심상품" class="btn_wish"><img src="./images/bookmark.png" width="26px" height="24px"></span>
								 </div>
								</div>
								<div class="info_box">
									<div class="brand">
										<p class="brand-text"> 샤넬 </p>
									</div>
									<p class="name"> 샤넬 백 </p>
									<div class="price">
										<div class="amount">
											<em class="num">
												1,300,000원
											</em>
										</div>
										<div class="desc">
											<p>즉시 구매가</p>
										</div>
									</div>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
			
			
			
			
	<jsp:include page="/include/main_bottom.jsp" />
