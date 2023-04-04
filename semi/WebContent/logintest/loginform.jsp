<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="authentication.jsp" method="post">
		<label>NO: </label>
		<input type="text" name="user_no"><br>
        <label>ID: </label>
        <input name="id" type="text"><br>
        <label>PW: </label>
        <input name="pw" type="password"><br>
        <input type="submit" value="로그인">
        
        <h3>
			<% if(session.getAttribute("id") != null) {
				%>
				<a href="<%=request.getContextPath() %>/free_board_list.do">[자유게시판]</a>
			<% } %>
		</h3>
    </form>

</body>
</html>