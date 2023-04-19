package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDTO;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class UserSearchAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String field = request.getParameter("field").trim();
        String search = request.getParameter("search").trim();
        int approve = Integer.parseInt(request.getParameter("approve").trim());
        
        System.out.println(approve);
        System.out.println(field);
        System.out.println(search);
        
        String keyword1 = "user_id";
        String keyword2 = "user_approve";
        
        if (field != null && !field.trim().isEmpty()) {
            field = field.trim();
        }
        
        if (search != null && !search.trim().isEmpty()) {
        	search = search.trim();
        }

        UserDAO dao = UserDAO.getInstance();
        		
		
		// 현재 페이지에 해당하는 게시물을 가져오는 메서드 호출
		List<UserDTO> list = dao.getUserInfo();
		
        //if(approve != 0) {
        //	list = dao.getUserInfoSearchI(keyword2, approve);        	
        //}else if(search != null) {
        //	list = dao.getUserInfoSearch(keyword1, search);
        //}
        
		request.setAttribute("field", field);
		request.setAttribute("List", list);
		
		PrintWriter out = response.getWriter();
		
		// 결과값을 클라이언트(Ajax)에 보내주면 됨
		out.println(list);
		
		return null;
	}

}
