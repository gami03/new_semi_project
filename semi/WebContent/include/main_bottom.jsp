<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<!-- Footer -->
			<div class="footer lg">
				<div class="inner">
					<div class="service_area">
					   <div class="customer_service">
							<strong class="service_title">
								고객센터
								<a href="tel:1588-0000" calss="service_tel" style="color: black; margin-left: 5px; font-size: 20px;">1588-0000</a>
							</strong>
							<div class="service_time">
								<dl class="time_box">
									<dt class="time_trrm" style="font-size: 14px;">
										운영시간 평일 11:00 - 18:00 (토∙일, 공휴일 휴무) 점심시간 평일 13:00 - 14:00
									</dt>
								</dl>
							</div>
							<p class="service_noti">1:1 문의하기는 게시판에서만 가능합니다.</p>
							<div class="service_btn_box">
								<input type="button" value="자주 묻는 질문" onclick="location.href='board_list.do?board_name=FAQ_board'" style="letter-spacing: 2px; font-size: 13px; height: 43px;">
							</div>
					   </div>
					   <div class="footer_menu">
						<div class="menu_box">
							<strong class="menu_title">이용안내</strong>
							<ul class="menu_list" style="padding-left: 0;">
								<li class="menu_item">
									<a href="#" class="menu_link">검수기준</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">이용정책</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">패널티 정책</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">커뮤니티 가이드라인</a>
								</li>
							</ul>
						  </div>
							<div class="menu_box" style="padding-left: 80px;">
							<strong class="menu_title">고객지원</strong>
							<ul class="menu_list" style="padding-left: 0;">
								<li class="menu_item">
									<a href="<%=request.getContextPath() %>/board_list.do?board_name=notice_board" class="menu_link">공지사항</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">서비스 소개</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">쇼룸 안내</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">판매자 방문접수</a>
								</li>
							</ul>
						 </div>
						</div>
					</div>
					
					<div class="corporation_area">
						<ul class="term_list" style="padding-left: 0;">
							<li class="term_item">
								<a target="_blank" class="term_link"> 회사소개 </a>
							</li>
							<li class="term_item">
								<a target="_blank" class="term_link"> 인재채용 </a>
							</li>
							<li class="term_item">
								<a target="_blank" class="term_link"> 제휴제안 </a>
							</li>
							<li class="term_item">
								<a target="_blank" class="term_link"> 이용약관 </a>
							</li>
							<li class="term_item privacy">
								<a target="_blank" class="term_link"><b>개인정보처리방침</b></a>
							</li>
						</ul>
						
						<div class="footer_sns">
							<div class="sns_box">
								<img class="sns" aria-label="인스타그램" src="">
								<img class="sns" aria-label="페이스북" src="">
								<img class="sns" aria-label="카카오톡" src="">
							</div>
						</div>
						
						<div class="business_info">
							<div class="info_list">
								<dl class="info_item">
									<dt class="business_title">
										갈릭옥션 주식회사 · 대표 홍길동
										<span class="blank"></span>
										사업자등록번호 : 000-00-00000
										<a href="#">사업자정보확인</a>
										<span class="blank"></span>
										통신판매업 : 제 2023-서울종로KH정보교육원
										<span class="blank"></span>
										사업장소재지 : 서울특별시 중구 남대문로 120 대일빌딩 2층, 3층
									</dt>
								</dl>
							</div>
						</div>
						
					</div>
					<br><br>
					
					<div class="notice_area">
						<p class="notice">
							갈릭옥션(주)은 통신판매 중개자로서 통신판매의 당사자가 아닙니다. 본 상품은 개별판매자가 등록한 상품으로 상품, 상품정보, 거래에 관한 의무와 책임은 각 판매자에게 있습니다. 단, 이용약관 및 정책, 기타 거래 체결 과정에서 고지하는 내용 등에 따라 검수하고 보증하는 내용에 대한 책임은 갈릭옥션(주)에 있습니다.
						</p>
						<p class="copyright">© garlicAction Corp.</p>
					</div>
					
				</div>
			</div>
			
			
		</div>

			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/slick.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>
			<script src="assets/js/Active.js"></script>

	</body>
</html>