package com.board.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.action.Action;
import com.action.ActionForward;
import com.board.model.BoardDAO;
import com.board.model.BoardDTO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardWriteOkAction implements Action {

	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 자료실 폼 페이지에서 넘어온 데이터들을 DB(upload 테이블)에 저장하는 비지니스 로직.
		
		BoardDTO dto = new BoardDTO();
	      
	      String board_name = request.getParameter("board_name");
	      
	      Properties prop = new Properties();
	      
	      FileInputStream fis = new FileInputStream(request.getServletContext().getRealPath("\\WEB-INF\\classes\\com\\reply\\controller\\mapping.properties"));
	      
	      prop.load(fis);
	      
	      String saveFolder = prop.getProperty(System.getenv("USERPROFILE").substring(3));
	      
	      System.out.println(System.getenv("USERPROFILE").substring(3));
	      System.out.println(saveFolder);
	      // 파일 업로드 시에는 설정해야 할 내용이 있음.
	      // 1. 첨부 파일 저장 경로 지정.
	      saveFolder += "\\"+board_name+"\\"+board_name+"_fileUpload";
	      
	      // 2. 첨부 파일 크기 지정.
	      int fileSize = 10 * 1024 * 1024; // 10MB
		
		// 3. MultipartRequest 객체 생성
		//    ==> 파일 업로드를 진행하기 위한 객체 생성.
		MultipartRequest multi = new MultipartRequest(
									 request, 		// 일반적인 request 객체
									 saveFolder, // 첨부파일이 저장될 경로
									 fileSize, 	// 업로드할 첨부파일의 최대 크기
									"UTF-8",		// 문자 인코딩 방식
									 new DefaultFileRenamePolicy() // 첨부 파일의 이름이 같은 경우 중복이 안되게 설정.
									 );
		
		// 자료실 폼 페이지에서 넘어온 데이터들을 받아 주자.
		String upload_title = multi.getParameter(board_name+"_title").trim();
		String upload_summernote = multi.getParameter("editordata").trim();
		String upload_category = multi.getParameter(board_name+"_category");
		
		if (upload_category != null && !upload_category.trim().isEmpty()) {
		    upload_category = upload_category.trim();
		} else {
		    // upload_category가 null인 경우에 대한 예외 처리 코드
			
		}
		
		// 자료실 폼 페이지에서 type="file" 속성으로 되어 있으면 getfile() 메서드로 받아 주어야 함.
		File upload_file1 = multi.getFile("upload_file1");
		File upload_file2 = multi.getFile("upload_file2");
		
		// 넘어온 아이디도 받아주자.
		String user_id = multi.getParameter("id").trim();
		
		System.out.println("글쓰기 user_id >>> "+user_id);
		// 글쓴 사람을 세션으로 넘어온 아이디를 통해서 user_no, user_nickname을 받아오자.
		BoardDAO dao = BoardDAO.getInstance();
		
		String user_nickname = dao.getUserNickname(user_id);
		
		int user_no = dao.getUserNo(user_id);
		
		if(upload_file1 != null) { // 첨부파일이 존재하는 경우.
			
			// 우선은 첨부파일의 이름을 알아야 함.
			// getName() 메서드를 이용하면 이름을 알 수 있음.
			String fileName = upload_file1.getName();
			// fileName1 + "," + fileName2 +...
			// String fileName += fileName2 
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			
			int month = cal.get(Calendar.MONTH) + 1;
			
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			// ......../fileUpload/2023-03-28
			String homedir = saveFolder+"/"+year+"-"+month+"-"+day;
			
			// 날짜 폴더를 만들어 보자.
			File path1 = new File(homedir);
			
			String homedir2 = homedir+"/"+user_id;
			
			File path2 = new File(homedir2);
					
			if(!path1.exists()) { // 폴더가 존재하지 않는 경우
				path1.mkdir(); // 실제 폴더를 만들어 주는 메서드
			}
			
			if(!path2.exists()) { // 폴더가 존재하지 않는 경우
				path2.mkdir(); // 실제 폴더를 만들어 주는 메서드
			}
			
			// 파일을 만들어 보자 ==> 예) 홍길동_파일명
			String reFileName = user_id+"_"+fileName;
			
			upload_file1.renameTo(new File(homedir2+"/"+reFileName));
			
			// 실제로 DB에 저장되는 파일이름.
			// "/2023-03-28/홍길동_파일명" 으로 저장 예정.
			String fileDBName1 = "/"+year+"-"+month+"-"+day+"/"+user_id+"/"+reFileName;
			
			dto.setBoard_file1(fileDBName1);
		}
		
		if(upload_file2 != null) { // 첨부파일이 존재하는 경우.
			
			// 우선은 첨부파일의 이름을 알아야 함.
			// getName() 메서드를 이용하면 이름을 알 수 있음.
			String fileName = upload_file2.getName();
			// fileName1 + "," + fileName2 +...
			// String fileName += fileName2 
			
			// 날짜 객체 생성
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			
			int month = cal.get(Calendar.MONTH) + 1;
			
			int day = cal.get(Calendar.DAY_OF_MONTH);
			
			// ......../fileUpload/2023-03-28
			String homedir = saveFolder+"/"+year+"-"+month+"-"+day;
			
			// 날짜 폴더를 만들어 보자.
			File path1 = new File(homedir);
			
			String homedir2 = homedir+"/"+user_id;
			
			File path2 = new File(homedir2);
					
			if(!path1.exists()) { // 폴더가 존재하지 않는 경우
				path1.mkdir(); // 실제 폴더를 만들어 주는 메서드
			}
			
			if(!path2.exists()) { // 폴더가 존재하지 않는 경우
				path2.mkdir(); // 실제 폴더를 만들어 주는 메서드
			}
			
			
			// 파일을 만들어 보자 ==> 예) 홍길동_파일명
			String reFileName = user_id+"_"+fileName;
			
			upload_file2.renameTo(new File(homedir2+"/"+reFileName));
			
			// 실제로 DB에 저장되는 파일이름.
			// "/2023-03-28/홍길동_파일명" 으로 저장 예정.
			String fileDBName2 = "/"+year+"-"+month+"-"+day+"/"+user_id+"/"+reFileName;
			
			dto.setBoard_file2(fileDBName2);
		}
		
		dto.setUser_no(user_no);
		dto.setUser_nickname(user_nickname);
		dto.setBoard_title(upload_title);
		dto.setBoard_category(upload_category);
		dto.setBoard_content(upload_summernote);
		dto.setBoard_name(board_name);
		
		
		int check = dao.insertUpload(dto);
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('게시글이 등록 되었습니다.')");
			out.println("location.href='board_list.do?board_name="+board_name+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 등록 오류입니다. 확인 후 다시 시도 부탁드립니다.')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		return null;
	}

}
