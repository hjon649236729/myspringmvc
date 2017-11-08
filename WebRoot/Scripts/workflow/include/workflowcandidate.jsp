<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.ShowWorkflowCadidateAction" %>
<%@ page import="com.sinitek.sirm.common.utils.StringUtil" %>
<%@ page import="java.util.*" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-5-30
  Time: 下午3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%
    List<Map> _cadidatelist = new ArrayList<Map>();
    int _examplestepid = NumberTool.safeToInteger(request.getParameter("examplestepid"), 0);
    if (_examplestepid > 0) {
        _cadidatelist = ShowWorkflowCadidateAction.getdetailcadidatebyexamplestepid(_examplestepid);
    } else {
        String _syscode = StringUtil.safeToString(request.getParameter("syscode"), "");
        if (_syscode.length() > 0) {
            _cadidatelist = ShowWorkflowCadidateAction.getdetailcadidatebysyscode(_syscode);
        } else {
            int _processstepid = NumberTool.safeToInteger(request.getParameter("processstepid"), 0);
            if (_processstepid > 0) {
                _cadidatelist = ShowWorkflowCadidateAction.getdetailcadidatebyprocessstepid(_processstepid);
            }
        }
    }
    pageContext.setAttribute("workflowcadidatesize", _cadidatelist.size());
    pageContext.setAttribute("workflowcadidatelist", _cadidatelist);
    String _workflowcadidateid = StringUtil.safeToString(request.getParameter("cadidatename"), "workflowcadidateid");
    pageContext.setAttribute("workflowcadidateid", _workflowcadidateid);
    String _workflowtitle = StringUtil.safeToString(request.getParameter("title"), "");
    pageContext.setAttribute("workflowtitle",_workflowtitle);
    String _workflowwidth = StringUtil.safeToString(request.getParameter("width"),"");
    pageContext.setAttribute("workflowwidth", _workflowwidth);
    int _workflowformat = NumberTool.safeToInteger(request.getParameter("format"), 0);
    pageContext.setAttribute("workflowformat", _workflowformat);
    if (_workflowformat == 1) {
        String _workflowtdwidth1 = StringUtil.safeToString(request.getParameter("tdwidth1"), "auto");
        pageContext.setAttribute("workflowtdwidth1", _workflowtdwidth1);
        String _workflowtdcolspan1 = StringUtil.safeToString(request.getParameter("tdcolspan1"), "1");
        pageContext.setAttribute("workflowtdcolspan1", _workflowtdcolspan1);
        String _workflowtdwidth2 = StringUtil.safeToString(request.getParameter("tdwidth2"), "auto");
        pageContext.setAttribute("workflowtdwidth2", _workflowtdwidth2);
        String _workflowtdcolspan2 = StringUtil.safeToString(request.getParameter("tdcolspan2"), "1");
        pageContext.setAttribute("workflowtdcolspan2", _workflowtdcolspan2);
    }
%>
<c:if test="${workflowcadidatesize>0}">
    <c:if test="${workflowformat==0}">
    <ul>
        <li><span> ${workflowtitle}</span><span><ui:select id="${workflowcadidateid}" name="${workflowcadidateid}" headerKey="0" headerValue="--请选择--" list="#attr.workflowcadidatelist" listKey="orgid" listValue="orgname" width="${workflowwidth}"></ui:select></span></li>
    </ul>
    </c:if>
    <c:if test="${workflowformat==1}">
        <td class="hd" width="${workflotdwidth1}" colspan="${workflotdcolspan1}" ><label>${workflowtitle}</label></td>
        <td class="bd" width="${workflotdwidth2}" colspan="${workflotdcolspan2}">
            <ui:select id="${workflowcadidateid}" name="${workflowcadidateid}" headerValue="--请选择--" list="#attr.workflowcadidatelist"
                       headerKey="0" listKey="orgid" listValue="orgname" width="${workflowwidth}"></ui:select>
        </td>
    </c:if>
    <%--中再下使用的格式--%>
    <c:if test="${workflowformat==2}">
        <table class="stk-form-ui-st1">
            <tr>
                <td class="hd" width="120"  align="right" style="padding:5px"><label>${workflowtitle}</label></td>

                <td class="bd" style="padding:5px;width: 593px;">
                    <ui:select id="${workflowcadidateid}" name="${workflowcadidateid}" headerValue="--请选择--" list="#attr.workflowcadidatelist"
                               headerKey="" listKey="orgid" listValue="orgname" width="${workflowwidth}"></ui:select>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </c:if>
</c:if>