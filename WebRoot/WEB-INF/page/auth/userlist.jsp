<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../include/tableinclude.jsp"%>
<div class="box">
	<div class="box-header">
		<form id="pagerForm" method="post" action="userlist.action">
			<input type="hidden" name="pageNum" id="pageNum"
				value="${data.currentPageIndex}" /> <input type="hidden"
				name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
				type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
				type="hidden" name="orderField" value="createTime" /> <input
				type="hidden" name="orderDirection" value="desc" />

			<div class="input-group input-group-sm" style="width: 150px;">
				<input type="text" name="text" class="form-control"
					placeholder="请输入用户名">

				<div class="input-group-btn">
					<button type="submit" class="btn btn-default">
						<i class="fa fa-search"></i>
					</button>
				</div>
			</div>
		</form>
	</div>
	<!-- /.box-header -->
	<div class="box-body table-responsive no-padding"
		style="width:auto; height:480; overflow: hidden; ">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th>ID</th>
					<th>用户名</th>
					<th>姓名</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>

				<c:forEach var="userinfo" items="${data.result }">
					<tr>
						<td>${userinfo.id }</td>
						<td>${userinfo.userName }</td>
						<td>${userinfo.empName }</td>
						<td><a href="javascript:del(${userinfo.id })" role="button">删除</a>
						</td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>
	<!-- /.box-body -->
	<div class="box-footer clearfix center">
		<span>每页显示<20>条</span>
		<ul class="pagination pagination-sm no-margin  pull-right">
			<li><a href="javascript:Previous();">上一页</a></li>

			<li><a href="javascript:Next();">下一页</a></li>
		</ul>
	</div>
</div>