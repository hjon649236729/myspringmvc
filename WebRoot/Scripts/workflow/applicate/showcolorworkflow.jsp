<%@ page import="com.sinitek.sirm.common.utils.NumberTool" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-5-31
  Time: 下午2:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title>流程详细列表</title>
    <%
        int _exampleid = NumberTool.safeToInteger(request.getParameter("exampleid"), 0);
        request.setAttribute("exampleid", _exampleid);
    %>

    <script type="text/javascript">
        $(document).ready(function () {
            stretchHeight($("#_drawflow_iframe"), 60);
        });

        var stretchHeight = function (targetobj, delta) {
            var sf = function () {
                var tableWrap = $(targetobj);
                var tableOffset = tableWrap.offset();
                var documentHeight = $(window).height();
                var tableHeight = documentHeight - tableOffset.top - (delta == undefined ? 0 : delta);
                tableWrap.height(tableHeight);
            };
            sf();
            $(window).resize(function () {
                sf();
            });
        };
    </script>
</head>
<sirm:body>
    <layout:tabs>
        <layout:tab title="流程详细">
            <div style="padding-top:0px;">
                <jsp:include page="/workflow/include/showworkflowhistory.jsp" flush="true">
                    <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
                </jsp:include>
            </div>
            <div style="padding-top:0px;">
                <jsp:include page="/workflow/include/workflowsopinion.jsp" flush="true">
                    <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
                    <jsp:param name="title" value="处理意见"></jsp:param>
                    <jsp:param name="base" value="处理"></jsp:param>
                    <jsp:param name="sort" value="DESC"></jsp:param>
                    <jsp:param name="width" value="100%"></jsp:param>
                </jsp:include>
            </div>
        </layout:tab>
        <layout:tab title="流程图">
            <div id="_drawflow_iframe" style="padding-top:0px;">
                <jsp:include page="/workflow/include/showdrawflowhistory.jsp" flush="true">
                    <jsp:param name="exampleid" value="${exampleid}"></jsp:param>
                </jsp:include>
                <%--<iframe width="100%" id="_drawflow_iframe" src="${contextPath}/workflow/include/showdrawflowhistory.jsp?exampleid=${exampleid}" scrolling="auto"></iframe>--%>
            </div>
        </layout:tab>
    </layout:tabs>

</sirm:body>
</html>