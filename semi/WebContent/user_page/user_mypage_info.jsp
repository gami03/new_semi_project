<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="UTF-8" />
</head>
<body>

	<jsp:include page="../include/main_top.jsp" />

	<c:set var="userlist" value="${UserInfo }"></c:set>
		<!-- Main -->
		<div id="main">
			<div class="inner" style="margin-top: -78px;">
				<header></header>
				<section>
					<h3 style="font-family: 'LINESeedKR-Bd';">판매자 요청 회원 목록</h3>
					<br>
						<div class="table-wrapper" style="overflow: unset;"> 
							<table class="alt">
								<thead>
									<tr>
										<th>회원 아이디</th>
										<th>회원 닉네임</th>
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
												<td>${dto.getApprove_name()}</td>
												<td align="center">
													<div class="row">
														<a href="<%=request.getContextPath() %>/user_search_page.do?id=${user_id }&searchId=${dto.getUser_id() }"
																	style="margin-left: 25px; margin-right: 35px;">회원 글 목록</a>
														&nbsp;|&nbsp;
													
													<a data-toggle="modal" data-target="#approveModal${dto.getUser_no() }" data-book-id="${dto.getUser_nickname() }" style="margin-left: 5px;">등급 변경</a>
													
													<form id="approveForm${dto.getUser_no() }" method="post" action="<%=request.getContextPath() %>/user_approve.do?id=${dto.getUser_id()}">
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
													      	<p>${dto.getUser_nickname() } 회원의 등급 변경</p>
														
															<table border="1" cellspacing="0" width="400">
																<tr>
																	<th>유저명</th>
																	<td>${dto.getUser_nickname() }</td>
																</tr>
															
																<tr>
																	<th>등급</th>
																	<td>
																	<c:if test="${Integer.parseInt(dto.getUser_approve()) != 4 }">
																		<select name="selectedValue" id="userApprove-select${dto.getUser_no() }">
																			<option value="">등급을 변경해주세요</option>
																			<option value="0" ${Integer.parseInt(dto.getUser_approve()) == 0 ? 'selected' : ''}>일반 회원</option>
																			<option value="1" ${Integer.parseInt(dto.getUser_approve()) == 1 ? 'selected' : ''}>판매자 신청 회원</option>
																			<option value="2" ${Integer.parseInt(dto.getUser_approve()) == 2 ? 'selected' : ''}>판매자</option>
																			<option value="3" ${Integer.parseInt(dto.getUser_approve()) == 3 ? 'selected' : ''}>관리자</option>
																			<option value="5" ${Integer.parseInt(dto.getUser_approve()) == 5 ? 'selected' : ''}>차단 회원</option>
																		</select>
																		<input type="hidden" name="selectedValue" id="approveValue${dto.getUser_no() }" value="">
																	</c:if>																				
																		
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
						</div>
						<br>
				</section>
			</div>
		</div>

	<jsp:include page="../include/main_bottom.jsp" />

</body>
</html>