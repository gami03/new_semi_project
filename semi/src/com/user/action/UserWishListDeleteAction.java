package com.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class UserWishListDeleteAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		int sale_no = Integer.parseInt(request.getParameter("sale_no").trim());
		int user_no = Integer.parseInt(request.getParameter("user_no").trim());
		
		SaleDAO dao = SaleDAO.getInstance();
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		dao.wishListDelete(user_no, sale_no);
		out.println("<script>");
		out.println("alert('관심상품에서 해당 상품이 삭제 되었습니다.');");
		out.println("location.href='wish_list.do?user_no=" + user_no + "';"); // user_no 변수의 값을 함께 전달
		out.println("</script>");

		
		// 관심상품에 추가/삭제 했을 때 product 테이블에서 해당 게시물의 찜 수를 업데이트 하는 메서드.
        dao.productWishListCount(sale_no);
		
		return null;
	}

}
