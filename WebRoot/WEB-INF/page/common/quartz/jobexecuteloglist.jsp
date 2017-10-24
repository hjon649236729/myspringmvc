<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../../include/tableinclude.jsp"%>
<div class="box">
	<div class="box-header">
		<form id="pagerForm" method="post" action="jobexecuteloglist.action">
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
					<th>状态</th>
					<th>执行人</th>
					<th>执行开始时间</th>
					<th>执行结束时间</th>
					<th>执行类型</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="jobExecuteLog" items="${data.result }">
					<tr>
						<td>${jobExecuteLog.name }</td>
						<td>${jobExecuteLog.status }</td>
						<td>${jobExecuteLog.empid }</td>
						<td>${jobExecuteLog.startTime }</td>
						<td>${jobExecuteLog.endTime }</td>
						<td>${jobExecuteLog.type }</td>
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