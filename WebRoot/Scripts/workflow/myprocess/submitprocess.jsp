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
<ui:form id="submitprocessform" clazz="com.sinitek.sirm.web.workflow.myprocess.SubmitProcessAction" method="processsubmit">
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
<div align="center" style="padding-top:15px;">
    <div>
        status<ui:textfield id="markstatus" name="markstatus" width="150px"></ui:textfield>设-1时，不改变流程状态
    </div>
    <div>
        提交节点ownermap.condition置为3
    </div>
</div>
<div align="center" style="padding-top:15px;">
    <ui:button id="btsavestep" text="提交数据">
        <event:onclick>
            $("#submitprocessform").stk_submit("processsubmit", function(result) {
                if (result != null) {
                    stk.alert(result);
                    return;
                }
                stk.alert("提交成功");
                return;
            })
        </event:onclick>
    </ui:button>
</div>
</ui:form>
</sirm:body>
</html>