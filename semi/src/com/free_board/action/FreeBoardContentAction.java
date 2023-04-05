package com.free_board.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;

public class FreeBoardContentAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 글 번호에 해당하는 게시글의 상세내역을 DB에서 조회하여 view page로 이동시키는 비지니스 로직.
		
		int board_no = Integer.parseInt(request.getParameter("no").trim());
		
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		
		String user_id = request.getParameter("id").trim();
		
		String user_nickname = request.getParameter("nickname").trim();
		
		
		BoardDAO dao = BoardDAO.getInstance();
		
		// 글 제목 클릭 시 조회 수 증가시키는 메서드 호출.
		dao.getBoardHit(board_no);
		
		// 세션의 아이디를 갖고 로그인되어있는 유저의 닉네임 가져오기.
		String session_nickname = dao.getUserNickname(user_id);
		
		// 세션의 아이디를 갖고 로그인되어있는 유저의 user_no 가져오기.
		int session_user_no = dao.getUserNo(user_id);
		
		// 글번호에 해당하는 게시글의 상세내역을 조회하는 메서드 호출.
		BoardDTO content = dao.getBoardContent(board_no);
		
		
		request.setAttribute("Content", content);
		request.setAttribute("Page", nowPage);
		request.setAttribute("user_id", user_id);
		request.setAttribute("Nickname", user_nickname);
		request.setAttribute("session_nickname", session_nickname);
		request.setAttribute("session_user_no", session_user_no);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("/board/free_board/free_board_content.jsp");
		
		return forward;
	}

}
