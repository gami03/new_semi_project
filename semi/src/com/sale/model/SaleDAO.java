package com.sale.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SaleDAO {

	// DB와 연동하는 객체.
	Connection con = null;
	
	// DB에 SQL문을 전송하는 객체.
	PreparedStatement pstmt = null;
	
	// SQL문을 실행한 후에 결과 값을 가지고 있는 객체.
	ResultSet rs = null;
	
	// 쿼리문을 저장할 변수
	String sql = null;
	
	
	// SaleDAO 클래스를 싱글턴 방식으로 만들어 보자.
	// 1단계 : 싱글턴 방식을 객체를 만들기 위해서는 우선적으로
	//        기본생성자의 접근제어자를 public 이 아니라
	//        private 으로 바꾸어 주어야 한다.
	//        즉, 외부에서는 직접적으로 기본생성자를 호출하지
	//        못하게 하는 방식이다.
	
	// 2단계 : SaleDAO 클래스를 정적(static) 멤버로 
	//        선언을 해 주어야 한다.
	private static SaleDAO instance;
	
	private SaleDAO() {  }  // 기본 생성자
	
	// 3단계 : 기본생성자 대신에 싱글턴 객체를 return 해 주는
	//        getInstance() 메서드를 만들어서 해당 
	//        getInstance() 메서드를 외부에서 접근할 수 있도록
	//        해 주면 됨.
	public static SaleDAO getInstance() {
		
		if(instance == null) {
			instance = new SaleDAO();
		}
		
		return instance;
	}  // getInstance() 메서드 end
	
	// DB를 연동하는 작업을 진행하는 메서드.
	// 커넥션 풀 방식으로 DB연결 진행.
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
	public void closeConn(ResultSet rs,
			PreparedStatement pstmt, Connection con) {
		
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(con != null) con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}  // closeConn() 메서드 end
	
	
	// 판매 상품 index list의 갯수를 가져오는 메서드
	public int getindexListnumber() {
		
		int count = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from sale";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {	// sql문을 한번 실행
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
	
	
	// 판매 상품 index list를 가져오는 메서드
	public List<SaleDTO> getindexList() {
		
		List<SaleDTO> list = new ArrayList<SaleDTO>();
		
		try {
			openConn();
			
			sql = "select * from sale";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleDTO dto = new SaleDTO();
				
				dto.setSale_no(rs.getInt("sale_no"));
				dto.setSale_no(rs.getInt("user_no"));
				dto.setSale_title(rs.getString("sale_title"));
				dto.setSale_content(rs.getString("sale_content"));
				dto.setSale_price(rs.getDouble("sale_price"));
				dto.setSale_file(rs.getString("sale_file"));
				dto.setSale_date(rs.getString("sale_date"));
				// 댓글 기능때문에 group으로 묶어서 하려면 컬럼 하나 더 추가해야할지도 
				dto.setSale_reply(rs.getInt("sale_reply"));
				dto.setSale_hit(rs.getInt("sale_hit"));
				dto.setSale_check(rs.getInt("sale_check"));
				
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return list;
	}	// getindexList() 메서드 end
	
}
