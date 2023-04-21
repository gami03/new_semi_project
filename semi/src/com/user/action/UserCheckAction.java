package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.model.UserDAO;

public class UserCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException, Exception {

		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		String user_id =request.getParameter("paramId").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		int str = dao.idCheck(user_id);

		System.out.println("str>>> " + str);
		
		out.println(str);
		
		
		
		return null;
	}

}
