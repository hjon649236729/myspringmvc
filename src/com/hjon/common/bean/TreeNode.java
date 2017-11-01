package com.hjon.common.bean;

public class TreeNode extends Node{
    String parenttype = ""; //父节点所属类型
    String shortname = "";  //节点名称截取版

    public String getPreParentId(){
        return this.getParentid();
    }

    public String getParenttype() {
        return parenttype;
    }

    public void setParenttype(String parenttype) {
        this.parenttype = parenttype;
    }

    public void setName(String name) {
        super.setName(name);
        if(name.length() > 14){
            this.shortname = name.substring(0, 14) + "...";
        }else {
            this.shortname = name;
        }
    }

    public String getShortname() {
        return shortname;
    }

    public TreeNode(Node node){
        this.setObjid(node.getObjid());
        this.setType(node.getType());
        this.setParentid(node.getParentid());
        this.setName(node.getName());
        this.setLevel(node.getLevel());
        this.setSort(node.getSort());
        this.setCode(node.getCode());
        this.setIcon(node.getIcon());
        this.setRenameAble(node.isRenameable());
        this.setRemoveAble(node.isRemoveable());
        this.setDrag(node.isDrag());
    }

	public TreeNode() {
		// TODO Auto-generated constructor stub
	}
}