package com.board.model;

public class BoardReplyDTO {
	
	private int com_no;
	private int user_no;
	private int board_no;
	private String br_writer;
	private String br_content;
	private String br_regdate;
	
	
	public String getBr_writer() {
		return br_writer;
	}
	public void setBr_writer(String br_writer) {
		this.br_writer = br_writer;
	}
	public int getCom_no() {
		return com_no;
	}
	public void setCom_no(int com_no) {
		this.com_no = com_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getBr_content() {
		return br_content;
	}
	public void setBr_content(String br_content) {
		this.br_content = br_content;
	}
	public String getBr_regdate() {
		return br_regdate;
	}
	public void setBr_regdate(String br_regdate) {
		this.br_regdate = br_regdate;
	}
	
	

}
