<%@ page import="com.sinitek.sirm.web.workflow.include.ShowOnceLinkAction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-6
  Time: 上午10:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<script>
    $(function () {
        $("#returntargetstep").stk_checked(false)
        if ('${param.returntargetstepid}' != '')
            $("#${param.returntargetstepid}").val("")
        if ('${param.aftstepid}' != '')
            $("#${param.aftstepid}").val($("#aftstep").stk_val())
    })
    function showreturntargetstep() {
        if ('${param.aftstepid}' != '')
            $("#${param.aftstepid}").val($("#aftstep").stk_val())
    }
    function changreturntargestep() {
        if ('${param.returntargetstepid}' == '')
            return;
        if ($("#returntargetstep").stk_checked() == true) {
            $("#${param.returntargetstepid}").val($("#returntargetstep").val())
        }
        else {
            $("#${param.returntargetstepid}").val("")
        }
    }
</script>
<%
    int exampleid = NumberTool.safeToInteger(request.getParameter("exampleid"), 0);
    int examplestepid = NumberTool.safeToInteger(request.getParameter("examplestepid"), 0);

    Map processInfo = (Map) ShowOnceLinkAction.getProcessInfo(exampleid, examplestepid);
    List<Map> processsteplist = (List<Map>) processInfo.get("processsteplist");
    Integer currentprocessstepid = NumberTool.safeToInteger(processInfo.get("currentprocessstepid"), -1);
    pageContext.setAttribute("processsteplist", processsteplist);
    pageContext.setAttribute("currentprocessstepid", currentprocessstepid);
%>
<table class="stk-form-ui-st1">
    <tr>
        <td class="hd" width="120" align="right" style="padding:5px"><label>驳回节点选择</label></td>

        <td class="bd" style="padding:5px;width: 593px;">
            <ui:select id="aftstep" name="aftstep" headerValue="--正常驳回--" list="#attr.processsteplist"
                       headerKey="" listKey="processstepid" listValue="processstepname" width="120px">
                <event:onchange>
                    showreturntargetstep()
                </event:onchange>
            </ui:select>
        </td>
    </tr>
    <tr id="tr_returntargetstep">
        <td class="hd" width="120" align="right" style="padding:5px"><label>驳回处理后</label></td>
        <td class="bd" style="padding:5px;width: 593px;">
            <input id="returntargetstep" name="returntargetstep" type="checkbox" value="${currentprocessstepid}"
                   onclick="changreturntargestep()">直接跳转到当前节点</input>
        </td>
    </tr>
</table>