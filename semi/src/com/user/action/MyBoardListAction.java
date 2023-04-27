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
import com.user.model.UserDTO;

public class MyBoardListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String user_id = request.getParameter("id").trim();
        
        String search_id = request.getParameter("searchId").trim();
        if(!search_id.equals(user_id)) {	user_id = search_id;	}
        
        UserDAO udao = UserDAO.getInstance();
        
        // 유저 프로필 정보를 가져오는 메서드
        int user_no = udao.getUserNo(search_id);
        UserDTO dto = udao.getUserInfoDetail(user_no);
 		
        request.setAttribute("UserInfo", dto);
        
        System.out.println(user_no);
        System.out.println(dto);
        
        BoardDAO dao = BoardDAO.getInstance();
        
        // 유저가 작성한 게시판 게시글을 가져오는 메서드
        List<BoardDTO> list = dao.getUserBoard(user_id);
        
		SaleDAO sdao = SaleDAO.getInstance();
		
		// 제품 번호에 해당하는 제품 내용을 반환하는 메서드
		List<SaleDTO> saleList = sdao.getUserindexList(user_no);
		int saleCount = sdao.getUserindexCount(user_no);
		
		request.setAttribute("SaleList", saleList);
		request.setAttribute("SCount", saleCount);
		
		System.out.println("saleList >>> " + saleList);
		System.out.println("saleCount >>> " + saleCount);
		
		// 특정 유저의 구매 상품 index list를 가져오는 메서드
		List<SaleDTO> buyList = sdao.getUserBuyList(user_no);
		
		int buyCount = sdao.getUserBuyCount(user_no);
		
		request.setAttribute("BuyList", buyList);
		request.setAttribute("BCount", buyCount);
        
        // 마이페이지 유저의 닉네임 가져오기.
     	String user_nickname = dao.getUserNickname(user_id);
                
        request.setAttribute("BoardList", list);
        request.setAttribute("mypage_id", user_id);
        request.setAttribute("user_nickname", user_nickname);
        
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/user_mypage.jsp");

		
		return forward;
	}

}
