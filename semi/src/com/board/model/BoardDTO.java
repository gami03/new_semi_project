package com.board.model;

public class BoardDTO {
	private int board_no;
	private int user_no;
	private String user_nickname;
	private String board_title;
	private String board_content;
	private int board_hit;
	private int board_rec;
	private String board_date;
	private String board_update;
	private String board_name;
	private String board_file1;
	private String board_file2;
	private String board_category;
	private int board_reply;
	
	
	
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

	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public int getBoard_hit() {
		return board_hit;
	}
	public void setBoard_hit(int board_hit) {
		this.board_hit = board_hit;
	}
	public int getBoard_rec() {
		return board_rec;
	}
	public void setBoard_rec(int board_rec) {
		this.board_rec = board_rec;
	}
	public String getBoard_date() {
		return board_date;
	}
	public void setBoard_date(String board_date) {
		this.board_date = board_date;
	}
	
	public String getBoard_update() {
		return board_update;
	}
	public void setBoard_update(String board_update) {
		this.board_update = board_update;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	
	public String getBoard_file1() {
		return board_file1;
	}
	public void setBoard_file1(String board_file1) {
		this.board_file1 = board_file1;
	}
	public String getBoard_file2() {
		return board_file2;
	}
	public void setBoard_file2(String board_file2) {
		this.board_file2 = board_file2;
	}
	
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	
	public int getBoard_reply() {
		return board_reply;
	}
	public void setBoard_reply(int board_reply) {
		this.board_reply = board_reply;
	}
	
}