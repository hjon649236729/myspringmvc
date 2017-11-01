<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<script type="text/javascript">
	function modify() {
		$("#sysMenuModal").modal("show");
	}
	$(function() {
		$("form.required-validate").each(function() {
			var $form = $(this);
			$form.bootstrapValidator().on('success.form.bv', function(e) {
				//console.log("test");
				// 阻止默认事件提交
				e.preventDefault();
				$.ajax({
					cache : true,
					type : "POST",
					url : "sysmenusave.action",
					data : $('#sysmenuform').serialize(),// 你的formid
					async : false,
					error : function(request) {
						alert("Connection error");
					},
					success : function(data) {
						//$("#commonLayout_appcreshi").parent().html(data);
						alert(data);
						//window.location.href = "userlist.action";
						//$("#submit").click()
						
						$("#sysMenuModal").modal("hidden");
					}
				});

			});
		});
	});
</script>
<div class="box box-success">
	<div class="box-header with-border">
		<h3 class="box-title">当前菜单信息</h3>

		<div class="box-body">
			<table class="table table-bordered">
				<tr>
					<td>菜单名称</td>
					<td>${currentSysMenu.name}</td>
				</tr>
				<tr>
					<td>URL</td>
					<td>${currentSysMenu.url}</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<div class="box box-success">
	<div class="box-header with-border">
		<h3 class="box-title">下级子菜单</h3>
		<div class="box-body">
			<div class="box-body table-responsive no-padding "
				style="width:auto; height:300px; overflow: hidden; ">
				<button onclick="javascript:modify()">添加</button>
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>菜单</th>
							<th>url</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="child" items="${data.result }">
							<tr>
								<td>${child.name }</td>
								<td>${child.url }</td>
								<%-- <td><a href="javascript:del('${user.id}')">暂停</a></td> --%>

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
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="sysMenuModal" tabindex="-1" role="dialog"
	aria-labelledby="sysMenuModalLable">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="sysMenuModalLable">添加菜单</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal required-validate" id="quartzform"
					method="post" action="sysmenusave.action">
					<input type="hidden" id="id" name="id"> <input
						type="hidden" id="parentid" name="parentid"
						value="${currentSysMenu.id}">
					<div class="form-group">
						<label for="planName" class="col-sm-3 control-label">菜单名称</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="name" name="name"
								placeholder="请输入菜单名称" data-bv-notempty
								data-bv-notempty-message="菜单名称不能为空">
						</div>
					</div>
					<div class="form-group">
						<label for="time" class="col-sm-3 control-label">URL</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="url" name="url"
								placeholder="请输入URL">
						</div>
					</div>
					<div class="form-group">
						<label for="jobClass" class="col-sm-3 control-label">序号</label>
						<div class="col-sm-6">
							<input type="text" class="form-control" id="order" name="order"
								placeholder="请输入序号">
						</div>
					</div>
					<div class="form-group">
						<label for="time" class="col-sm-3 control-label">说明</label>
						<div class="col-sm-6">
							<textarea class="form-control" rows="3" id="descirption"
								name="descirption"></textarea>
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