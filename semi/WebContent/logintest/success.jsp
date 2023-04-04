<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%  // 인증된 세션이 없는경우, 해당페이지를 볼 수 없게 함.
    if (session.getAttribute("signedUser") == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1><%= session.getAttribute("signedUser") %>님 <small>반갑습니다.</small></h1>
	
	<h3>
	<% if(session.getAttribute("signedUser") != null) {
		%>
		<a href="<%=request.getContextPath() %>/board/board_list.jsp">[자유게시판]</a>
	<% }else {
		%>
		<h2>권한이 없습니다.</h2>
	<% } %>
	</h3>
	
        <a href="logout.jsp">로그아웃</a>

</body>
</html>