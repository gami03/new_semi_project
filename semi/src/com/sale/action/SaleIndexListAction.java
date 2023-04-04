package com.sale.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;

public class SaleIndexListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		
		SaleDAO dao = SaleDAO.getInstance();
		
		// indexList의 갯수를 넘겨주는 메서드.
		int count = dao.getindexListnumber();
		
		List<SaleDTO> index = dao.getindexList();
		
		request.setAttribute("Count", count);
		request.setAttribute("Index", index);
		
		ActionForward forward = new ActionForward();
		
		// view page로 이동 시에는 false 값 지정.
		forward.setRedirect(false);
		
		forward.setPath("sale/sale_index_list.jsp");
		
		return forward;
	}


}
