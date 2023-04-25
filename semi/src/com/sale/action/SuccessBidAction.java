package com.sale.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class SuccessBidAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 경매물품의 시간이 만료 되었을 경우 현재 입찰된 가격을 product 테이블의 success_bid 컬럼에 등록하는 비즈니스 로직
		int product_no = Integer.parseInt(request.getParameter("no").trim());
		
		System.out.println("no >>> " + product_no);
		
		
		SaleDAO dao = SaleDAO.getInstance();
		
		int upper_val = dao.getUpper(product_no);
		
		// 현재 경매물품의 success_bid 컬럼에 입찰가를 넣는 메서드 
		dao.inputBid(upper_val, product_no);
		
		return null;
	}

}
