package com.free_board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;

public class FreeBoardDeleteAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 삭제버튼에서 넘어온 글번호와 글 비밀번호를 가지고 board 테이블에서 해당 게시글을 삭제하는 비지니스 로직.
		
		int board_no = Integer.parseInt(request.getParameter("board_no").trim());
		
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		
		BoardDAO dao = BoardDAO.getInstance();
		
		int check = dao.deleteBoard(board_no);
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			dao.updateSequence(board_no);
			out.println("<script>");
			out.println("alert('해당 게시글은 삭제 되었습니다.')");
			out.println("location.href='free_board_list.do?page="+nowPage+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 삭제를 실패했습니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
