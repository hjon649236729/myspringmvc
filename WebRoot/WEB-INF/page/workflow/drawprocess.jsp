<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="../include/workflowinclude.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<script type="text/javascript">
	//        初始化数据， 从服务器获取。

	//----------------  selectEditor  ----------------
	var _specialtaskList = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getSpecialTaskList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						console.log(data);
						_specialtaskList = eval(data);
					//}
				}
			});
	var _pointtypelist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getPointtypeList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_pointtypelist = eval(data);
					//}
				}
			});
	var _processurllist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getProcessUrlList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//console.log( _opts && _opts.length);
					//if (_opts && _opts.length) {
					console.log("processurllist" + _processurllist);
					_processurllist = eval(data);
					console.log("processurllist" + _processurllist);
					//}
				}
			});
	var _submitownerlist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getSubmitOwnerList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_submitownerlist = eval(data);
					//}
				}
			});
	var _stepdealerlist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getStepDealerList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_stepdealerlist = eval(data);
					//}
				}
			});
	var _messageremindlist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getMessageRemindList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_messageremindlist = eval(data);
					//}
				}
			});

	//------------------------------------------------
	var _stepconditionlist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getStepConditionList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_stepconditionlist = eval(data);
					//}
				}
			});

	var _judgetypeList = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getJudgeTypeList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_judgetypeList = eval(data);
					//}
				}
			});
	var _messagenoticelist = "";
	$
			.ajax({
				type : "POST",
				url : "${path}/drawprocess/getMessageNoticeList.action?processtype=${processtype}",
				async : false,
				success : function(data) {
					var _opts = eval(data);
					//if (_opts && _opts.length) {
						_messagenoticelist = eval(data);
					//}
				}
			});

	var _ownerlink = "";
	$.ajax({
		type : "POST",
		url : "${path}/drawprocess/getOwnerLinkOriginListJSON.action",
		async : false,
		success : function(data) {
			var _opts = eval(data);
			//if (_opts && _opts.length) {
				_ownerlink = eval(data)[0];
			//}
		}
	});
</script>
<script type="text/javascript">
	$(function() {
		//console.log('${flowdata}');
		console.log('${path}');
		var json = eval('(' + '${flowdata}' + ')');
		console.log(json);
		$('#myflow').myflow({
			processtype : "${processtype}",
			showtype : false,
			editable : true,
			basePath : "${path}",
			restore : json,//
			iscancel : false,
			tools : {
				save : {
					onclick : function(data) {
						console.log(data);
						saveMyflow(data);
					}
				},
				showorg : {
					onclick : function(relationDiv, hiddenname) {
						//show("user", relationDiv, hiddenname, "wwww", "");
					}
				}
			}
		});

		if ('${not empty svgwidth && not empty svgheight}' == 'true') {
			$("#myflow").children().first().width(Number('${svgwidth}'))
					.height(Number('${svgheight}'));
			$("#setSvgSizeForm").find("input[name='svgwidth']").val(
					Number('${svgwidth}'));
			$("#setSvgSizeForm").find("input[name='svgheight']").val(
					Number('${svgheight}'));
		}
		$("#pointer").click();

		$("#myflow").click(function() {
			$("#pointer").click();
		});
		stretchHeight($("#showdrawflowdiv"), 30);

		$('#myflow_props').show();
		stretchHeight($("#myflow_props_table"), 100);
		$('#myflow_props').hide();
	});

	var stretchHeight = function(targetobj, delta) {
		var sf = function() {
			var tableWrap = $(targetobj);
			var tableOffset = tableWrap.offset();
			var documentHeight = $(window).height();
			var tableHeight = documentHeight - tableOffset.top
					- (delta == undefined ? 0 : delta);
			tableWrap.css("max-height", tableHeight);
		};
		sf();
		$(window).resize(function() {
			sf();
		});
	};
	function saveMyflow(_flowData) {
		console.log("save MYflow");
	}
</script>


<div id="showdrawflowdiv"
	style="height:585px;padding-top:0px; overflow: scroll;"
	class="myflow_bg">
	<!-- 
    <jsp:include page="/org/searchorg/selectorginclude.jsp"></jsp:include> -->

	<div id="myflow_tools" class="ui-widget-content">
		<div id="myflow_tools_handle" class="ui-widget-header">工具集</div>

		<div class="node" id="myflow_save">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/save.gif" /><span>保存</span>
		</div>
		<div>
			<hr />
		</div>
		<div class="node selectable" id="pointer">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/select16.gif" /><span>选择</span>
		</div>
		<div class="node selectable" id="path">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/flow_sequence.png" /><span>指向</span>
		</div>
		<%--<div class="node selectable" id="line"><img src="img/16/flow_line.png"/><span>关联</span></div>--%>
		<div>
			<hr />
		</div>
		<div class="node state" id="start" type="start">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/start_event_empty.png" /><span>开始</span>
		</div>
		<div class="node state" id="submit" type="submit">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/task_yellow.png" /><span>提交</span>
		</div>
		<div class="node state" id="judge" type="judge">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/task_empty2.png" /><span>处理</span>
		</div>
		<%--<div class="node state" id="linkif" type="linkif"><img src="${contextPath}/Scripts/workflow/img/16/gateway_parallel.png"/><span>条件</span></div>--%>
		<div class="node state" id="state" type="state">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/task_empty.png" /><span>条件</span>
		</div>
		<%--<div class="node state" id="task" type="task"><img src="${contextPath}/Scripts/workflow/img/16/task_java.png"/><span>任务</span></div>--%>
		<div class="node state" id="end" type="end">
			<img
				src="${contextPath}/Scripts/workflow/configurate/drawprocess/img/16/end_event_terminate.png" /><span>结束</span>
		</div>
		<%--<div>--%>
		<%--<hr/>--%>
		<%--</div>--%>
		<%--<div class="node state" id="fork" type="fork"><img src="img/16/gateway_parallel.png"/><span>分支</span></div>--%>
		<%--<div class="node state" id="join" type="join"><img src="img/16/gateway_parallel.png"/><span>合并</span></div>--%>
		<%--<div class="node state" id="end-cancel" type="end-cancel"><img src="img/16/end_event_cancel.png"/><span>取消</span></div>--%>
		<%--<div class="node state" id="end-error" type="end-error"><img src="img/16/end_event_error.png"/><span>错误</span></div>--%>
		<div>
			<hr />
		</div>
		<div style="text-align: center">
			<c:if test="${true}">
				<button type="button" onclick="$('#setSvgSizeWindow').show();"
					class="">
					<span>面板大小</span>
				</button>
			</c:if>
		</div>
	</div>


	<div id="myflow_props" class="ui-widget-content">
		<div id="myflow_props_handle" class="ui-widget-header">
			<span>属性</span> <b class="closeicon"
				onclick="$('#myflow_close_bt').click();"></b>
		</div>
		<div id="myflow_props_table"
			style="overflow-y: auto;overflow-x: hidden;">
			<table class="">
			</table>
		</div>
		<div style="padding-top: 2px; text-align: center;">
			<c:if test="${editable}">
				<button id="myflow_save_bt" class="">确定</button>
                &nbsp;&nbsp;
            </c:if>
			<button id="myflow_close_bt" class="">${editable==true?
				"取消":"关闭"}</button>
		</div>
	</div>
	<div id="myflow"></div>

</div>