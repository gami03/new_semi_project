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

public class HitProductListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_noStr = request.getParameter("user_no");
		
		int user_no = 0;
        
        if (user_noStr != null && !user_noStr.trim().isEmpty()) {
            user_no = Integer.parseInt(user_noStr.trim());
        }
		
		SaleDAO dao = SaleDAO.getInstance();
		
		
		if(user_no != 0) { // 로그인이 되있을 때 리스트 가져오는 메서드.
			List<SaleDTO> list = dao.getProductHitList(user_no);
			
			// JSON 형태로 데이터 반환
	        JsonObject data = new JsonObject();
	        
	        data.add("productList", new Gson().toJsonTree(list));
			
	     // 응답 데이터로 전송
	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(data));
			
		}else { // 로그인 되지 않았을때 리스트 가져오는 메서드.
			List<SaleDTO> list = dao.nlogingetProductHitList();
			
			// JSON 형태로 데이터 반환
	        JsonObject data = new JsonObject();
	        
	        data.add("productList", new Gson().toJsonTree(list));
			
	     // 응답 데이터로 전송
	        response.setContentType("application/json;charset=UTF-8");
	        response.getWriter().write(new Gson().toJson(data));
		}
		
        
		return null;
	}

}
