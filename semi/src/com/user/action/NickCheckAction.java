package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.model.UserDAO;

public class NickCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception {
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		String user_nick=request.getParameter("paramNick").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		int nc = dao.nickCheck(user_nick);
		
		out.println(nc);
		
		return null;
	}

}
