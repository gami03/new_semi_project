package com.free_board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardReplyDTO;

public class FreeBoardReplyWriteAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		String re_cont = request.getParameter("re_cont").trim();
		String re_writer = request.getParameter("re_writer").trim();
		
		int re_bno = Integer.parseInt(request.getParameter("board_no").trim());
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		BoardReplyDTO dto = new BoardReplyDTO();
		
		dto.setBoard_no(re_bno);
		dto.setBr_writer(re_writer);
		dto.setBr_content(re_cont);
		dto.setUser_no(user_no);
		
		BoardDAO dao = BoardDAO.getInstance();
		
		int check = dao.replyInsert(dto);
		
		PrintWriter out = response.getWriter();
		
		// 결과값을 클라이언트(Ajax)에 보내주면 됨.
		out.println(check);
		
		return null;
	}

}
