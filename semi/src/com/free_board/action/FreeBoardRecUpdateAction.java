package com.free_board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;

public class FreeBoardRecUpdateAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// no와 id값을 가져오자.
		int board_no = Integer.parseInt(request.getParameter("no").trim());
		String user_id = request.getParameter("id").trim();
		
		BoardDAO dao = BoardDAO.getInstance();
		
		int user_no = dao.getUserNo(user_id);
		
		// 동일 게시글에 대한 이전 추천 여부 검색
		int result = dao.recCheck(board_no, user_no);
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
		
		if(result == 0){ // 추천하지 않았다면 추천 추가
			dao.recUpdate(board_no, user_no);
			out.print("좋아요를 눌렀습니다.");
			
		}else{ // 추천을 하였다면 추천 삭제
			dao.recDelete(board_no, user_no);
			out.println("좋아요를 취소하였습니다.");
		}
		
		return null;
	}


}
