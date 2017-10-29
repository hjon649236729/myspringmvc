<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<%@include file="../../include/ztreeinclude.jsp"%>

<SCRIPT type="text/javascript">
<!--
	var setting = {
		edit : {
			enable : false
		}  ,callback: {
       // beforeDrag: beforeDrag,
        //beforeDrop: beforeDrop,
       // beforeRename:beforeRename,

        onClick: openUrl
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
				target:"treeListFrame"
			}, {
				name : "叶子节点112"
			}, {
				name : "叶子节点113"
			}, {
				name : "叶子节点114"
			} ]
		} ]
	} ];

	$(document).ready(function() {
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
	function openUrl(event, treeId, treeNode) { 
		console.log(treeNode);
	}
//-->
</SCRIPT>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
