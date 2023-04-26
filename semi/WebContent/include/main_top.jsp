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
		<title>garlicAuction</title>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		<script src="js/find.js"></script>
		<script src="js/join.js"></script>
		<script src="js/user.js"></script>
		<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.1.0/kakao.min.js"
  integrity="sha384-dpu02ieKC6NUeKFoGMOKz6102CLEWi9+5RQjWSV0ikYSFFd8M3Wp2reIcquJOemx" crossorigin="anonymous"></script>
<script>
  Kakao.init('c089c8172def97eb00c07217cae17495'); // 사용하려는 앱의 JavaScript 키 입력
</script>
		<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'https://developers.kakao.com/tool/demo/oauth',
    });
  }

  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>
		<script type="text/javascript">

			var user_no = "${User_no}";

		</script>
		
		<script type="text/javascript">

		function openModal() {
			var modal = document.getElementById("signup-modal"); // 회원가입 모달창의 id를 가진 엘리먼트를 가져옴
			modal.style.display = "block"; // 모달창을 보이도록 스타일 변경
		}
		$(function() {
			$("#id_find_email").keydown(function(event) {
				if (event.keyCode === 13) {
					event.preventDefault();
					$("#find_id_btn").click();
				}
			});
		});
		
		
		</script>

<style type="text/css">

	.search_card_ranking li {
		font-family: 'LINESeedKR-Bd';
	}
	
	.title_sub_text span {
		font-family: 'LINESeedKR-Bd';
		font-size: 15px;
	}
	
	input.submit_btn.btn-primary:hover {
	  background-color: white;
	}
	
	input.btn.btn-primary:hover {
		background-color: white;
	}
	
	.btn-primary:focus {
		background-color: white;
		color: #585858;
		border-color: #585858;
	    box-shadow: 0 0 0 2px #585858;
	    height: 47px;
	}
	

</style>

	<link rel="stylesheet" href="assets/css/maintop.css" />

	</head>
	<body class="is-preload">
	<form id="nav_form" method="post" name="f"  action="<%=request.getContextPath()%>/login_check.do" onsubmit="return login_check();" align="center">
	<c:set var="id" value="${user_id }" />
	<c:set var="user_approve" value="${user_approve }" />
	<c:if test="${empty id }">
		<!-- Modal -->
			<div class="modal fade" id="boardModal" tabindex="-1" aria-labelledby="boardModalLabel" aria-hidden="true" style="z-index: 3000">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="boardModalLabel">로그인</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<table border="1" cellspacing="0" width="400">
								<tr>
									<th style="font-size: 18px;">아이디</th>
									<td> <input type="text" name="login_id" id="login_id"></td>
								</tr>
								<tr>
									<th style="font-size: 18px;">비밀번호</th>
									<td> <input type="password" name="login_pwd" id="login_pwd"></td>
								</tr>
							</table>
						<!-- 	<a id="kakao-login-btn" href="javascript:void(0);" onclick="loginWithKakao()">
							  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
							    alt="카카오 로그인 버튼" />
							</a>  -->
							<div class="submit1" align="center">
								<input class="submit_btn btn-primary" type="submit" value="로그인">
								<input class="submit_btn btn-primary" type="button" value="회원가입" data-toggle="modal" data-target="#signupModal">
								<br>
						     <div style="margin-top: 12px;">
	           					 <a href="#" data-toggle="modal" data-target="#findIdModal" data-dismiss="modal" style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">아이디 찾기</a> / 
								 <a href="#" data-toggle="modal" data-target="#findPwdModal" data-dismiss="modal" style="font-family: 'LINESeedKR-Bd'; font-size: 18px;">비밀번호 재설정</a>
							 </div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</c:if>
	
	</form>
		<!-- 회원가입 Modal -->
	<form action="<%=request.getContextPath() %>/join_ok.do" method="POST" name = "j" onsubmit="return join_check()" >	
	<div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true" style="z-index: 4000;">
	
	  <div class="modal-dialog">
	    <div class="modal-content" style="width: 600px;">
	      <div class="modal-header">
	        <h5 class="modal-title" id="signupModalLabel">회원가입</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">		
        	<input type="hidden" name="user_no">
          <div class="form-group">
            <label for="userid">아이디</label>
            <input type="text" class="form-control" id="user_id" name="user_id" placeholder="영문+숫자 16자리">
            <span id="idcheck"></span>
          </div>
          <div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" class="form-control" id="password" name="user_password" placeholder="영문+숫자 조합 16자리">
            <span id="pwdcheck"></span>
          </div>
          <div class="form-group">
            <label for="confirm_password">비밀번호 확인</label>
            <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="비밀번호를 똑같이 입력해주세요." >
            <span id="confirm_pwdcheck"></span>
          </div>
          <div class="form-group">
            <label for="name">이름</label>
            <input type="text" class="form-control" id="user_name" name="user_name" placeholder="이름을 입력해주세요.">
          </div>
          <div class="form-group">
            <label for="nickname">닉네임</label>
            <input type="text" class="form-control" id="user_nickname" name="user_nickname" placeholder="닉네임을 입력해주세요.">
             <span id="nickcheck"></span>
          </div>
          <div class="form-group">
            <label for="user_phone">연락처</label>
            <input type="text" class="form-control" id="user_phone" name="user_phone" placeholder=" - 없이 입력">
             <span id="phonecheck"></span>
          </div>
          <div class="form-group">
            <label for="user_birth">생년월일</label>
            <input type="text" class="form-control" id="user_birth" name="user_birth" placeholder="yyyymmdd">
          </div>
          
          
          <div class="form-group">
           <label for="user_addr">주소</label>
			<input type="text" class="user_addr" id="sample4_postcode" name="postcode" placeholder="우편번호" style="font-size: 16px; ">
			<input type="button"class="user_addr" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" style="font-size: 0.9em; letter-spacing: 2px; margin-top: 10px;"><br>
			
			<input type="text" class="user_addr" id="sample4_roadAddress" name="road_address" placeholder="도로명주소" style="font-size: 0.9em;">
			<input type="text" class="user_addr" id="sample4_jibunAddress" name="jibun_address" placeholder="지번주소" style="font-size: 0.9em;">
			<span id="guide" style="color:#999;display:none"></span>
			<input type="text" class="user_addr" id="sample4_detailAddress" name="detail_address" placeholder="상세주소" style="font-size: 0.9em;">
			<input type="text" class="user_addr" id="sample4_extraAddress" name="extra_address" placeholder="참고항목" style="font-size: 0.9em;">
					
			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			    function sample4_execDaumPostcode() {
			        new daum.Postcode({
			            oncomplete: function(data) {
			                var roadAddr = data.roadAddress; // 도로명 주소 변수
			                var extraRoadAddr = ''; // 참고 항목 변수
			
			                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
			                    extraRoadAddr += data.bname;
			                }
			                if(data.buildingName !== '' && data.apartment === 'Y'){
			                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			                }
			                if(extraRoadAddr !== ''){
			                    extraRoadAddr = ' (' + extraRoadAddr + ')';
			                }
			
			                document.getElementById('sample4_postcode').value = data.zonecode;
			                document.getElementById("sample4_roadAddress").value = roadAddr;
			                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
			                
			                if(roadAddr !== ''){
			                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
			                } else {
			                    document.getElementById("sample4_extraAddress").value = '';
			                }
			
			                var guideTextBox = document.getElementById("guide");
			                if(data.autoRoadAddress) {
			                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
			                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
			                    guideTextBox.style.display = 'block';
			
			                
			                } else {
			                    guideTextBox.innerHTML = '';
			                    guideTextBox.style.display = 'none';
			                }
			            }
			        }).open();
			    }
			</script>
			
          
          
          <div class="form-group" style="margin-top: 20px;">
            <label for="user_email">이메일</label>
            <input type="email" class="form-control" id="user_email" name="user_email" placeholder="example@example.com">
            <span id="emailcheck"></span>
            
          </div>
        
        <div class="modal-footer">
          <div>
          	<input type="submit" value="회원가입" class="btn btn-primary" >
          	<input type="reset" value="취소" class="btn btn-primary"  data-dismiss="modal">
          </div>
          </div>
          </div>
          </div>
          </div>
          </div>
      </div>
      </form>
	<!--  회원가입 폼 end -->
	
	<!-- 아이디 찾기 폼 -->

	<div class="modal fade" id="findIdModal" tabindex="-1" role="dialog"
		aria-labelledby="findIdModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="findIdModalLabel">아이디 찾기</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
						<div class="form-group">
							<label for="id_find_email">이메일</label> <input type="email"
								class="form-control" id="id_find_email" name="id_find_email"
								required>
						</div>
						<button style="background: white; border: none; color: #6c757d;" type="button" id="find_id_btn" class="btn btn-primary"
							data-toggle="modal" data-target="#IdModal" data-dismiss="modal">아이디 찾기</button>
					
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="IdModal" tabindex="-1" role="dialog"
		aria-labelledby="findIdModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="findIdModalLabel">아이디 찾기 결과</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<span id="foundId"></span>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 비밀번호 재설정 모달 -->
	<div class="modal fade" id="findPwdModal" tabindex="-1" role="dialog"
		aria-labelledby="resetPwdModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="resetPwdModalLabel">비밀번호 재설정</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<form id="reset_pwd_form">
					<div class="modal-body">
						<div class="form-group">
							<label for="reset_pwd_id">아이디</label> <input type="text"
								class="form-control" id="reset_pwd_id" required>
						</div>
						<div class="form-group">
							<label for="reset_pwd_name">이름</label> <input type="text"
								class="form-control" id="reset_pwd_name" required>
						</div>
						<div class="form-group">
							<label for="reset_pwd_email">이메일</label> <input type="email"
								class="form-control" id="reset_pwd_email" required>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" style="border: none; background-color: white; color: #6c757d;" class="btn btn-primary" id="reset_pwd_btn">비밀번호
							재발급</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	
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
									<c:if test="${empty id }">
										<a data-toggle="modal" data-target="#boardModal">관심상품</a>
										<a data-toggle="modal" data-target="#boardModal">로그인</a>
									</c:if>
									<c:if test="${!empty id }">
										<a href="<%=request.getContextPath() %>/wish_list.do?user_no=${User_no}">관심상품</a>
										<a href="logintest/logout.jsp">로그아웃</a>
									</c:if>
									
								
							</div>
								<div class="topimage">
								<!-- Logo -->
								<a href="index.jsp" class="logo" style="margin: 0;">
									<span class="logotitle"><img src="./images/galicaction_logotitle.png" /></span>
								</a>
								<c:if test="${empty user_id }">
								<div class="topbyttondiv">
									<ul>
											<li><button class="topbutton" name="NOTICE" onclick="location.href='board_list.do?board_name=notice_board'">NOTICE</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><a href="#menu">search</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${!empty user_id and user_approve <= 2 }">
								<div class="topbyttondiv">
									<ul>
											<li><button class="topbutton" name="NOTICE" onclick="location.href='board_list.do?board_name=notice_board'">NOTICE</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><button class="topbutton" name="MY" onclick="location.href='user_mypage.do?id=${user_id }&searchId=${user_id }'">MY</button></li>
											<li><a href="#menu">search</a></li>
									</ul>
								</div>
								</c:if>
								<c:if test="${!empty user_id and user_approve > 2 }">
								<div class="topbyttondiv">
									<ul>
											<li><button class="topbutton" name="NOTICE" onclick="location.href='board_list.do?board_name=notice_board'">NOTICE</button></li>
											<li><button class="topbutton" name="FREE" onclick="location.href='board_list.do?board_name=free_board'">FREE</button></li>
											<li><button class="topbutton" name="SHOP" onclick="location.href='sale_index_list.do'">SHOP</button></li>
											<li><button class="topbutton" name="ADMIN" onclick="location.href='admin_page.do?id=${user_id }'">ADMIN</button></li>
											<li><a href="#menu">search</a></li>
									</ul>
								</div>
								</c:if>
								</div>
									
							</nav>
							</div>
						</div>
					

				<!-- Menu -->
					<nav id="menu" style="width: 450px; background-color: white;">
					<br><br>
						<h2 align="center" style="color: black; font-family: 'LINESeedKR-Bd';">Search</h2>
						<%-- 검색 폼 페이지 처리 영역 --%>
						<div align="left">
						   <form method="post" action="<%=request.getContextPath() %>/board_search.do?board_name=${board_name }">
						   	 <div class="search" style="border-bottom: 3px solid black;">
						   		<input type="text" name="keyword" placeholder="브랜드명, 모델명, 모델번호 등" class="input_search" style="width:90%; color: black; border-bottom: none; text-decoration: none; font-family: 'LINESeedKR-Bd';" onfocus="this.style.boxShadow = 'none';">
						   		<button class="btn_search_delete" type="reset">
								  x
								</button>
						   	 </div>
						   </form>
						   <br>
						</div>
						
						<%-- 최근 검색어 (로그인 했을 때만) --%>
						<c:if test="${!empty user_id }">
						
							<div class="recent_search">
								<div class="recent_search_wrap" style="margin-bottom: 12px;">
									<span class="title" style="color: black;">최근 검색어</span>
									<div class="recent_search_inner">
										
									</div>
								</div>
							</div>
						</c:if>
						
		
	<script src="assets/js/recentSearchList.js"></script>
						
						<%-- 추천 검색어 --%>
						<div class="rec_search">
							<div style="margin-bottom: 12px;">
								<span class="title" style="color: black; font-family: 'LINESeedKR-Bd';">추천 검색어</span>
							</div>
							<div class="rec_search_inner">
								<div class="rec_search_item">
									<button class="rec_search_text">나이키</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">갈릭옥션</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">에어팟</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">반팔</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">샌들</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">샤넬</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">조던</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">스투시</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">가젤</button>
								</div>
								<div class="rec_search_item">
									<button class="rec_search_text">리퍼비시</button>
								</div>
							</div>
						</div>
						
						<br>
						
						<%-- 인기 검색어 --%>
						<div class="hit_search">
							<div class="ranking">
								<div class="search_title_wrap">
									<span class="title" style="color: black; font-family: 'LINESeedKR-Bd';">실시간 인기 검색어</span>
									<div class="title_sub_text">
										<span style="color: black;"></span>
									</div>
								</div>
								<div class="search_item_content_wrap">
									<div class="search_card">
										<ol class="search_card_ranking" style="padding-left: 5;">
										</ol>
									</div>
								</div>
							</div>
							
						</div>
						
<script type="text/javascript">

	$(function() {
		
	    // ajax에서 동일하게 사용되는 속성 설정
	    $.ajaxSetup({
	        ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
	    });
	    
	    // 초기 리스트 출력
	    searchHitList();
	    
	});
	
	
	// 실시간 인기 검색어 불러오는 ajax
	function searchHitList() {
	    $.ajax({
	        type: "get",
	        url: "user_search_hit_list.do",
	        data: {},
	        datatype: "json",
	        success: function(response) {
	            console.log("실시간 인기검색어 top10 >>>"+response);
	            var $searchCardList = $("<ol>").addClass("search_card_ranking").css("padding-left", "5px");
	
	            $.each(response.searchList, function(index, item) {
	                var $cardItem = $("<li>").addClass("search_card_ranking_item");
	                var $rankingIdx = $("<span>").addClass("ranking_idx").text(index+1);
	                var $rankingTitle = $("<span>").addClass("ranking_title").text(item.keyword);
	                var $link = $("<a>").append($rankingTitle);
	                $cardItem.append($rankingIdx).append($link);
	                $searchCardList.append($cardItem);
	            });
	
	            // "시간" 부분 수정
	            var currentTime = new Date();
	            var currentMonth = (currentTime.getMonth() + 1).toString().padStart(2, '0');
	            var currentDay = currentTime.getDate().toString().padStart(2, '0');
	            var currentHour = currentTime.getHours().toString().padStart(2, '0');
	            var currentMinute = currentTime.getMinutes().toString().padStart(2, '0');
	            var currentTimeStr = currentMonth + "." + currentDay + " " + currentHour + ":" + currentMinute;
	            $(".title_sub_text span").text(currentTimeStr + " 기준");
	
	            // 애니메이션 적용
	            $('.search_card').slideUp(800, function() {
	                $(".search_card_ranking").replaceWith($searchCardList);
	                $('.search_card').slideDown(800);
	            });
	        },
	        error: function() {
	            alert("searchHitList() 통신 에러가 발생했습니다.");
	        }
	    });
	}
	
	// 5초 간격으로 updateData 함수를 실행하는 코드
	setInterval(searchHitList, 3600000);


</script>
						
					</nav>
					
					</header>
					
