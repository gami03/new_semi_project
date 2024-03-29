package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class SaleProductApproveDeleteAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_id = request.getParameter("user_id").trim();
		
		int sale_no = Integer.parseInt(request.getParameter("sale_no").trim());
		
		String nickname = request.getParameter("nickname");
		
		if (nickname != null && !nickname.trim().isEmpty()) {
			nickname = nickname.trim();
		}
		
		SaleDAO dao = SaleDAO.getInstance();
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		if(nickname ==null)  {
			dao.saleNoApprove(sale_no);
			out.println("<script>");
			out.println("alert('판매 승인 거부했습니다.');");
			out.println("location.href='admin_page.do?id=" + user_id + "';"); 
			out.println("</script>");
		}else {
			dao.saleNoApprove(sale_no);
			out.println("<script>");
			out.println("alert('판매 승인 거부했습니다.');");
			out.println("location.href='sale_approve_list.do?user_id=" + user_id + "';"); 
			out.println("</script>");
		}
		
		
		return null;
	}

}
