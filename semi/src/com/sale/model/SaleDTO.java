package com.sale.model;

public class SaleDTO {

	private int sale_no;
	private int user_no;
	// private String user_nickname;
	private String sale_title;
	private String sale_content;
	private double sale_price;
	private String sale_file;
	private String sale_date;
	private int sale_reply;
	private int sale_hit;
	private int sale_check;
	
	public int getSale_no() {
		return sale_no;
	}
	public void setSale_no(int sale_no) {
		this.sale_no = sale_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getSale_title() {
		return sale_title;
	}
	public void setSale_title(String sale_title) {
		this.sale_title = sale_title;
	}
	public String getSale_content() {
		return sale_content;
	}
	public void setSale_content(String sale_content) {
		this.sale_content = sale_content;
	}
	public double getSale_price() {
		return sale_price;
	}
	public void setSale_price(double sale_price) {
		this.sale_price = sale_price;
	}
	public String getSale_file() {
		return sale_file;
	}
	public void setSale_file(String sale_file) {
		this.sale_file = sale_file;
	}
	public String getSale_date() {
		return sale_date;
	}
	public void setSale_date(String sale_date) {
		this.sale_date = sale_date;
	}
	public int getSale_reply() {
		return sale_reply;
	}
	public void setSale_reply(int sale_reply) {
		this.sale_reply = sale_reply;
	}
	public int getSale_hit() {
		return sale_hit;
	}
	public void setSale_hit(int sale_hit) {
		this.sale_hit = sale_hit;
	}
	public int getSale_check() {
		return sale_check;
	}
	public void setSale_check(int sale_check) {
		this.sale_check = sale_check;
	}
	
	
}
