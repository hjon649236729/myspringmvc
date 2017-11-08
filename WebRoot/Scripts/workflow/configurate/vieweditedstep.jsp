<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-7-7
  Time: 上午9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>Simple jsp page</title></head>
<sirm:body>
<ui:form id="configstepform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigStepAction" method="savestepall">
<input type="hidden" id="processid" name="processid" value="${processid}">
<input type="hidden" id="stepid" name="stepid" value="${stepid}">

<div style="padding-top:7px;">
    <table>
        <tr>
            <td class="bd" width="60px">步骤名称</td>
            <td style="padding-left:7px;">
                    ${stepmain['name']}
            </td>
        </tr>
        <tr>
            <td class="bd" width="60px" style="">步骤类型</td>
            <td style="padding-left:7px;">
                    ${stepmain['steptypename']}
            </td>
        </tr>
        <c:if test="${not empty stepmain['pointtypevalue']}">
        <tr>
            <td class="bd" width="60px" style="">步骤阶段</td>
            <td style="padding-left:7px;">
                    ${stepmain['pointtypevalue']}
            </td>
        </tr>
        </c:if>
        <c:if test="${not empty stepmain['urlname']}">
        <tr>
            <td class="bd" width="60px" style="">处理页面</td>
            <td style="padding-left:7px;">
                    ${stepmain['urlname']}
            </td>
        </tr>
        </c:if>
    </table>
    <table id="ownertable">
        <c:if test="${(stepmain['steptypeid'] eq 3)}">
            <tr>
                <td class="bd" style="" width="60px">处理类型</td>
                <td style="padding-left:7px;">
                        ${steptypeads['judgetype']}
                </td>
                <td style="padding-left:7px;">
                        ${steptypeads['coojudge']} ${steptypeads['coojudgeads']} ${steptypeads['resultdeal']}
                </td>
            </tr>
            <c:if test="${not empty stepdealer}">
                <tr>
                    <td style="">
                        特殊处理人
                    </td>
                    <td style="padding-left:7px;">
                            ${stepdealer}
                    </td>
                </tr>
            </c:if>
            <tr>
                <td style="">
                    默认处理人
                </td>
                <td style="padding-left:7px;">
                        ${conditionowners}
                </td>
                <td style="padding-left:7px;">
                        ${workflowagent}
                </td>
            </tr>
        </c:if>
        <c:if test="${(stepmain['steptypeid'] eq 7)}">
            <tr>
                <td class="bd" style="" width="60px">处理类型</td>
                <td style="padding-left:7px;">
                        ${steptypeads['judgetype']}
                </td>
            </tr>
            <c:if test="${not empty stepdealer}">
                <tr>
                    <td style="">
                        特殊处理人
                    </td>
                    <td style="padding-left:7px;">
                            ${stepdealer}
                    </td>
                </tr>
            </c:if>
            <tr>
                <td style="">
                    默认处理人
                </td>
                <td style="padding-left:7px;">
                        ${conditionowners}
                </td>
                <td style="padding-left:7px;">
                        ${workflowagent}
                </td>
            </tr>
        </c:if>
    </table>
</div>
<c:if test="${(stepmain['steptypeid'] eq 3)}">
    <c:if test="${not empty ownerlinklist}">
        <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
            <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
                <table id="ownerlinktable" class="stk-table" width="100%"
                       style="min-height: 30px; table-layout: fixed;">
                    <tr>
                        <th class="stk-table-th" align="center" width="120px">来源种类</th>
                        <th class="stk-table-th" align="center">来源范围</th>
                        <th class="stk-table-th" align="center">处理人员</th>
                    </tr>
                    <c:forEach items="${ownerlinklist}" var="ownerlinkmap">
                        <tr id="ownerlink${ownerlinkmap['objid']}">
                            <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                                <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['linkleafname']}</div>
                                <input type='hidden' id='ownertype${ownerlinkmap['objid']}'
                                       name='ownertype${ownerlinkmap['objid']}' value='${ownerlinkmap['linkleaf']}'>
                            </td>
                            <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                                <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['ownerstartershow']}</div>
                                <input type='hidden' id='ownerstarter${ownerlinkmap['objid']}'
                                       name='ownerstarter${ownerlinkmap['objid']}'
                                       value='${ownerlinkmap['ownerstarter']}'>
                            </td>
                            <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                                <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['ownerendershow']}</div>
                                <input type='hidden' id='ownerender${ownerlinkmap['objid']}'
                                       name='ownerender${ownerlinkmap['objid']}' value='${ownerlinkmap['ownerender']}'>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </c:if>
</c:if>
<c:if test="${!(stepmain['steptypeid'] eq 2)}">
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table id="linktable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <th class="stk-table-th" align="center">条件</th>
                    <th class="stk-table-th" align="center">执行</th>
                    <th class="stk-table-th" align="center">目标步骤</th>
                </tr>
                <c:forEach items="${linklist}" var="linkmap">
                    <tr id="link${linkmap['objid']}">
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                <div style='padding-left:7px;padding-top:5px;'>${linkif['ifshow']}</div>
                            </c:forEach>
                            <input type='hidden' id='linkif${linkmap['objid']}' name='linkif${linkmap['objid']}'
                                   value="${linkmap['linkifs']}">
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <c:forEach items="${linkmap['linkdolist']}" var="linkdo">
                                <div style='padding-left:7px;padding-top:5px;'>${linkdo['doshow']}</div>
                            </c:forEach>
                            <input type='hidden' id='linkdo${linkmap['objid']}' name='linkdo${linkmap['objid']}'
                                   value="${linkmap['linkdos']}">
                        </td>
                        <td class='stk-table-td'
                            style='border:1px #BBBBBB solid;padding-left:7px;'>${linkmap['aftstepname']}
                            <input type='hidden' id='linktarget${linkmap['objid']}' name='linktarget${linkmap['objid']}'
                                   value='${linkmap['aftstepid']}'>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</c:if>
<c:if test="${!(stepmain['steptypeid'] eq 2)}">
    <div style="padding-top:20px;">
    <c:if test="${(stepmain['steptypeid'] eq 3) or (stepmain['steptypeid'] eq 7)}">
        <c:if test="${not empty stepcondition['messageremind']}">
            <table width="90%">
                <tr>
                    <td class="bd" width="60px">任务提醒</td>
                    <td style="padding-left:7px;" width="200px">
                            ${stepcondition['messageremind']}
                    </td>
                    <td style="padding-left:7px;"></td>
                </tr>
            </table>
            </div>
            <div style="">
        </c:if>
    </c:if>
    <c:if test="${not empty stepcondition['messagenotice']}">
        <table width="90%">
            <tr>
                <td class="bd" width="60px">消息通知</td>
                <td style="padding-left:7px;">
                        ${stepcondition['messagenotice']}
                </td>
            </tr>
            <tr>
                <td class="bd" width="60px">特殊通知人</td>
                <td style="padding-left:7px;">
                        ${stepcondition.specialnoticer}
                </td>
            </tr>
            <tr>
                <td class="bd" width="60px">默认通知人</td>
                <td style="padding-left:7px;">
                        ${stepcondition.noticeowner}
                </td>
            </tr>
        </table>
    </c:if>
    </div>

    <c:if test="${not empty candidates}">
        <div style="">
            <table width="90%">
                <tr>
                    <td class="bd" width="60px">候选人</td>
                    <td style="padding-left:7px;">
                            ${candidates}
                    </td>
                </tr>
            </table>
        </div>
    </c:if>
</c:if>
<div align="center" style="padding-top:15px;">
    <ui:button id="btreturnstep" text="返回">
        <event:onclick>
            $(document).stk_navigate(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + ${processid}+"&type=1"),
            "流程步骤列表", {keyWithoutParams:true});
        </event:onclick>
    </ui:button>
</div>
</ui:form>
</sirm:body>
</html>