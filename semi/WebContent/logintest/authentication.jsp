<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%
    // 0: 인증 가능 사용자 및 비밀번호 목록.
    int[] user_no = { 1, 2, 3 };
    String[] users = { "ninja", "knight", "elf" };
    String[] passwords = { "ak74", "m4", "pgs11" };
    // 1: form 으로부터 전달된 데이터를 변수에 저장.
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");
    // 2: 사용자 인증
    String redirectUrl = "loginform.jsp"; // 인증 실패시 재요청 될 url 
    for (int i = 0; i < users.length; i++) {
        if (users[i].equals(id) && passwords[i].equals(pw)) {
            session.setAttribute("signedUser", id); // 인증되었음 세션에 남김
            redirectUrl = "../index.jsp"; // 인증 성공 시 재요청 url
        }
    }
    response.sendRedirect(redirectUrl);
	%>

</body>
</html>