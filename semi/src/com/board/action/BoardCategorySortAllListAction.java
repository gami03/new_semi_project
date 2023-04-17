package com.board.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class BoardCategorySortAllListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 카테고리 별 전체 게시물 불러오는 비지니스 로직.
		
		String board_name = request.getParameter("board_name").trim();
		
		String field = request.getParameter("field");
        String keyword = request.getParameter("keyword");
        
        if (field != null && !field.trim().isEmpty()) {
		    field = field.trim();
		}

		if (keyword != null && !keyword.trim().isEmpty()) {
		    keyword = keyword.trim();
		}
		
		// 현재 페이지 변수
     	int page = 0;
     		
     		
 		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}else {
			// 처음으로 "자유 게시판" a 태그를 클린한 경우
			page = 1;
		}

        int rowsize = 10;
        
        // 비지니스 로직 진행
        BoardDAO dao = BoardDAO.getInstance();
        
        
        // JSON 형태로 데이터 반환
        JsonObject data = new JsonObject();
        
        // FAQ_board_list.jsp에서 넘어온 경우
        if(field == null) {
	        List<BoardDTO> list = dao.getBoardTimeList(page, rowsize, board_name);
	        data.addProperty("board_name", board_name);
	        data.addProperty("page", page);
	        data.addProperty("rowsize", 10);
	        data.addProperty("block", 7);
	        data.addProperty("totalRecord", dao.getBoardCount(board_name));
	        data.addProperty("allPage", (int)Math.ceil((double) dao.getBoardCount(board_name) / 10));
	        data.addProperty("startNo", (page - 1) * 10 + 1);
	        data.addProperty("endNo", (page - 1) * 10 + list.size());
	        data.addProperty("startBlock", ((page - 1) / 7) * 7 + 1);
	        data.addProperty("endBlock", (((page - 1) / 7) + 1) * 7);
	        data.addProperty("totalEndNo", dao.getBoardCount(board_name) - (page - 1) * 10);
	        data.add("list", new Gson().toJsonTree(list));
	        
        }else { // board_search.jsp에서 넘어온 경우
        	List<BoardDTO> searchList = dao.getSearchBoardTimeList(field, keyword, page, rowsize, board_name);
        	data.addProperty("board_name", board_name);
            data.addProperty("page", page);
            data.addProperty("rowsize", 10);
            data.addProperty("block", 7);
            data.addProperty("totalRecord", dao.searchListCount(field, keyword, board_name));
            data.addProperty("allPage", (int)Math.ceil((double) dao.searchListCount(field, keyword, board_name) / 10));
            data.addProperty("startNo", (page - 1) * 10 + 1);
            data.addProperty("endNo", (page - 1) * 10 + searchList.size());
            data.addProperty("startBlock", ((page - 1) / 7) * 7 + 1);
            data.addProperty("endBlock", (((page - 1) / 7) + 1) * 7);
            data.addProperty("totalEndNo", dao.searchListCount(field, keyword, board_name) - (page - 1) * 10);
            data.add("list", new Gson().toJsonTree(searchList));
        }

        // 응답 데이터로 전송
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(data));
		
		return null;
	}

}
