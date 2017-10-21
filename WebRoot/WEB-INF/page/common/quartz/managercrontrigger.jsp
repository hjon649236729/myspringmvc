<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../../include/indexinclude.jsp"%>
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

<form class="navbar-form navbar-left" id="pagerForm" method="post"
	action="userlist.action">
	<input type="hidden" name="pageNum" id="pageNum"
		value="${data.currentPageIndex}" /> <input type="hidden"
		name="pageCount" id="pageCount" value="${data.totalPageCount}" /> <input
		type="hidden" name="numPerPage" value="${data.pageSize}" /> <input
		type="hidden" name="orderField" value="createTime" /> <input
		type="hidden" name="orderDirection" value="desc" />

	<div class="form-group">
		<input type="text" class="form-control" name="userName"
			value="${userName }" placeholder="用户名">
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
			<th>ID</th>
			<th>用户名</th>
			<th>姓名</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="userinfo" items="${data.result }">
			<tr>
				<td>${userinfo.id }</td>
				<td>${userinfo.userName }</td>
				<td>${userinfo.empName }</td>
				<td>${userinfo.empName }</td>
				<td><a class="btn btn-default"
					href="javascript:del(${userinfo.id })" role="button">删除</a></td>
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
				<form class="form-horizontal required-validate" method="post"
					action="usersave.action" id="userform" action="usersave.action">
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
							<textarea class="form-control" rows="3" id="memo"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>