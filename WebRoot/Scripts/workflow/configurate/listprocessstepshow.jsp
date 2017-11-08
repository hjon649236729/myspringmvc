<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-24
  Time: 下午1:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程步骤查看</title>
    <script type="text/javascript">
        function showstep(processid, stepid) {
            sirm.openTab(sirm.jsurl("/workflow/configurate/vieweditedstep.action?processid=" + processid + "&stepid=" + stepid) , name + "-流程步骤查看", {keyWithoutParams:true});
//            $(document).stk_navigate(sirm.jsurl("/workflow/configurate/vieweditedstep.action?processid=" + processid + "&stepid=" + stepid) , "流程步骤查看", {keyWithoutParams:true});
//            $(document).stk_navigate("/workflow/configurate/configuratestep.action?processid=" + processid + "&stepid=" + stepid + "&type=1", "流程步骤编辑", {keyWithoutParams:true});
        }
    </script>
</head>
<sirm:body>
<form>
    <ui:textfield type="hidden" id="processid" name="processid" defaultValue="${processid}"></ui:textfield>
    <div class="stk_component_wrap">
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: hidden;">
            <table id="templatesteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <%--<th class="stk-table-th" align="center" width="4%">--%>
                        <%--<input type="checkbox" id="allStep" name="allStep" onclick="selectallstep(this);">--%>
                    <%--</th>--%>
                    <th class="stk-table-th" width="10%">步骤名称</th>
                    <th class="stk-table-th" width="8%">步骤类型</th>
                    <th class="stk-table-th" width="8%">步骤阶段</th>
                    <th class="stk-table-th" width="8%">处理策略</th>
                    <th class="stk-table-th" width="8%">被处理人</th>
                    <th class="stk-table-th" width="12%">处理条件</th>
                    <th class="stk-table-th" width="12%">处理人</th>
                    <th class="stk-table-th" width="12%">判定条件</th>
                    <th class="stk-table-th" width="10%">目标步骤</th>
                    <th class="stk-table-th" width="8%">操作</th>
                </tr>
                <c:forEach items="${steplist}" var="stepmain" varStatus="status">
                    <tr class="${status.index%2==0 ?"stk-table-tr-odd":"stk-table-tr-even"}">
                        <%--<td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="4%">--%>
                            <%--<input type="checkbox" name="subStep" value="${stepmain['objid']}">--%>
                        <%--</td>--%>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">${stepmain['name']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['steptypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['pointtypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['acrosstype']}</td>
                        <c:choose>
                            <c:when test="${empty stepmain['ownerlinklist']}">
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">${stepmain['conditonowners']}</td>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <%--新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增--%>
                                    <c:when test="${stepmain['ownerlinklistsize']=='1'}">
                                        <c:forEach items="${stepmain['ownerlinklist']}" var="ownerlinkmap">
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['linkleafname']}
                                                </div>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['ownerstartershow']}
                                                </div>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['ownerendershow']}
                                                </div>
                                            </td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="padding:0;" colspan="3">
                                            <table style="width: 100%;height:100%;padding: 0;">
                                                <c:forEach items="${stepmain['ownerlinklist']}" var="ownerlinkmap">
                                                    <s:if test="${stepmain['whichislower']=='ownheight'}">
                                                        <tr style="height: ${stepmain['htmlheight']}px">
                                                    </s:if>
                                                    <s:if test="${stepmain['whichislower']!='ownheight'}">
                                                        <tr>
                                                    </s:if>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${ownerlinkmap['linkleafname']}
                                                            </div>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${ownerlinkmap['ownerstartershow']}
                                                            </div>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${ownerlinkmap['ownerendershow']}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                            <%----%>
                        <c:choose>
                            <c:when test="${empty stepmain['linklist']}">
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%"></td>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <%--新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增--%>
                                    <c:when test="${stepmain['linklistsize']=='1'}">
                                        <c:forEach items="${stepmain['linklist']}" var="linkmap">
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                                    <div style='padding-left:7px;padding-top:5px;'>
                                                        ${linkif['ifshow']}
                                                    </div>
                                                </c:forEach>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${linkmap['aftstepname']}
                                                </div>
                                            </td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="padding:0;" colspan="2">
                                            <table class="stk-table-td" style="width: 100%;height:100%;padding: 0;border: none;">
                                                <c:forEach items="${stepmain['linklist']}" var="linkmap">
                                                    <s:if test="${stepmain['whichislower']=='linkheight'}">
                                                        <tr style="height: ${stepmain['htmlheight']}px">
                                                    </s:if>
                                                    <s:if test="${stepmain['whichislower']!='linkheight'}">
                                                        <tr>
                                                    </s:if>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="13%">
                                                            <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                                                <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${linkif['ifshow']}
                                                                </div>
                                                            </c:forEach>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${linkmap['aftstepname']}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="8%">
                            <ui:a href="javascript:showstep('${processid}','${stepmain['objid']}','${stepmain['name']}')">查看</ui:a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</form>
</sirm:body>
</html>