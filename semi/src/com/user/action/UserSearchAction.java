package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class UserSearchAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        int approve = 0;
        String field = request.getParameter("field").trim();
        String search = request.getParameter("search").trim();
        approve = Integer.parseInt(request.getParameter("approve").trim());
        
        if (field != null && !field.trim().isEmpty()) {
            field = field.trim();
        }
        
        if (search != null && !search.trim().isEmpty()) {
        	search = search.trim();
        }

        UserDAO dao = UserDAO.getInstance();
        
        List<UserDTO> list = null;
        
        if(approve != 0) {
        	list = dao.getUserInfoSearch(field, approve);        	
        }else if(search != null) {
        	list = dao.getUserInfoSearch(field, search);
        }
		
		System.out.println(list);
		
		PrintWriter out = response.getWriter();
		
		// 결과값을 클라이언트(Ajax)에 보내주면 됨
		out.println(list);
		
		return null;
	}

}
