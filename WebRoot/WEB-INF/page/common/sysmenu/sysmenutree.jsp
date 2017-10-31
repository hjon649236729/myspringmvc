<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<%@include file="../../include/ztreeinclude.jsp"%>

<SCRIPT type="text/javascript">
<!--
	var setting = {
		edit : {
			enable : false
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
			//beforeDrop: beforeDrop,
			// beforeRename:beforeRename,

			onClick : openUrl
		// onRename: changeNodeName,
		// onRemove: removeNode,
		// onDrop: dropNode
		},

	};
	$(document).ready(
			function() {
				//$.post("",{}){}
				$.post("getnodelist.action", {

				}, function(result) {
					console.log(result);
					if (result != "[]]") {
						var zTree = $.fn.zTree.init($("#treeDemo"), setting,
								eval(result));
						zTree.expandAll(true);
					}
				});
			});
	function openUrl(event, treeId, treeNode) {
		parent.treeListFrame.location.href = "sysmenulist.action?id="
				+ treeNode.objid;
	}
//-->
</SCRIPT>
<div class="content_wrap">
	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
</div>
