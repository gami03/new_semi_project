package com.free_board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;

public class FreeBoardReplyListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 글번호에 해당하는 댓글 전체 리스트를 DB에서 조회하여 상세내역 view page로 이동시키는 비지니스 로직.
		int reply_no = Integer.parseInt(request.getParameter("com_no").trim());
		
		BoardDAO dao = BoardDAO.getInstance();
		
		String str = dao.getReplyList(reply_no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		out.println(str);
		
		return null;
	}

}
