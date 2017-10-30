<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<%@include file="../../include/ztreeinclude.jsp"%>

<SCRIPT type="text/javascript">
<!--
	var setting = {
		edit : {
			enable : false
		},
		callback : {
			// beforeDrag: beforeDrag,
			//beforeDrop: beforeDrop,
			// beforeRename:beforeRename,

			onClick : openUrl
		// onRename: changeNodeName,
		// onRemove: removeNode,
		// onDrop: dropNode
		},

	};

	var zNodes = [ {
		name : "父节点1 - 展开",
		open : true,
		children : [ {
			name : "父节点11 - 折叠",
			children : [ {
				name : "叶子节点111",
				unitId : 1
			}, {
				name : "叶子节点112"
			}, {
				name : "叶子节点113"
			}, {
				name : "叶子节点114"
			} ]
		} ]
	} ];
	$(document).ready(
			function() {
				//$.post("",{}){}
				$.post("getnodelist.action", {
					
				}, function(result) {
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
		parent.treeListFrame.location.href = "sysmenulist.action?unitId="
				+ treeNode.unitId;
	}
//-->
</SCRIPT>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
