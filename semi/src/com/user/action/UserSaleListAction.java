package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;
import com.user.model.UserDAO;

public class UserSaleListAction implements Action{

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String user_id = request.getParameter("user_id").trim();
		
		UserDAO udao = UserDAO.getInstance();
		
		// user_id값을 가져와 no로 반환하는 메서드
		int user_no = udao.getUserNo(user_id);
		
		SaleDAO dao = SaleDAO.getInstance();
		
		// 특정 유저의 구매 상품 index list를 가져오는 메서드
		List<SaleDTO> buyList = dao.getUserBuyList(user_no);
		
		request.setAttribute("BuyList", buyList);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/user_mypage_info.jsp");
		
		return forward;
		
	}

}
