package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserUpdateApproveAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int user_no = Integer.parseInt(request.getParameter("userNo").trim());
		String user_nickname = request.getParameter("userNickname").trim();
		int user_approve = Integer.parseInt(request.getParameter("approveValue").trim());
		
		HttpSession session =  request.getSession();
		
		int session_no = (int)session.getAttribute("User_no");
		String session_id = (String)session.getAttribute("user_id");
		
		int result = 0;
		
		if(session_no != user_no && session_no >= 3) {
			UserDAO dao = UserDAO.getInstance();
			
			result = dao.UpdateApprove(user_no, user_approve);
		}else {
			result = -1;
		}
		
		PrintWriter out = response.getWriter();
		
		if(result > 0) {
			out.println("<script>");
			out.println("alert('등급 변경이 완료 되었습니다.')");
			out.println("location.href='admin_page.do?id="+session_id+"'");
			out.println("</script>");
		}else if(result == 0) {
			out.println("<script>");
			out.println("alert('변경된 값이 적용되지 않았습니다. 확인 후 다시 시도 부탁드립니다.')");
			out.println("history.back()");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('자신의 등급은 변경할 수 없습니다!')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
