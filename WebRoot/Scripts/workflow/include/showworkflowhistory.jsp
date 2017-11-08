<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sinitek.sirm.web.workflow.include.ShowWorkflowStyleAction" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-12-1
  Time: 上午10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%
    int showStyle = ShowWorkflowStyleAction.getShowStyle();
    pageContext.setAttribute("showStyle", showStyle);
%>
<table width="100%;">
    <tr>
        <td>
            <c:choose>
                <c:when test="${showStyle == 1}">
                    <jsp:include page="showworkflowstyle1.jsp" flush="true"/>
                </c:when>
                <c:when test="${showStyle == 2}">
                    <jsp:include page="showworkflowstyle2.jsp" flush="true"/>
                </c:when>
                <c:otherwise>
                    <span style="color: #f00000;">不可识别的展示类型${showStyle}</span>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</table>

