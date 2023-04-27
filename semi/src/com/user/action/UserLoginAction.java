package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.action.Action;
import com.action.ActionForward;
import com.user.model.UserDAO;

public class UserLoginAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String user_id = request.getParameter("login_id").trim();
        String user_pwd = request.getParameter("login_pwd").trim();

        System.out.println("입력한 user_id"+ user_id);
        System.out.println("입력한 user_pwd"+user_pwd);
        
        
        UserDAO dao = UserDAO.getInstance();
                
        int result = dao.userCheck(user_id, user_pwd);
        int user_no = dao.getUserNo(user_id);
        String user_nickname = dao.getUserNickname(user_no);
        PrintWriter out = response.getWriter();

        if (result > 0) { // 로그인 성공
            int user_approve = dao.getUserApprove(user_id);
            if (user_approve == 5) { // 차단된 회원 확인
                out.println("<script>");
                out.println("alert('이 계정은 차단되었습니다. 관리자에게 문의하세요.');");
                out.println("history.back();");
                out.println("</script>");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("user_id", user_id);
                session.setAttribute("user_pwd", user_pwd);
                session.setAttribute("user_approve", user_approve);
                
                session.setAttribute("User_no", user_no);
                System.out.println(user_no);
                
                // 세션 값 확인
                System.out.println("세션에 저장된 user_id: " + session.getAttribute("user_id"));
                System.out.println("세션에 저장된 user_pwd: " + session.getAttribute("user_pwd"));

                out.println("<script>");
                out.println("alert('" + user_nickname + "님 환영합니다!');");
                out.println("location.href='index.jsp'");
                out.println("</script>");
            }

            

        }else if(result ==-2){
            out.println("<script>");
             out.println("alert('비밀번호 오류');");
             out.println("history.back();");
             out.println("</script>");
        }else if(result ==-1) {
            out.println("<script>");
             out.println("alert('아이디가 없음');");
             out.println("history.back();");
             out.println("</script>");
        }else if(result == 0) {
            out.println("<script>");
             out.println("alert('로그인 실패');");
             out.println("history.back();");
             out.println("</script>");
        }
      return null;
    }
}
