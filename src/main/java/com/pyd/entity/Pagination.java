package com.pyd.entity;

public class Pagination {
	private Integer page;
	private Integer count;
	
	public Pagination() {
		super();
	}
	public Pagination(Integer page, Integer count) {
		super();
		this.page = page;
		this.count = count;
	}
	@Override
	public String toString() {
		return "Pagination [page=" + page + ", count=" + count + "]";
	}
	public Integer getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
}
