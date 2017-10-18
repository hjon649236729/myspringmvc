package com.hjon.common.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页对象
 * 
 */
@SuppressWarnings( { "unused", "unchecked" })
public class Page {
    private int pageSize=10; // 每页的记录数
    private int currentPageIndex = 1; // 当前页,从1开始
    private List dataOfCurrentPage; // 当前页中存放的记录
    private long totalDataCount; // 总记录数
    private long totalPageCount;//总页数

	public Page() {
		this(0, 0, 10, new ArrayList());
	}

	public Page(int currentPageIndex, long totalDataCount,int pageSize, List dataOfCurrentPage) {
        this.currentPageIndex = currentPageIndex;
        this.totalDataCount = totalDataCount;
        this.pageSize = pageSize;
        this.dataOfCurrentPage = dataOfCurrentPage;
        this.totalPageCount=totalDataCount % pageSize == 0 ? totalDataCount / pageSize : totalDataCount / pageSize + 1;
	}
	
	/**
	 * 取每页的数据条数
	 * @return
	 */
	public int getPageSize() {
		return this.pageSize;
	}
	
	/**
	 * 当前页的索引，从1开始
	 * @return
	 */
	public int getCurrentPageIndex() {
		return this.currentPageIndex;
	}
	
	/**
	 * 取总条数
	 * @return
	 */
	public long getTotalDataCount() {
		return totalDataCount;
	}
	
	/**
	 * 取总页数
	 * @return
	 */
	public long getTotalPageCount() {
		return totalDataCount % pageSize == 0 ? totalDataCount / pageSize : totalDataCount / pageSize + 1;
	}
	
	/**
	 * 取当前页中的数据
	 * @return
	 */
	public List getResult() {
		return this.dataOfCurrentPage;
	}
	
	public void setResult(List data) {
		this.dataOfCurrentPage=data;
	}
}
