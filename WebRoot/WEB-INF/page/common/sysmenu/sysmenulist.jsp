<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../include/tableinclude.jsp"%>

<!-- Main content -->
<div class="box">
	<div class="box-body table-responsive no-padding "
		style="width:auto; height:550px; overflow: hidden; ">
		<section class="content">
			<div class="row">
				<div class="col-md-3">
					<iframe id="treeLeftFrame" frameborder="1" name="treeLeftFrame"
						src="sysmenutree.action" height="500px" width="100%"></iframe>
				</div>
				<div class="col-md-9">
					<iframe id="treeRightFrame" frameborder="1" name="treeRightFrame"
						src="" height="500px" width="100%"></iframe>

				</div>
			</div>
		</section>
	</div>
</div>