package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class JoinOkAction implements Action {


		

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String user_id = request.getParameter("user_id").trim();
		String user_password = request.getParameter("user_password").trim();
		String user_name = request.getParameter("user_name").trim();
		String user_nickname = request.getParameter("user_nickname").trim();
		String user_email = request.getParameter("user_email").trim();
		String postcode = request.getParameter("postcode");
		String roadAddress = request.getParameter("road_address");
		String jibunAddress = request.getParameter("jibun_address");
		String detailAddress = request.getParameter("detail_address");
		String extraAddress = request.getParameter("extra_address");

		String user_addr = roadAddress + " " + detailAddress + " " + extraAddress + " " + postcode;

		// DB에 회원 정보와 함께 주소 정보를 저장하는 코드

		String user_phone = request.getParameter("user_phone").trim();
		String user_birth = request.getParameter("user_birth").trim();
		
		UserDTO dto = new UserDTO();
		
		dto.setUser_id(user_id);
		dto.setUser_pwd(user_password);
		dto.setUser_name(user_name);
		dto.setUser_nickname(user_nickname);
		dto.setUser_email(user_email);
		dto.setUser_addr(user_addr);
		dto.setUser_phone(user_phone);
		dto.setUser_birth(user_birth);
		
		UserDAO dao = UserDAO.getInstance();
		
		int res = dao.joinUser(dto);
		PrintWriter out =  response.getWriter();
		ActionForward forward = new ActionForward();

		if(res>0) {
			out.println("<script>");
			out.println("alert('회원가입을 환영합니다')");
			out.println("</script>");
			forward.setRedirect(true);
			forward.setPath("index.jsp");
		}else {
			out.println("<script>");
			out.println("alert('회원가입 실패. 입력정보를 확인 바랍니다.')");
			out.println("</script>");
			forward.setRedirect(false);
			forward.setPath("index.jsp");
		}
		
				
		return forward;
	}
}
