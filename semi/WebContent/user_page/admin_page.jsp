<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8" />
<script>
  
$(document).ready(function(){
	$("#approveModal${dto.getUser_no()} .submit_btn").click(function() {
		var approveValue = $("#userApprove-select option:selected").val();
		$("#approveValue${dto.getUser_no()}").val(approveValue);
		$("#approveForm${dto.getUser_no()}").submit();
	});
});

function submitModal(userNo) {
	  var selectedValue = document.getElementById("userApprove-select" + userNo).value;
	  document.getElementById("approveValue" + userNo).value = selectedValue;
	  document.getElementById("approveForm" + userNo).submit();
	}

  
</script>
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />

	<c:set var="userlist" value="${UserList }" />
	<c:set var="mypage" value="${mypage_id}" />
				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
							</header>
							<section>
								<h2 style="font-family: 'LINESeedKR-Bd';">${mypage} 관리자의 게시글 목록</h2>
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
										<h4 style="font-family: 'LINESeedKR-Bd';"><a href="<%=request.getContextPath() %>/user_board_all.do?id=${user_id }&searchId=${mypage }">작성 글 목록 전체보기 >> </a></h4>
									</div>
									
								</div>
								<h3 style="font-family: 'LINESeedKR-Bd';">회원 목록</h3>
								<br>
									<div class="table-wrapper"> 
										<table class="alt">
											<thead>
												<tr>
													<th>회원 닉네임</th>
													<th>회원 아이디</th>
													<th>회원명</th>
													<th>회원 등급</th>
													<th>회원 등급 변경</th>
												</tr>
											</thead>
												<tbody>
												<c:if test="${!empty userlist }">
													<c:forEach items="${userlist }" var="dto">
														
														<tr>
															<td>${dto.getUser_id() }</td>
															<td>${dto.getUser_nickname() }</td>
															<td>${dto.getUser_name() }</td>
															<td>${dto.getUser_approve() }</td>
															<td>
																<div class="row">
																	<a href="<%=request.getContextPath() %>/user_search_page.do?id=${user_id }&searchId=${dto.getUser_id() }&total=0">회원 글 목록</a>
																	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
																
																<a data-toggle="modal" data-target="#approveModal${dto.getUser_no() }" data-book-id="${dto.getUser_nickname() }">등급 변경</a>
																
																<form id="approveForm${dto.getUser_no() }" method="post" action="<%=request.getContextPath() %>/user_approve.do?id=${user_id}">
																	<input type="hidden" name="userNo" value="${dto.getUser_no()}">
																	<input type="hidden" name="userNickname" value="${dto.getUser_nickname()}">
																	<input type="hidden" name="approveValue" id="approveValue${dto.getUser_no() }" value="">			
																<!-- Modal -->
																<div class="modal fade" id="approveModal${dto.getUser_no() }" tabindex="-1" aria-labelledby="approveModalLabel" aria-hidden="true" style="z-index: 3000;">
																  <div class="modal-dialog">
																    <div class="modal-content">
																      <div class="modal-header">
																        <h5 class="modal-title" id="approveModalLabel">등업 신청</h5>
																        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
																          <span aria-hidden="true">&times;</span>
																        </button>
																      </div>
																      <div class="modal-body">
																      	<p>${dto.getUser_nickname() } 회원으로 부터의 등업 요청</p>
																	
																		<table border="1" cellspacing="0" width="400">
																			<tr>
																				<th>유저명</th>
																				<td>${dto.getUser_nickname() }</td>
																			</tr>
																		
																			<tr>
																				<th>등급</th>
																				<td>
																				<select name="selectedValue" id="userApprove-select${dto.getUser_no() }">
																				 <option value="">등급을 변경해주세요</option>
																				 <option value="0" ${Integer.parseInt(dto.getUser_approve()) == 0 ? 'selected' : ''}>일반 회원</option>
																				 <option value="1" ${Integer.parseInt(dto.getUser_approve()) == 1 ? 'selected' : ''}>판매자 신청 회원</option>
																				 <option value="2" ${Integer.parseInt(dto.getUser_approve()) == 2 ? 'selected' : ''}>판매자</option>
																				 <option value="3" ${Integer.parseInt(dto.getUser_approve()) == 2 ? 'selected' : ''}>관리자</option>
																				</select>
																				<input type="hidden" name="selectedValue" id="approveValue${dto.getUser_no() }" value="">
																																								
																					
																					<c:if test="${Integer.parseInt(dto.getUser_approve()) == 4 }">
																						<select name="userApprove" id="userApprove-select">
																					    	<option value="" >총 관리자 입니다.</option>
																						</select>
																					</c:if>
																				</td>
																			</tr>
																		
																		</table>
																		<br>
																		<div class="submitA" align="center">
																			<input class="submit_btn btn-primary" type="submit" value="변경" onclick="submitModal(${dto.getUser_no()})">
																		</div>
															
															
															      </div>
															    </div>
															  </div>
															</div>
														</form>
																
																	&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
																<a href="user_block.do?user_no=${dto.getUser_no() }&user_id=${user_id }">회원 차단</a>
																</div>
															</td>
														</tr>
	
												</c:forEach>
											</c:if>
											
											<c:if test="${empty userlist }">
												<tr>
													<td colspan="5" align="center">
														<h3>회원 게시물 리스트가 없습니다</h3>
													</td>
												</tr>
											</c:if>
											</tbody>
										</table>
										
										<%-- 페이징 처리 영역 --%>
										<div style="margin-left: 30%;">
										   <nav style ="float:left; width: 55%;">
										      <ul class="pagination">
											      <li class="page-item">
											         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=1">처음</a>
											      </li>
											      <li>
											      	<c:if test="${page > 1 }">
											         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${page-1 }">이전</a>
											        </c:if>
											        <c:if test="${page <= 1 }">
											         <a class="page-link">이전</a>
											        </c:if>
											      </li>
											      
											      <c:forEach begin="${startBlock }" end="${endBlock }" var="i">
											      <c:if test="${ i == page }">
											         <li class="page-item active" aria-current="page">
											         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${i }">${i }</a>
											         </li>   
											      </c:if>
											      
											      <c:if test="${ i != page }">
											         <li class="page-item">
											         <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${i }">${i }</a>
											         </li>   
											      </c:if>
											      </c:forEach>
											      
											      <c:if test="${endBlock < allPage }">
											         <li class="page-item">
											            <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${page+1 }">다음</a>
											         </li>   
											      </c:if>
											      
											      <c:if test="${page < allPage }">
											      <li class="page-item">
											            <a class="page-link" href="user_board_all.do?id=${user_id }&searchId=${mypage }&page=${allPage }">끝</a>
											      </li>
											      </c:if>
										      </ul>
										   </nav>
										</div>
									</div>
									
									<h2 style="font-family: 'LINESeedKR-Bd';">판매 승인 요청 게시글 목록</h2>
									<div class="table-wrapper"> 
										<table class="alt">
											<thead>
												<tr>
													<th>카테고리명</th>
													<th>닉네임</th>
													<th>제목</th>
													<th>작성 일자</th>
													<th>경매 기간</th>
													<th>승인</th>
													<th>거부</th>
												</tr>
											</thead>
											<tbody>
											<c:set var="salelist" value="${saleList }" />
											<c:if test="${!empty salelist && salelist.size() >= 5 }">
													<c:forEach var="i" begin="0" end="5">
														<tr>
															<td>${salelist[i].getUpload_category() }</td>
															<td>${salelist[i].getUser_nickname() }</td>
															<td><a href="product_detail.do?no=${salelist[i].getSale_no() }&user=${User_no}">${salelist[i].getSale_title() }</a></td>
															<td>${salelist[i].getSale_date().substring(0, 19) }</td>
															<td>${salelist[i].getAuction_period() }</td>
															<td style="text-align: center;"><button onclick="location.href='sale_product_approve_ok.do?sale_no=${salelist[i].getSale_no() }&user_id=${user_id }'">승인</button></td>
															<td style="text-align: center;"><button onclick="location.href='sale_product_approve_delete.do?sale_no=${salelist[i].getSale_no() }&user_id=${user_id }'">거부</button></td>
														</tr>
													</c:forEach>,
											</c:if>		
												<c:if test="${!empty salelist && salelist.size() < 5 }">
													<c:forEach items="${salelist }" var="dto">
														<tr>
															<td>${dto.getUpload_category() }</td>
															<td>${dto.getUser_nickname() }</td>
															<td><a href="product_detail.do?no=${dto.getSale_no() }&user=${User_no}">${dto.getSale_title() }</a></td>
															<td>${dto.getSale_date().substring(0, 19) }</td>
															<td>${dto.getAuction_period() }</td>
															<td style="text-align: center;"><button onclick="location.href='sale_product_approve_ok.do?sale_no=${dto.getSale_no() }&user_id=${user_id }'">승인</button></td>
															<td style="text-align: center;"><button onclick="location.href='sale_product_approve_delete.do?sale_no=${dto.getSale_no() }&user_id=${user_id }'">거부</button></td>
														</tr>
													</c:forEach>
												</c:if>
										
										
										<c:if test="${empty salelist }">
											<tr>
												<td colspan="7" align="center">
													<h3>판매 승인 요청 게시물이 없습니다</h3>
												</td>
											</tr>
										</c:if>
										</tbody>
									</table>
									
									<div align="right">
										<h4 style="font-family: 'LINESeedKR-Bd';"><a href="<%=request.getContextPath() %>/sale_approve_list.do?user_id=${user_id }">판매 승인 글 목록 전체보기 >> </a></h4>
									</div>
									
								</div>
							</section>
						</div>
					</div>
					
		<jsp:include page="../include/main_bottom.jsp" />
	</body>
</html>