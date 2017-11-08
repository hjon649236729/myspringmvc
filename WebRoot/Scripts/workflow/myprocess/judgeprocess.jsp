<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-14
  Time: 下午4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>Simple jsp page</title></head>
<sirm:body>
<ui:form id="judgeprocessform" clazz="com.sinitek.sirm.web.workflow.myprocess.JudgeProcessAction" method="processjudge">
<div style="padding-left:150px;padding-top:7px;">
    <table>
        <tr>
            <td>exampleid或mainmap.objid</td>
            <td>
                <ui:textfield id="exampleid" name="exampleid" width="150px" disabled="true" readOnly="true" defaultValue="${exampleid}"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td>examplestepid或stepmap.objid</td>
            <td>
                <ui:textfield id="examplestepid" name="examplestepid" width="150px" disabled="true" readOnly="true" defaultValue="${examplestepid}"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td>exampleownerid或ownermap.objid</td>
            <td>
                <ui:textfield id="exampleownerid" name="exampleownerid" width="150px" disabled="true" readOnly="true" defaultValue="${exampleownerid}"></ui:textfield>
            </td>
        </tr>
    </table>
</div>
<div style="padding-left:150px;padding-top:7px;">
    <table>
        <tr>
            <td class="bd">流程ID*：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="processid" name="processid" width="150px" disabled="true" readOnly="true" defaultValue="${mainmap['processid']}"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td class="bd">发起人ID*：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="starterid" name="starterid" width="150px" disabled="true" readOnly="true" defaultValue="${mainmap['starterid']}"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td class="bd">发起人备注：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="starterads" name="starterads" width="150px" disabled="true" readOnly="true" defaultValue="${mainmap['starterads']}"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td class="bd">流程描述：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="brief" name="brief" width="150px" disabled="true" readOnly="true" defaultValue="${mainmap['brief']}"></ui:textfield>
            </td>
        </tr>
    </table>
</div>
<div style="padding-left:150px;padding-top:7px;">
    <table>
        <tr>
            <td class="bd">实体类型：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="sourcename" name="sourcename" width="150px" disabled="true" readOnly="true" defaultValue="${entrymap['sourcename']}"></ui:textfield>
            </td>
            <td class="bd">实体ID：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="sourceid" name="sourceid" width="150px" disabled="true" readOnly="true" defaultValue="${entrymap['sourceid']}"></ui:textfield>
            </td>
            <td class="bd">实体标记：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="sourcestatus" name="sourcestatus" width="150px" defaultValue="${entrymap['status']}"></ui:textfield>
            </td>
            <td class="bd">int变量名entrylist.status(-1为删除)</td>
        </tr>
        <tr>
            <td class="bd">实体类型：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="newsourcename" name="newsourcename" width="150px"></ui:textfield>
            </td>
            <td class="bd">实体ID：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="newsourceid" name="newsourceid" width="150px"></ui:textfield>
            </td>
            <td class="bd">实体标记：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="newsourcestatus" name="newsourcestatus" width="150px" disabled="true" readOnly="true"></ui:textfield>
            </td>
            <td class="bd">这条为新增</td>
        </tr>
    </table>
</div>
<div style="padding-left:150px;padding-top:7px;">
    <table>
        <tr>
            <td class="bd">替代审批人：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="insteadowners" name="insteadowners" width="150px"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td class="bd">添加审批人：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="addowners" name="addowners" width="150px"></ui:textfield>
            </td>
        </tr>
    </table>
</div>
<div align="center" style="padding-top:15px;">
    <table>
        <tr>
            <td class="bd">审批结果：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="stepcondition" name="stepcondition" width="150px"></ui:textfield>
            </td>
            <td class="bd">int变量名ownermap.condition;其中通过为1，驳回为2</td>
        </tr>
        <tr>
            <td class="bd">审批意见：</td>
            <td style="padding-left:7px;">
                <ui:textfield id="approveopinion" name="approveopinion" width="150px"></ui:textfield>
            </td>
            <td class="bd">string变量名ownermap.approveopinion</td>
        </tr>
    </table>
</div>
<div align="center" style="padding-top:15px;">
    <ui:button id="btsavestep" text="保存审批">
        <event:onclick>
            $("#judgeprocessform").stk_submit("processjudge", function(result) {
                if (result != null) {
                    stk.alert(result);
                    return;
                }
                stk.alert("审批成功");
                return;
            })
        </event:onclick>
    </ui:button>
    <%--<ui:button id="btsavestep2" text="审批">
        </ui:button>--%>
</div>
<div style="padding-top:15px;">
    <jsp:include page="/workflow/include/workflowcandidate.jsp" flush="true">
        <jsp:param name="examplestepid" value="${examplestepid}"></jsp:param>
    </jsp:include>
</div>
<div style="padding-top:15px;">
    <jsp:include page="/workflow/include/workflownopinion.jsp" flush="true">
        <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
        <jsp:param name="title" value="处理意见"></jsp:param>
        <jsp:param name="base" value="处理"></jsp:param>
        <jsp:param name="sort" value="DESC"></jsp:param>
        <jsp:param name="width" value="100%"></jsp:param>
    </jsp:include>
</div>
<div style="padding-top:15px;">
    <jsp:include page="/workflow/include/showworkflowhistory.jsp" flush="true">
        <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
    </jsp:include>
</div>
</ui:form>
</sirm:body>
</html>