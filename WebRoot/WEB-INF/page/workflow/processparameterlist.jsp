<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@include file="../include/listinclude.jsp"%>
<%@ taglib uri="/basedata" prefix="basedata"%>
<script type="text/javascript">
	
</script>
<div>
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li role="presentation" class="active"><a href="#processType"
			aria-controls="processType" role="tab" data-toggle="tab">流程类型</a></li>
		<li role="presentation"><a href="#processUrl"
			aria-controls="processUrl" role="tab" data-toggle="tab">处理页面配置</a></li>
		<li role="presentation"><a href="#linkIfType"
			aria-controls="linkIfType" role="tab" data-toggle="tab">linkIfType</a>
		</li>
		<li role="presentation"><a href="#spaceialTask"
			aria-controls="spaceialTask" role="tab" data-toggle="tab">spaceialTask</a>
		</li>
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">
		<div role="tabpanel" class="tab-pane active" id="processType">
			<div class="box">
				<div class="box-header">
					<form id="pageForm" method="post" action="processlist.action">
						<input type="hidden" name="pageNum" id="pageNum"
							value="${data.currentPageIndex}" /> <input type="hidden"
							name="pageCount" id="pageCount" value="${data.totalPageCount}" />
						<input type="hidden" name="numPerPage" value="${data.pageSize}" />
						<input type="hidden" name="orderField" value="createtimestamp" />
						<input type="hidden" name="orderDirection" value="desc" />

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
					style="width:auto; height:425px; overflow: hidden; ">
					<table class="table table-striped table-hover">
						<thead>
							<tr>

								<th>任务名称</th>
								<th>流程code</th>
								<th>版本号</th>
								<th>流程状态</th>
								<th>流程类型</th>
								<th>流程备注</th>
								<th>操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="process" items="${data.result }">
								<tr>
									<td>${process.name}</td>
									<td>${process.processcode }</td>
									<td>${process.sysversion }</td>
									<td>${process.statusname }</td>
									<td>${process.processtypename }</td>
									<td>${process.processbrief }</td>
									<td><a href="drawprocess.action?processid=${process.id}">绘制流程</a>
									</td>
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
		<div role="tabpanel" class="tab-pane" id="processUrl">
			<div class="box">
				<div class="box-header">
					<form id="pageForm" method="post" action="processlist.action">
						<input type="hidden" name="pageNum" id="pageNum"
							value="${data.currentPageIndex}" /> <input type="hidden"
							name="pageCount" id="pageCount" value="${data.totalPageCount}" />
						<input type="hidden" name="numPerPage" value="${data.pageSize}" />
						<input type="hidden" name="orderField" value="createtimestamp" />
						<input type="hidden" name="orderDirection" value="desc" />

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
					style="width:auto; height:425px; overflow: hidden; ">
					<table class="table table-striped table-hover">
						<thead>
							<tr>

								<th>任务名称</th>
								<th>流程code</th>
								<th>版本号</th>
								<th>流程状态</th>
								<th>流程类型</th>
								<th>流程备注</th>
								<th>操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="process" items="${data.result }">
								<tr>
									<td>${process.name}</td>
									<td>${process.processcode }</td>
									<td>${process.sysversion }</td>
									<td>${process.statusname }</td>
									<td>${process.processtypename }</td>
									<td>${process.processbrief }</td>
									<td><a href="drawprocess.action?processid=${process.id}">绘制流程</a>
									</td>
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
		<div role="tabpanel" class="tab-pane" id="linkIfType">
			<div class="box">
				<div class="box-header">
					<form id="pageForm" method="post" action="processlist.action">
						<input type="hidden" name="pageNum" id="pageNum"
							value="${data.currentPageIndex}" /> <input type="hidden"
							name="pageCount" id="pageCount" value="${data.totalPageCount}" />
						<input type="hidden" name="numPerPage" value="${data.pageSize}" />
						<input type="hidden" name="orderField" value="createtimestamp" />
						<input type="hidden" name="orderDirection" value="desc" />

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
					style="width:auto; height:425px; overflow: hidden; ">
					<table class="table table-striped table-hover">
						<thead>
							<tr>

								<th>任务名称</th>
								<th>流程code</th>
								<th>版本号</th>
								<th>流程状态</th>
								<th>流程类型</th>
								<th>流程备注</th>
								<th>操作</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="process" items="${data.result }">
								<tr>
									<td>${process.name}</td>
									<td>${process.processcode }</td>
									<td>${process.sysversion }</td>
									<td>${process.statusname }</td>
									<td>${process.processtypename }</td>
									<td>${process.processbrief }</td>
									<td><a href="drawprocess.action?processid=${process.id}">绘制流程</a>
									</td>
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
		<div role="tabpanel" class="tab-pane" id="spaceialTask">spaceialTask</div>
	</div>

</div>