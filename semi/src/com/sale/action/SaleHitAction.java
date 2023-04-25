package com.sale.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class SaleHitAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 게시물을 클릭할때마다 product 테이블의 hit 컬럼이 1씩 증가하는 메서드
		
		int product_no = Integer.parseInt(request.getParameter("no"));
		
		System.out.println("nonono >>>" + product_no);
		
		SaleDAO dao = SaleDAO.getInstance();
		
		dao.inputHit(product_no);
		
		return null;
	}

}
