<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-24
  Time: 下午3:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程模板管理</title>
    <script type="text/javascript">
        function showtemplate(objid) {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid + "&type=1"), "流程步骤查看", {keyWithoutParams: true});
        }
        function edittemplate(objid) {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid), "流程步骤列表", {keyWithoutParams: true});
        }

        function edittemplate_new(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/drawprocess/drawprocess.jsp?processid=" + objid + "&type=EDIT"),"绘制流程",{keyWithoutParams:true});
        }
        function showtemplate_new(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/drawprocess/drawprocess.jsp?processid=" + objid +"&type=SHOW"),"流程查看",{keyWithoutParams:true});
        }
    </script>
</head>
<sirm:body>
    <form id="processhistoryform" name="processhistoryform">
        <input type="hidden" id="modeprocessid" name="modeprocessid" value="${param.processid}">
        <ui:table id="processhistorytable" nowrap="true"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessHistoryAction" pageSize="10"
                  queryForm="processhistoryform">
            <%--<ui:col plugin="checkBoxPlugin" width="20px" align="center"/>--%>
            <ui:col property="name" title="流程模版" align="left" width="120px" allowSort="false"/>
            <ui:col property="processcode" title="流程Code" align="left" allowTip="true" width="120px" allowSort="false"/>
            <ui:col property="sysversion" title="版本号" align="right" width="40px" allowSort="false"/>
            <ui:col property="statusname" title="流程状态" width="60px" allowSort="false"/>
            <ui:col property="processtypename" title="流程类型" align="left" width="80px" allowSort="false"/>
            <ui:col property="processbrief" title="流程备注" align="left" allowTip="true" allowSort="false"/>
            <ui:colCust method="changeprocess${param.prefix}" title="操作" allowSort="false" width="100px"/>
        </ui:table>
    </form>
    <ui:form id="freshtemplateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction"
             method="freshtemplate${param.prefix}">
        <input type="hidden" id="freshinfo" name="freshinfo">
        <input type="hidden" id="freshtype" name="freshtype">
    </ui:form>
</sirm:body>
</html>