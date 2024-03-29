<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 슬라이드 부트스트랩 쓰기위한 cdn 불러오기 --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

   <link rel="stylesheet" href="assets/css/index.css" />
   <jsp:include page="/include/main_top.jsp" />
   
   
      <!-- Main -->
      	<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-interval="4000" data-bs-ride="carousel" style="margin-top: 120px;">
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <img src="./images/style_event_banner.png" class="d-block w-100" height="45%">
                  <div class="carousel-caption d-none d-md-block">
                  </div>
                </div>
                <div class="carousel-item">
                  <img src="./images/sale_event_banner.PNG" class="d-block w-100" height="45%">
                </div>
                <div class="carousel-item">
                  <img src="./images/kb_event_banner.PNG" class="d-block w-100" height="45%">
                </div>
                <div class="carousel-item carousel-fade">
                  <img src="./images/style_event_banner.png" class="d-block w-100" height="45%">
                  <div class="carousel-caption d-none d-md-block">
                  </div>
                </div>
              </div>
              <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="prev" style="box-shadow: none; height: 100%;">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade" data-bs-slide="next" style="box-shadow: none; height: 100%;">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>
      	
         <div id="main" style="padding-top: 0; padding-bottom: 0px;">

         <br>
         
         <div class="shortcut_items_wrap">
            <div class="shortcut_item">
               <div class="shortcut_item_img_wrap">
                  <img src="images/electronic_banner.png" class="shortcut_image" onclick="location.href='sale_search.do?keyword=전자기기'" style="background-color: antiquewhite;">
               </div>
               <br>
               <p style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">전자기기 추천</p>
            </div>
            <div class="shortcut_item">
               <div class="shortcut_item_img_wrap">
                  <img src="images/clothes_banner.png" class="shortcut_image" onclick="location.href='sale_search.do?keyword=의류'" style="background-color: antiquewhite;">
               </div>
               <br>
               <p style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">의류 추천</p>
            </div>
            <div class="shortcut_item">
               <div class="shortcut_item_img_wrap">
                  <img src="images/shoose.png" class="shortcut_image" onclick="location.href='sale_search.do?keyword=신발'" style="background-color: antiquewhite;">
               </div>
               <br>
               <p style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">신발 추천</p>
            </div>
            <div class="shortcut_item">
               <div class="shortcut_item_img_wrap">
                  <img src="images/watch.png" class="shortcut_image" onclick="location.href='sale_search.do?keyword=시계'" style="background-color: antiquewhite;">
               </div>
               <br>
               <p style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">시계 추천</p>
            </div>
            <div class="shortcut_item">
               <div class="shortcut_item_img_wrap">
                  <img src="images/gitar.png" class="shortcut_image" onclick="location.href='sale_search.do?keyword=기타'" style="background-color: antiquewhite;">
               </div>
               <br>
               <p style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">기타 추천</p>
            </div>
         </div>
         
         <div class="home_products" style="border-bottom: 1px solid #ebebeb">
            <div class="product_title">
               <div style="margin-bottom: 15px;">
                  <div class="div_title">
                     <p style="font-family: 'LINESeedKR-Bd'; font-size: 25px; margin-bottom: 0px;">Hot Auction</p>
                  </div>
                  <div class="sub_title">
                     	인기 경매
                  </div>
               </div>
            </div>
            <div class="product_list_wrap lg">
               <div class="product_list list_first horizontal_product_collection">
                  
                  <%-- ajax로 생성  --%>
                  <%-- <div class="product_item">
                     <a class="item_inner">
                        <div class="thumb_box">
                         <div class="product">
                            <img src="images/pic02.jpg" class="product_image" width="100%" height="auto">
                            <span aria-label="관심상품" class="btn_wish"><img src="./images/bookmark.png" width="26px" height="24px" onclick="wishListClick()"></span>
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
                  </div> class="product_item end" --%>
                  
                  <script src="assets/js/hitproduct.js"></script>
                  
               </div>
            </div>
         </div>
         
         <div class="home_products">
            <div class="product_title">
               <div style="margin-bottom: 15px;">
                  <div class="div_title">
                     <p style="font-family: 'LINESeedKR-Bd'; font-size: 25px; margin-bottom: 0px;">High Auction</p>
                  </div>
                  <div class="sub_title">
                     	최고가 경매
                  </div>
               </div>
            </div>
            <div class="product_list_wrap lg">
               <div class="product_list_high list_first horizontal_product_collection">
                  
                  <script src="assets/js/highproduct.js"></script>
                  
               </div>
            </div>
         </div>
         
      </div> <%-- main end --%>
         
         
         
         
   <jsp:include page="/include/main_bottom.jsp" />