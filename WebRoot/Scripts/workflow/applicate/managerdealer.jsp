<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-9-26
  Time: 下午2:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>Simple jsp page</title></head>
<sirm:body>
    <form id="dealerform">
        <plugin:colLink id="showdealtask" dataVar="data">
            $(document).stk_go(sirm.jsurl("/workflow/applicate/showdealertask.jsp?ownerid=" + data.ownerid),data.orgname+"任务详细",{keyWithoutParams:true});
        </plugin:colLink>
        <ui:table id="dealertable" queryForm="dealerform" nowrap="true" pageSize="10"
                  actionClass="com.sinitek.sirm.web.workflow.applicate.ManagerDealerAction">
            <ui:col align="left" property="orgname" title="员工名" allowSort="false"/>
            <ui:col align="left" property="tasknum" plugin="showdealtask" title="未完成任务数" allowSort="false"/>
        </ui:table>
    </form>
</sirm:body>
</html>