package com.sale.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;

public class InputProductDetailAjaxAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 현재 경매 물품에 직접 입찰할 경우 동작하는 비즈니스 로직.
		SaleDAO dao = SaleDAO.getInstance();
		
		int product_no = Integer.parseInt(request.getParameter("product_no").trim());
		
		int user_bid = Integer.parseInt(request.getParameter("user_bid").trim());
		
		String user_id = request.getParameter("id").trim();
		
		// 경매물품의 상세정보를 가져오는 메서드
        SaleDTO dto = dao.getProductDetail(product_no);
		
		System.out.println("bid >>" + user_bid);
		
		int check = 0;
		
		// 가져온 id로 user_no 가져오는 비즈니스 로직.
		int user_no = dao.getUserNo(user_id);
		
		// 현재 경매 물품을 상회입찰한 유저 번호를 가져오는 메서드
		int user_upper_no = dao.getUserUpperNo(product_no);
		
		// 현재 경매 물품을 등록한 판매자의 번호를 가져오는 메서드.
		int product_user_no = dao.getProductUserNo(product_no);
		
		// 경매물품의 시작 날짜와 종료 날짜를 정리하는 코드.
        String startDateString = dto.getSale_date();

        String endDateString = dto.getEnd_date();

        // 날짜 형식 변경
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
        LocalDateTime startDate = LocalDateTime.parse(startDateString, formatter);
        LocalDateTime endDate = LocalDateTime.parse(endDateString, formatter);

        // 남은 시간 계산
        Duration duration = Duration.between(LocalDateTime.now(), endDate);
        long hours = duration.toHours();
        long minutes = duration.toMinutesPart();
        long seconds = duration.toSecondsPart();
		
        long total = hours * 3600 + minutes * 60 + seconds;
		
		// 상회 입찰을 할려는 유저와 경매물품을 등록한 판매자의 유저 번호가 같은지 확인하는 코드
		if(product_user_no != user_no) {
			
			// 상회 입찰을 할려는 유저와 이미 상회입찰을 할려는 유저의 번호가 같은지 확인하는 코드
			if(user_upper_no != user_no) {
				
				// 유저가 정상 DB에 정상 등록 되었는지 확인하는 코드.
				if(user_no > 0) {
					
					check = dao.updateBid(product_no, user_bid, user_no);
					
					if(total <= 300) {
						
						dao.inputTime(product_no);
						
					}
					
					// 현재 상회 입찰가를 가져오는 메서드
					int user_upper = dao.getUpper(product_no);
					
					if(user_upper == dto.getSale_end_price()) {
						
						dao.inputBid(user_upper, product_no);
						
					}
					
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
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == 2) {
			out.println("<script>");
			out.println("alert('이미 입찰하신 상품입니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == 3) {
			out.println("<script>");
			out.println("alert('상품 판매자는 입찰할 수 없습니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -1) {
			out.println("<script>");
			out.println("alert('소지금이 부족합니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -2) {
			out.println("<script>");
			out.println("alert('최저 입찰금액보다 낮은 금액이 입력되었습니다."
					+ "다시 입력해주세요.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -3) {
			out.println("<script>");
			out.println("alert('최저 입찰금액보다 낮은 금액이 입력되었습니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -4) {
			out.println("<script>");
			out.println("alert('입력된 금액이 즉시 입찰가보다 높습니다. 확인 후 다시 입력해 주세요.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -5) {
			out.println("<script>");
			out.println("alert('오류가 발생하였습니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else if(check == -6) {
			out.println("<script>");
			out.println("alert('이미 구매가 완료된 경매품 입니다.')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('입찰에 실패 하였습니다')");
			out.println("location.href='product_detail.do?no="+product_no+"&user="+user_no+"'");
			out.println("</script>");
		}
		
		return null;
	}

}
