package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserBlockAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		String session_id = request.getParameter("user_id").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		String user_nickname =  dao.getUserNickname(user_no);
		
		PrintWriter out = response.getWriter();
		
		dao.userBlock(user_no);
		
		out.println("<script>");
		out.println("alert('"+user_nickname+"회원님이 차단 되었습니다.');");
		out.println("location.href='admin_page.do?id=" + session_id + "';"); 
		out.println("</script>");
		
		return null;
	}

}
