package com.hjon.common.bean;

/**
 * CommonTreelevel entity. @author MyEclipse Persistence Tools
 */

public class CommonTreelevel implements java.io.Serializable {

	// Fields

	private Integer id;
	private String treeId;
	private String parentId;
	private String ancestorPath;
	private Integer ancestorCount;
	private Integer childrenCount;

	// Constructors

	/** default constructor */
	public CommonTreelevel() {
	}

	/** minimal constructor */
	public CommonTreelevel(String treeId, String ancestorPath,
			Integer ancestorCount, Integer childrenCount) {
		this.treeId = treeId;
		this.ancestorPath = ancestorPath;
		this.ancestorCount = ancestorCount;
		this.childrenCount = childrenCount;
	}

	/** full constructor */
	public CommonTreelevel(String treeId, String parentId,
			String ancestorPath, Integer ancestorCount, Integer childrenCount) {
		this.treeId = treeId;
		this.parentId = parentId;
		this.ancestorPath = ancestorPath;
		this.ancestorCount = ancestorCount;
		this.childrenCount = childrenCount;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTreeId() {
		return this.treeId;
	}

	public void setTreeId(String treeId) {
		this.treeId = treeId;
	}

	public String getParentId() {
		return this.parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getAncestorPath() {
		return this.ancestorPath;
	}

	public void setAncestorPath(String ancestorPath) {
		this.ancestorPath = ancestorPath;
	}

	public Integer getAncestorCount() {
		return this.ancestorCount;
	}

	public void setAncestorCount(Integer ancestorCount) {
		this.ancestorCount = ancestorCount;
	}

	public Integer getChildrenCount() {
		return this.childrenCount;
	}

	public void setChildrenCount(Integer childrenCount) {
		this.childrenCount = childrenCount;
	}
}