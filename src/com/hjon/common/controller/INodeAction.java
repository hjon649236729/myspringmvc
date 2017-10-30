package com.hjon.common.controller;

import java.util.List;

import com.hjon.common.bean.Node;

public interface INodeAction {
	/**
	 * 通过父节点id查找直接子节点， 找不到时返回 new ArrayList<Node>()
	 */
	public List<Node> findChildrenByParentId(String parentid, String type);

	/**
	 * 通过当前节点id查找父节点， 找不到时返回 null
	 */
	public Node findParentByNodeId(String nodeid, String type);

	/**
	 * 删除节点， 在树状列表上删除节点时调用
	 */
	public void deleteNode(String nodeid, String type);

	/**
	 * 检测能否删除该节点
	 * 
	 * @return { true：可以删除， false：不能删除 }
	 */
	@Deprecated
	public boolean checkDeleteNode(String nodeid, String type);

	/**
	 * 保存节点信息， 在初始化树状列表、删除节点、拖动节点时会调用
	 * 
	 * @return 不能保存时的提示信息
	 */
	public String saveNode(Node node);

	/**
	 * 判断节点能否移动
	 * 
	 * @param node
	 *            拖动的节点
	 * @param target
	 *            拖动到的目标节点
	 * @param moveType
	 *            "prev"：移动到目标节点前面， "next"：移动到目标节点后面， inner：成为目标节点的子节点
	 * @return { true：可以移动， false：不能移动 }
	 */
	public boolean checkMoveNode(Node node, Node target, String moveType);
}
