package com.sale.action;

import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;
import com.user.model.UserDAO;
import com.user.model.UserDTO;

public class ProductDetailAction implements Action {

    @Override
    public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {

        int sale_no = Integer.parseInt(request.getParameter("no").trim());
        
        String user_noStr = request.getParameter("user");
        
        int user_no = 0;
        
        if (user_noStr != null && !user_noStr.trim().isEmpty()) {
            user_no = Integer.parseInt(user_noStr.trim());
        }
        
        System.out.println(user_no);
        
        SaleDAO dao = SaleDAO.getInstance();
        
        UserDAO udao = UserDAO.getInstance();
        
        // 상회입찰가의 정보를 가져오는 메서드
        int upper = dao.getUpper_value(sale_no);
        
        // DB에 저장된 경매물품의 마감 시간이 지났는지 확인하는 메서드
        int date_check = dao.getEndDate(sale_no);
        
        System.out.println("date_check >>> " +date_check);
        
        // 로그인한 회원의 정보를 가져오는 메서드
        int user_money = udao.getUserMoney(user_no);
        
        // 경매물품의 상세정보를 가져오는 메서드
        SaleDTO dto = dao.getProductDetail(sale_no);

        // 판매자의 정보를 가져오는 메서드.
        UserDTO udto = udao.getUserOne(dto.getUser_no());
        
        // 판매자의 경매물품 판매 이력을 가져오는 메서드
        int count = dao.getCountProduct(dto.getUser_no());
        
        // 관심상품 되있는지 여부 체크하기 위해 필요한 정보 불러오는 메서드.
        int wishlistCheck = dao.wishListCheck(user_no, sale_no);
        
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

        // 남은 시간 정보를 request에 저장
        request.setAttribute("hours", hours);
        request.setAttribute("minutes", minutes);
        request.setAttribute("seconds", seconds);
        request.setAttribute("Dto", dto);
        request.setAttribute("Udto", udto);
        request.setAttribute("Count", count);
        request.setAttribute("User_money", user_money);
        request.setAttribute("Date_check", date_check);
        request.setAttribute("Upper", upper);
        request.setAttribute("wishlistCheck", wishlistCheck);
        System.out.println(user_money);
        ActionForward forward = new ActionForward();

        // view page로 이동 시에는 false 값 지정.
        forward.setRedirect(false);

        forward.setPath("sale/product_detail.jsp");

        return forward;
    }

}
