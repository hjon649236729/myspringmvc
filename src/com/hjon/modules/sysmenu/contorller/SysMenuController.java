package com.hjon.modules.sysmenu.contorller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hjon.common.bean.Node;
import com.hjon.common.bean.Page;
import com.hjon.common.bean.TreeNode;
import com.hjon.common.controller.BaseController;
import com.hjon.common.controller.INodeAction;
import com.hjon.common.dao.CriterionCollection;
import com.hjon.common.utils.NumberUtils;
import com.hjon.common.utils.StringUtils;
import com.hjon.modules.sysmenu.entity.SysMenu;
import com.hjon.modules.sysmenu.service.SysMenuService;

@Controller
@Scope("prototype")
public class SysMenuController extends BaseController implements INodeAction {
	Logger logger = Logger.getLogger(SysMenuController.class);
	@Resource(name = "sysMenuService")
	private SysMenuService sysMenuService;

	@RequestMapping("sysmenu/sysmenumain")
	public String sysmenumain() {

		return "sysmenu/sysmenumain";

	}

	@RequestMapping("sysmenu/sysmenusave")
	@ResponseBody
	public String sysmenusave() {
		String name = this.getParameter("name");
		String url = this.getParameter("url");
		String sort = this.getParameter("sort");
		String description = this.getParameter("description");
		SysMenu sysMenu = new SysMenu();
		this.setEntityValueFromPage(sysMenu);
		sysMenuService.saveOrUpdate(sysMenu);
		return new JSONObject(SysMenu2Node(sysMenu)).toString();
	}

	@RequestMapping("sysmenu/sysmenulist")
	public String sysmenulist() {
		int id = NumberUtils.safeToInteger(this.getParameter("id"), -1);
		SysMenu currentMenu = new SysMenu();
		// List<SysMenu> childSysMenus = new ArrayList<SysMenu>();
		int pageNum = NumberUtils
				.safeToInteger(this.getParameter("pageNum"), 1);
		int numPerPage = NumberUtils.safeToInteger(
				this.getParameter("numPerPage"), 10);
		String orderField = this.getParameter("orderField");
		String orderDirection = this.getParameter("orderDirection");
		Order order = Order.desc("sort");
		CriterionCollection search = new CriterionCollection();
		if (orderField != null && !orderField.equals("")) {
			if (orderDirection.toLowerCase().equals("asc")) {
				order = Order.asc(orderField);
				this.setAttribute("orderDirection", "asc");
			} else {
				order = Order.desc(orderField);
				this.setAttribute("orderDirection", "desc");
			}
			this.setAttribute("orderField", orderField);
		}
		// Page childSysMenus=new Page();
		Page data = new Page();
		if (id != -1) {
			currentMenu = sysMenuService.get(id);
			search.Add(Restrictions.eq("parentId", id));
			data = sysMenuService
					.pagedQuery(pageNum, numPerPage, search, order);
		}
		this.setAttribute("currentSysMenu", currentMenu);
		this.setAttribute("data", data);
		return "sysmenu/sysmenulist";

	}

	@RequestMapping("sysmenu/sysmenutree")
	public String sysmenutree() {

		return "sysmenu/sysmenutree";
	}

	@RequestMapping("sysmenu/getnodelist")
	@ResponseBody
	public String getNodeList() {
		List<TreeNode> _res = new LinkedList<TreeNode>();

		_res = this.getChildNodeList("0", "");

		String result = new JSONArray(sortNodeListBySort(_res)).toString();
		return result;
	}

	private List<TreeNode> sortNodeListBySort(List<TreeNode> list) {

		Collections.sort(list, new Comparator<TreeNode>() {
			public int compare(TreeNode a, TreeNode b) {
				int sort1 = a.getSort();
				int sort2 = b.getSort();
				return sort1 - sort2;
			}
		});
		return list;
	}

	private List<TreeNode> getChildNodeList(String parentid, String parenttype) {
		List<TreeNode> _res = new LinkedList<TreeNode>();
		List<Node> _roots = this.findChildrenByParentId(parentid, parenttype);
		if (_roots != null) {
			for (Node _node : _roots) {
				TreeNode _treenode = new TreeNode(_node);
				_treenode.setParenttype(parenttype);
				_res.add(_treenode);
			}

			for (Node _node : _roots) {
				String objid = _node.getObjid();
				if (!StringUtils.isBlank(objid)) {
					List<TreeNode> _nodeList = this.getChildNodeList(objid,
							_node.getType());
					if (_nodeList.size() > 0) {
						_res.addAll(_nodeList);
					}
				}
			}
		}
		return _res;
	}

	@Override
	public List<Node> findChildrenByParentId(String parentid, String type) {
		int _parentid = NumberUtils.safeToInteger(parentid, -1);
		List<SysMenu> _list = new LinkedList<SysMenu>();
		if (_parentid == 0) {
			_list = sysMenuService.getTopMenus("DEFAULT");
		} else {
			_list = sysMenuService.findSysMenuByParentId(_parentid);
		}
		return this.SysMenuList2NodeList(_list);
	}

	private List<Node> SysMenuList2NodeList(List<SysMenu> list) {
		List<Node> _res = new ArrayList<Node>();
		if (list != null) {
			for (SysMenu _sysmenu : list) {
				Node node = new Node();
				node.setObjid(StringUtils.safeToString(_sysmenu.getId(), ""));
				node.setParentid(StringUtils.safeToString(
						_sysmenu.getParentId(), ""));
				node.setName(_sysmenu.getName());
				node.setSort(_sysmenu.getSort());
				_res.add(node);
			}
		}

		return _res;
	}

	private TreeNode SysMenu2Node(SysMenu sysMenu) {

		TreeNode node = new TreeNode();
		node.setObjid(StringUtils.safeToString(sysMenu.getId(), ""));
		node.setParentid(StringUtils.safeToString(sysMenu.getParentId(), ""));
		node.setName(sysMenu.getName());
		node.setSort(sysMenu.getSort());
		return node;

	}

	@Override
	public Node findParentByNodeId(String nodeid, String type) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteNode(String nodeid, String type) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean checkDeleteNode(String nodeid, String type) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String saveNode(Node node) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkMoveNode(Node node, Node target, String moveType) {
		// TODO Auto-generated method stub
		return false;
	}
}
