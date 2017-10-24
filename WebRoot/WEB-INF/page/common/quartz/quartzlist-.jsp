<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../../include/indexinclude.jsp"%>
<script type="text/javascript">
	$(function() {
		$("form.required-validate").each(function() {
			var $form = $(this);
			$form.bootstrapValidator().on('success.form.bv', function(e) {
				//console.log("test");
				// 阻止默认事件提交

				$.ajax({
					cache : true,
					type : "POST",
					url : "quartzsave.action",
					data : $('#quartzform').serialize(),// 你的formid
					async : false,
					error : function(request) {
						alert("Connection error");
					},
					success : function(data) {
						//$("#commonLayout_appcreshi").parent().html(data);
						//alert(data);
						//window.location.href = "userlist.action";
						$("#submit").click();
					}
				});
				e.preventDefault();
			});
		});
	});
	function modify(jobname, jobclass, cron, description) {
		$("#planName").val(jobname);
		$("#time").val(cron);
		$("#jobClass").val(jobclass);
		var desc = description != null ? description.split("########$$%%:")
				: '';
		$("#memo").val(desc[0] == 'null' ? '' : desc[0]);
		$("#reqtype").val(1);
		$("#oldJobName").val(jobname);
		$("#addCrontriggerModal").modal("show");
	}

	function StandardPost(url, args) {
		var form = $("<form method='post'></form>");
		form.attr({
			"action" : url
		});
		for (arg in args) {
			var input = $("<input type='hidden'>");
			input.attr({
				"name" : arg
			});
			input.val(args[arg]);
			form.append(input);
		}
		$(document.body).append(form);
		form.submit();
	}
	function showExecuteLog(jobname) {
		StandardPost("jobexecuteloglist.action", {
			jobName : jobname
		});
	}
</script>

<form class="navbar-form navbar-left" id="pagerForm" method="post"
	action="quartzlist.action">
	<input type="hidden" name="pageNum" id="pageNum"
		value="${data.currentPageIndex}" /> <input type="hidden"
		name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
		type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
		type="hidden" name="orderField" value="createTime" /> <input
		type="hidden" name="orderDirection" value="desc" />

	<div class="form-group">
		<%-- <input type="text" class="form-control" name="userName"
                        value="${userName }" placeholder="用户名"> --%>
	</div>
	<button type="submit" id="submit" class="btn btn-primary btn-mx">查询</button>
	<!-- <a class="btn btn-default" href="" role="button">添加</a> -->
	<button type="button" class="btn btn-primary btn-mx"
		data-toggle="modal" data-target="#addCrontriggerModal">添加</button>
</form>
<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary btn-mx">添加</button> -->
<table class="table table-striped">
	<thead>
		<tr>

			<th>任务名称</th>
			<th>任务类</th>
			<th>上次执行时间</th>
			<th>下次执行时间</th>
			<th>状态</th>
			<th>操作</th>
		</tr>
	</thead>

	<tbody>
		<c:forEach var="quartz" items="${data.result }">
			<tr>
				<td><a href="javascript:showExecuteLog('${quartz.JOB_NAME }')">${quartz.JOB_NAME
						}</a>
				</td>
				<td>${quartz.JOB_CLASS_NAME }</td>
				<td>${quartz.PREV_FIRE_TIME }</td>
				<td>${quartz.NEXT_FIRE_TIME }</td>
				<td>${quartz.TRIGGER_STATE }</td>
				<td><a
					href="javascript:modify('${quartz.JOB_NAME}','${quartz.JOB_CLASS_NAME }','${quartz.CRON_EXPRESSION }','${quartz.DESCRIPTION }')">修改</a>|<a
					href="">手动执行</a>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<nav aria-label="...">
	<ul class="pager">
		<li>共${data.totalPageCount }页</li>
		<c:if test="${data.currentPageIndex<=1}">
			<li class="disabled"><a href="#">上一页</a></li>
		</c:if>
		<c:if test="${data.currentPageIndex>1}">
			<li><a href="javascript:Previous();">上一页</a></li>
		</c:if>
		<c:if test="${data.currentPageIndex>=data.totalPageCount}">
			<li class="disabled"><a href="#">下一页</a></li>
		</c:if>
		<c:if test="${data.currentPageIndex<data.totalPageCount}">
			<li><a href="javascript:Next();">下一页</a></li>
		</c:if>
		<li>第${data.currentPageIndex }页</li>
	</ul>
</nav>

<!-- Modal -->
<div class="modal fade" id="addCrontriggerModal" tabindex="-1"
	role="dialog" aria-labelledby="addCrontriggerModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="addCrontriggerModalLabel">添加定时任务</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal required-validate" id="quartzform"
					method="post" action="quartzsave.action">
					<input type="hidden" id="reqtype" name="reqtype" value=0> <input
						type="hidden" id="oldJobName" name="oldJobName" value="">
					<div class="form-group">
						<label for="planName" class="col-sm-3 control-label">定时任务名称</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="planName"
								name="planName" placeholder="请输入定时任务名称" data-bv-notempty
								data-bv-notempty-message="用户名不能为空">
						</div>
					</div>
					<div class="form-group">
						<label for="time" class="col-sm-3 control-label">定时任务执行时间</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="time" name="time"
								placeholder="请输入Cron表达式" data-bv-notempty
								data-bv-notempty-message="执行时间不能为空">
						</div>
					</div>
					<div class="form-group">
						<label for="jobClass" class="col-sm-3 control-label">执行类</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="jobClass"
								name="jobClass" placeholder="请输入执行类" data-bv-notempty
								data-bv-notempty-message="执行类不能为空">
						</div>
					</div>
					<div class="form-group">
						<label for="time" class="col-sm-3 control-label">说明</label>
						<div class="col-sm-6">
							<!-- <input type="text" class="form-control" id="time"
                                                                name="time" data-bv-notempty
                                                                data-bv-notempty-message="执行时间不能为空"> -->
							<textarea class="form-control" rows="3" id="memo" name="memo"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Save
							changes</button>
					</div>
				</form>
			</div>

		</div>
	</div>
</div>