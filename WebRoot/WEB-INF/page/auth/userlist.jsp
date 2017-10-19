<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../include/indexinclude.jsp"%>
<script type="text/javascript">
	function Previous() {
		var pageNum = $("#pageNum").val();
		if (pageNum > 1) {
			$("#pageNum").val(pageNum * 1 - 1);
			$("#submit").click();
		}
	}
	function Next() {
		var pageNum = $("#pageNum").val();
		var pageCount = $("#pageCount");
		if (pageNum < pageCount) {
			$("#pageNum").val(eval(pageNum * 1 + 1));
			$("#submit").click();
		}
	}
	function del(id) {
		$.post("userdelete.action", {
			"id" : id,
		}, function(data) {
			if (data == "200") {
				$("#submit").click();
			}else{
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
	<a class="btn btn-default" href="useredit.action" role="button">添加</a>
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
				<td><a class="btn btn-default" href="javascript:del(${userinfo.id })"
					role="button">删除</a></td>
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