package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;
import com.user.model.UserDAO;

public class SaleApproveListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_id = request.getParameter("user_id").trim();
		
		SaleDAO dao = SaleDAO.getInstance();
		
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
		int startBlock = (((page - 1) / block) * block) + 1;
		
		// 해당 페이지에서 마지막 블럭
		int endBlock = (((page - 1) / block) * block) + block;
		
		UserDAO user_dao = UserDAO.getInstance();
		
		int user_no = user_dao.getUserNo(user_id);
		
        // 전체 게시물의 수를 확인하는 메서드 호출
     	totalRecord = dao.getApproveCount();
     	
 		// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
 		// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
 		// 이 때 전체 페이지 수가 나올 때 나머지가 있으면 무조건 전체 페이지 수를 하나 올려 주어야 함.
 		allPage = (int)Math.ceil(totalRecord / (double)rowsize);
 		
 		if(endBlock > allPage) {
 			endBlock = allPage;
 		}
 		
 		//  총 게시물 수의 끝번호
 		// 게시판으로 모인 게시글에 번호를 순차적으로 매겨서 보여주기 위함.
 		totalEndNo = totalRecord - ((page-1) * rowsize);
        
        List<SaleDTO> list = dao.getApproveBoardPage(page, rowsize);
        
        request.setAttribute("page", page);
		request.setAttribute("rowsize", rowsize);
		request.setAttribute("block", block);
		request.setAttribute("totalRecord", totalRecord);
		request.setAttribute("allPage", allPage);
		request.setAttribute("startNo", startNo);
		request.setAttribute("endNo", endNo);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("List", list);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/approveOk_all.jsp");
		
		return forward;

	}

}
