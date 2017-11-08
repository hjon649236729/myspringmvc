<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 13-12-19
  Time: 上午11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@ taglib prefix="sirmwf" uri="http://www.sinitek.com/sirm/workflow/tag" %>
<html>
<head>
    <title></title>
</head>
<%
    int exampleid = NumberTool.safeToInteger(request.getParameter("exampleid"), 0);
    pageContext.setAttribute("exampleid", exampleid);
    int examplestepid = NumberTool.safeToInteger(request.getParameter("examplestepid"), 0);
    pageContext.setAttribute("examplestepid", examplestepid);
    int exampleownerid = NumberTool.safeToInteger(request.getParameter("exampleownerid"), 0);
    pageContext.setAttribute("exampleownerid", exampleownerid);
%>
<sirm:body>
    <ui:form id="processform" clazz="com.sinitek.sirm.web.workflow.myprocess.jumpstep.LogicStepAction"
             method="sub">
        <input type="hidden" id="exampleid" name="exampleid" value="${exampleid}">
        <input type="hidden" id="examplestepid" name="examplestepid" value="${examplestepid}">
        <input type="hidden" id="exampleownerid" name="exampleownerid" value="${exampleownerid}">
        <div align="center" style="padding-top:5px;">
            提交步骤选择：
            <sirmwf:physicalsteplist var="steplist" type="3" mode="0" self="1" exampleownerid="${exampleownerid}"/>
            <ui:select name="processstepid" id="processstepid" list="#attr.steplist"
                       headerKey="0" headerValue="不指定步骤"></ui:select>
        </div>
        <div align="center" style="padding-top:5px;">
            <ui:button text="提交任务">
                <event:onclick>
                    $("#processform").stk_submit("sub", function(result) {
                    if (result != null) {
                    stk.alert(result);
                    return;
                    }
                    return;
                    })
                </event:onclick>
            </ui:button>
        </div>
    </ui:form>
    <div style="padding-top:15px;">
        <jsp:include page="/workflow/include/showworkflowhistory.jsp" flush="true">
            <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
        </jsp:include>
    </div>
</sirm:body>
</html>