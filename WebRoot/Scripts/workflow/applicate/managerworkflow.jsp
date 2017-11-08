<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-7
  Time: 下午5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程详细</title>
    <script type="text/javascript">
        function showworkflow(exampleid) {
            $(document).stk_go(sirm.jsurl("/workflow/applicate/showworkflow.action?exampleid=" + exampleid), "流程详细列表", {keyWithoutParams:true});
        }
        function dealworkflow(exampleid, examplestepid, exampleownerid, actionurl) {
            if (actionurl.indexOf("?") == -1) {
                $(document).stk_go(sirm.jsurl(actionurl + "?exampleid=" + exampleid + "&examplestepid=" + examplestepid + "&exampleownerid=" + exampleownerid), "处理任务", {keyWithoutParams:true});
            } else {
                $(document).stk_go(sirm.jsurl(actionurl + "&exampleid=" + exampleid + "&examplestepid=" + examplestepid + "&exampleownerid=" + exampleownerid), "处理任务", {keyWithoutParams:true});
            }
        }
    </script>
</head>
<sirm:body>
<div class="stk_component_wrap">
    <form>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto;">
            <table id="templatesteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <%--<th class="stk-table-th" align="center" width="4%">--%>
                    <%--<input type="checkbox" id="allStep" name="allStep" onclick="selectallstep(this);">--%>
                    <%--</th>--%>
                    <th class="stk-table-th" width="12%">流程名称</th>
                    <th class="stk-table-th" width="6%">流程状态</th>
                    <th class="stk-table-th" width="20%">流程描述</th>
                    <th class="stk-table-th" width="8%">步骤名称</th>
                    <th class="stk-table-th" width="6%">步骤类型</th>
                    <th class="stk-table-th" width="14%">开始时间</th>
                    <th class="stk-table-th" width="12%">处理人</th>
                    <th class="stk-table-th" width="9%">处理结果</th>
                    <th class="stk-table-th" width="9%">操作</th>
                </tr>
                <c:forEach items="${steplist}" var="stepmain">
                    <tr>
                            <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="4%">--%>
                            <%--<input type="checkbox" name="subStep" value="${stepmain['examplestepid']}">--%>
                            <%--</td>--%>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['processname']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['processstatusvalue']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                            <ui:a href="javascript:showworkflow(${stepmain['exampleid']})">${stepmain['processbrief']}</ui:a>
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['processstepname']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['steptypevalue']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">${stepmain['starttime']}</td>
                        <c:choose>
                            <c:when test="${empty stepmain['ownerlist']}">
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                                    <div style='padding-left:7px;padding-top:5px;'>待定</div>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td style="padding:0px;" colspan="3">
                                    <table width="100%">
                                        <c:forEach items="${stepmain['ownerlist']}" var="ownermap">
                                            <tr>
                                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="40%">
                                                    <div style='padding-left:7px;padding-top:5px;'>${ownermap['ownername']}</div>
                                                </td>
                                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="30%">
                                                    <div style='padding-left:7px;padding-top:5px;'>${ownermap['ownerstatusvalue']}</div>
                                                </td>
                                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="30%">
                                                    <div style='padding-left:7px;padding-top:5px;'>
                                                        <ui:a href="javascript:dealworkflow(${stepmain['exampleid']},${stepmain['examplestepid']},${ownermap['exampleownerid']},'${stepmain['actionurl']}')">处理</ui:a>
                                                    </div>
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
        </div>
    </form>
</div>
<div align="center" style="padding-top:15px;">
    <ui:button text="发起流程">
        <event:onclick>
            $(document).stk_go(sirm.jsurl("/workflow/myprocess/startprocess.action?"),"发起流程",{keyWithoutParams:true});
        </event:onclick>
    </ui:button>
</div>
</sirm:body>
</html>