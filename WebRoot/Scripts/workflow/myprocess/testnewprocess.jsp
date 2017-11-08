<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-7-31
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title></title>
</head>
<sirm:body>
<script type="text/javascript">
    function  startProcess(){
        $("#form").stk_submit("startProcess",function(result){
            var exampleid=result.exampleid;
            STK.go(sirm.jsurl("workflow/applicate/showcolorworkflow.jsp?exampleid="+exampleid), "查看",{ refresh: true});
        })
    }
</script>
<ui:form id="form" clazz="com.sinitek.sirm.busin.workflow.support.action.WorkflowActionTest2" method="startProcess">
    <input id="syscode" name="syscode" value="250" type="hidden"/>
    <jsp:include page="/workflow/include/workfloworderapproval.jsp" flush="true">
        <jsp:param name="syscode" value="250"></jsp:param>
    </jsp:include>
</ui:form>
<ui:button text="提交">
    <event:onclick>
        startProcess()
    </event:onclick>
</ui:button>
</sirm:body>
</html>

