package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class KakaoLoginAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		        // Get user info from request parameters
		        String kakao_token = request.getParameter("member_token");
		        String kakao_name = request.getParameter("member_name");
		        String kakao_email = request.getParameter("member_email");

		        // Save user info in a User object
		        UserDTO dto = new UserDTO();
		        dto.setUser_id(kakao_token);
		        dto.setUser_name(kakao_name);
		        dto.setUser_email(kakao_email);

		        // Check if user exists in database
		        UserDAO dao = UserDAO.getInstance();
		        boolean userExists = dao.checkUser(dto);

		        if (userExists) {
		            // User exists, login
		            HttpSession session = request.getSession();
		            session.setAttribute("user", dto);

		            // Redirect to the main page
		            ActionForward forward = new ActionForward();
		            forward.setPath("./index.jsp");
		            forward.setRedirect(true);
		            return forward;
		        } else {
		            // User does not exist, redirect to registration page
		            request.setAttribute("kakao_user", dto);

		            // Set up the action forward
		            ActionForward forward = new ActionForward();
		            forward.setPath("kakao_registration.jsp");
		            forward.setRedirect(false);
		            return forward;
		        }
		  }

}
