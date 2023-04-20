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

		<!-- Main -->
		<div id="main">
			<div class="inner">
				<header>
					<c:set var="nickname" value="${user_nickname}" />
					<c:set var="mypage" value="${mypage_id}" />
					
					<h2>${nickname} 님</h2>
					
					
					
				</header>
			</div>
		</div>

	<jsp:include page="../include/main_bottom.jsp" />

</body>
</html>