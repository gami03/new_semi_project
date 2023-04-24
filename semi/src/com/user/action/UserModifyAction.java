package com.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class UserModifyAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		  // 로그인한 사용자 아이디를 세션에서 가져온다.
        HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("user_id");

        // 수정할 사용자 정보를 가져온다.
        String user_nickname = request.getParameter("user_nickname");
        String user_phone = request.getParameter("user_phone");
        String user_email = request.getParameter("user_email");
        String user_addr = request.getParameter("user_addr");

        // UserDTO 객체에 수정된 정보를 담는다.
        UserDTO dto = new UserDTO();
        dto.setUser_id(user_id);
        dto.setUser_nickname(user_nickname);
        dto.setUser_phone(user_phone);
        dto.setUser_email(user_email);
        dto.setUser_addr(user_addr);

        // UserDAO를 이용해 DB에 수정된 정보를 업데이트 한다.
        UserDAO dao = UserDAO.getInstance();
        int res = dao.updateUser(dto);

        // 업데이트 결과에 따라서 성공/실패 메시지를 출력하고 페이지를 이동한다.
        if (res > 0) {
            request.setAttribute("msg", "회원 정보가 수정되었습니다.");
        } else {
            request.setAttribute("msg", "회원 정보 수정에 실패하였습니다.");
        }
        String redirectUrl = "user_mypage.do?id=" + user_id + "&searchId=" + user_id;
        response.sendRedirect(redirectUrl);
        return null;
    

	}

}
