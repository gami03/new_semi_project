package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class ModifyPwdAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 // 현재 로그인된 회원 아이디 가져오기
	    HttpSession session = request.getSession();
	    String userId = (String) session.getAttribute("user_id");

	    // 파라미터에서 입력한 현재 비밀번호, 새로운 비밀번호 값 
	    String currentPwd = request.getParameter("current_password").trim();
	    String newPwd = request.getParameter("new_password").trim();
	    
	    System.out.println("currentPwd"+currentPwd);
	    System.out.println("newPwd"+newPwd);
	    // 회원 비밀번호 변경 처리
	    UserDAO dao = UserDAO.getInstance();
	    int result = dao.modifyUserPassword(userId, currentPwd, newPwd);
	    
	    ActionForward forward = new ActionForward();
	    if (result > 0) {
	    	 // 비밀번호 변경 성공
	        session.invalidate(); // 로그아웃 처리
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('비밀번호가 변경되었습니다. 변경된 비밀번호로 다시 로그인 해주세요.');");
	        out.println("window.opener.location.href='./index.jsp';"); // 부모창의 URL 변경
	        out.println("window.close();"); // 팝업 창 닫기
	        out.println("</script>");
	        out.close();
	    } else if (result == -1) {
	        // 현재 비밀번호가 일치하지 않음
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('현재 비밀번호가 일치하지 않습니다.');");
	        out.println("history.back();");
	        out.println("</script>");
	        out.close();
	    } else {
	        // 비밀번호 변경 실패
	        response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>");
	        out.println("alert('비밀번호 변경에 실패하였습니다. 다시 시도해주세요.');");
	        out.println("history.back();");
	        out.println("</script>");
	        out.close();
	    }

	    return forward;
	}

}
