package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserMoneyPlusAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_id = request.getParameter("user_id").trim();
		int money = Integer.parseInt(request.getParameter("money").trim());
		
		UserDAO dao = UserDAO.getInstance();
		
		int user_no = dao.getUserNo(user_id);
		
		dao.userMoneyPlus(user_no, money);
		
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('소지금이 추가 되었습니다.')");
		out.println("location.href='user_mypage.do?id="+user_id+"&searchId="+user_id+"'");
		out.println("</script>");
		
		return null;
	}

}
