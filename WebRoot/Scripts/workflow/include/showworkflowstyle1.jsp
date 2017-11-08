<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.ShowAllWorkflowAction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.sinitek.sirm.common.utils.StringUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-11-5
  Time: 上午10:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%
    Map map = new HashMap();
    map.put("showtype", NumberTool.safeToInteger(request.getParameter("showtype"), 0));
    int workflowmark = 0;
    int workflowbool = 1;
    int _exampleid = 0;
    String[] exampleArr = request.getParameterValues("exampleid");
    for(int i = 0; i < exampleArr.length; i++) {
        _exampleid = NumberTool.safeToInteger(exampleArr[i], 0);
        if(_exampleid != 0) {
            break;
        }
    }
    int _spshow = NumberTool.safeToInteger(request.getParameter("spshow"), 0);
    map.put("spshow", _spshow);
    if (_exampleid != 0) {
        map.put("exampleid", _exampleid);
        List<Map> _steplist = ShowAllWorkflowAction.showcolorworkflow(map);
        pageContext.setAttribute("steplist", _steplist);
        if (_steplist.size() == 0) {
            workflowbool = 0;
        }
    } else {
        map.put("sourcename", StringUtil.safeToString(request.getParameter("sourcename"), ""));
        map.put("sourceid", NumberTool.safeToInteger(request.getParameter("sourceid"), 0));
        List<List<Map>> _examplelist = ShowAllWorkflowAction.showcolorworkflows(map);
        pageContext.setAttribute("examplelist", _examplelist);
        workflowmark = 1;
        if (_examplelist.size() == 0) {
            workflowbool = 0;
        }
    }
    pageContext.setAttribute("workflowmark", workflowmark);
    pageContext.setAttribute("workflowbool", workflowbool);
    Map workflowmap = new HashMap();
    workflowmap.put("processstepname", "100px");
    workflowmap.put("stepbrief", "120px");
    workflowmap.put("stepstatusvalue", "60px");
    workflowmap.put("starttime", "110px");
    workflowmap.put("ownername", "80px");
    workflowmap.put("ownerstatusvalue", "80px");
    workflowmap.put("approvetime", "110px");
    pageContext.setAttribute("workflowmap", workflowmap);
%>
<table>  <%-- 外面套一层table， 尝试解决错位问题 --%>
    <tr>
        <td>

            <c:if test="${workflowbool=='1'}">
                <c:if test="${workflowmark=='0'}">    <%-- url的参数是 exampleid --%>
                    <table id="workflowsteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                        <tr>
                            <th class="stk-table-th" width="${workflowmap['processstepname']}">步骤名称</th>
                                <%--<th class="stk-table-th" width="${workflowmap['stepbrief']}">步骤描述</th>--%>
                            <th class="stk-table-th" width="${workflowmap['stepstatusvalue']}">步骤结果</th>
                            <th class="stk-table-th" width="${workflowmap['starttime']}">开始时间</th>
                            <th class="stk-table-th" width="${workflowmap['ownername']}">处理人</th>
                            <th class="stk-table-th" width="${workflowmap['ownerstatusvalue']}">处理结果</th>
                            <th class="stk-table-th" width="${workflowmap['approvetime']}">处理时间</th>
                            <th class="stk-table-th" width="100%">处理意见</th>
                        </tr>
                        <c:forEach items="${steplist}" var="stepmain">
                            <c:choose>
                                <c:when test="${empty stepmain['ownerlist']}">
                                    <tr bgcolor="${stepmain.bgcolor}" style="color:#EEEEEE">
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['processstepname']}">${stepmain['processstepname']}</td>
                                            <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;word-break : break-all;padding-left:7px;width:${workflowmap['stepbrief']}">${stepmain['stepbrieftip']}</td>--%>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['stepstatusvalue']}">${stepmain['stepstatusvalue']}</td>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['starttime']}">${fn:substring(stepmain['starttime'], 0, 16)}</td>
                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;width: 60px;">
                                            &nbsp;</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:set value="0" var="pagecount" scope="page"/>
                                    <tr bgcolor="${stepmain.bgcolor}" style="color:#EEEEEE">
                                    <td class="stk-table-td"
                                        style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['processstepname']}"
                                        rowspan="${stepmain['ownerlistsize']}">${stepmain['processstepname']}</td>
                                    <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;word-break : break-all;padding-left:7px;width: ${workflowmap['stepbrief']}"--%>
                                    <%--rowspan="${stepmain['ownerlistsize']}">${stepmain['stepbrieftip']}</td>--%>
                                    <td class="stk-table-td"
                                        style="border:1px #BBBBBB solid;padding-left:7px;width:${workflowmap['stepstatusvalue']}"
                                        rowspan="${stepmain['ownerlistsize']}">${stepmain['stepstatusvalue']}</td>
                                    <td class="stk-table-td"
                                        style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['starttime']}"
                                        rowspan="${stepmain['ownerlistsize']}">${fn:substring(stepmain['starttime'], 0, 16)}</td>
                                    <c:forEach items="${stepmain['ownerlist']}" var="ownermap">
                                        <c:if test="${pagecount=='1'}">
                                            <tr bgcolor="${stepmain.bgcolor}">
                                        </c:if>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                            width="${workflowmap['ownername']}">
                                            <div style='padding-left:0px;padding-top:5px;'>${ownermap['ownername']}</div>
                                        </td>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                            width="${workflowmap['ownerstatusvalue']}">
                                            <div style='padding-left:0px;padding-top:5px;'>${ownermap['ownerstatusvalue']}</div>
                                        </td>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                            width="${workflowmap['approvetime']}">
                                            <div style='padding-left:0px;padding-top:5px;'>${fn:substring(ownermap['approvetime'], 0, 16)}</div>
                                        </td>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                            width="100%">
                                            <div style='padding-left:0px;padding-top:5px;' title="${ownermap['approveopiniontip']}">${ownermap['approveopinion']}</div>
                                        </td>
                                        </tr>
                                        <c:set value="1" var="pagecount" scope="page"/>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </table>
                </c:if>
                <c:if test="${workflowmark=='1'}">   <%-- url的参数是 sourcename 和 sourceid --%>
                    <c:set value="0" var="pagecounts" scope="page"/>
                    <c:forEach items="${examplelist}" var="examplemain">
                        <s:if test="${pagecounts=='1'}">
                            <br>
                        </s:if>
                        <table class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                            <tr>
                                <th class="stk-table-th" width="${workflowmap['processstepname']}">步骤名称</th>
                                    <%--<th class="stk-table-th" width="${workflowmap['stepbrief']}">步骤描述</th>--%>
                                <th class="stk-table-th" width="${workflowmap['stepstatusvalue']}">步骤结果</th>
                                <th class="stk-table-th" width="${workflowmap['starttime']}">开始时间</th>
                                <th class="stk-table-th" width="${workflowmap['ownername']}">处理人</th>
                                <th class="stk-table-th" width="${workflowmap['ownerstatusvalue']}">处理结果</th>
                                <th class="stk-table-th" width="${workflowmap['approvetime']}">处理时间</th>
                                <th class="stk-table-th" width="100%">处理意见</th>
                            </tr>
                            <c:forEach items="${examplemain}" var="stepmain">
                                <c:choose>
                                    <c:when test="${empty stepmain['ownerlist']}">
                                        <tr bgcolor="${stepmain.bgcolor}" style="color:#EEEEEE">
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['processstepname']}">${stepmain['processstepname']}</td>
                                                <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;word-break : break-all;padding-left:7px;width:${workflowmap['stepbrief']}">${stepmain['stepbrieftip']}</td>--%>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['stepstatusvalue']}">${stepmain['stepstatusvalue']}</td>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['starttime']}">${fn:substring(stepmain['starttime'], 0, 16)}</td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;width: 60px;">
                                                &nbsp;</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:set value="0" var="pagecount" scope="page"/>
                                        <tr bgcolor="${stepmain.bgcolor}" style="color:#EEEEEE">
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['processstepname']}"
                                            rowspan="${stepmain['ownerlistsize']}">${stepmain['processstepname']}</td>
                                        <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;word-break : break-all;padding-left:7px;width:${workflowmap['stepbrief']}"--%>
                                        <%--rowspan="${stepmain['ownerlistsize']}">${stepmain['stepbrieftip']}</td>--%>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['stepstatusvalue']}"
                                            rowspan="${stepmain['ownerlistsize']}">${stepmain['stepstatusvalue']}</td>
                                        <td class="stk-table-td"
                                            style="border:1px #BBBBBB solid;padding-left:7px;width: ${workflowmap['starttime']}"
                                            rowspan="${stepmain['ownerlistsize']}">${fn:substring(stepmain['starttime'], 0, 16)}</td>
                                        <c:forEach items="${stepmain['ownerlist']}" var="ownermap">
                                            <s:if test="${pagecount=='1'}">
                                                <tr bgcolor="${stepmain.bgcolor}">
                                            </s:if>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                                width="${workflowmap['ownername']}">
                                                <div style='padding-left:0px;padding-top:5px;'>${ownermap['ownername']}</div>
                                            </td>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                                width="${workflowmap['ownerstatusvalue']}">
                                                <div style='padding-left:0px;padding-top:5px;'>${ownermap['ownerstatusvalue']}</div>
                                            </td>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                                width="${workflowmap['approvetime']}">
                                                <div style='padding-left:0px;padding-top:5px;'>${fn:substring(ownermap['approvetime'], 0, 16)}</div>
                                            </td>
                                            <td class="stk-table-td"
                                                style="border:1px #BBBBBB solid;padding-left:7px;color:${ownermap.color}"
                                                width="100%">
                                                <div style='padding-left:0px;padding-top:5px;'
                                                     title="${ownermap['approveopiniontip']}">${ownermap['approveopinion']}</div>
                                            </td>
                                            </tr>
                                            <c:set value="1" var="pagecount" scope="page"/>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </table>
                        <c:set value="1" var="pagecounts" scope="page"/>
                    </c:forEach>
                </c:if>
                <div style="padding-top:6px;">
                    <ul>
                        <li><span style="background-color:#229800;color:#EEEEEE">浅绿色</span><span>代表该任务执行中&nbsp</span><span
                                style="background-color:#2CA0EA;color:#EEEEEE">浅蓝色</span><span>代表该任务自动完成&nbsp</span><span
                                style="background-color:#00477A;color:#EEEEEE">蓝色</span><span>代表该任务已处理&nbsp</span><span
                                style="background-color:#404040;color:#EEEEEE">灰色</span><span>代表该任务非正常结束&nbsp</span><span
                                style="color:#FF2202">红色</span><span>代表您的任务&nbsp</span></li>
                    </ul>
                </div>
            </c:if>

        </td>
    </tr>
</table>