<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../include/editinclude.jsp"%>
<script type="text/javascript">
	$(function() {
		$('[data-toggle="tooltip"]').tooltip();
		$("form.required-validate").each(function() {
			var $form = $(this);
			$form.bootstrapValidator().on('success.form.bv', function(e) {
				//console.log("test");
				// 阻止默认事件提交

				$.ajax({
					cache : true,
					type : "POST",
					url : "usersave.action",
					data : $('#userform').serialize(),// 你的formid
					async : false,
					error : function(request) {
						alert("Connection error");
					},
					success : function(data) {
						//$("#commonLayout_appcreshi").parent().html(data);
						alert(data);
						window.location.href = "userlist.action";
					}
				});
				e.preventDefault();
			});
		});
	});
</script>

<div class="col-md-6">
	<!-- Horizontal Form -->
	<div class="box box-info">
		<div class="box-header with-border">
			<h3 class="box-title">用户管理</h3>
		</div>
		<form class="form-horizontal required-validate" id="userform"
			method="post" action="usersave.action">
			<div class="form-group">
				<label for="userName" class="col-sm-2 control-label">用户名</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="userName"
						name="userName" placeholder="请输入用户名" data-bv-notempty
						data-bv-notempty-message="用户名不能为空" data-toggle="tooltip"
						data-placement="top" title="用户名不能为空">
				</div>
			</div>
			<div class="form-group">
				<label for="empName" class="col-sm-2 control-label">姓名</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="empName" name="empName"
						placeholder="请输入姓名" data-bv-notempty
						data-bv-notempty-message="姓名不能为空" data-toggle="tooltip"
						data-placement="top" title="姓名不能为空">
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">保存</button>
				</div>
			</div>
		</form>
	</div>
	<!-- /.box-body -->
</div>
<!-- /.box -->