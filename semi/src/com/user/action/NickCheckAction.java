package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class NickCheckAction implements Action {

	

		
		

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		// 넘어온 파라미터의 인코딩 설정을 UTF-8로 설정
    	request.setCharacterEncoding("utf-8");
    
    	// HTML이 UTF-8 형식이라는 것을 브라우저에게 전달
    	response.setContentType("text/html; charset=utf-8");
    
    	// 서블릿을 통해 생성되는 HTML 파일의 인코딩을 UTF-8로 설정
	response.setCharacterEncoding("utf-8");
		
		
		
		PrintWriter out = response.getWriter();
		
		String user_nick=request.getParameter("paramNick").trim();
		
		UserDAO dao = UserDAO.getInstance();
		
		int nc = dao.nickCheck(user_nick);
		
		out.println(nc);
		
		return null;
	}

}
