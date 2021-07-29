package com.pyd.entity;

public class SearchCondition {
	private String condition;
	private int pageNow;
	private int beginRow;
	private int pageSize;
	private int pageCnt = 1;
	private String queryLogCard;
    public SearchCondition(){
    	
    }
    public SearchCondition(String queryLogCard,String condition){
    	this.queryLogCard = queryLogCard;
    	this.condition = condition;
    }
    public SearchCondition(String condition,int pageNow,int pageSize){
    	this.condition = condition;
    	this.pageNow = pageNow;
    	this.pageSize = pageSize;
    }
	public SearchCondition(String condition, int pageNow, int pageSize, String queryLogCard) {
		super();
		this.condition = condition;
		this.pageNow = pageNow;
		this.pageSize = pageSize;
		this.queryLogCard = queryLogCard;
	}
	
	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public int getPageNow() {
		return pageNow;
	}

	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}

	public int getBeginRow() {
		return beginRow;
	}

	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
    
	public String getQueryLogCard() {
		return queryLogCard;
	}
	
	public void setQueryLogCard(String queryLogCard) {
		this.queryLogCard = queryLogCard;
	}
	
	@Override
	public String toString() {
		return "SearchCondition [condition=" + condition + ", pageNow=" + pageNow + ", beginRow=" + beginRow
				+ ", pageSize=" + pageSize + ", pageCnt=" + pageCnt + ", queryLogCard=" + queryLogCard + "]";
	}

}
