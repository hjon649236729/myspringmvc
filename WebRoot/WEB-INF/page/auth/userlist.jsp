<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../include/tableinclude.jsp"%>
<%@ taglib uri="/basedata" prefix="basedata"%>
<script type="text/javascript">
	function del(id) {
		$.post("userdelete.action", {
			"id" : id,
		}, function(data) {
			if (data == "200") {
				$("#submit").click();
			} else {
				alert("参数错误");
			}
		});
	}
</script>
<div class="box">
	<div class="box-header">
		<form id="pageForm" method="post" action="userlist.action">
			<input type="hidden" name="pageNum" id="pageNum"
				value="${data.currentPageIndex}" /> <input type="hidden"
				name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
				type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
				type="hidden" name="orderField" value="createTime" /> <input
				type="hidden" name="orderDirection" value="desc" />

			<div class="input-group input-group-sm" style="width: 150px;">
				<input type="text" name="userName" class="form-control"
					value="${userName }" placeholder="请输入用户名称">

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
		style="width:auto; height:425px; overflow: hidden; ">
		<table class="table table-striped table-hover">
			<thead>
				<tr>

					<th>用户名</th>
					<th>姓名</th>
					<th>操作</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="user" items="${data.result }">
					<tr>
						<td>
						<a href="javascript:showExecuteLog('${user.userName }')">${user.userName }</a>
						</td>
						<td>${user.empName }</td>
						<td><a href="javascript:del('${user.id}')">暂停</a></td>

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