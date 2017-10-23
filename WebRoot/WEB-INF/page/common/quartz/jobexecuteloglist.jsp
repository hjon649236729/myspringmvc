<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../../include/indexinclude.jsp"%>
<form class="navbar-form navbar-left" id="pagerForm" method="post"
	action="jobexecuteloglist.action">
	<input type="hidden" name="pageNum" id="pageNum"
		value="${data.currentPageIndex}" /> <input type="hidden"
		name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
		type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
		type="hidden" name="orderField" value="startTime" /> <input
		type="hidden" name="orderDirection" value="desc" />

	<div class="form-group">
		<input type="hidden" class="form-control" name="jobName"
			value="${jobName }">

	</div>
	<button type="submit" id="submit" class="btn btn-primary btn-mx">查询</button>
</form>
<table class="table table-striped">
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
<nav aria-label="...">
	<ul class="pager">
		<li>共${data.totalPageCount }页</li>
		<c:if test="${data.currentPageIndex<=1}">
			<li class="disabled"><a href="#">上一页</a>
			</li>
		</c:if>
		<c:if test="${data.currentPageIndex>1}">
			<li><a href="javascript:Previous();">上一页</a>
			</li>
		</c:if>
		<c:if test="${data.currentPageIndex>=data.totalPageCount}">
			<li class="disabled"><a href="#">下一页</a>
			</li>
		</c:if>
		<c:if test="${data.currentPageIndex<data.totalPageCount}">
			<li><a href="javascript:Next();">下一页</a>
			</li>
		</c:if>
		<li>第${data.currentPageIndex }页</li>
	</ul>
</nav>
