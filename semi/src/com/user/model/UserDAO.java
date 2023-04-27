package com.user.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;





public class UserDAO {

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
		private static UserDAO instance;
				
		private UserDAO() { } // 기본 생성자
				
		// 3단계 : 기본생성자 대신에 싱글턴 객체를 return 해 주는 getInstance() 메서드를 만들어서 
		//        해당 getInstance() 메서드를 외부에서 접근할 수 있도록 해주면 됨.
		public static UserDAO getInstance() {
					
			if(instance == null) {
				instance = new UserDAO();
			}
					
			return instance;
		} // getInstance() 메서드 end
				
		// DB를 연동하는 작업을 진행하는 메서드.
			public void openConn() {
				String driver = "org.mariadb.jdbc.Driver";
		         
		        String url = "jdbc:mariadb://211.42.114.149:3306/semi";
		            
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
 	
 	public int insertMember(UserDTO dto) {
 		
 		int result=0, count = 0;
 		
 	
 		
 		try {
	 		
	 		openConn();
	 		
	 		sql= "select max(num) from board1";
			pstmt = con.prepareStatement(sql);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			sql="insert into user_table values(?, ?, ?, ?, ?, ?, ?, ?, sysdate, 0)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count+1);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_pwd());
			pstmt.setString(5, dto.getUser_email());
			pstmt.setString(6, dto.getUser_phone());
			pstmt.setString(7, dto.getUser_birth());
			pstmt.setInt(8, dto.getUser_approve());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
 		
 		return result;
 	} 
 	
 	public int userCheck(String user_id, String user_pwd) {

		int result = 0; // 로그인 실패시 -1 반환

		try {
			openConn();
			
			
			
			//sql = "select * from usertable";
			sql = "select user_pwd from user_table where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 아이디가 있음.
				String dbPW = rs.getString("user_pwd");
				if(dbPW.equals(user_pwd)) { // 아이디+비밀번호 맞음.

					result = 1; // 로그인 성공
				} else { // 비밀번호 불일치
				result = -2;
				}
			}else { //로그인 실패
				result = -1;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
 	
 	public int getUserApprove(String id) {
 		
 		int result = 0;
 		
 		try {
 			openConn();
 	 		
 	 		sql = "select user_approve from user_table where user_id = ?";
 	 		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
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
 	} // getUserApprove() 메서드 end
 	
 	
 	// 세션으로 사용하는 user_id를 가져와서 user_no값을 가져올 떄 사용하는 메서드
 	// 다른 테이블에서 정보 가져오려고 매번 조인하는거 보다 나을거 같아서
 	public int getUserNo(String session_id) {
 		
 		int no = 0;
 		
 		try {
 			openConn();
 	 		
 	 		sql = "select user_no from user_table where user_id = ?";
 	 		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, session_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				no = rs.getInt("user_no");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
 		
 		return no;
 	}
 	
 	
 	// user 회원 목록 전체를 가져오는 메서드
  	public List<UserDTO> getUserInfo(int page, int rowsize) {	// user_no 혹은 user_id
  		
  		List<UserDTO> list = new ArrayList<UserDTO>();
  		
  		// 해당 페이지에서 시작번호
  		int startNo = (page * rowsize) - (rowsize - 1);
	
  		// 해당 페이지에서 끝번호
  		int endNo = (page * rowsize);
  		
  		openConn();
  		
  		sql = "select * from (select row_number() over(order by user_no desc) rnum, u.*, a.approve_name from user_table u join approve a on a.approve_no = u.user_approve where u.user_approve < 3) Y  where rnum >= ? and rnum <= ? order by user_no desc";

  		try {
 			pstmt = con.prepareStatement(sql);
 			
 			pstmt.setInt(1, startNo);
 			pstmt.setInt(2, endNo);
 			
 			rs = pstmt.executeQuery();
 			
 			while(rs.next()) {
 				UserDTO dto = new UserDTO();
 				
 				dto.setUser_no(rs.getInt("user_no"));
 				dto.setUser_id(rs.getString("user_id"));
 				dto.setUser_name(rs.getString("user_name"));
 				dto.setUser_nickname(rs.getString("user_nickname"));
 				dto.setUser_pwd(rs.getString("user_pwd"));
 				dto.setUser_approve(rs.getInt("user_approve"));
 				dto.setApprove_name(rs.getString("approve_name"));
 				
 				list.add(dto);
 			}
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} finally {
 			closeConn(rs, pstmt, con);
 		}
  		
  		return list;
  	}
  	
  	// user 회원 목록 전체를 가져오는 메서드
   	public List<UserDTO> getAdminInfo(int page, int rowsize) {	// user_no 혹은 user_id
   		
   		List<UserDTO> list = new ArrayList<UserDTO>();
   		
   		// 해당 페이지에서 시작번호
   		int startNo = (page * rowsize) - (rowsize - 1);
 	
   		// 해당 페이지에서 끝번호
   		int endNo = (page * rowsize);
   		
   		openConn();
   		
   		sql = "select * from (select row_number() over(order by user_no desc) rnum, u.*, a.approve_name from user_table u join approve a on a.approve_no = u.user_approve) Y  where rnum >= ? and rnum <= ? order by user_no desc";
   		
   		try {
  			pstmt = con.prepareStatement(sql);
  			
  			pstmt.setInt(1, startNo);
  			pstmt.setInt(2, endNo);
  			
  			rs = pstmt.executeQuery();
  			
  			while(rs.next()) {
  				UserDTO dto = new UserDTO();
  				
  				dto.setUser_no(rs.getInt("user_no"));
  				dto.setUser_id(rs.getString("user_id"));
  				dto.setUser_name(rs.getString("user_name"));
  				dto.setUser_nickname(rs.getString("user_nickname"));
  				dto.setUser_pwd(rs.getString("user_pwd"));
  				dto.setUser_approve(rs.getInt("user_approve"));
  				dto.setApprove_name(rs.getString("approve_name"));
  				
  				list.add(dto);
  			}
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   		return list;
   	}
 	
   	// user 회원 등급 설정
   	public void requestApprove(String id) {	// user_no 혹은 user_id
   		
   		
   		try {
   			openConn();
   			
  			sql = "update user_table set user_approve = 1 where user_id = ?";
  			
  			pstmt = con.prepareStatement(sql);
  			
  			pstmt.setString(1, id);
  			
  			pstmt.executeUpdate();
  			
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   	}
   	
  	// user 회원 등급 설정
  	public int UpdateApprove(int no, int new_approve) {	// user_no 혹은 user_id
  		
  		int result = 0;
  		
  		try {
  			openConn();
  			
 			sql = "update user_table set user_approve = ? where user_no = ?";
 			
 			pstmt = con.prepareStatement(sql);
 			
 			pstmt.setInt(1, new_approve);
 			pstmt.setInt(2, no);
 			
 			result = pstmt.executeUpdate();
 			
 		} catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		} finally {
 			closeConn(rs, pstmt, con);
 		}
  		
  		return result;
  	}
  	
  	// user 회원 삭제
   	public int DeleteUserData(int no) {	// user_no 혹은 user_id
   		
   		int result = 0;
   		
   		try {
   			openConn();
   			
  			sql = "update user_table set user_approve = ? where user_no = ?";
  			
  			pstmt = con.prepareStatement(sql);
  			
  			pstmt.setInt(1, no);
  			
  			result = pstmt.executeUpdate();
  			
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   		return result;
   	}
   	
   	// 전체 유저의 수를 확인하는 메서드 호출
   	public int getUserCount() {
   		
   		int count = 0;
   		
   		openConn();
   		
   		sql = "select count(*) from user_table";
   		
   		try {
			pstmt = con.prepareStatement(sql);
			
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
   	}
   	
   	
   	// user 회원 목록 전체를 가져오는 메서드
   	public List<UserDTO> getUserInfoSearch(String search, String data) {	// user_no 혹은 user_id
   		
   		List<UserDTO> list = new ArrayList<UserDTO>();
   		
   		openConn();
   		
   		sql = "select * from user_table where ? like ? ";
   		
   		try {
  			pstmt = con.prepareStatement(sql);
  			
  			pstmt.setString(1, search);
  			pstmt.setString(2, "%"+data+"%");
  			
  			rs = pstmt.executeQuery();
  			
  			while(rs.next()) {
  				UserDTO dto = new UserDTO();
  				
  				dto.setUser_no(rs.getInt("user_no"));
  				dto.setUser_id(rs.getString("user_id"));
  				dto.setUser_name(rs.getString("user_name"));
  				dto.setUser_nickname(rs.getString("user_nickname"));
  				dto.setUser_pwd(rs.getString("user_pwd"));
  				dto.setUser_approve(rs.getInt("user_approve"));
  				
  				list.add(dto);
  			}
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   		return list;
   	}
   	
   	// 판매자 승인을 원하는 회원정보 전체를 가져오는 메서드
   	public List<UserDTO> getUserInfoDetail() {	// user_no 혹은 user_id
   		
   		List<UserDTO> list = new ArrayList<UserDTO>();
   		
   		openConn();
   		
   		sql = "select u.*, a.approve_name from user_table u join approve a on a.approve_no = u.user_approve where u.user_approve = 1";
   		
   		try {
  			pstmt = con.prepareStatement(sql);
    			
  			rs = pstmt.executeQuery();
  			
  			while(rs.next()) {
  				UserDTO dto = new UserDTO();
  				
  				dto.setUser_no(rs.getInt("user_no"));
  				dto.setUser_id(rs.getString("user_id"));
  				dto.setUser_name(rs.getString("user_name"));
  				dto.setUser_nickname(rs.getString("user_nickname"));
  				dto.setUser_pwd(rs.getString("user_pwd"));
  				dto.setUser_approve(rs.getInt("user_approve"));
  				dto.setApprove_name(rs.getString("approve_name"));
  				
  				list.add(dto);
  			
  			}
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   		return list;
   	}
   	
   	
   	// 한 회원의 회원정보 전체를 가져오는 메서드
   	public UserDTO getUserInfoDetail(int no) {	// user_no 혹은 user_id
   		
   		UserDTO dto = null;
   		
   		openConn();
   		
   		sql = "select * from user_table where user_no = ?";
   		
   		try {
  			pstmt = con.prepareStatement(sql);
  			
  			pstmt.setInt(1, no);
  			
  			rs = pstmt.executeQuery();
  			
  			while(rs.next()) {
  				dto = new UserDTO();
  				
  				dto.setUser_no(rs.getInt("user_no"));
  				dto.setUser_id(rs.getString("user_id"));
  				dto.setUser_name(rs.getString("user_name"));
  				dto.setUser_nickname(rs.getString("user_nickname"));
  				dto.setUser_pwd(rs.getString("user_pwd"));
  				dto.setUser_email(rs.getString("user_email"));
  				dto.setUser_phone(rs.getString("user_phone"));
  				dto.setUser_addr(rs.getString("user_addr"));
  				dto.setUser_birth(rs.getString("user_birth"));
  				dto.setUser_approve(rs.getInt("user_approve"));
  				dto.setUser_money(rs.getInt("user_money"));
  			
  			}
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		} finally {
  			closeConn(rs, pstmt, con);
  		}
   		
   		return dto;
   	}
   	
   	// 회원의 정보를 가져오는 메서드
   	public UserDTO getUserOne(int no) {
   		
   		UserDTO dto = null;
   		
   		try {
   			openConn();
   			
   			sql = "select * from user_table where user_no = ?";
   			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new UserDTO();
				
				dto.setUser_nickname(rs.getString("user_nickname"));
				
				dto.setUser_email(rs.getString("user_email"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
   		return dto;
   	}	// getUserOne() 메서드 end
 	
   	// 인기 검색어에 들어갈 리스트 상위 10개만 가져오는 메서드
   	public List<SearchDTO> getUserSearchHitList() {

   		List<SearchDTO> list = new ArrayList<SearchDTO>();
   	    try {
   	        openConn();
   	        sql = "SELECT keyword, COUNT(*) AS count, MAX(search_time) AS search_time FROM search GROUP BY keyword ORDER BY count DESC, search_time DESC LIMIT 10";
   	        
   	        pstmt = con.prepareStatement(sql);
   	        
   	        rs = pstmt.executeQuery();
   	        
   	        while (rs.next()) {
   	            SearchDTO dto = new SearchDTO();
   	           
   	            dto.setKeyword(rs.getString("keyword"));
   	            dto.setSearch_count(rs.getInt("count"));
   	            dto.setSearch_time(rs.getString("search_time"));
   	            
   	            list.add(dto);
   	        }
   	        
   	    } catch (SQLException e) {
   	        e.printStackTrace();
   	    } finally {
   	        closeConn(rs, pstmt, con);
   	    }
   	    
   	    return list;
   	} // getUserSearchHitList() 메서드 end
   	
   	// 회원의 소지금을 가져오는 메서드
   	public int getUserMoney(int no) {
   		
   		int result = 0;
   		
   		try {
   			openConn();
   			
   			sql = "select user_money from user_table where user_no = ?";
   			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
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
   	}
   	
   	// 해당 유저의 최근 검색어 4개 가져오는 메서드.
   	public List<SearchDTO> getUserSearchRecentList(int user_no) {
   		
   		List<SearchDTO> list = new ArrayList<SearchDTO>();
   		
   		try {
   			openConn();
   	   		
   			sql = "SELECT keyword FROM search WHERE user_no = ? ORDER BY search_time DESC LIMIT 4";
   	   		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, user_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SearchDTO dto = new SearchDTO();
				
				dto.setKeyword(rs.getString("keyword"));
				
				System.out.println(rs.getString("keyword"));
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
   		
   		return list;
   	} // getUserSearchRecentList() 메서드 end
	
	
	public int joinUser(UserDTO dto) {
		
		int result=0 ,count=0;
		
		
		
		try {
			openConn();
			
			sql ="select max(user_no) from user_table";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count= rs.getInt(1)+1;
			}
			
			sql= "insert into user_table values(?,?,?,?,?,?,?,?,?,0,0)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, count);
			pstmt.setString(2, dto.getUser_id());
			pstmt.setString(3, dto.getUser_name());
			pstmt.setString(4, dto.getUser_nickname());
			pstmt.setString(5, dto.getUser_pwd());
			pstmt.setString(6, dto.getUser_email());
			pstmt.setString(7, dto.getUser_phone());
			pstmt.setString(8, dto.getUser_addr());
			pstmt.setString(9, dto.getUser_birth());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}

	public int idCheck(String user_id) {
 		
		int result =0;
 		
 		try {
 			openConn();
	 		
	 		sql ="select * from user_table where user_id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				//true 이면 중복인 경우
				result= -1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
			
		}
 		return result;
 		
 	} //idCheck() end

	public int nickCheck(String nick) {
		
		int result = 0;
		
		
		
		try {
			
			openConn();
			
			sql = "select * from user_table where user_nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result=-1;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
			
		}
		return result;
	}
	
	public int emailCheck(String email) {
		int result=0;
		
		
		try {
			openConn();
			
			sql ="select * from user_table where user_email = ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, email);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result=-1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	public int phoneCheck(String phone) {
		int result=0;
		
		
		try {
			openConn();
			
			sql ="select * from user_table where user_phone = ?";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, phone);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				result=-1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}
	
	public String findId(String email) {
		
		String foundId = null;
			try {
			openConn();
			
			sql="select user_id from user_table where user_email = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
               foundId = rs.getString("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		return foundId;
	}
	
	  public UserDTO UserFindPwd(String userId, String userName, String userEmail) {

	      UserDTO dto = null;

	      int result = 0;

	      openConn();
	      
	      System.out.println("DAO ID :"+userId);
	      System.out.println("DAO NAME :"+userName);
	      System.out.println("DAO EMAIL :"+userEmail);
	      
	      try {
	         String sql = "select * from user_table where user_id = ? and user_name =? and user_email = ?";

	         pstmt = con.prepareStatement(sql);

	         pstmt.setString(1, userId);
	         pstmt.setString(2, userName);
	         pstmt.setString(3, userEmail);

	         rs = pstmt.executeQuery();

	         if (rs.next()) {

	            dto = new UserDTO();

	            dto.setUser_id(rs.getString("User_id"));
	            dto.setUser_name(rs.getString("User_name"));
	            dto.setUser_email(rs.getString("User_email"));
	            dto.setUser_no(rs.getInt("User_no"));

	            System.out.println("아이디 : " + dto.getUser_id());
	            System.out.println("이름 : " + dto.getUser_name());
	            System.out.println("이메일 : " + dto.getUser_email());

	         } else {
	            dto = new UserDTO();

	            dto.setUser_id("없음");
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         closeConn(rs, pstmt, con);
	      }
	      return dto;
	   }
	   // 임시비밀번호 DB에 저장
	   public void TempPwdUpdate(int no, String encode) {

	      openConn();

	      String sql = "update user_table set user_pwd = ? where user_no = ?";

	      try {

	         pstmt = con.prepareStatement(sql);

	         pstmt.setString(1, encode);

	         pstmt.setInt(2, no);

	         pstmt.executeUpdate();

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         closeConn(rs, pstmt, con);
	      }

	   }
	   
	   //회원 정보 수정. - 닉네임, 연락처, 이메일, 주소
	   public int updateUser(UserDTO dto) {
			int res = 0;
			try {
				
				openConn();
				sql = "UPDATE user_table SET user_nickname = ?, user_phone = ?, user_email = ?, user_addr = ? WHERE user_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getUser_nickname());
				pstmt.setString(2, dto.getUser_phone());
				pstmt.setString(3, dto.getUser_email());
				pstmt.setString(4, dto.getUser_addr());
				pstmt.setString(5, dto.getUser_id());
				res = pstmt.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			return res;
		}
	   public UserDTO getUser(String user_id) {
		    
		    UserDTO dto = null;

		    try {
		        
		    	openConn();
		        sql = "SELECT * FROM users WHERE user_id=?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, user_id);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            dto = new UserDTO();
		            dto.setUser_id(rs.getString("user_id"));
		            dto.setUser_pwd(rs.getString("user_password"));
		            dto.setUser_name(rs.getString("user_name"));
		            dto.setUser_nickname(rs.getString("user_nickname"));
		            dto.setUser_phone(rs.getString("user_phone"));
		            dto.setUser_email(rs.getString("user_email"));
		            dto.setUser_addr(rs.getString("user_addr"));
		            dto.setUser_birth(rs.getString("user_birth"));
		            dto.setUser_money(rs.getInt("user_money"));
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        closeConn(rs, pstmt, con);
		    }

		    return dto;
		}
	   
	   public boolean checkPassword(String userId, String password) {
		   boolean result = false;

		   try {
		     openConn();
		     sql = "select user_pwd from user_table where user_id = ?";
		     pstmt = con.prepareStatement(sql);
		     pstmt.setString(1, userId);
		     rs = pstmt.executeQuery();

		     if (rs.next()) {
		       String storedPassword = rs.getString("user_pwd");
		       if (storedPassword.equals(password)) {
		         result = true;
		       }
		     }
		   } catch (SQLException e) {
		     e.printStackTrace();
		   } finally {
		     closeConn(rs, pstmt, con);
		   }

		   return result;
		 }
	   
	   // 소지금 추가하는 메서드.
	   public void userMoneyPlus(int user_no, int money) {
		   
		   try {
			   openConn();
			   
			   sql = "update user_table set user_money = user_money + ? where user_no = ?";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, money);
			   pstmt.setInt(2, user_no);
			   
			   pstmt.executeUpdate();
			   
			   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		   
	   } // userMoneyPlus() 메서드 end 
	  
	   public int modifyUserPassword(String id, String cpwd, String npwd) {
		  
		   
		   int result=0;
		   
		   try {
		        openConn();

		        // 현재 비밀번호 확인
		        sql = "select user_pwd from user_table where user_id = ?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, id);
		        System.out.println("dao id" + id);
		        System.out.println("dao cpwd" + cpwd);
		        System.out.println("dao npwd" + npwd);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            String nowPwd = rs.getString("user_pwd");//db에 있는 현재 비밀번호
		            
		            System.out.println("nowpwd"+nowPwd);
		            
		            // 현재 비밀번호가 일치하면
		            if (nowPwd.equals(cpwd)) {//db에 있는 현재 비밀번호와 비밀번호 변경창에서 입력한 번호의 비교
		                // 비밀번호 변경
		                sql = "update semi.user_table set user_pwd = ? where user_id = ?";
		                pstmt = con.prepareStatement(sql);
		                pstmt.setString(1, npwd);
		                pstmt.setString(2, id);
		                
		                
		                
		                result = pstmt.executeUpdate();
		                
		                System.out.println("dadsa>>>" +result);
		            } else {
		                // 현재 비밀번호가 일치하지 않음
		                result = -1;
		            }
		        }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		   return result;
		   
		   
	   }
	   
	   //회원 차단하는 메서드.
	   public void userBlock(int user_no) {
		   
		   try {
			   openConn();
			   
			   sql = "update user_table set user_approve = '5' where user_no = ?";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, user_no);
			   
			   pstmt.executeUpdate();
			   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		   
	   } // userDelete() 메서드 end
	   
	   
	   // user_nickname 가져오는 메서드.
	   public String getUserNickname(int user_no) {
		   
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
	   } // getUserNickname() 메서드 end
	   
	   public boolean checkUser(UserDTO user) {
		    
		    boolean result = false;

		    try {
		    	openConn();
		    	
		         sql = "SELECT * FROM user_table WHERE user_id=?";
		        pstmt = con.prepareStatement(sql);
		        pstmt.setString(1, user.getUser_id());
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            result = true;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		    	closeConn(rs, pstmt, con);
		    }

		    return result;
		}
	

}
