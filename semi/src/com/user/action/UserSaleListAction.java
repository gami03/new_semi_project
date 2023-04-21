package com.user.action;

import java.io.IOException;

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
		
		// 유저가 구매한 제품 번호를 가져오는 메서드
		int sale_no = dao.getBuyProduct(user_no);
		
		// 제품 번호에 해당하는 제품 내용을 반환하는 메서드
		SaleDTO dto = dao.getProductDetail(sale_no);
		
		request.setAttribute("OrderList", dto);
		
		ActionForward forward = new ActionForward();
		
		forward.setRedirect(false);
		
		forward.setPath("user_page/user_mypage_info.jsp");
		
		return forward;
		
	}

}
