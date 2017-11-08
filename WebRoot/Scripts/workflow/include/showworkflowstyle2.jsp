<%@ page import="com.sinitek.sirm.web.workflow.include.ShowWorkflowStyleAction" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.StepQuery" %>
<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.WorkflowStep" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-11-5
  Time: 上午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%--<link type="text/css" href="../../framework/css/default/stk.css" rel="stylesheet" />--%>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        $(function () {
            if (window.PIE) {
                $('.productTypeManager .content li dl').each(function () {
                    PIE.attach(this);
                });
            }
        });
    </script>
</head>
<%
    int exampleId = 0;
    String[] exampleArr = request.getParameterValues("exampleid");
    for(int i = 0; i < exampleArr.length; i++) {
        exampleId = NumberTool.safeToInteger(exampleArr[i], 0);
        if(exampleId != 0) {
            break;
        }
    }
    StepQuery stepQuery = new StepQuery();
    stepQuery.setExampleId(exampleId);
    List<WorkflowStep> stepList = ShowWorkflowStyleAction.getWorkflowStepList2(stepQuery);
    request.setAttribute("stepList", stepList);
%>
<sirm:body>
    <table class="w100p mauto" style="border: 1px #666 solid;">
        <c:forEach items="${stepList}" var="workflowStep" varStatus="status">
            <c:choose>
                <c:when test="${status.index % 2 == 0}"><tr class="stk-table-tr-even" style="border: 1px #333 solid;"></c:when>
                <c:otherwise><tr></c:otherwise>
            </c:choose>
            <td width="20px;">&nbsp;</td>
            <c:choose>
                <c:when test="${status.first}">

                    <td class="process-step step-start"></td>
                </c:when>
                <c:when test="${status.last}">
                    <td class="process-step step-end-check"></td>
                </c:when>
                <c:otherwise>
                    <td class="process-step step-check"></td>
                </c:otherwise>
            </c:choose>
            <td style="border-right: 1px #666 solid;" width="100px">
                <%--&nbsp;<br>--%>
                ${workflowStep.name}<br>${workflowStep.result}
            </td>
            <td class="pt5 pb5" >
                <table width="100%">
                    <c:forEach items="${workflowStep.ownerList}" var="workflowOwner" varStatus="status2">
                        <tr><td>&nbsp;</td></tr>
                        <tr><td style="padding-left: 7px;">${workflowOwner.title}</td></tr>
                        <tr><td style="padding-left: 7px;padding-top: 3px;">${workflowOwner.tail}</td></tr>
                        <tr><td>&nbsp;</td></tr>
                        <c:if test="${!status2.last}">
                            <tr><td><hr style="border:0px;border-bottom: 1px #333 dotted ;" /></td></tr>
                        </c:if>
                    </c:forEach>
                </table>
            </td>
            </tr>
        </c:forEach>
    </table>
</sirm:body>
</html>