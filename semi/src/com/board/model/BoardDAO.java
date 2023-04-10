package com.board.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class BoardDAO {

	// DAO 객체를 싱글턴 방식으로 만들어서 사용을 해 보자.
	
	// DB와 연동하는 객체.
	Connection con = null;
			
	// DB에 SQL문을 전송하는 객체.
	PreparedStatement pstmt = null;
			
	// SQL문을 실행한 후에 결과 값을 가지고 있는 객체.
	ResultSet rs = null;
			
	// 쿼리문을 저장할 변수
	String sql = null;
			
	// BoardDAO 클래스를 싱글턴 방식으로 만들어 보자.
	// 1단계 : 싱글턴 방식으로 객체를 만들기 위해서는 우선적으로 기본생성자의 접근제어자를 
	//        public 이 아니라 private 으로 바꾸어 주어야 한다.
	//        즉, 외부에서는 직접적으로 기본생성자를 호출하지 못하게 하는 방식이다.
			
	// 2단계 : BoardDAO 클래스를 정적(static) 멤버로 선언을 해 주어야 한다.
	private static BoardDAO instance;
			
	private BoardDAO() { } // 기본 생성자
			
	// 3단계 : 기본생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 메서드를 만들어서 
	//        해당 getInstance() 메서드를 외부에서 접근할 수 있도록 해주면 됨.
	public static BoardDAO getInstance() {
				
		if(instance == null) {
			instance = new BoardDAO();
		}
				
		return instance;
	} // getInstance() 메서드 end
			
	// DB를 연동하는 작업을 진행하는 메서드.
		public void openConn() {
			 String driver = "org.mariadb.jdbc.Driver";
	         
	         String url = "jdbc:mariadb://192.168.40.3:3306/semi";
	            
	         String user  = "root";
	               
	         String password = "1234";
			
					
			try {
				// 1단계 : 오라클 드라이버를 메모리로 로딩 작업 진행.
				Class.forName(driver);
				System.out.println("드라이버로딩 성공!!!");
				// 2단계 : 오라클 데이터베이스와 연결 작업 진행.
				con = DriverManager.getConnection(url, user, password);
						
						
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // openConn() 메서드 end
	
	// DB에 연결되어 있던 자원 종료하는 메서드.
	public void closeConn(ResultSet rs, PreparedStatement pstmt, Connection con) {
		
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	} // closeConn() 메서드 end
	
	// board 테이블의 전체게시물의 수를 확인하는 메서드.
		public int getBoardCount(String name) {
			
			int count = 0;
			
			try {
				openConn();
				
				sql = "select count(*) from board where board_name = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, name);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				} 
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return count;
		} // getBoardCount 메서드 end
	
	// board 테이블에서 현재 페이지에 해당하는 게시물을 조회하는 메서드
	public List<BoardDTO> getBoardList(int page, int rowsize, String name) {
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
	
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from (select row_number() over(order by board_no desc) rnum, b.*, u.user_nickname from board b join user_table u on b.user_no = u.user_no where board_name = ?) Y where rnum >=? and rnum <=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_category(rs.getString("board_category"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file1(rs.getString("board_file1"));
				dto.setBoard_file2(rs.getString("board_file2"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_rec(rs.getInt("board_rec"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // getBoardList() 메서드 end
	
	// 세션으로 넘어온 아이디로 닉네임 보여주는 메서드 작성
	public String getUserNickname(String id) {
		
		String nickname = null;
		
		try {
			openConn();
			
			sql = "select user_nickname from user_table where user_id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nickname = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return nickname;
	} // getUserNickname() 메서드 end
	
	// 세션으로 넘어온 아이디로 user_no 보여주는 메서드 작성
	public int getUserNo(String id) {
		int user_no = 0;
		
		try {
			openConn();
			
			sql = "select user_no from user_table where user_id=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user_no = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return user_no;
	} // getUserNo() 메서드 end
	
	//
	public int insertUpload(BoardDTO dto) {
		
		int result = 0, count = 0;
		
		try {
			openConn();
			
			sql = "select max(board_no) from board";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into board values(?, ?, ?, ?, ?, ?, ?, ?, 0, 0, now(), null)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setInt(2, dto.getUser_no());
			pstmt.setString(3, dto.getBoard_name());
			pstmt.setString(4, dto.getBoard_category());
			pstmt.setString(5, dto.getBoard_title());
			pstmt.setString(6, dto.getBoard_content());
			pstmt.setString(7, dto.getBoard_file1());
			pstmt.setString(8, dto.getBoard_file2());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // insertUpload() 메서드 end
	
	// board 테이블의 게시글 번호에 해당하는 게시글의 조회수를 증가시켜주는 메서드.
	public void getBoardHit(int no) {
		
		try {
			openConn();
			
			sql = "update board set board_hit = board_hit + 1 where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	} // getBoardHit() 메서드 end
	
	// upload 테이블의 글번호에 해당하는 게시글의 상세내역을 조회하는 메서드.
	public BoardDTO getBoardContent(int no) {
		
		BoardDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from board where Board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new BoardDTO();
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_rec(rs.getInt("board_rec"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_file1(rs.getString("board_file1"));
				dto.setBoard_file2(rs.getString("board_file2"));
				dto.setBoard_category(rs.getString("board_category"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		return dto;
	} // uploadContent() 메서드 end
	
	// 닉네임으로 아이디 가져오는 메서드.
	public String getUserId(String nickname) {
		
		String id = "";
		
		try {
			openConn();
			
			sql = "select user_id from user_table where user_nickname = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, nickname);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				id = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return id;
	} // getUserId() 메서드 end
	
	// 글번호에 해당하는 댓글 전체 리스트를 조회하는 메서드.
	public String getReplyList(int reply_no) {
		
		String result = "";
		
		try {
			openConn();
			
			sql = "select * from board_reply r join user_table u on r.user_no = u.user_no where board_no = ? order by br_regdate desc";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, reply_no);
			
			rs = pstmt.executeQuery();
			
			result += "<replys>";
			
			while(rs.next()) {
				result += "<reply>";
				result += "<com_no>"+rs.getInt("com_no")+"</com_no>";
				result += "<user_no>"+rs.getInt("user_no")+"</user_no>";
				result += "<user_nickname>"+rs.getString("user_nickname")+"</user_nickname>";
				result += "<board_no>"+rs.getInt("board_no")+"</board_no>";
				result += "<br_content>"+rs.getString("br_content")+"</br_content>";
				result += "<br_regdate>"+rs.getString("br_regdate")+"</br_regdate>";
				result += "</reply>";
			}
			
			result += "</replys>";
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // getReplyList() 메서드 end
	
	// 댓글 내용을 tbl_reply 테이블에 저장하는 메서드.
	public int replyInsert(BoardReplyDTO dto) {
		
		int result = 0, count = 0;
		
		try {
			openConn();
			
			sql = "select max(com_no) from board_reply";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1) + 1;
			}
			
			sql = "insert into board_reply values(?, ?, ?, ?, now())";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setInt(2, dto.getUser_no());
			pstmt.setInt(3, dto.getBoard_no());
			pstmt.setString(4, dto.getBr_content());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // replyInsert() 메서드 end
	
	// 댓글 com.no에 해당하는 user_no 가져오는 메서드
	public int getUserNoWhereComno(int reply_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select user_no from board_reply where com_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, reply_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // getUserNoWhereComno() 메서드 end
	
	//
	public String getUserNicknameWhereuserno(int user_no) {
		
		String nickname = "";
		
		try {
			openConn();
			
			sql = "select user_nickname from user_table where user_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, user_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nickname = rs.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return nickname;
	} // getUserNicknameWhereuserno() 메서드 end
	
	//
	public int deleteBoard(int board_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			// 1. "board_reply" 테이블에서 해당 "board_no"를 참조하는 모든 행을 먼저 삭제합니다.
			sql = "delete from board_reply where board_no = ?";
			
	        pstmt = con.prepareStatement(sql);
	        
	        pstmt.setInt(1, board_no);
	        
	        pstmt.executeUpdate();
	        
	        pstmt.close();
	        
	     // 3. "board" 테이블에서 해당 "board_no"의 게시글을 삭제합니다.
			sql = "select * from board where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "delete from board where board_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, board_no);
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // deleteBoard(board_no)
	
	public void updateSequence(int no) {
		try {
			openConn();
			
			sql = "update board set board_no = board_no - 1 where board_no > ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	} // updateSequence() 메서드 end
	
	// board 테이블에 게시글 번호에 해당하는 게시글을 수정하는 메서드.
	public int ModifyUpload(BoardDTO dto) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from board where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getBoard_no());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if((dto.getBoard_file1() == null) && (dto.getBoard_file2() == null)) {
					// 첨부파일이 없는 경우
					sql = "update board set board_title = ?, board_category = ?, board_content = ?, board_update = now() where board_no = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getBoard_title());
					pstmt.setString(2, dto.getBoard_category());
					pstmt.setString(3, dto.getBoard_content());
					pstmt.setInt(4, dto.getBoard_no());
				}else if((dto.getBoard_file1() != null) && (dto.getBoard_file2() == null)){
					// 첨부파일1만 있는경우
					sql = "update board set board_title = ?, board_category = ?, board_content = ?, board_file1 = ?, board_update = now() where board_no = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getBoard_title());
					pstmt.setString(2, dto.getBoard_category());
					pstmt.setString(3, dto.getBoard_content());
					pstmt.setString(4, dto.getBoard_file1());
					pstmt.setInt(5, dto.getBoard_no());
				
				}else if((dto.getBoard_file1() == null) && (dto.getBoard_file2() != null)) {
					// 첨부파일 2만 있는 경우
					sql = "update board set board_title = ?, board_category = ?, board_content = ?, board_file2 = ?, board_update = now() where board_no = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getBoard_title());
					pstmt.setString(2, dto.getBoard_category());
					pstmt.setString(3, dto.getBoard_content());
					pstmt.setString(4, dto.getBoard_file1());
					pstmt.setInt(5, dto.getBoard_no());
				}else if((dto.getBoard_file1() != null) && (dto.getBoard_file2() != null)){
					// 첨부파일이 둘다 있는 경우
					sql = "update board set board_title = ?, board_category = ?, board_content = ?, board_file1 = ?, board_file2 = ?, board_update = now() where board_no = ?";
					
					pstmt = con.prepareStatement(sql);
					
					pstmt.setString(1, dto.getBoard_title());
					pstmt.setString(2, dto.getBoard_category());
					pstmt.setString(3, dto.getBoard_content());
					pstmt.setString(4, dto.getBoard_file1());
					pstmt.setString(5, dto.getBoard_file2());
					pstmt.setInt(6, dto.getBoard_no());
				}
				
				result = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // ModifyUpload() 메서드 end
	
	// 자유게시판에서 검색어에 해당하는 게시물의 수를 조회하는 메서드
	public int searchListCount(String field, String keyword, String board_name) {
		
		int count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from board b join user_table u on b.user_no = u.user_no";
			
			if(field.equals("title")) {
				sql += " where board_title like ? and board_name = ?";
			}else if(field.equals("cont")) {
				sql += " where board_content like ? and board_name = ?";
			}else if(field.equals("title_cont")) {
				sql += " where (board_title like ? or board_content like ?) and board_name = ?";
			}else if(field.equals("writer")){
				sql += " where user_nickname like ? and board_name = ?";
			}else {
				sql += " where board_category like ? and board_name = ?";
			}
			
			sql += " order by board_no desc";
			
			pstmt = con.prepareStatement(sql);
			
			if(field.equals("title_cont")) {
				pstmt.setString(1, '%'+keyword+'%');
				pstmt.setString(2, '%'+keyword+'%');
				pstmt.setString(3, board_name);
			}else {
				pstmt.setString(1, '%'+keyword+'%');
				pstmt.setString(2, board_name);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return count;
	} // searchListCount() 메서드 end
	
	// board 테이블에서 검색한 내용을 가지고 페이징 처리하는 메서드.
	public List<BoardDTO> getSearchBoardList(String field, String keyword, int page, int rowsize, String board_name) {
		
		List<BoardDTO> searchList = new ArrayList<BoardDTO>();
		
		// 해당 페이지에서 시작번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from (select row_number() over(order by board_no desc) rnum, b.*, u.user_nickname from board b join user_table u on b.user_no = u.user_no";
					
			if(field.equals("title")) {
				sql += " where board_title like ? and board_name = ?) Y";
			}else if(field.equals("cont")) {
				sql += " where board_content like ? and board_name = ?) Y";
			}else if(field.equals("title_cont")) {
				sql += " where (board_title like ? or board_content like ?) and board_name = ?) Y";
			}else if(field.equals("writer")){
				sql += " where user_nickname like ? and board_name = ?) Y";
			}else {
				sql += " where board_category like ? and board_name = ?) Y";
			}
			
			sql += " where rnum >=? and rnum <=?";
					
			pstmt = con.prepareStatement(sql);
			
			if(field.equals("title_cont")) {
				pstmt.setString(1, '%'+keyword+'%');
				pstmt.setString(2, '%'+keyword+'%');
				pstmt.setString(3, board_name);
				pstmt.setInt(4, startNo);
				pstmt.setInt(5, endNo);
			}else {
				pstmt.setString(1, '%'+keyword+'%');
				pstmt.setString(2, board_name);
				pstmt.setInt(3, startNo);
				pstmt.setInt(4, endNo);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_category(rs.getString("board_category"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file1(rs.getString("board_file1"));
				dto.setBoard_file2(rs.getString("board_file2"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_rec(rs.getInt("board_rec"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				
				searchList.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return searchList;
	} // getSearchBoardList() 메서드 end
	
	// 게시글 추천여부 검사
	public int recCheck(int board_no, int user_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "SELECT COUNT(*) FROM board_recommend WHERE user_no = ? AND board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, user_no);
			pstmt.setInt(2, board_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // recCheck() 메서드 end
	
	// 게시글 추천 추가 메서드
	public void recUpdate(int board_no, int user_no) {
		
		try {
			openConn();
			
			sql = "insert into board_recommend values(?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_no);
			pstmt.setInt(2, user_no);
			
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	} // recUpdate() 메서드 end
	
	// 게시글 추천 제거
	public void recDelete(int board_no, int user_no) {
		
		try {
			openConn();
			
			sql = "delete from board_recommend where board_no = ? and user_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_no);
			pstmt.setInt(2, user_no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	} // recDelete() 메서드 end
	
	// 게시글 추천 수 
	public int recCount(int board_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from board_recommend where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	} // reCount() 메서드 end
	
	// 추천을 추가/삭제 했을 때 board테이블의 해당 게시물의 추천수 업데이트하는 메서드.
	public void boardRecCount(int board_no) {
		
		try {
			openConn();
			
			sql = "select count(*) from board_recommend where board_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, board_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				sql = "update board set board_rec = ? where board_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, rs.getInt(1));
				pstmt.setInt(2, board_no);
				
				pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
	} // boardRecCount() 메서드 end
	
	
	// board 테이블에서 현재 페이지에 해당하는 게시물을 좋아요수 많은 순으로 조회하는 메서드
	public List<BoardDTO> getBoardHitList(int page, int rowsize, String name) {
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
	
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from (select row_number() over(order by board_rec desc, board_no desc) rnum, b.*, u.user_nickname from board b join user_table u on b.user_no = u.user_no where board_name = ?) Y where rnum >=? and rnum <=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_category(rs.getString("board_category"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file1(rs.getString("board_file1"));
				dto.setBoard_file2(rs.getString("board_file2"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_rec(rs.getInt("board_rec"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // getBoardHitList() 메서드 end
	
	// board 테이블에서 현재 페이지에 해당하는 게시물을 시간순으로 조회하는 메서드
	public List<BoardDTO> getBoardTimeList(int page, int rowsize, String name) {
		
		List<BoardDTO> list = new ArrayList<BoardDTO>();
	
		// 해당 페이지에서 시작 번호
		int startNo = (page * rowsize) - (rowsize - 1);
		
		// 해당 페이지에서 끝 번호
		int endNo = (page * rowsize);
		
		try {
			openConn();
			
			sql = "select * from (select row_number() over(order by board_no desc) rnum, b.*, u.user_nickname from board b join user_table u on b.user_no = u.user_no where board_name = ?) Y where rnum >=? and rnum <=?";
			 
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setInt(2, startNo);
			pstmt.setInt(3, endNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				
				
				dto.setBoard_no(rs.getInt("board_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setUser_nickname(rs.getString("user_nickname"));
				dto.setBoard_name(rs.getString("board_name"));
				dto.setBoard_category(rs.getString("board_category"));
				dto.setBoard_title(rs.getString("board_title"));
				dto.setBoard_content(rs.getString("board_content"));
				dto.setBoard_file1(rs.getString("board_file1"));
				dto.setBoard_file2(rs.getString("board_file2"));
				dto.setBoard_hit(rs.getInt("board_hit"));
				dto.setBoard_rec(rs.getInt("board_rec"));
				dto.setBoard_date(rs.getString("board_date"));
				dto.setBoard_update(rs.getString("board_update"));
				
				list.add(dto);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	} // getBoardTimeList() 메서드 end
	
	// board 테이블에서 현재 페이지에 해당하는 게시물을 조회수 순으로 조회하는 메서드
		public List<BoardDTO> getBoardLookList(int page, int rowsize, String name) {
			
			List<BoardDTO> list = new ArrayList<BoardDTO>();
		
			// 해당 페이지에서 시작 번호
			int startNo = (page * rowsize) - (rowsize - 1);
			
			// 해당 페이지에서 끝 번호
			int endNo = (page * rowsize);
			
			try {
				openConn();
				
				sql = "select * from (select row_number() over(order by board_hit desc, board_no desc) rnum, b.*, u.user_nickname from board b join user_table u on b.user_no = u.user_no where board_name = ?) Y where rnum >=? and rnum <=?";
				 
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, name);
				pstmt.setInt(2, startNo);
				pstmt.setInt(3, endNo);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					BoardDTO dto = new BoardDTO();
					
					
					dto.setBoard_no(rs.getInt("board_no"));
					dto.setUser_no(rs.getInt("user_no"));
					dto.setUser_nickname(rs.getString("user_nickname"));
					dto.setBoard_name(rs.getString("board_name"));
					dto.setBoard_category(rs.getString("board_category"));
					dto.setBoard_title(rs.getString("board_title"));
					dto.setBoard_content(rs.getString("board_content"));
					dto.setBoard_file1(rs.getString("board_file1"));
					dto.setBoard_file2(rs.getString("board_file2"));
					dto.setBoard_hit(rs.getInt("board_hit"));
					dto.setBoard_rec(rs.getInt("board_rec"));
					dto.setBoard_date(rs.getString("board_date"));
					dto.setBoard_update(rs.getString("board_update"));
					
					list.add(dto);
				}
				
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return list;
		} // getBoardLookList() 메서드 end
	
 	
}
