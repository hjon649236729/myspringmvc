<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../../include/tableinclude.jsp"%>
<div class="box">
	<div class="box-header">
		<form id="pagerForm" method="post" action="quartzlist.action">
			<input type="hidden" name="pageNum" id="pageNum"
				value="${data.currentPageIndex}" /> <input type="hidden"
				name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
				type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
				type="hidden" name="orderField" value="startTime" /> <input
				type="hidden" name="orderDirection" value="desc" />

			<div class="input-group input-group-sm" style="width: 150px;">
				<input type="text" name="jobName" class="form-control"
					value="${jobName }" placeholder="请输入用任务名称">

				<div class="input-group-btn">
					<button type="submit" class="btn btn-default" id="submit">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</form>
	</div>
	<!-- /.box-header -->
	<div class="box-body table-responsive no-padding "
		style="width:auto; height:400px; overflow: hidden; ">
		<table class="table table-striped table-hover">
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
						<td><a
							href="javascript:showExecuteLog('${quartz.JOB_NAME }')">${quartz.JOB_NAME
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

	</div>
	<div class="box-footer clearfix center">
		<span>共${data.totalPageCount}页， 第${data.currentPageIndex}页，
			每页显示${data.pageSize}条</span>
		<ul class="pagination pagination-sm no-margin  pull-right">
			<li><a href="javascript:Previous();">上一页</a></li>
			<li><a href="javascript:Next();">下一页</a></li>
		</ul>
	</div>
</div>