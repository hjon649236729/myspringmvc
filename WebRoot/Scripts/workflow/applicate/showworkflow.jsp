<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-7
  Time: 下午5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程详细列表</title></head>
<sirm:body>
    <form>
        <div class="stk_component_wrap">
            <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto;">
                <table id="templatesteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
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
                        <tr>
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
                                                <tr>
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
            </div>
        </div>
    </form>
</sirm:body>
</html>