package com.user.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.user.model.SearchDTO;
import com.user.model.UserDAO;

public class UserSearchRecentList implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		System.out.println("user_no >>>"+user_no);
		
		UserDAO dao = UserDAO.getInstance();
		
		List<SearchDTO> list = dao.getUserSearchRecentList(user_no);
		
		System.out.println("list >>>"+list);
		
		// JSON 형태로 데이터 반환
        JsonObject data = new JsonObject();
        
        data.add("recentList", new Gson().toJsonTree(list));
        
        // 응답 데이터로 전송
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(data));
		
		return null;
	}

}
