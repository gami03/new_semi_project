package com.sale.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;

public class HighProductListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		SaleDAO dao = SaleDAO.getInstance();
		
		List<SaleDTO> list = dao.getProductHighList();
		
		System.out.println("list >>>" + list);
		
		// JSON 형태로 데이터 반환
        JsonObject data = new JsonObject();
        
        data.add("productList", new Gson().toJsonTree(list));
		
     // 응답 데이터로 전송
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(data));
		
		
		return null;
	}

}
