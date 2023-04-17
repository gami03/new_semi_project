package com.sale.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class ProductDetailAjaxAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// ajax로 상회입찰가를 실시간으로 갱신하기 위한 비즈니스 로직.
		
		int user_no = Integer.parseInt(request.getParameter("no").trim());
		
		SaleDAO dao = SaleDAO.getInstance();
		
		String check = dao.getProductUpper(user_no);
		
		PrintWriter out = response.getWriter();
		
		out.println(check);
		
		return null;
	}

}
