package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class UserInfoDetailAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String search_id = request.getParameter("searchId").trim();
        
    
        UserDAO dao = UserDAO.getInstance();
                        
 		int user_no = dao.getUserNo(search_id);
 		
        UserDTO dto = dao.getUserInfoDetail(user_no);
 		
        request.setAttribute("UserInfo", dto);
        
	
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/user_mypage_info.jsp");
		
		return forward;
		
	}
}
