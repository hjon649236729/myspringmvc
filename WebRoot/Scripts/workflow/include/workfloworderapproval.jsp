<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.OrderApprovalAction" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinitek.sirm.common.utils.StringUtil" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-19
  Time: 上午11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<script type="text/javascript">
   function setcheckbox(processstepid){
       if($("#checkbox_"+processstepid).stk_checked()==true){
           $("#processsteptype_"+processstepid).val(1)
       }
       else{
           $("#processsteptype_"+processstepid).val(0)
       }
   }
</script>
<%
    String syscode= StringUtil.safeToString(request.getParameter("syscode"), "");
    Map processInfo = (Map) OrderApprovalAction.getProcessInfo(syscode);
    List<Map> processsteplist = (List<Map>) processInfo.get("processsteplist");
    pageContext.setAttribute("processsteplist", processsteplist);
%>
<table  class='stk-table stk-table-bbline'>
    <tr>
        <th class='stk-table-th' width='120px'>步骤名称</th>
        <th class='stk-table-th' width='300px'>审批人</th>
        <th class='stk-table-th' width='80px'>是否顺序审批</th>
    </tr>
    <c:forEach  var="processstep" items="${processsteplist}" >
         <tr>
             <td class='stk-table-td'>${processstep.processstepname}</td>
             <td class='stk-table-td'>
                 <input id="prefix_${processstep.processstepid}" name="prefix_${processstep.processstepid}"
                        type="hidden" value="${processstep.prefix}">
                 <input id="processstep_${processstep.processstepid}" name="processstepids" type="hidden" value="${processstep.processstepid}">
                 <input id="org_${processstep.processstepid}" name="org_${processstep.processstepid}" type="hidden">
                 <input id="processsteptype_${processstep.processstepid}" name="processsteptype_${processstep.processstepid}"
                        type="hidden" value="0" >
                 <input id="skiplinkstepid_${processstep.processstepid}" name="skiplinkstepid_${processstep.processstepid}"
                         type="hidden" value="${processstep.skiplinkstepid}">
                 <org:SelectOrg prefix="approver_${processstep.processstepid}" multi="true" mode="ORG"
                                hiddenId="org_${processstep.processstepid}" selectWidth="300px"/>
             </td>
             <td class='stk-table-td'>
                 <input type="checkbox" id="checkbox_${processstep.processstepid}" name="checkbox_${processstep.processstepid}"
                         value="${processstep.processstepid}" onclick="setcheckbox(${processstep.processstepid})">
                 </input>
             </td>
         </tr>
    </c:forEach>
</table>
</div>