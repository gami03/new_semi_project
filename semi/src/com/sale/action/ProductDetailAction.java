package com.sale.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;
import com.sale.model.UpperDTO;

public class ProductDetailAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int sale_no = Integer.parseInt(request.getParameter("no").trim());
		
		SaleDAO dao = SaleDAO.getInstance();
		
		SaleDTO dto = dao.getProductDetail(sale_no);
		
		// 게시물의 상세정보
		request.setAttribute("Dto", dto);
		
		ActionForward forward = new ActionForward();
		
		// view page로 이동 시에는 false 값 지정.
		forward.setRedirect(false);
		
		forward.setPath("sale/product_detail.jsp");
		
		return forward;
	}
	

}
