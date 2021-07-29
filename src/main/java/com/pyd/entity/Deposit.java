package com.pyd.entity;

import java.sql.Timestamp;
import java.util.Date;

public class Deposit {
	private Integer id;
    private String save_card;
    private Integer save_money;
    private String save_way;
    private Integer save_arrive;
	private Timestamp save_time;
	public Deposit(Integer id,String save_card, Integer save_money, String save_way,Integer save_arrive,Timestamp save_time) {
		super();
		this.id = id;
		this.save_card = save_card;
		this.save_money = save_money;
		this.save_way = save_way;
		this.save_arrive = save_arrive;
		this.save_time = save_time;
	}
	
	public Deposit(String save_card, Integer save_money, String save_way,Integer save_arrive,Timestamp save_time) {
		super();
		this.save_card = save_card;
		this.save_money = save_money;
		this.save_way = save_way;
		this.save_arrive = save_arrive;
		this.save_time = save_time;
	}
	
	public Deposit(Integer id,Integer save_money) {
		super();
        this.id = id;
		this.save_money = save_money;
	}
	
	public Deposit() {
		super();
		// TODO 自动生成的构造函数存根
	}
    
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getSave_card() {
		return save_card;
	}

	public void setSave_card(String save_card) {
		this.save_card = save_card;
	}
	public Integer getSave_money() {
		return save_money;
	}
	public void setSave_money(Integer save_money) {
		this.save_money = save_money;
	}
	public String getSave_way() {
		return save_way;
	}
	public void setSave_way(String save_way) {
		this.save_way = save_way;
	}

	public Integer getSave_arrive() {
		return save_arrive;
	}

	public void setSave_arrive(Integer save_arrive) {
		this.save_arrive = save_arrive;
	}
    
	public Timestamp getSave_time() {
		return save_time;
	}
	public void setSave_time(Timestamp save_time) {
		this.save_time = save_time;
	}
	
	@Override
	public String toString() {
		return "Deposit [id=" + id + ", save_card=" + save_card + ", save_money=" + save_money + ", save_way="
				+ save_way + ", save_arrive=" + save_arrive + ", save_time=" + save_time + "]";
	}

}
