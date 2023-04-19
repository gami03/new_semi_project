package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class MyBoardListSearchAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        String field = request.getParameter("field").trim();
        String search = request.getParameter("keyword").trim();
        String search_id = request.getParameter("searchId").trim();
        
        System.out.println(field);
        System.out.println(search);
        
        if (field != null && !field.trim().isEmpty()) {
            field = field.trim();
        }
        
        if (search != null && !search.trim().isEmpty()) {
        	search = search.trim();
        }
        
		// 페이징 처리 작업 진행
		
		// 한 페이지당 보여질 게시물의 수
		int rowsize = 10;
		
		// 아래에 보여질 페이지 최대 블럭 수
		int block = 7;
		// 예) [1][2][3] / [4][5][6] / [7][8][9]
		
		// DB 상의 게시물의 전체 수
		int totalRecord = 0;
		
		// 전체 페이지 수
		int allPage = 0;
		
		// 현재 페이지 변수
		int page = 0;
		
		// 게시물 수의 끝번호 변수
		int totalEndNo = 0;
		
		if(request.getParameter("page") != null) {
			page = 
				Integer.parseInt(request.getParameter("page").trim());
		}else {
			// 처음으로 "전체 게시물 목록" a 태그를 클릭한 경우
			page = 1;
		}
		
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		// 해당 페이지에서 시작 블럭
		int startBlock = 
				(((page - 1) / block) * block) + 1;
		
		// 해당 페이지에서 마지막 블럭
		int endBlock = 
				(((page - 1) / block) * block) + block;
		
		UserDAO user_dao = UserDAO.getInstance();
		
		int search_no = user_dao.getUserNo(search_id);
		
        BoardDAO dao = BoardDAO.getInstance();
        
        // 전체 게시물의 수를 확인하는 메서드 호출
     	totalRecord = dao.getBoardCount(search_no);
     	
 		// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
 		// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
 		// 이 때 전체 페이지 수가 나올 때 나머지가 있으면 무조건 전체 페이지 수를 하나 올려 주어야 함.
 		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
 		
 		if(endBlock > allPage) {
 			endBlock = allPage;
 		}
 		
 		// 자유게시판 총 게시물 수의 끝번호
 		// 자유게시판으로 모인 게시글에 번호를 순차적으로 매겨서 보여주기 위함.
 		totalEndNo = totalRecord - ((page-1) * rowsize);
        
        List<BoardDTO> list = dao.getUserBoardSearch(search_id, field, search, page, rowsize);
        
        // 마이페이지 유저의 닉네임 가져오기.
     	String user_nickname = dao.getUserNickname(search_id);
                
        request.setAttribute("BoardList", list);
        request.setAttribute("mypage_id", search_id);
        request.setAttribute("user_nickname", user_nickname);
        
     // 지금까지 페이징 처리 시 작업했던 모든 데이터들을 view page로 이동을 시키자.
		request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("field", field);
		request.setAttribute("keyword", search);
		
		// 자유게시판에 모인 게시글을 번호를 순차적으로 매겨서 보여주기 위한 데이터를 view page로 이동.
		request.setAttribute("totalEndNo", totalEndNo);
 		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/user_mypage_search.jsp");
		
		return forward;
	}

}
