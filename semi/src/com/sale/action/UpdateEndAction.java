package com.sale.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class UpdateEndAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int check = 0;
		
		int product_no = Integer.parseInt(request.getParameter("no").trim());
		
		String user_id = request.getParameter("id").trim();
		
		SaleDAO dao = SaleDAO.getInstance();
		
		// 로그인된 유저 번호를 가져오는 메서드
		int user_no = dao.getUserNo(user_id);
		
		System.out.println("user_no >>>" + user_no);
		
		// 현재 경매 물품을 상회입찰한 유저 번호를 가져오는 메서드
		int user_upper_no = dao.getUserUpperNo(product_no);
		
		// 현재 경매 물품을 등록한 판매자의 번호를 가져오는 메서드.
		int product_user_no = dao.getProductUserNo(product_no);
		
		// 상회 입찰을 할려는 유저와 경매물품을 등록한 판매자의 유저 번호가 같은지 확인하는 코드
		if(product_user_no != user_no) {
			
			// 상회 입찰을 할려는 유저와 이미 상회입찰을 할려는 유저의 번호가 같은지 확인하는 코드
			if(user_upper_no != user_no) {
				
				// 유저가 정상 DB에 정상 등록 되었는지 확인하는 코드.
				if(user_no > 0) {
					
					check = dao.updateNow(product_no, user_no);
					
					System.out.println("check >>> " + check);
				}
			} else {
				check = 2;
			}
		} else {
			check = 3;
		}
		
		PrintWriter out = response.getWriter();
		
		if(check == 1) {
			out.println("<script>");
			out.println("alert('입찰이 완료 되었습니다.')");
			out.println("location.href='sale_index_list.do'");
			out.println("</script>");
		} else if(check == 2) {
			out.println("<script>");
			out.println("alert('이미 입찰하신 상품입니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == 3) {
			out.println("<script>");
			out.println("alert('상품 판매자는 입찰할 수 없습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == -1) {
			out.println("<script>");
			out.println("alert('소지금이 부족합니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == -2) {
			out.println("<script>");
			out.println("alert('최저 입찰금액보다 낮은 금액이 입력되었습니다."
					+ "다시 입력해주세요.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == -3) {
			out.println("<script>");
			out.println("alert('최저 입찰금액보다 낮은 금액이 입력되었습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == -4) {
			out.println("<script>");
			out.println("alert('입력된 금액이 즉시 입찰가보다 높습니다. 확인 후 다시 입력해 주세요.')");
			out.println("history.back()");
			out.println("</script>");
		} else if(check == -5) {
			out.println("<script>");
			out.println("alert('오류가 발생하였습니다.')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('입찰에 실패 하였습니다')");
			out.println("history.back()");
			out.println("</script>");
		}

		
		return null;
	}

}
