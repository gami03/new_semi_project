package com.sale.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.sale.model.SaleDAO;
import com.sale.model.SaleDTO;

public class SaleSearchAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String user_noStr = request.getParameter("user_no");
		
		int user_no = 0;
        
        if (user_noStr != null && !user_noStr.trim().isEmpty()) {
            user_no = Integer.parseInt(user_noStr.trim());
        }
		
		String field = request.getParameter("field");
		
		if (field != null && !field.trim().isEmpty()) {
			field = field.trim();
		}
		
		String keyword = request.getParameter("keyword").trim();
		
		SaleDAO dao = SaleDAO.getInstance();
		
		// indexList의 갯수를 넘겨주는 메서드.
		int count = dao.getindexListnumber();
		
		// 한 페이지당 보여질 게시물의 수
		int rowsize = 12;
		
		// 아래에 보여질 페이지 최대 블럭 수
		int block = 7;
		
		// DB 상의 게시물의 전체 수
		int totalRecord = 0;
		
		// 전체 페이지 수
		int allPage = 0;
		
		// 현재 페이지 변수
		int page = 0;
		
		// 게시물 수의 끝번호 변수
		int totalEndNo = 0;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}else {
			// 처음으로 "자유 게시판" a 태그를 클린한 경우
			page = 1;
		}
		
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		// 해당 페이지에서 시작 블럭
		int startBlock = (((page - 1) / block) * block) + 1;
		
		// 해당 페이지에서 마지막 블럭
		int endBlock = (((page - 1) / block) * block) + block;
		
		if(field != null) {
			// 전체 게시물의 수를 확인하는 메서드 호출
			totalRecord = dao.getSearchProductCount(field, keyword);
			
			// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
			// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
			// 이 때 전체 페이지 수가 나올 때 나머지가 있으면 무조건 전체 페이지 수를 하나 올려 주어야 함.
			allPage = (int)Math.ceil(totalRecord / (double)rowsize);
			
			if(endBlock > allPage) {
				endBlock = allPage;
			}
			
			totalEndNo = totalRecord - ((page-1) * rowsize);
			List<SaleDTO> index = dao.getSearchList(field, keyword, page, rowsize);
			request.setAttribute("Index", index);
			
			// 지금까지 페이징 처리 시 작업했던 모든 데이터들을 view page로 이동을 시키자.
			request.setAttribute("page", page);
			request.setAttribute("rowsize", rowsize);
			request.setAttribute("block", block);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("allPage", allPage);
			request.setAttribute("startNo", startNo);
			request.setAttribute("endNo", endNo);
			request.setAttribute("startBlock", startBlock);
			request.setAttribute("endBlock", endBlock);
			request.setAttribute("Count", count);
			request.setAttribute("keyword", keyword);
			request.setAttribute("field", field);
			
			// 게시판에 모인 게시글을 번호를 순차적으로 매겨서 보여주기 위한 데이터를 view page로 이동.
			request.setAttribute("totalEndNo", totalEndNo);
			
		}else {
			// 전체 게시물의 수를 확인하는 메서드 호출
			totalRecord = dao.getSearchProductallCount(keyword);
			
			dao.insertkeyword(user_no, keyword);
			
			
			// 전체 게시물의 수를 한 페이지당 보여질 게시물의 수로 나누어 주어야 함.
			// 이 과정을 거치면 전체 페이지 수가 나오게 됨.
			// 이 때 전체 페이지 수가 나올 때 나머지가 있으면 무조건 전체 페이지 수를 하나 올려 주어야 함.
			allPage = (int)Math.ceil(totalRecord / (double)rowsize);
			
			if(endBlock > allPage) {
				endBlock = allPage;
			}
			
			totalEndNo = totalRecord - ((page-1) * rowsize);
			
			List<SaleDTO> index = dao.getSearchAllList(keyword, page, rowsize);
			request.setAttribute("Index", index);
			
			// 지금까지 페이징 처리 시 작업했던 모든 데이터들을 view page로 이동을 시키자.
			request.setAttribute("page", page);
			request.setAttribute("rowsize", rowsize);
			request.setAttribute("block", block);
			request.setAttribute("totalRecord", totalRecord);
			request.setAttribute("allPage", allPage);
			request.setAttribute("startNo", startNo);
			request.setAttribute("endNo", endNo);
			request.setAttribute("startBlock", startBlock);
			request.setAttribute("endBlock", endBlock);
			request.setAttribute("Count", count);
			request.setAttribute("keyword", keyword);
			request.setAttribute("field", field);
			
			// 게시판에 모인 게시글을 번호를 순차적으로 매겨서 보여주기 위한 데이터를 view page로 이동.
			request.setAttribute("totalEndNo", totalEndNo);
		}
		
		ActionForward forward = new ActionForward();
		
		// view page로 이동 시에는 false 값 지정.
		forward.setRedirect(false);
		
		forward.setPath("sale/sale_search_list.jsp");
		
		return forward;
		
	}
}
