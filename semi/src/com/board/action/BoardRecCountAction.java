package com.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;

public class BoardRecCountAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int board_no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = BoardDAO.getInstance();
		
		// 게시글 총 추천수를 구함
		int count = dao.recCount(board_no);
		
		PrintWriter out = response.getWriter();
		
		// 뷰페이지(boardContent.jsp)에 추천수를 출력하도록 하는 역할
		out.println(count);
		
		out.close();
		
		return null;
	}

}
