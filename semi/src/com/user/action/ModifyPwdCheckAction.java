package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class ModifyPwdCheckAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userId = request.getParameter("user_id");
	    String password = request.getParameter("password");

	    UserDAO dao = UserDAO.getInstance();
	    boolean isValid = dao.checkPassword(userId, password);

	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");

	    PrintWriter out = response.getWriter();
	    JSONObject json = new JSONObject();

	    if (isValid) {
	      json.put("result", "success");
	    } else {
	      json.put("result", "error");
	    }

	    out.print(json.toString());
	    out.flush();
	    return null;
	  }

}
