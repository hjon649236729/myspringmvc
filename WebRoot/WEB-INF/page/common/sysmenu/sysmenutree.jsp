<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<%@include file="../../include/ztreeinclude.jsp"%>

<SCRIPT type="text/javascript">
	var setting = {
		edit : {
			enable : true,
			showRemoveBtn : showRemoveBtn,
			showRenameBtn : showRenameBtn
		},
		data : {
			key : {
				title : "name",
				name : "shortname"
			},
			simpleData : {
				enable : true,
				idKey : "objid",
				pIdKey : "parentid",
				rootPId : 0
			}
		},
		callback : {
			// beforeDrag: beforeDrag,
			//beforeDrop : beforeDrop,
			// beforeRename:beforeRename,
			beforeRemove : beforeRemove,
			onClick : openUrl,
			// onRename: changeNodeName,
			onRemove : removeNode
		// onDrop: dropNode
		},

	};

	$(document).ready(
			function() {
				//$.post("",{}){}
				$.post("getnodelist.action", {}, function(result) {
					console.log(result);
					if (result != "") {
						var zTree = $.fn.zTree.init($("#treeDemo"), setting,
								eval(result));
						zTree.expandAll(true);
					}
				});
			});
	function openUrl(event, treeId, treeNode) {
		console.log(event);
		console.log(treeId);
		console.log(treeNode);
		parent.treeListFrame.location.href = "sysmenulist.action?id="
				+ treeNode.objid;
	}
	function beforeRemove(treeId, treeNode) {
		console.log(treeNode);
		return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
	}
	function removeNode(treeId, treeNode) {
		return alert("删除 节点 -- " + treeNode.name + " 成功");
	}
	function add(id, shortName, noteName, isParent) {
		//console.log(noteName);
		var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		//isParent = e.data.isParent;
		nodes = zTree.getSelectedNodes();
		treeNode = nodes[0];
		if (treeNode) {
			treeNode = zTree.addNodes(treeNode, {
				id : id,
				pId : treeNode.id,
				isParent : isParent,
				title : noteName,
				shortname : shortName
			});
		} else {
			treeNode = zTree.addNodes(null, {
				id : id,
				pId : 0,
				isParent : isParent,
				title : noteName,
				shortname : shortName
			});
		}
	};
	function showRemoveBtn(treeId, treeNode) {
		return !treeNode.isParent;
	}
	function showRenameBtn(treeId, treeNode) {
		return true;
	}
</SCRIPT>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
