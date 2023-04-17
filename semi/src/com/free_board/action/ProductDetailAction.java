package com.free_board.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int sale_no = Integer.parseInt(request.getParameter("no").trim());
		
		SaleDAO dao = SaleDAO.getInstance();
		
		dao.getProductDetail(sale_no);
		
		return null;
	}

}
