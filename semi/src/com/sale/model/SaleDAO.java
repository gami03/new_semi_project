package com.sale.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


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
			
			sql = "select count(*) from product";
			
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
			
			sql = "select * from product";
			
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SaleDTO dto = new SaleDTO();
				
				dto.setSale_no(rs.getInt("sale_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setSale_title(rs.getString("sale_title"));
				dto.setSale_content(rs.getString("sale_content"));
				dto.setSale_price(rs.getInt("sale_price"));
				dto.setSale_file1(rs.getString("sale_file1"));
				dto.setSale_date(rs.getString("sale_date"));
				// 댓글 기능때문에 group으로 묶어서 하려면 컬럼 하나 더 추가해야할지도 
				dto.setSale_hit(rs.getInt("sale_hit"));
				
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
	
	
	// 선택된 경매물품의 상세정보를 가져오는 메서드.
	public SaleDTO getProductDetail(int no) {
		
		SaleDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from product where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new SaleDTO();
				
				dto.setSale_no(rs.getInt("sale_no"));
				dto.setUser_no(rs.getInt("user_no"));
				dto.setSale_title(rs.getString("sale_title"));
				dto.setSale_content(rs.getString("sale_content"));
				dto.setSale_price(rs.getInt("sale_price"));
				dto.setSale_end_price(rs.getInt("end_price"));
				dto.setSale_file1(rs.getString("sale_file1"));
				dto.setSale_file2(rs.getString("sale_file2"));
				dto.setSale_file3(rs.getString("sale_file3"));
				dto.setSale_file4(rs.getString("sale_file4"));
				dto.setSale_date(rs.getString("sale_date"));
				dto.setEnd_date(rs.getString("end_date"));
				dto.setSale_hit(rs.getInt("sale_hit"));
				
				System.out.println(rs.getString("sale_file3"));
				System.out.println(rs.getString("sale_file4"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}
	
	
	// 로그인된 user_id를 이용하여 user_no를 가져오는 메서드.
	public int getUserNo(String id) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select user_no from user_table where user_id = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = rs.getInt("user_no");
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getUserNo() 메서드 end
	
	
	// 현재 경매품을 상회 입찰한 사람의 회원 번호를 가져오는 메서드
	public int getUserUpperNo(int sale_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from upper where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, sale_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = rs.getInt("user_no");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getUserUpperNo() 메서드 end
	
	// 경매품을 등록한 회원의 유저 번호를 가져오는 메서드
	public int getProductUserNo(int product_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from product where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, product_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("user_no");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}
	
	
	
	// 상회입찰가를 불러오는 메서드.
	public String getProductUpper(int no) {
		
		String result = "";
		
		try {
			openConn();
			
			sql = "select * from upper where sale_no =?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			result += "<uppers>";
			
			if(rs.next()) {
				result += "<upper>";
				result += "<sale_no>"+rs.getInt("sale_no") +"</sale_no>";
				result += "<user_no>"+rs.getInt("user_no") +"</user_no>";
				result += "<user_upper>"+rs.getInt("user_upper") +"</user_upper>";
				result += "</upper>";
			}
			
			
			result += "</uppers>";
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	//getProductUpper() 메서드 end
	
	// 현재 경매품의 시작 값을 불러오는 메서드
	public int getStrat_value(int no) {
		
		int result = 0;
		
		try {
			
			openConn();
			
			// 현재 경매품의 시작 값을 불러오는 코드
			sql = "select * from product where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("sale_price");
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getStart_value() 메서드 end
	
	
	// 현재 경매품의 입찰가를 불러오는 메서드.
	public int getUpper_value(int no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from upper where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = rs.getInt("user_upper");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getUpper_value() 메서드 end
	
	
	// 입찰한 회원의 소지금을 불러오는 메서드
	public int getUser_money(int user_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select user_money from user_table where user_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, user_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = rs.getInt("user_money");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// getUser_money() 메서드 end
	
	
	// 현재 경매품의 즉시 구매가를 불러오는 메서드
	public int getEnd_price(int sale_no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from product where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, sale_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = rs.getInt("end_price");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	} 	// getEnd_price() 메서드 end
	
	
	
	// 입찰을 뺏긴 회원의 입찰금액을 user_tabled의 user_money 에 더해주는 메서드
	public void InputUser_money(int sale_no) {
		
		try {
			openConn();
			
			sql = "select * from upper where sale_no = ? ";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, sale_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				int sale_user_no = rs.getInt("user_no");
				
				int sale_user_money = rs.getInt("user_upper");
				
				sql = "select * from user_table where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, sale_user_no);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					sale_user_money += rs.getInt("user_money");
					
				}
				
				sql = "update user_table set user_money = ? where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, sale_user_money);
				
				pstmt.setInt(2, sale_user_no);
				
				int check = pstmt.executeUpdate();
				
				System.out.println(check);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	} 	// InputUser_money() 메서드 end
	
	
	// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 메서드
	public int InputUser_upper(int upper_value, int user_no, int sale_no) {
		
		// 결과값을 보내기위한 변수
		int result = 0;
		
		try {
			openConn();
			
			sql = "update upper set user_upper = ?, user_no = ? where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, upper_value);
			
			pstmt.setInt(2, user_no);
			
			pstmt.setInt(3, sale_no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return result;
	}	// InputUser_upper() 메서드 end
	
	
	// 입찰한 유저의 소지금에서 입찰금액 만큼 뺴주는 메서드
	public void InputMoney(int total, int user_no) {
		
		try {
			openConn();
			
			sql = "update user_table set user_money = ? where user_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, total);
			
			pstmt.setInt(2, user_no);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	}	// InputMoney() 메서드 end
	
	// 입찰한 유저가 
	
	
	// result 각 결과 값의 의미
	//  1 = 정상 작동
	// -1 = user_money 부족, -2 = 최소 금액에 맞지 않는 금액이 입력 되었을때 , -3 = 직접 입력한 금액이 최소 입찰가보다 적을 경우, 
	// -4 = 직접 입력한 금액이 즉시 구매가보다 높을 경우 -5 = 유저가 입찰한 금액보다 즉시 구매가가 낮을 경우 
	// -6 = 즉시구매가 만큼의 가격이 이미 입찰 되어 있을때.
	// 즉시 입찰 버튼을 누르시 동작하는 메서드
	public int updateMini(int sale_no, int user_no) {
		
		int result = 0, upper_value = 0, start_value = 0, user_money = 0, end_price = 0;
		
		// 현재 경매품의 시작 값을 불러오는 코드
		start_value = getStrat_value(sale_no);
		
		// 현재 경매품의 상회 입찰가를 불러오는 코드
		upper_value = getUpper_value(sale_no);
		
		// 입찰한 회원의 소지금을 불러오는 코드
		user_money = getUser_money(user_no);
		
		end_price = getEnd_price(sale_no);
		
		if(end_price != upper_value) {
			
			if(upper_value >= start_value) {	// 상회 입찰 금액이 있을때.
				
				// upper_price 에 10% 만큼 더해줘야 된다.
				int upper_price = (int) (upper_value * 1.1);
				
				if(upper_price >= end_price) {	// 즉시 입찰가가 즉시 구매가 보다 높을 경우
					// 즉시 입찰가가 즉시 구매가보다 높으면 안되므로 입찰한 유저의 차감 금액을 end_price로 잡는다.
					
					if(user_money >= end_price) {	// 회원 소지금이 즉시 입찰금액보다 많을 경우
						
						// 입찰을 뺏긴 회원의 입찰금액을 user_tabled의 user_money 에 더해주는 코드
						InputUser_money(sale_no);
						
						// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
						result = InputUser_upper(end_price, user_no, sale_no);
						
						// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
						int total = user_money - end_price;
						
						InputMoney(total, user_no);
					} 	// if(user_money >= end_price) end
					
				}	// if(upper_price >= end_price) end 
				else {
					if(user_money >= upper_price) {	// 회원 소지금이 상회 입찰금 보다 많거나 같을때.
						
						// 입찰을 뺏긴 회원의 입찰금액을 user_tabled의 user_money 에 더해주는 코드
						InputUser_money(sale_no);
						
						// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
						result = InputUser_upper(upper_price, user_no, sale_no);
						
						// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
						int total = user_money - upper_price;
						
						InputMoney(total, user_no);
					} else {
						
						// 회원 소지금이 상회입찰가 보다 적을때 
						result = -1;
					} // if(user_money >= upper_price) end
				}	// if(upper_price >= end_price) else 문 end 
				
			} else if(start_value > upper_value) {	// 상회 입찰 금액이 없을때.
				
				int start_price = start_value;
				
				if(user_money >= start_price) {
					
					if(start_price >= end_price) {
						
						// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
						result = InputUser_upper(end_price, user_no, sale_no);
						
						// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
						int total = user_money - end_price;
						
						InputMoney(total, user_no);
						
					} else {
						
						// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
						result = InputUser_upper(start_price, user_no, sale_no);
						
						// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
						int total = user_money - start_price;
						
						InputMoney(total, user_no);
						
					}
				} else {
					
					// 회원 소지금이 상회입찰가 보다 적을때 
					result = -1;
				}
			} else {
				// 최소 금액에 맞지 않는 금액이 입력 되었을 때.
				result = -2;
			}
			
		} else {
			// 상품이 이미 구매가 완료 되었을때.
			result = -6;
		}
		
		
		return result;
		
	}	// updateMini() 메서드 end
	
	
	// 사용자가 집적입찰을 했을때 작동하는 메서드
	public int updateBid(int sale_no, int bid, int user_no) {
		
		int result = 0, upper_value = 0, start_value = 0, user_money = 0;
		
		// 현재 경매품의 시작 값을 불러오는 코드
		start_value = getStrat_value(sale_no);
		
		// 현재 경매품의 상회 입찰가를 불러오는 코드
		upper_value = getUpper_value(sale_no);
		
		// 입찰한 회원의 소지금을 불러오는 코드
		user_money = getUser_money(user_no);
		
		// 현재 경매품의 즉시 구매가를 불러오는 코드
		int end_price = getEnd_price(sale_no);
		
		if(end_price != upper_value) {
			
			// 상회 입찰가가 있을 경우
			if(upper_value > start_value) {
				
				upper_value += upper_value * 0.1;
				
				// 입찰한 금액이 최소 입찰가 보다 높은 경우
				if(bid >= upper_value) {
					// 입찰한 금액 즉시구매가 보다 적을 경우
					if(end_price > bid) {
						// 입찰한 금액이 자신의 소지금 만큼 있을경우
						if(user_money > bid) {
							
							// 입찰을 뺏긴 회원의 입찰금액을 user_tabled의 user_money 에 더해주는 코드
							InputUser_money(sale_no);
							
							// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
							result = InputUser_upper(bid, user_no, sale_no);
							
							// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
							int total = user_money - bid;
							
							InputMoney(total, user_no);
							
						} else {
							result = -1;
						}	// if(user_money > bid) end
					} else {
						result = -4;	// 직접 입력한 금액이 즉시 구매가보다 적을 경우
					}	// if(end_price > bid) end
					
				} else {
					result = -3;	// 직접 입력한 금액이 최소 입찰가 보다 낮을 경우
				}	// if(bid > user_value) end
				
				// 상회 입찰가가 없을 경우
			} else if(upper_value < start_value) {
				start_value += start_value * 1.1;
				
				// 입찰한 금액이 최소 입찰가 보다 높은 경우
				if(bid > start_value) {
					// 입찰한 금액이 즉시구매가 보다 적을 경우
					if(end_price >= bid) {
						
						// 입찰한 금액이 자신의 소지금 만큼 있을경우
						if(user_money > bid) {
							
							// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
							result = InputUser_upper(bid, user_no, sale_no);
							
							// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
							int total = start_value - bid;
							
							InputMoney(total, user_no);
							
						} else {
							result = -1;
						} // if(user_money > bid) end
					} else {
						result = -5;	// 직접 입력한 금액이 즉시 구매가보다 높을 경우
					}	// if(end_price >= bid) end
				} else {
					result = -3;	// 직접 입력한 금액이 최소 입찰가 보다 낮을 경우
				}	// if(bid > start_value) end
			} else {
				result = -2;
			}	// else if(upper_value < start_value) end
		} else {
			result = -6;
		}
		
		return result;
	}	// updateBid() 메서드 end
		
	
	
	// 즉시 구매 버튼을 눌렀을때 동작하는 메서드.
	public int updateNow(int sale_no, int user_no) {
		
		int result = 0, user_money = 0, start_value = 0, upper_value =0, end_price = 0;
		
		// 현재 경매품의 시작 값을 불러오는 코드
		start_value = getStrat_value(sale_no);
		
		// 현재 경매품의 상회 입찰가를 불러오는 코드
		upper_value = getUpper_value(sale_no);
		
		// 현재 경매 물품의 즉시 구매가를 불러오는 코드
		end_price = getEnd_price(sale_no);
		
		// 입찰한 회원의 소지금을 불러오는 코드
		user_money = getUser_money(user_no);
		
		
		// 상회 입찰가가 있을 경우
		if(upper_value >= start_value) {
			if(upper_value == end_price ) {
				result = -6;
			} else {
				// 회원 소지금이 즉시 구매가 보다 같거나 많을 경우.
				if(user_money >= end_price) {
					
					// 입찰을 뺏긴 회원의 입찰금액을 user_tabled의 user_money 에 더해주는 코드
					InputUser_money(sale_no);
					
					// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
					result = InputUser_upper(end_price, user_no, sale_no);
					
					// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
					int total = user_money - end_price;
					
					InputMoney(total, user_no);
				
				} else {
					result = - 5;
				}	// if(user_money >= end_price) end
			}
			
			// 상회 입찰가가 없을 경우
		} else if(upper_value < start_value) {
			
			if(upper_value == end_price) {
				result = -6;
			} else {
				
				if(user_money >= end_price) {
					
					// 입찰한 유저의 유저 번호와 금액을 upper 테이블에 업데이트 하는 코드.
					result = InputUser_upper(end_price, user_no, sale_no);
					
					// 입찰한 유저의 소지금에서 입찰 금액 만큼 빼주는 코드
					int total = user_money - end_price;
					
					InputMoney(total, user_no);
				} else {
					result = - 5;
				}	// if(user_money >= end_price) end
			}
		} else {
			result = -2;
		}
		
		return result;
		
	}	//updateNow() 메서드 end
	
	
	
	// 경매물품의 시간을 가져오는 메서드.
	public SaleDTO getTime(int no) {
		
		SaleDTO dto = null;
		
		try {
			openConn();
			
			sql = "select * from product where sale_no = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery(sql);
			
			if(rs.next()) {
				
				dto = new SaleDTO();
				
				dto.setSale_date(rs.getString("sale_date"));
				dto.setEnd_date(rs.getString("end_date"));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		return dto;
	}	// getTime(int no) end
	
	
	// 회원의 경매물품 판매 이력을 가져오는 메서드
	public int getCountProduct(int no) {
		
		int result = 0;
		
		try {
			openConn();
			
			sql = "select count(*) from product where user_no = ? and successful_bid > 0";
			
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
	}	// getCountProduct() 메서드 end
	
	
	// 현재시간이 경매물품의 시간을 넘었을 경우 특정 값을 받아오는 메서드
	public int getEndDate(int no) {
		
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String date = now.format(formatter);

		int result = 0;
		
		try {
			openConn();
			
			sql = "select * from product where sale_no = ? and end_date < ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			pstmt.setString(2, date);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				result = 3;
				
			} else {
				result = 2;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		
		return result;
	}

	
	// 유저 no를 통해서 낙찰받은 물건의 판매번호를 받아오는 메서드
   public int getBuyProduct(int no) {

      int sale_no = 0;

      try {
         openConn();

         sql = "select sale_no from upper where user_no = ?";

         pstmt = con.prepareStatement(sql);

         pstmt.setInt(1, no);

         rs = pstmt.executeQuery();
         
         if(rs.next()) {
             sale_no = rs.getInt(1);
          }
          
          // getProductDetail(sale_no)로 데이터 받아오기

       } catch (SQLException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
       } finally {
          closeConn(rs, pstmt, con);
       }

       return sale_no;
    }	// getBuyProduct() 메서드 end

         
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
		
		// 판매페이지 업로드() 메서드
		public int saleBoardWrite(SaleDTO dto) {
			
			int result = 0, count = 0;
			
			try {
				openConn();
				
				sql = "select max(board_no) from board";
				
				pstmt = con.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1) + 1;
				}
				
				sql = "insert into board values(?, ?, 0, ?, ?, ?, ?, now(), 0, 0, ?, ?, ?, ?, 0, ?)";
				
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, count);
				pstmt.setInt(2, dto.getUser_no());
				pstmt.setString(3, dto.getSale_title());
				pstmt.setString(4, dto.getSale_content());
				pstmt.setInt(5, dto.getSale_price());
				pstmt.setInt(6, dto.getSale_end_price());
				pstmt.setString(7, dto.getSale_file1());
				pstmt.setString(8, dto.getSale_file2());
				pstmt.setString(9, dto.getSale_file3());
				pstmt.setString(10, dto.getSale_file4());
				pstmt.setString(11, dto.getUpload_category());
				
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return result;
		} // 판매페이지 업로드() 메서드 end
            
   
	// 낙찰된 금액을 product 테이블의 successful_bid 컬럼에 넣는 메서드
	public void inputBid(int upper_val, int no) {

		try {
			openConn();

			sql = "update product set successful_bid = ? where sale_no = ?";

			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, upper_val);
			pstmt.setInt(2, no);

			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
	} // inputBid() 메서드 end

	   
	   // wishlist 상품 추가 메서드
	   public void wishListInsert(int user_no, int sale_no) {
		   
		   try {
			   openConn();
			   
			   sql = "insert into wishlist values(?, ?, default)";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, user_no);
			   pstmt.setInt(2, sale_no);
			   
			   pstmt.executeUpdate();
			   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		   
	   } // wishListInsert() 메서드 end
	   
	// wishlist 상품 삭제 메서드
	   public void wishListDelete(int user_no, int sale_no) {
		   
		   try {
			   openConn();
			   
			   sql = "delete from wishlist where user_no = ? and sale_no = ?";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, user_no);
			   pstmt.setInt(2, sale_no);
			   
			   pstmt.executeUpdate();
			   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}
		   
	   } // wishListInsert() 메서드 end
	   
	   // 관심상품에 추가/삭제 했을 때 product 테이블에서 해당 게시물의 찜 수를 업데이트 하는 메서드.
	   public void productWishListCount(int sale_no) {
		   
		   try {
			   openConn();
			   
			   sql = "select count(*) from wishlist where sale_no = ?";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, sale_no);
			   
			   rs = pstmt.executeQuery();
			   
			   if(rs.next()) {
				   sql = "update product set wishlist_count = ? where sale_no = ?";
				   
				   pstmt = con.prepareStatement(sql);
				   
				   pstmt.setInt(1, rs.getInt(1));
				   pstmt.setInt(2, sale_no);
				   
				   pstmt.executeUpdate();
				   
			   }
			   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeConn(rs, pstmt, con);
		}
		   
	   } //productWishListCount() 메서드 end
	   
	   // 로그인 안했을 때 때 관심상품으로 많이 등록된(찜 많이 된) 상위 4개만 가져오는 메서드
	   public List<SaleDTO> nlogingetProductHitList() {
			   
			   List<SaleDTO> list = new ArrayList<SaleDTO>();
			   
			   try {
				   openConn();
				   
				   sql = "SELECT * FROM product ORDER BY wishlist_count DESC, sale_no DESC LIMIT 4";
				   
				   pstmt = con.prepareStatement(sql);
				   
				   rs = pstmt.executeQuery();
				   
				   while(rs.next()) {
						   
						   sql = "select *, count(*) from upper where sale_no = ? and user_upper > 0";
						    
						    // 새로운 PreparedStatement 생성
						    PreparedStatement pstmt2 = con.prepareStatement(sql); 
						    
						    pstmt2.setInt(1, rs.getInt("sale_no"));
						    
						    // 새로운 ResultSet을 생성
						    ResultSet rs2 = pstmt2.executeQuery(); 
						    
						    if(rs2.next()) {
						        int count = rs2.getInt(1);
						        if(count > 0) {
						            SaleDTO dto = new SaleDTO();
						            dto.setSale_no(rs.getInt("sale_no"));
						            dto.setSale_file1(rs.getString("sale_file1"));
						            dto.setSale_title(rs.getString("sale_title"));
						            dto.setSale_content(rs.getString("sale_content"));
						            dto.setSale_end_price(rs2.getInt("user_upper"));
						            dto.setBookmark("bookmark.png");
						            list.add(dto);
						        } else {
						            SaleDTO dto = new SaleDTO();
						            dto.setSale_no(rs.getInt("sale_no"));
						            dto.setSale_file1(rs.getString("sale_file1"));
						            dto.setSale_title(rs.getString("sale_title"));
						            dto.setSale_content(rs.getString("sale_content"));
						            dto.setSale_end_price(rs.getInt("sale_price"));
						            dto.setBookmark("bookmark.png");
						            list.add(dto);
						        }
						    }
						    rs2.close();
						    pstmt2.close();
						   
					   }
					   
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}

			   
			   return list;
	   } //nlogingetProductHitList() 메서드 end
	   
	   // 로그인 됐을 때 관심상품으로 많이 등록된(찜 많이 된) 상위 4개만 가져오는 메서드
	   public List<SaleDTO> getProductHitList(int session_no) {
		    
		   List<SaleDTO> list = new ArrayList<SaleDTO>();
		    
		   try {
		        openConn();
		        
		        String sql = "SELECT * FROM product ORDER BY wishlist_count DESC, sale_no DESC LIMIT 4";
		       
		        PreparedStatement pstmt = con.prepareStatement(sql);
		        
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next()) {
		            
		        	sql = "SELECT COUNT(*) FROM upper WHERE sale_no = ? and user_upper > 0";
		            
		        	PreparedStatement pstmt2 = con.prepareStatement(sql);
		            
		        	pstmt2.setInt(1, rs.getInt("sale_no"));
		            
		        	ResultSet rs2 = pstmt2.executeQuery();
		            
		        	int count = 0;
		            
		        	if (rs2.next()) {
		                count = rs2.getInt(1);
		            }
		           
		        	pstmt2.close();
		           
		        	rs2.close();
		            
		        	SaleDTO dto = new SaleDTO();
		            
		        	dto.setSale_no(rs.getInt("sale_no"));
		            
		        	dto.setSale_file1(rs.getString("sale_file1"));
		            
		        	dto.setSale_title(rs.getString("sale_title"));
		            
		        	dto.setSale_content(rs.getString("sale_content"));
		            
		        	if (count > 0) {
		                
		        		sql = "SELECT user_upper FROM upper WHERE sale_no = ? ORDER BY user_upper DESC LIMIT 1";
		                
		        		PreparedStatement pstmt4 = con.prepareStatement(sql);
		                
		        		pstmt4.setInt(1, rs.getInt("sale_no"));
		                
		        		ResultSet rs4 = pstmt4.executeQuery();
		                
		        		if (rs4.next()) {
		                    dto.setSale_end_price(rs4.getInt("user_upper"));
		                
		        		}
		                pstmt4.close();
		                rs4.close();
		            } else {
		                dto.setSale_end_price(rs.getInt("sale_price"));
		            }
		            
		        	// Add code to get bookmark value based on session_no
		            
		        	sql = "SELECT user_no, bookmark FROM wishlist WHERE sale_no = ? AND user_no = ?";
		            
		        	PreparedStatement pstmt3 = con.prepareStatement(sql);
		            
		        	pstmt3.setInt(1, rs.getInt("sale_no"));
		            
		        	pstmt3.setInt(2, session_no);
		            
		        	ResultSet rs3 = pstmt3.executeQuery();
		            
		        	String bookmark = "bookmark.png";
		            
		        	int user_no = 0;
		            
		        	if (rs3.next()) {
		                bookmark = rs3.getString("bookmark");
		                user_no = rs3.getInt("user_no");
		            }
		            
		        	pstmt3.close();
		            
		        	rs3.close();
		            
		        	dto.setBookmark(bookmark);
		            
		        	dto.setUser_no(user_no);
		            
		        	list.add(dto);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        closeConn(rs, pstmt, con);
		    }
		    return list;
	   } // getProductHitList() 메서드end
	   
	   
	   // 로그인이 되있을 때 즉시 구매가가 높은 순으로 상위 리스트 4개 빼는 메서드.
	   public List<SaleDTO> getProductHighList(int session_no) {
		   
		   List<SaleDTO> list = new ArrayList<SaleDTO>();
		    
		   try {
		        openConn();
		        
		        String sql = "SELECT * FROM product ORDER BY end_price DESC, sale_no DESC LIMIT 4";
		       
		        PreparedStatement pstmt = con.prepareStatement(sql);
		        
		        ResultSet rs = pstmt.executeQuery();
		        
		        while(rs.next()) {
		            
		        	SaleDTO dto = new SaleDTO();
		            
		        	dto.setSale_no(rs.getInt("sale_no"));
		            
		        	dto.setSale_file1(rs.getString("sale_file1"));
		            
		        	dto.setSale_title(rs.getString("sale_title"));
		            
		        	dto.setSale_content(rs.getString("sale_content"));
		        	
		        	dto.setSale_end_price(rs.getInt("end_price"));
		            
		        	// Add code to get bookmark value based on session_no
		            
		        	sql = "SELECT user_no, bookmark FROM wishlist WHERE sale_no = ? AND user_no = ?";
		            
		        	PreparedStatement pstmt3 = con.prepareStatement(sql);
		            
		        	pstmt3.setInt(1, rs.getInt("sale_no"));
		            
		        	pstmt3.setInt(2, session_no);
		            
		        	ResultSet rs3 = pstmt3.executeQuery();
		            
		        	String bookmark = "bookmark.png";
		            
		        	int user_no = 0;
		            
		        	if (rs3.next()) {
		                bookmark = rs3.getString("bookmark");
		                user_no = rs3.getInt("user_no");
		            }
		            
		        	pstmt3.close();
		            
		        	rs3.close();
		            
		        	dto.setBookmark(bookmark);
		            
		        	dto.setUser_no(user_no);
		            
		        	list.add(dto);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        closeConn(rs, pstmt, con);
		    }
		    return list;
	   } // getProductHighList() 메서드 end
	   
	   // 로그인이 안되있을 때 즉시 구매가가 높은 순으로 상위 리스트 4개 빼는 메서드.
	   public List<SaleDTO> nlogingetProductHighList() {
		   
		   List<SaleDTO> list = new ArrayList<SaleDTO>();
		   
		   try {
			   openConn();
			   
			   sql = "SELECT * FROM product ORDER BY end_price DESC, sale_no DESC LIMIT 4";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   rs = pstmt.executeQuery();
			   
			   while(rs.next()) {
					    
		            SaleDTO dto = new SaleDTO();
		            dto.setSale_no(rs.getInt("sale_no"));
		            dto.setSale_file1(rs.getString("sale_file1"));
		            dto.setSale_title(rs.getString("sale_title"));
		            dto.setSale_content(rs.getString("sale_content"));
		            dto.setSale_end_price(rs.getInt("end_price"));
		            dto.setBookmark("bookmark.png");
		            list.add(dto);
			   }
				   
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeConn(rs, pstmt, con);
		}

		   return list;
	   } // nlogingetProductHighList() 메서드 end
	   
	   // 동일 상품에 대한 이전 추천 여부 검색
	   public int wishListCheck(int user_no, int sale_no) {
		   
		   int result = 0;
		   
		   try {
			   openConn();
			   
			   sql = "select count(*) from wishlist where user_no = ? and sale_no = ?";
			   
			   pstmt = con.prepareStatement(sql);
			   
			   pstmt.setInt(1, user_no);
			   pstmt.setInt(2, sale_no);
			   
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
	   }// wishListCheck() 메서드 end
	
	   
	   // 특정 유저의 판매 상품 index list를 가져오는 메서드
	   public List<SaleDTO> getUserindexList(int user_no) {
			
			List<SaleDTO> list = new ArrayList<SaleDTO>();
			
			try {
				openConn();
				
				sql = "select * from product where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					SaleDTO dto = new SaleDTO();
					
					dto.setSale_no(rs.getInt("sale_no"));
					dto.setUser_no(rs.getInt("user_no"));
					dto.setSale_title(rs.getString("sale_title"));
					dto.setSale_content(rs.getString("sale_content"));
					dto.setSale_price(rs.getInt("sale_price"));
					dto.setSale_file1(rs.getString("sale_file1"));
					dto.setSale_date(rs.getString("sale_date"));
					// 댓글 기능때문에 group으로 묶어서 하려면 컬럼 하나 더 추가해야할지도 
					dto.setSale_hit(rs.getInt("sale_hit"));
					
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

	
	// 특정 유저의 판매 상품 index list 개수를 가져오는 메서드
	   public int getUserindexCount(int user_no) {
			
			int count = 0;
			
			try {
				openConn();
				
				sql = "select count(*) from product where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					count = rs.getInt(1);
				}
			}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				closeConn(rs, pstmt, con);
			}
			
			return count;
		}	// getindexList() 메서드 end
	   
	   
	   // 특정 유저의 구매 상품 index list를 가져오는 메서드
	   public List<SaleDTO> getUserBuyList(int user_no) {
			
			List<SaleDTO> list = new ArrayList<SaleDTO>();
			int sale_no = 0;
			
			try {
				openConn();
				
				sql = "select sale_no from upper where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					sale_no = rs.getInt(1);
				}
				
				sql = "select * from product where sale_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, sale_no);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					SaleDTO dto = new SaleDTO();
					
					dto.setSale_no(rs.getInt("sale_no"));
					dto.setUser_no(rs.getInt("user_no"));
					dto.setSale_title(rs.getString("sale_title"));
					dto.setSale_content(rs.getString("sale_content"));
					dto.setSale_price(rs.getInt("sale_price"));
					dto.setSale_file1(rs.getString("sale_file1"));
					dto.setSale_date(rs.getString("sale_date"));
					// 댓글 기능때문에 group으로 묶어서 하려면 컬럼 하나 더 추가해야할지도 
					dto.setSale_hit(rs.getInt("sale_hit"));
					
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

	
	   // 특정 유저의 구매 상품 index list 개수를 가져오는 메서드
	   public int getUserBuyCount(int user_no) {
			
			int count = 0;
			int sale_no = 0;
			
			try {
				openConn();
				
				sql = "select sale_no from upper where user_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, user_no);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					sale_no = rs.getInt(1);
				}
				
				sql = "select * from product where sale_no = ?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, sale_no);
				
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
		}	// getindexList() 메서드 end
	   
	   
	   
	   
	   
	   
}
