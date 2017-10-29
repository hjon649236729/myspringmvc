<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>我的项目管理系统</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<%@include file="../include/admininclude.jsp"%>
<link rel="shortcut icon " type="images/x-icon"
	href="${contextPath }/favicon.ico">
<script type="text/javascript">
	$(function() {
		menuInit();
	});
	//quartz/quartzlist.action" target="contentFrame"
	var menuJson = [ {
		"name" : "运营管理",
		"controller" : "#",
		"child" : [ {
			"name" : "用户管理",
			"controller" : "auth/userlist.action",
		}, {
			"name" : "定时任务",
			"controller" : "quartz/quartzlist.action",
		} , {
			"name" : "菜单管理",
			"controller" : "common/sysmenumain.action",
		} ]
	}];
	function menuInit() {
		/*
			 <li class="active treeview">
		      <a href="#">
		        <i class="fa fa-dashboard"></i> <span>Dashboard</span>
		        <span class="pull-right-container">
		          <i class="fa fa-angle-left pull-right"></i>
		        </span>
		      </a>
		      <ul class="treeview-menu">
		        <li class="active"><a href="index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>
		        <li><a href="index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
		      </ul>
		    </li>
		 */
		var menu = null;
		var html = null;
		var childLen = null;
		var child = null;
		for ( var i = 0; i < menuJson.length; i++) {
			menu = menuJson[i];
			if (i == 0) {
				html = " <li class='active treeview'>";
			} else {
				html = " <li class='treeview'>";
			}
			html = html
					+ "<a href='#'><i class='fa fa-dashboard'></i> <span>"
					+ menu.name
					+ "</span><span class='pull-right-container'><i class='fa fa-angle-left pull-right'></i></span></a>";
			html = html + " <ul class='treeview-menu'> ";

			childLen = menu.child.length;
			for ( var j = 0; j < childLen; j++) {
				child = menu.child[j];
				if (i == 0 && j == 0) {
					html = html
							+ "<li class='active'><a href='"+child.controller+"' target='contentFrame'><i class='fa fa-circle-o'></i>"
							+ child.name + "</a></li>";
				} else {
					html = html
							+ "<li><a href='"+child.controller+"' target='contentFrame'><i class='fa fa-circle-o'></i>"
							+ child.name + "</a></li>";
				}
			}
			html = html + "</ul>";
			console.log(html);
			$(".sidebar .sidebar-menu").append(html);
			
			//	$(" .sidebar-menu li:first a").click();
			
		}
		/* var menu = null;.
		var html = null;
		var chidLen = null;
		var child = null;
		for ( var i = 0; i < menuJson.length; i++) {
			menu = menuJson[i];
			if (i == 0) {
				html = $(' <li menu-id="' + i + '" class="active treeview "><li>');
			} else {
				html = $(' <li menu-id="' + i + '" class="treeview "><li>');
			}

			$(".sidebar .sidebar-menu").append(html);

			html = $(' <a href="'+menu.controller+'"> <i class="fa fa-dashboard"></i> <span>'
					+ menu.name
					+ '</span> <span class="pull-right-container"> <i class="fa fa-angle-left pull-right"></i> </span> </a> <ul menuUl-id="'+i+'" class="treeview-menu"> </ul>');
			$('[menu-id="' + i + '"]').append(html);

			chidLen = menu.child.length;
			for ( var j = 0; j < chidLen; j++) {
				child = menu.child[j];
				if (i == 0 && j == 0) {
					html = $('<li class="active"><a href="javascript:void(0);" menu-controller="'
							+ child.controller
							+ '"><i class="fa fa-circle-o"></i> '
							+ child.name
							+ '</a></li>');
				} else {
					html = $('<li class=""><a href="javascript:void(0);" menu-controller="'
							+ child.controller
							+ '"><i class="fa fa-circle-o"></i> '
							+ child.name
							+ '</a></li>');
				}

				$('[menuUl-id="' + i + '"]').append(html);
			}
		}
		$(".sidebar-menu li:first ul li:first a").click(); */
	}
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header"> <!-- Logo --> <a
			href="index.action" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
			<span class="logo-mini"><b>A</b>LT</span> <!-- logo for regular state and mobile devices -->
			<span class="logo-lg"><b>Admin</b>LTE</span> </a> <!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top"> <!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu"
			role="button"> <span class="sr-only">Toggle navigation</span> </a>

		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<li class="dropdown messages-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <i
						class="fa fa-envelope-o"></i> <span class="label label-success">4</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 4 messages</li>
						<li>
							<!-- inner menu: contains the actual data -->
							<ul class="menu">
								<li>
									<!-- start message --> <a href="#">
										<div class="pull-left">
											<img src="Scripts/AdminLte/dist/img/user2-160x160.jpg"
												class="img-circle" alt="User Image">
										</div>
										<h4>
											Support Team <small><i class="fa fa-clock-o"></i> 5
												mins</small>
										</h4>
										<p>Why not buy a new awesome theme?</p> </a>
								</li>
								<!-- end message -->
								<li><a href="#">
										<div class="pull-left">
											<img src="Scripts/AdminLte/dist/img/user3-128x128.jpg"
												class="img-circle" alt="User Image">
										</div>
										<h4>
											AdminLTE Design Team <small><i class="fa fa-clock-o"></i>
												2 hours</small>
										</h4>
										<p>Why not buy a new awesome theme?</p> </a>
								</li>
								<li><a href="#">
										<div class="pull-left">
											<img src="Scripts/AdminLte/dist/img/user4-128x128.jpg"
												class="img-circle" alt="User Image">
										</div>
										<h4>
											Developers <small><i class="fa fa-clock-o"></i> Today</small>
										</h4>
										<p>Why not buy a new awesome theme?</p> </a>
								</li>
								<li><a href="#">
										<div class="pull-left">
											<img src="Scripts/AdminLte/dist/img/user3-128x128.jpg"
												class="img-circle" alt="User Image">
										</div>
										<h4>
											Sales Department <small><i class="fa fa-clock-o"></i>
												Yesterday</small>
										</h4>
										<p>Why not buy a new awesome theme?</p> </a>
								</li>
								<li><a href="#">
										<div class="pull-left">
											<img src="Scripts/AdminLte/dist/img/user4-128x128.jpg"
												class="img-circle" alt="User Image">
										</div>
										<h4>
											Reviewers <small><i class="fa fa-clock-o"></i> 2 days</small>
										</h4>
										<p>Why not buy a new awesome theme?</p> </a>
								</li>
							</ul>
						</li>
						<li class="footer"><a href="#">See All Messages</a></li>
					</ul>
				</li>
				<!-- Notifications: style can be found in dropdown.less -->
				<li class="dropdown notifications-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <i
						class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 10 notifications</li>
						<li>
							<!-- inner menu: contains the actual data -->
							<ul class="menu">
								<li><a href="#"> <i class="fa fa-users text-aqua"></i>
										5 new members joined today </a>
								</li>
								<li><a href="#"> <i class="fa fa-warning text-yellow"></i>
										Very long description here that may not fit into the page and
										may cause design problems </a>
								</li>
								<li><a href="#"> <i class="fa fa-users text-red"></i> 5
										new members joined </a>
								</li>
								<li><a href="#"> <i
										class="fa fa-shopping-cart text-green"></i> 25 sales made </a>
								</li>
								<li><a href="#"> <i class="fa fa-user text-red"></i>
										You changed your username </a>
								</li>
							</ul>
						</li>
						<li class="footer"><a href="#">View all</a></li>
					</ul>
				</li>
				<!-- Tasks: style can be found in dropdown.less -->
				<li class="dropdown tasks-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <i
						class="fa fa-flag-o"></i> <span class="label label-danger">9</span>
				</a>
					<ul class="dropdown-menu">
						<li class="header">You have 9 tasks</li>
						<li>
							<!-- inner menu: contains the actual data -->
							<ul class="menu">
								<li>
									<!-- Task item --> <a href="#">
										<h3>
											Design some buttons <small class="pull-right">20%</small>
										</h3>
										<div class="progress xs">
											<div class="progress-bar progress-bar-aqua"
												style="width: 20%" role="progressbar" aria-valuenow="20"
												aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">20% Complete</span>
											</div>
										</div> </a>
								</li>
								<!-- end task item -->
								<li>
									<!-- Task item --> <a href="#">
										<h3>
											Create a nice theme <small class="pull-right">40%</small>
										</h3>
										<div class="progress xs">
											<div class="progress-bar progress-bar-green"
												style="width: 40%" role="progressbar" aria-valuenow="20"
												aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">40% Complete</span>
											</div>
										</div> </a>
								</li>
								<!-- end task item -->
								<li>
									<!-- Task item --> <a href="#">
										<h3>
											Some task I need to do <small class="pull-right">60%</small>
										</h3>
										<div class="progress xs">
											<div class="progress-bar progress-bar-red" style="width: 60%"
												role="progressbar" aria-valuenow="20" aria-valuemin="0"
												aria-valuemax="100">
												<span class="sr-only">60% Complete</span>
											</div>
										</div> </a>
								</li>
								<!-- end task item -->
								<li>
									<!-- Task item --> <a href="#">
										<h3>
											Make beautiful transitions <small class="pull-right">80%</small>
										</h3>
										<div class="progress xs">
											<div class="progress-bar progress-bar-yellow"
												style="width: 80%" role="progressbar" aria-valuenow="20"
												aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">80% Complete</span>
											</div>
										</div> </a>
								</li>
								<!-- end task item -->
							</ul>
						</li>
						<li class="footer"><a href="#">View all tasks</a>
						</li>
					</ul>
				</li>
				<!-- User Account: style can be found in dropdown.less -->
				<li class="dropdown user user-menu"><a href="#"
					class="dropdown-toggle" data-toggle="dropdown"> <img
						src="Scripts/AdminLte/dist/img/user2-160x160.jpg"
						class="user-image" alt="User Image"> <span class="hidden-xs">Alexander
							Pierce</span> </a>
					<ul class="dropdown-menu">
						<!-- User image -->
						<li class="user-header"><img
							src="Scripts/AdminLte/dist/img/user2-160x160.jpg"
							class="img-circle" alt="User Image">

							<p>
								Alexander Pierce - Web Developer <small>Member since
									Nov. 2012</small>
							</p>
						</li>
						<!-- Menu Body -->
						<li class="user-body">
							<div class="row">
								<div class="col-xs-4 text-center">
									<a href="#">Followers</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Sales</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Friends</a>
								</div>
							</div> <!-- /.row -->
						</li>
						<!-- Menu Footer-->
						<li class="user-footer">
							<div class="pull-left">
								<a href="#" class="btn btn-default btn-flat">Profile</a>
							</div>
							<div class="pull-right">
								<a href="#" class="btn btn-default btn-flat">Sign out</a>
							</div>
						</li>
					</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<li><a href="#" data-toggle="control-sidebar"><i
						class="fa fa-gears"></i> </a>
				</li>
			</ul>
		</div>
		</nav> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar"> <!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="Scripts/AdminLte/dist/img/user2-160x160.jpg"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Alexander Pierce</p>
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>
		<!-- search form -->
		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control" placeholder="查询">
				<span class="input-group-btn">
					<button type="submit" name="search" id="search-btn"
						class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button> </span>
			</div>
		</form>
		<!-- /.search form --> <!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">
			<!-- <li class="active treeview"><a href="#"> <i
					class="fa fa-dashboard"></i> <span>用户管理</span> <span
					class="pull-right-container"> <i
						class="fa fa-angle-left pull-right"></i> </span> </a>
				<ul class="treeview-menu">
					<li class="active"><a href="auth/userlist.action"
						target="contentFrame"><i class="fa fa-circle-o"></i>用户信息</a>
					</li>
					<li><a href="quartz/quartzlist.action" target="contentFrame"><i
							class="fa fa-circle-o"></i>定时任务管理</a>
					</li>
					<li><a href="quartz/jobexecuteloglist.action"
						target="contentFrame"><i class="fa fa-circle-o"></i>定时任务运行日志管理</a>
					</li>
				</ul></li> -->
		</ul>
		</section> <!-- /.sidebar --> </aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header"> <iframe id="contentFrame"
				frameborder="0" name="contentFrame" src="" scrolling="no"
				height="545px" width="100%"></iframe> </section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
		<footer class="main-footer">
		<div class="pull-right hidden-xs">
			<b>Version</b> 2.4.0
		</div>
		<strong>Copyright &copy; 2014-2016 <a
			href="https://adminlte.io">Almsaeed Studio</a>.</strong> All rights reserved.
		</footer>
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
</html>
