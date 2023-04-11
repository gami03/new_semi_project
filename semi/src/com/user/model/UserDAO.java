package com.user.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;





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
			
			sql="insert into user_table values(?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
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

 	
 	
 	
 	
}
