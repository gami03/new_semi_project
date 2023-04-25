package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class UserListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        HttpSession session =  request.getSession();
		int user_approve = (int)session.getAttribute("user_approve");
        
        String user_id = request.getParameter("id").trim();

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
    
        UserDAO dao = UserDAO.getInstance();
                
        // 전체 게시물의 수를 확인하는 메서드 호출
     	totalRecord = dao.getUserCount();
     	
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
        
 		List<UserDTO> list = null;
 		
 		System.out.println("approve >>> " + user_approve);
 		
 		if(user_approve == 3) {
 			list = dao.getUserInfo(page, rowsize);
 		}else{
 			list = dao.getAdminInfo(page, rowsize);
 		}
 		
        request.setAttribute("UserList", list);
                
        BoardDAO bdao = BoardDAO.getInstance();
        
        // 유저가 작성한 게시판 게시글을 가져오는 메서드
        List<BoardDTO> board = bdao.getUserBoard(user_id);
        
        request.setAttribute("BoardList", board);
        
        request.setAttribute("mypage_id", user_id);
        
        System.out.println(list);
        
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
 		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/admin_page.jsp");
		
		return forward;
	}

}
