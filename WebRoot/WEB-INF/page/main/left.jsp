<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<%@include file="../include/admininclude.jsp"%>
<!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
  <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">菜单</li>
                <li class="active treeview">
                    <a href="#">
                        <i class="fa fa-dashboard"></i> <span>用户管理</span>
                        <span class="pull-right-container">
                            <i class="fa fa-angle-left pull-right"></i>
                        </span>
                    </a>
                    <ul class="treeview-menu">
                        <li class="active"><a href="javascript:void(0);" menu-controller="user/home.do"><i class="fa fa-circle-o"></i> 用户浏览</a></li>
                        <li><a href="javascript:void(0);"  menu-controller="user/add.do"><i class="fa fa-circle-o"></i> 添加用户</a></li>
                    </ul>
                </li>
                <li class="treeview">
                    <a href="#">
                        <i class="fa fa-files-o"></i>
                        <span>文章管理</span>
                        <span class="pull-right-container">
                          <span class="label label-primary pull-right">4</span>
                        </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a  href="javascript:void(0);" menu-controller="post/home.do"><i class="fa fa-circle-o"></i>文章概览</a></li>
                        <li><a  href="javascript:void(0);" menu-controller="post/add.do"><i class="fa fa-circle-o"></i> 添加文章</a></li>
                    </ul>
                </li>
            </ul>
        </section>
    </aside>