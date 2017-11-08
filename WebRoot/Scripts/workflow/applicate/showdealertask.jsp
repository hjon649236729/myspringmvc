<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-9-26
  Time: 下午3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>Simple jsp page</title></head>
<sirm:body>
    <form id="unfinishform">
        <input type="hidden" id="showdealertask" value="${param.ownerid}">
        <plugin:colLink id="workflowmain2" dataVar="data">
            $(document).stk_go(sirm.jsurl("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid),"流程详细列表",{keyWithoutParams:true});
        </plugin:colLink>
        <plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked">
        </plugin:colCheckbox>
        <ui:table id="unfinishtable" queryForm="unfinishform" nowrap="true" pageSize="10"
                  actionClass="com.sinitek.sirm.web.workflow.applicate.ManagerTaskDbAction">
            <ui:col plugin="checkBoxPlugin" show="false" width="0px" align="center"/>
            <%--<ui:col property="processname" title="流程名称" align="left" width="120px" allowSort="false"></ui:col>--%>
            <ui:col property="processstepname" title="步骤名称" width="120px" align="left" allowTip="true"/>
            <%--<ui:col property="steptypevalue" title="步骤类型" width="60px" allowSort="false"></ui:col>--%>
            <ui:col plugin="workflowmain2" property="processbrief" align="left" title="描述" allowTip="true" width="100%"
                    allowSort="false"/>
            <%--<ui:col property="startername" title="发起人" align="left" width="80px" allowSort="false"></ui:col>--%>
            <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="80px"
                        allowSort="false"/>
            <%--<ui:col property="preownername" title="来源" width="80px" allowSort="false"></ui:col>--%>
            <%--<ui:colCust property="preownerid" method="getpreownername" align="left" title="来源" width="80px" allowSort="false"/>--%>
            <ui:colDate property="starttime" title="开始时间" width="120px" format="yyyy-MM-dd HH:mm"/>
            <%--<ui:col plugin="condition2" title="操作" width="60px"/>--%>
        </ui:table>
    </form>
</sirm:body>
</html>