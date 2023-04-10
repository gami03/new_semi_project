package com.free_board.action;

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

public class BoardTimeListAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 요청 파라미터에서 데이터 가져오기
        String boardName = request.getParameter("board_name");
        
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
        List<BoardDTO> list = dao.getBoardTimeList(page, rowsize, boardName);

        // JSON 형태로 데이터 반환
        JsonObject data = new JsonObject();
        data.addProperty("board_name", boardName);
        data.addProperty("page", page);
        data.addProperty("rowsize", 10);
        data.addProperty("block", 7);
        data.addProperty("totalRecord", dao.getBoardCount(boardName));
        data.addProperty("allPage", (int)Math.ceil((double) dao.getBoardCount(boardName) / 10));
        data.addProperty("startNo", (page - 1) * 10 + 1);
        data.addProperty("endNo", (page - 1) * 10 + list.size());
        data.addProperty("startBlock", ((page - 1) / 7) * 7 + 1);
        data.addProperty("endBlock", (((page - 1) / 7) + 1) * 7);
        data.addProperty("totalEndNo", dao.getBoardCount(boardName) - (page - 1) * 10);
        data.add("list", new Gson().toJsonTree(list));

        // 응답 데이터로 전송
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(new Gson().toJson(data));

        return null;
	}

}
