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
		int detail = Integer.parseInt(request.getParameter("detail").trim());
		
		HttpSession session = request.getSession();
		
		String session_id = (String)session.getAttribute("user_id");
		
		UserDAO dao = UserDAO.getInstance();
			
		dao.UpdateApprove(user_no, user_approve);
		
		PrintWriter out = response.getWriter();
		
		if(detail == 1) {
			out.println("<script>");
			out.println("alert('등급 변경이 완료 되었습니다.')");
			out.println("location.href='user_info_detail.do?id="+session_id+"'");
			out.println("</script>");
		}else if(detail == 0) {
			out.println("<script>");
			out.println("alert('등급 변경이 완료 되었습니다.')");
			out.println("location.href='admin_page.do?id="+session_id+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('변경된 값이 적용되지 않았습니다. 확인 후 다시 시도 부탁드립니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
