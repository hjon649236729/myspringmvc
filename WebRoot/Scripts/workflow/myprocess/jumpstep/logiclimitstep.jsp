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
             method="limit">
        <input type="hidden" id="exampleid" name="exampleid" value="${exampleid}">
        <input type="hidden" id="examplestepid" name="examplestepid" value="${examplestepid}">
        <input type="hidden" id="exampleownerid" name="exampleownerid" value="${exampleownerid}">
        <input type="hidden" id="condition" name="condition">
        <div align="center" style="padding-top:5px;">
            通过步骤选择：
            <sirmwf:logicsteplist var="steplist1" type="3" mode="3" exampleownerid="${exampleownerid}"/>
            <ui:select name="processstepid1" id="processstepid1" list="#attr.steplist1"
                       headerKey="0" headerValue="不指定步骤"></ui:select>
            <ui:button text="通过任务">
                <event:onclick>
                    $("#condition").stk_val(1);
                    $("#processform").stk_submit("limit", function(result) {
                    if (result != null) {
                    stk.alert(result);
                    return;
                    }
                    return;
                    })
                </event:onclick>
            </ui:button>
        </div>
        <div align="center" style="padding-top:5px;">
            驳回步骤选择：
            <sirmwf:logicsteplist var="steplist2" type="3" mode="4" even="1" exampleownerid="${exampleownerid}"/>
            <ui:select name="processstepid2" id="processstepid2" list="#attr.steplist2"
                       headerKey="0" headerValue="不指定步骤"></ui:select>
            <ui:button text="驳回任务">
                <event:onclick>
                    $("#condition").stk_val(2);
                    $("#processform").stk_submit("limit", function(result) {
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