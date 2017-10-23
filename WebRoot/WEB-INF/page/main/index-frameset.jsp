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

<title>My JSP 'index.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%-- 
<%@include file="../include/indexinclude.jsp"%> --%>
<%-- 
<link rel="icon" href="${contextPath}/favicon.ico"> --%>
<%-- <%@include file="../include/admininclude.jsp"%> --%>
</head>
<frameset cols="20%,80%">
	<frame src="left.action" id="menu" name="menu" />
	<frame src="" id="content" name="content" />
</frameset>
<noframes>
	<body>浏览器不支持框架，请更新浏览器，或换其它浏览器再打开
	</body>
</noframes>
</html>
