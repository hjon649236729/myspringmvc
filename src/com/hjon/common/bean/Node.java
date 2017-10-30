package com.hjon.common.bean;

public class Node {
	String objid = "";
	String parentid = "";
	String name = "";
	String code = "";
	int level = 0;
	int sort = 0;
	String type = "";
	String icon = "";
	boolean removeable = true;
	boolean renameable = true;
	boolean dragable = true;

	public Node() {
	}

	public String getObjid() {
		return this.objid;
	}

	public void setObjid(String objid) {
		this.objid = objid;
	}

	public String getParentid() {
		return this.parentid;
	}

	public void setParentid(String parentid) {
		this.parentid = parentid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getLevel() {
		return this.level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public int getSort() {
		return this.sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public boolean isRemoveable() {
		return this.removeable;
	}

	public void setRemoveAble(boolean removeable) {
		this.removeable = removeable;
	}

	public boolean isRenameable() {
		return this.renameable;
	}

	public void setRenameAble(boolean renameable) {
		this.renameable = renameable;
	}

	public boolean isDrag() {
		return this.dragable;
	}

	public void setDrag(boolean dragable) {
		this.dragable = dragable;
	}
}
