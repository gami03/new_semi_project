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

	<jsp:include page="/include/main_top.jsp" />
	
	<!-- Main -->
	<div align="center" id="main" style="padding-top: 0;">
	
		<div class="board_banner" style="border-bottom-color: darkcyan;">
			<p style="font-family: 'Cafe24Ssurround'; font-size: 37px;">관심상품</p>
		</div>
		
		<ul class="wish_list">
			<c:set var="list" value="${List }" />
			<c:forEach items="${list }" var="dto">
				<li>
					<div class="wish_item">
						<div class="wish_product">
							<div class="product_box">
								<a href="<%=request.getContextPath() %>/product_detail.do?no=${dto.getSale_no() }&user=${dto.getUser_no()}">
									<img src="./images/${dto.getSale_file1() }" height="170px" width="170px;">
								</a>
							</div>
							
							<div class="product_detail">
								<div>
									<a href="<%=request.getContextPath() %>/product_detail.do?no=${dto.getSale_no() }&user=${dto.getUser_no()}" class="wish_product_title">${dto.getSale_title() }</a>
								</div>
								<p class="wish_product_content">${dto.getSale_content() }</p>
							</div>
						</div>
						
						<div class="wish_buy">
							<div class="division_btn_box md">
								<a class="btn_division buy">
								<button type="button" style="background-color: #EF6253; color: white; display: flex; height: 100px; align-items: center; padding-left: 14px; border-radius: 25px;">
									<div class="price">
										<span class="amount">
											<span class="won">${dto.getSale_end_price() } 원</span>
										</span>
										<span class="desc">즉시 입찰가</span>
									</div>
								</button>
								</a>
							</div>
							
							<a href="<%=request.getContextPath() %>/wishlist.delete.do?sale_no=${dto.getSale_no() }&user_no=${User_no }" class="status_link">삭제</a>
						</div>
						
					</div>
				</li>
			</c:forEach>
		</ul>
	
	</div>
	
	<jsp:include page="/include/main_bottom.jsp" />

</body>
</html>