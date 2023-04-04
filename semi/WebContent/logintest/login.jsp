<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div align="center">
		<hr width="50%" color="maroon">
		<h3>로그인 페이지</h3>
		<hr width="50%" color="maroon">
	<br>
	   <form method="post" action="<%=request.getContextPath()%>/login_check.do">
		<table border="1" cellspacing="0" >
		<tr>
			<th>아이디</th>
			<td>
			<input type="text" name="userid"
			class="login" autofocus="autofocus"
			placeholder="ID">
			</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td>
			<input type="password" name="pwd" 
			class="login"
			placeholder="Password">
			</td>
		</tr>

			
		</table>
		<br>
	
		<input type="button" value="로그인" onclick="location.href='login.do'">
   </form>
		
	</div>


</body>
</html>