<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.ShowAllWorkflowAction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-5-31
  Time: 下午2:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%
    List<Map> _steplist = ShowAllWorkflowAction.showcolorworkflow(NumberTool.safeToInteger(request.getParameter("exampleid"),0));
    pageContext.setAttribute("steplist", _steplist);
%>
<script type="text/javascript">
    function showworkflowhistory(){
        $("#workflowsteptable").stk_show();
        $("#hideworkflowstep").stk_show();
        $("#showworkflowstep").stk_hide();
    }
    function hideworkflowhistory(){
        $("#workflowsteptable").stk_hide();
        $("#hideworkflowstep").stk_hide();
        $("#showworkflowstep").stk_show();
    }
</script>
<ui:a href="javascript:showworkflowhistory();" id="showworkflowstep" name="showworkflowstep">查看流程</ui:a>
<ui:a href="javascript:hideworkflowhistory();" hidden="true" id="hideworkflowstep" name="hideworkflowstep">隐藏流程</ui:a>
<table id="workflowsteptable" class="stk-table" width="100%" style="min-height: 30px;display: none; table-layout: fixed;">
    <tr>
        <th class="stk-table-th" width="8%">步骤名称</th>
        <th class="stk-table-th" width="6%">步骤类型</th>
        <th class="stk-table-th" width="10%">步骤描述</th>
        <th class="stk-table-th" width="6%">步骤状态</th>
        <th class="stk-table-th" width="14%">开始时间</th>
        <th class="stk-table-th" width="6%">步骤结果</th>
        <th class="stk-table-th" width="10%">处理人</th>
        <th class="stk-table-th" width="6%">处理结果</th>
        <th class="stk-table-th" width="14%">处理时间</th>
        <th class="stk-table-th" width="20%">处理意见</th>
    </tr>
    <c:forEach items="${steplist}" var="stepmain">
        <%--<tr bgcolor="${stepmain.stepstatus == 2 ? '#FF0000' : '#0000FF'}" style="color:#00FF00">--%>
        <tr bgcolor="${stepmain.bgcolor}" style="color:#111111">
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['processstepname']}</td>
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['steptypevalue']}</td>
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['stepbrief']}</td>
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['stepstatusvalue']}</td>
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['starttime']}</td>
            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['stepconditonvalue']}</td>
            <c:choose>
                <c:when test="${empty stepmain['ownerlist']}">
                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                </c:when>
                <c:otherwise>
                    <td style="padding:0px;" colspan="4">
                        <table width="100%">
                            <c:forEach items="${stepmain['ownerlist']}" var="ownermap">
                                <tr style="color:${ownermap.color}">
                                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="20%">
                                        <div style='padding-left:7px;padding-top:5px;'>${ownermap['ownername']}</div>
                                    </td>
                                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                        <div style='padding-left:7px;padding-top:5px;'>${ownermap['ownerstatusvalue']}</div>
                                    </td>
                                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="28%">
                                        <div style='padding-left:7px;padding-top:5px;'>${ownermap['approvetime']}</div>
                                    </td>
                                    <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="40%">
                                        <div style='padding-left:7px;padding-top:5px;'>${ownermap['approveopinion']}</div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </td>
                </c:otherwise>
            </c:choose>
        </tr>
    </c:forEach>
</table>
    <%--<tr>--%>
        <%--<td colspan="10">--%>
            <%--<div style="bgcolor:#229800">未处理</div>--%>
            <%--<div style="bgcolor:#2CA0EA">自动完成</div>--%>
            <%--<div style="bgcolor:#00477A">已处理</div>--%>
            <%--<div style="bgcolor:#F0F080">非正常结束</div>--%>
        <%--</td>--%>
    <%--</tr>--%>