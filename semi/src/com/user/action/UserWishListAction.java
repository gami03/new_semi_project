package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;

public class UserWishListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		SaleDAO dao = SaleDAO.getInstance();
		
		List<SaleDTO> list =  dao.getUserWishList(user_no);
		
		request.setAttribute("List", list);
		
		ActionForward forward = new ActionForward();
		
		// view page 로 이동 시에는 false 값 지정.
		forward.setRedirect(false);
		
		forward.setPath("user_page/wish_list.jsp");
		
		return forward;
	}

}
