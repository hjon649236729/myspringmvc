<%@include file="head.jsp"%>
<%
	request.setAttribute("contextPath", request.getContextPath());
%>
<%
	request.setAttribute("path", request.getContextPath());
%>
<link rel="stylesheet"
	href="${contextPath }/Scripts/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${contextPath }/Scripts/AdminLte/bower_components/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet"
	href="${contextPath }/Scripts/AdminLte/bower_components/Ionicons/css/ionicons.min.css">
<link rel="stylesheet"
	href="${contextPath }/Scripts/AdminLte/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="${contextPath }/Scripts/AdminLte/dist/css/skins/_all-skins.min.css">
<script src="${contextPath }/Scripts/jquery/jquery-3.2.1.min.js"></script>
<script src="${contextPath }/Scripts/jquery-ui/jquery-ui.min.js"></script>
<script src="${contextPath }/Scripts/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${contextPath }/Scripts/AdminLte/dist/js/adminlte.min.js"></script>