<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>
<script type="text/javascript">
	function modify() {
		$("#addCrontriggerModal").modal("show");
	}
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
					<li><a href="javascript:Previous();">上一页</a>
					</li>
					<li><a href="javascript:Next();">下一页</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

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