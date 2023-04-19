<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Phantom by HTML5 UP</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="./assets/css/main.css" />
<link rel="stylesheet" href="./assets/css/product.css" />
<noscript>
	<link rel="stylesheet" href="./assets/css/noscript.css" />
</noscript>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">

<jsp:include page="/include/main_top.jsp" />

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
								<c:forEach var="i" begin="0" end="${Count-1 }">
									<div class="col-md-4">
										<div class="product">
											<a href="product_detail.do?no=${dto[i].getSale_no() }">
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
