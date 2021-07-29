package com.pyd.entity;

import java.sql.Timestamp;

public class Account {
	private Integer id;
	private String card;
	private String username;
	private String sex;
	private Double money;
	private Timestamp open_date;
	private String old_pay_password;
	private String new_pay_password;
	private Integer isDelete;
	private String email;
	public Account(){
		super();
	}
	
	public Account(String card, Double money) {
		super();
		this.card = card;
		this.money = money;
	}

	public Account(String card, String username, String sex, Double money, Timestamp open_date, String old_pay_password,
			Integer isDelete, String email) {
		super();
		this.card = card;
		this.username = username;
		this.sex = sex;
		this.money = money;
		this.open_date = open_date;
		this.old_pay_password = old_pay_password;
		this.new_pay_password = old_pay_password;
		this.isDelete = isDelete;
		this.email = email;
	}
    
	public Account(String card, String username, String sex, Double money, Timestamp open_date,
			String old_pay_password, String new_pay_password, Integer isDelete, String email) {
		super();
		this.card = card;
		this.username = username;
		this.sex = sex;
		this.money = money;
		this.open_date = open_date;
		this.old_pay_password = old_pay_password;
		this.new_pay_password = new_pay_password;
		this.isDelete = isDelete;
		this.email = email;
	}

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCard() {
		return card;
	}
	public void setCard(String card) {
		this.card = card;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Double getMoney() {
		return money;
	}
	public void setMoney(Double money) {
		this.money = money;
	}
	public Timestamp getOpen_date() {
		return open_date;
	}
	public void setOpen_date(Timestamp open_date) {
		this.open_date = open_date;
	}
	public String getOld_pay_password() {
		return old_pay_password;
	}
	public void setOld_pay_password(String old_pay_password) {
		this.old_pay_password = old_pay_password;
	}
	public String getNew_pay_password() {
		return new_pay_password;
	}
	public void setNew_pay_password(String new_pay_password) {
		this.new_pay_password = new_pay_password;
	}
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "Account [id=" + id + ", card=" + card + ", username=" + username + ", sex=" + sex + ", money=" + money
				+ ", open_date=" + open_date + ", old_pay_password=" + old_pay_password + ", new_pay_password="
				+ new_pay_password + ", isDelete=" + isDelete + ", email=" + email + "]";
	}
	
}