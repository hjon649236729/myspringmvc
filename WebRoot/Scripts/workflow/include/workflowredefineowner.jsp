<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 13-10-21
  Time: 上午10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinitek.sirm.common.utils.StringUtil" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.WorkflowRedefineAction" %>
<%@ page import="java.util.HashMap" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-19
  Time: 上午11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@ taglib prefix="org" uri="http://www.sinitek.com/sirm/org/tag" %>
<%
    Map map = request.getParameterMap();
    Map processInfo = WorkflowRedefineAction.getRedefineOwnerMap(map);
    List<Map> processsteplist = (List<Map>) processInfo.get("processsteplist");
    String  processstepprefixs = ""+processInfo.get("processstepprefixs");
    pageContext.setAttribute("processsteplist", processsteplist);
    pageContext.setAttribute("processstepprefixs", processstepprefixs);
%>

<script type="text/javascript">
    $(function(){
    });
</script>
<table  class='stk-table stk-table-bbline'>
    <script type="text/javascript" src="/workflow/include/js/owner_edit.js"></script>

    <input id="wn_processstepprefixs" name="wn_processstepprefixs"
           type="hidden" value="${processstepprefixs}">
    <tr>
        <th class='stk-table-th' width='120px'>步骤名称</th>
        <th class='stk-table-th' width='300px'>审批人</th>
        <th class='stk-table-th' width='80px'>是否顺序流转</th>
    </tr>
    <c:forEach  var="processstep" items="${processsteplist}" >
        <tr>
            <td class='stk-table-td'>${processstep.stepname}</td>
            <td class='stk-table-td'>
                <input id="${processstep.prefix}Stepid" name="${processstep.prefix}Stepid"
                       type="hidden" value="${processstep.stepid}">
                <input id="${processstep.prefix}Nextid" name="${processstep.prefix}Nextid"
                       type="hidden" value="${processstep.aftstepid}">
                <div id="${processstep.prefix}BaseDiv">
                    <div>
                        <org:SelectOrg prefix="${processstep.prefix}usersiframe" hiddenId="${processstep.prefix}Ids" callbackfn="renderuser${processstep.prefix}"  multi="${not empty settingMap.moreauthor && settingMap.moreauthor == 0 ? false : true}" render="true" readOnly="${authorreadonly}"/>
                    </div>
                    <div id="${processstep.prefix}Div"></div>
                    <input type="hidden" id="${processstep.prefix}Ids" name="${processstep.prefix}Ids" value=""/>
                </div>
            </td>
            <td class='stk-table-td' align="center">
                <input type="checkbox" id="${processstep.prefix}Type" name="${processstep.prefix}Type"
                       value="1">
                </input>
            </td>
        </tr>
    </c:forEach>
</table>
</div>
<script type="text/javascript">
    <c:forEach  var="processstep" items="${processsteplist}" >
            function renderuser${processstep.prefix}(){
                <%--alert(${processstep.prefix});--%>
                <%--var value= "${processstep.prefix}"+"Ids";--%>
                sirm.workflow.applicate.owner.readOnly = false;
                sirm.workflow.applicate.owner.controlIds = "${processstep.prefix}Ids";
                sirm.workflow.applicate.owner.controlDiv = "${processstep.prefix}Div";
                sirm.workflow.applicate.owner.addAuthor();
            }
    </c:forEach>
</script>