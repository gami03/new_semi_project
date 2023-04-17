package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;

public class SearchBoardListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String user_id = request.getParameter("id").trim();
        
        String search_id = request.getParameter("searchId").trim();
        if(!search_id.equals(user_id)) {	user_id = search_id;	}
        
        BoardDAO dao = BoardDAO.getInstance();
        
        List<BoardDTO> list = dao.getUserBoard(user_id);
        
        // 마이페이지 유저의 닉네임 가져오기.
     	String user_nickname = dao.getUserNickname(user_id);
                
        request.setAttribute("BoardList", list);
        request.setAttribute("mypage_id", user_id);
        request.setAttribute("user_nickname", user_nickname);
        
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
	
		forward.setPath("user_page/user_mypage.jsp");

		
		return forward;
	}

}
