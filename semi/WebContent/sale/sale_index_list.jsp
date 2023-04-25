<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="./assets/css/product.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<style type="text/css">

	.product_list_wrap {
		flex: 0 0 315px;
	}
	
	
	.shop_board_banner {
		padding-top: 213px;
		padding-bottom: 58px;
		margin-bottom: 50px;
	    display: flex;
	    justify-content: space-around;
	}
	
	.sale_top {
		display: flex;
    	justify-content: space-between;
	}
	
</style>

<jsp:include page="/include/main_top.jsp" />
		<!-- Main -->
		<div id="main" style="padding-top: 0;">
		
			<div class="shop_board_banner">
				<img src="./images/shop_title.png" style="width: 460px;">
			</div>
			  <div class="sale_top">
				<%-- 판매페이지 검색 폼 페이지 처리 영역 --%>
				<div>
				   <form method="post" action="<%=request.getContextPath() %>/sale_search.do?board_name=${board_name }" style="margin-left: 40px;">
				   		<select name="field" style="width:26%;">
				   			<option value="title">제목</option>
				   			<option value="cont">내용</option>
				   			<option value="title_cont">제목+내용</option>
				   			<option value="writer">작성자</option>
				   			<option value="category">카테고리</option>
				   		</select>
				   		
				   		<input type="text" name="keyword" style="width:54%;">&nbsp;&nbsp;
				   		<input type="submit" value="검색">
				   </form>
				   <br>
				</div>
				
				<div class="write" style="margin-right: 17px;">
					<%-- 글쓰기 폼 처리 -판매페이지 --%>
					<c:set var="id" value="${user_id }" />
					<c:if test="${!empty id }">
						<c:if test="${user_approve >= 2 }">
							<input type="button" name="write" value="글쓰기" onclick="location.href='sale_board_write.do'">
						</c:if>
					</c:if>
				</div>
			  </div>
			
			<div class="inner">
				<header></header>
				<section>
					<div class="container" style="padding: 0; margin: 0; max-width: 1280px;">
						<div class="row" style="padding:0; margin: 0;">
							<c:set var="user_no" value="${User_no }" />
							<c:set var="count" value="${Count }" />
							<c:set var="dto" value="${Index }" />
							<c:if test="${!empty count}">
								<c:forEach var="i" begin="0" end="${Count-1 }">
									<div class="product_list_wrap">
										<div class="product">
											<a href="product_detail.do?no=${dto[i].getSale_no() }&user=${User_no}">
												<div class="product-img">
													<img style="height: 300px"
														src="./images/${dto[i].getSale_file1() }" alt="" />
													<hr style="margin: 0px" width="black" color="100%">
													<div class="product-label">
														<span class="sale">-30%</span>
													</div>
												</div>
												<div class="product-body">
													<h3 class="product-name">${dto[i].getSale_title() }</h3>
												</div>
												<div class="product-btns"></div>
										</div>
										</a>
									</div>
								</c:forEach>
							</c:if>

			
						</div>
					</div>
				</section>
			</div>
		</div>

<jsp:include page="/include/main_bottom.jsp"/>
