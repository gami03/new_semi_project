package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class IdFindAction implements Action {

    

    	
    	
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		 String email = request.getParameter("email");
 	    System.out.println(email);

 	    // Use UserDao to find user ID by email
 	    UserDAO dao = UserDAO.getInstance();

 	    String foundId = dao.findId(email);

 	    request.setAttribute("FoundId", foundId);

 	    PrintWriter out = response.getWriter();

 	    System.out.println(foundId);

 	    JSONObject jsonResponse = new JSONObject();
 	    if (foundId == null) {
 	        jsonResponse.put("status", "not_found");
 	    } else {
 	        jsonResponse.put("status", "found");
 	        jsonResponse.put("id", foundId);
 	    }
 	    response.setContentType("application/json");
 	    out.println(jsonResponse.toString());

 	    return null;
 	}

}

