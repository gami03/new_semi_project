package com.free_board.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;

public class FreeBoardModifyAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 게시 글 번호에 해당하는 상세내역을 DB에서 조회하여 수정 폼 페이지로 이동시키는 비지니스 로직.
		
		int board_no = Integer.parseInt(request.getParameter("no").trim());

		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		
		 BoardDAO dao = BoardDAO.getInstance();
		 
		// 글번호에 해당하는 게시글의 상세내역을 조회하는 메서드 호출.
		 BoardDTO cont =  dao.getBoardContent(board_no);
		 
		 request.setAttribute("Modify", cont);
		 
		 request.setAttribute("Page", nowPage);
		 
		 ActionForward forward = new ActionForward();
		 
		 forward.setRedirect(false);
		 
		 forward.setPath("board/free_board/free_board_modify.jsp");
		
		return forward;
	}

}
