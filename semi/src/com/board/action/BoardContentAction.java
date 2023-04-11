package com.board.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;

public class BoardContentAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// get 방식으로 넘어온 글 번호에 해당하는 게시글의 상세내역을 DB에서 조회하여 view page로 이동시키는 비지니스 로직.
		
		int board_no = Integer.parseInt(request.getParameter("no").trim());
		
		int nowPage = Integer.parseInt(request.getParameter("page").trim());
		
		String user_id = request.getParameter("id").trim();
		
		String user_nickname = request.getParameter("nickname").trim();
		
		String board_name = request.getParameter("board_name").trim();
		
		// field와 keyword로 검색한 free_board_search.jsp 화면에서 게시글 상세내역을 보려고 눌렀을 때 필드 값과 키워드 값이 넘어옴.
		// 상세페이지에서 목록버튼을 눌렀을 때 다시 검색한 화면으로 돌아가게 하려고 함.
		String field = request.getParameter("field");
		String keyword = request.getParameter("keyword");
		String orderBy = request.getParameter("orderBy");
		
		// 위 코드에서는 먼저 파라미터 값을 가져온 후에, null 체크를 하지 않고 바로 변수에 저장합니다. 
		// 그리고 파라미터 값이 null이 아니고, 공백이 아닌 경우에만 trim() 메소드를 호출하여 변수 값을 수정합니다. 
		// 이렇게 하면, 파라미터 값이 null인 경우에는 변수가 초기화되지 않으므로 NullPointerException이 발생하지 않습니다.
		if (field != null && !field.trim().isEmpty()) {
		    field = field.trim();
		}

		if (keyword != null && !keyword.trim().isEmpty()) {
		    keyword = keyword.trim();
		}
		
		if (orderBy != null && !orderBy.trim().isEmpty()) {
			orderBy = orderBy.trim();
		}
		
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
		
		// field와 keyword로 검색한 free_board_search.jsp 화면에서 게시글 상세내역을 보려고 눌렀을 때 필드 값과 키워드 값을 상세페이지로 넘겨주자.
		// 상세페이지에서 목록버튼을 눌렀을 때 다시 검색한 화면으로 돌아가게 하려고 함.
		request.setAttribute("field", field);
		request.setAttribute("keyword", keyword);
		
		// 게시판에서 시간순, 추천수, 조회수로 정렬한 상태에서 해당 게시글을 눌렀을 때 다시 정렬한 상태의 화면으로 돌아가게 하려고 함.
		request.setAttribute("orderBy", orderBy);
		
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("/board/"+board_name+"/"+board_name+"_content.jsp");
		
		return forward;
	}

}
