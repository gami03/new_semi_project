package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class PhoneCheckAction implements Action {



	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		String user_phone =request.getParameter("paramPhone").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		
		
		int str = dao.phoneCheck(user_phone);

		
		out.println(str);
		return null;
	}

}
