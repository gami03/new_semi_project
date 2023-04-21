package com.sale.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;

public class WishListClickAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
			// sale_no와 user_no값을 가져오자.
			String user_noStr = request.getParameter("user_no");
			int sale_no = Integer.parseInt(request.getParameter("sale_no").trim());
			
			int user_no = 0;
	        
	        if (user_noStr != null && !user_noStr.trim().isEmpty()) {
	            user_no = Integer.parseInt(user_noStr.trim());
	        }
	        
			SaleDAO dao = SaleDAO.getInstance();
			
			// 동일 상품에 대한 이전 추천 여부 검색
			int result = dao.wishListCheck(user_no, sale_no);
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/html; charset=UTF-8");
	        response.setCharacterEncoding("UTF-8");
	        
	        if(user_no > 0) {
	        	if(result == 0) { // 찜하지 않았다면 찜 추가
		            dao.wishListInsert(user_no, sale_no);
		            out.println("<script>");
		            out.println("alert('관심상품에 등록 되었습니다.')");
		            out.println("location.href='index.jsp'");
		            out.println("</script>");
		            
		        } else { // 이미 등록되어 있다면 찜 삭제
		            dao.wishListDelete(user_no, sale_no);
		            out.println("<script>");
		            out.println("alert('관심상품이 삭제 되었습니다.')");
		            out.println("location.href='index.jsp'");
		            out.println("</script>");
		        }
	        }else {
	        	out.println("<script>");
	            out.println("alert('관심상품 등록은 로그인 후 이용해 주세요.')");
	            out.println("history.back()");
	            out.println("</script>");
	        }
	        
	        // 관심상품에 추가/삭제 했을 때 product 테이블에서 해당 게시물의 찜 수를 업데이트 하는 메서드.
	        dao.productWishListCount(sale_no);
	
		return null;
	}

}
