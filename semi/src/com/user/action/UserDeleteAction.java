package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserDeleteAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
	
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		UserDAO dao = UserDAO.getInstance();
		
		String user_nickname =  
		
		PrintWriter out = response.getWriter();
		
		dao.userDelete(user_no);
		
		out.println("<script>");
		out.println("alert('회원이 삭제 되었습니다.');");
		out.println("location.href='admin_page.do?id=" + user_id + "';"); 
		out.println("</script>");
		
		return null;
	}

}
