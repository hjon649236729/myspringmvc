<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%@ page import="com.sinitek.sirm.common.utils.StringUtil" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.ShowWorkflowOpinionAction" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 12-9-11
  Time: 下午5:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%
    int _exampleid = NumberTool.safeToInteger(request.getParameter("exampleid"), 0);
    String _sort = StringUtil.safeToString(request.getParameter("sort"), "");
    int _type = NumberTool.safeToInteger(request.getParameter("type"), 1);
    List<Map> _opinionlist = ShowWorkflowOpinionAction.getworkflownopinion(_exampleid, _sort, _type);
    pageContext.setAttribute("workflowopinionsize", _opinionlist.size());
    pageContext.setAttribute("workflowopinionlist", _opinionlist);
    String _title = StringUtil.safeToString(request.getParameter("title"), "");
    pageContext.setAttribute("workflowtitle", _title);
    String _base = StringUtil.safeToString(request.getParameter("base"), "评论");
    pageContext.setAttribute("workflowbase", _base);
    String _titlecolor = StringUtil.safeToString(request.getParameter("titlecolor"), "#2CA0EA");
    pageContext.setAttribute("workflowtitlecolor", _titlecolor);
    String _bgcolor = StringUtil.safeToString(request.getParameter("bgcolor"), "#ACD0EA");
    pageContext.setAttribute("workflowbgcolor", _bgcolor);
    String _width = StringUtil.safeToString(request.getParameter("width"), "100%");
    pageContext.setAttribute("workflowwidth", _width);
%>
<c:if test="${workflowopinionsize>0}">
    <table width="${workflowwidth}">
        <c:if test="${not empty workflowtitle}">
            <tr bgcolor="${workflowtitlecolor}">
                <th class="stk-table-th" colspan="3">
                    <B>${workflowtitle}</B>
                </th>
            </tr>
        </c:if>
        <c:forEach items="${workflowopinionlist}" var="workflowopinion">
            <tr bgcolor="${workflowbgcolor}">
                <td width="200px"><B>${workflowbase}人：${workflowopinion.ownername}&nbsp${workflowopinion.statusvalue}</B></td>
                <td></td>
                <td width="240px"><B>${workflowbase}时间：${workflowopinion.approvetimeshow}</B></td>
            </tr>
            <c:if test="${not empty workflowopinion.approveopinion}">
            <tr>
                <td colspan="3">
                    <ui:textarea rows="3" width="100%" readOnly="true" defaultValue="${workflowopinion.approveopinion}"></ui:textarea>
                </td>
            </tr>
            </c:if>
        </c:forEach>
    </table>
</c:if>