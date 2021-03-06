package com.pyd.entity;

import java.sql.Timestamp;

public class Log {
	private Integer id;
	private String card;
	private Integer deal;
	private String msg;
	private Timestamp deal_time;
	
	public Log() {
		super();
	}


	public Log(String card, Integer deal, String msg, Timestamp deal_time) {
		super();
		this.card = card;
		this.deal = deal;
		this.msg = msg;
		this.deal_time = deal_time;
	}

	public Log(String card) {
		super();
		this.card = card;
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

	public int getDeal() {
		return deal;
	}

	public void setDeal(int deal) {
		this.deal = deal;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}


	public Timestamp getDeal_time() {
		return deal_time;
	}

	public void setDeal_time(Timestamp deal_time) {
		this.deal_time = deal_time;
	}


	@Override
	public String toString() {
		return "Log [id=" + id + ", card=" + card + ", deal=" + deal + ", msg="
				+ msg + ", deal_time=" + deal_time + "]";
	}
	
}
