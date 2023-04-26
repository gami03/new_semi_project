package com.admin.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserReqeustApproveAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_id = request.getParameter("id").trim();
		
		System.out.println("user_id >>> " + user_id);
		
		UserDAO dao = UserDAO.getInstance();
		
		dao.requestApprove(user_id);
		
		PrintWriter out = response.getWriter();
		
		// 결과값을 클라이언트(Ajax)에 보내주면 됨.
		out.println("<script>");
		out.println("alert('값이 전달 되었습니다.')");
		out.println("location.href='user_mypage.do?id="+user_id+"&searchId="+user_id+"'");
		out.println("</script>");
		
		return null;
	}

}
