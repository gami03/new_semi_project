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
					<c:set var="dto" value="${UserInfo}" />
					
					<h4>${dto.getUser_nickname()} 님 회원정보</h4>
					<br>
					<div>
						<p>유저명 : ${dto.getUser_nickname() }</p>
						<p>이름 : ${dto.getUser_name() }</p>
						<p>아이디 : ${dto.getUser_id() }</p>
						<p>이메일 : ${dto.getUser_email() }</p>
						<p>연락처 : ${dto.getUser_phone() }</p>
						<p>주소 : ${dto.getUser_addr() }</p>
						<p>생일 : ${dto.getUser_birth() }</p>
						<p>소지금 : ${dto.getUser_money() }</p>
					</div>
					
				</header>
			</div>
		</div>

	<jsp:include page="../include/main_bottom.jsp" />

</body>
</html>