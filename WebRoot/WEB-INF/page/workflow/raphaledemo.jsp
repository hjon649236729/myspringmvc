<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@include file="../include/head.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'raphaledemo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/lib/raphael-min.js"></script>
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/lib/jquery-ui-1.8.4.custom/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/lib/jquery-ui-1.8.4.custom/js/jquery-ui-1.8.4.custom.min.js"></script>
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/myflow.js"></script>
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/myflow.jpdl4.js"></script>
<script type="text/javascript"
	src="${contextPath}/Scripts/workflow/myflow.editors.js"></script>

<script type="text/javascript">
	
</script>
<body>
	<div id="myflow"></div>
</body>
</html>
