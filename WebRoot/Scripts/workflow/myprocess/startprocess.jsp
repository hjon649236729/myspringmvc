<%@ page import="com.sinitek.sirm.busin.workflow.service.IWorkflowSupportService" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-14
  Time: 下午4:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%--<%@ taglib prefix="sirmwf" uri="http://www.sinitek.com/sirm/workflow/tag" %>--%>
<html>
<head><title>Simple jsp page</title>
    <%
        try {
            IWorkflowSupportService _worksup = WorkflowServiceFactory.getWorkflowSupportService();
            List<Map> _processlist = _worksup.getReleaseProcessList();
            pageContext.setAttribute("processlist", _processlist);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
    <script type="text/javascript">
        function document.onclick() {
            showSel(false)
        }
        function showSel(flag) {
            document.all.qswh.style.display = (flag ? "block" : "none")
            window.event.cancelBubble = true;
        }
        function selText(obj) {
            obj.value = (document.all.qswh.options[document.all.qswh.selectedIndex].text)
            //showSel(false)
        }
    </script>

</head>
<sirm:body>
    <ui:form id="startprocessform" clazz="com.sinitek.sirm.web.workflow.myprocess.StartProcessAction"
             method="processstart">
        <div style="padding-left:150px;padding-top:7px;">
            <table>
                <tr>
                    <td class="bd">流程ID*：</td>
                    <td style="padding-left:7px;">
                        <ui:select list="#attr.processlist" name="processid" id="processid" width="150px"
                                   listKey="processid" listValue="name">
                        </ui:select>
                            <%--<ui:textfield id="processid" name="processid" width="150px"></ui:textfield>--%>
                    </td>
                    <td class="bd">int变量名mainmap.processid</td>
                </tr>
                <tr>
                    <td class="bd">发起人ID*：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="starterid" name="starterid" width="150px"></ui:textfield>
                    </td>
                    <td class="bd">int变量名mainmap.starterid</td>
                </tr>
                <tr>
                    <td class="bd">发起人备注：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="starterads" name="starterads" width="150px"></ui:textfield>
                    </td>
                    <td class="bd">string变量名mainmap.starterads</td>
                </tr>
                <tr>
                    <td class="bd">流程描述：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="brief" name="brief" width="150px"></ui:textfield>
                    </td>
                    <td class="bd">string变量名mainmap.brief</td>
                </tr>
                <tr>
                    <td class="bd">实体类型：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="sourcename" name="sourcename" width="150px"></ui:textfield>
                    </td>
                    <td class="bd">string变量名entrylist.sourcename</td>
                </tr>
                <tr>
                    <td class="bd">实体ID：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="sourceid" name="sourceid" width="150px"></ui:textfield>
                    </td>
                    <td class="bd">int变量名entrylist.sourceid</td>
                </tr>
                <tr>
                    <td class="bd">变量一：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="paraname1" name="paraname1" width="150px"></ui:textfield>
                    </td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="paravalue1" name="paravalue1" width="150px"></ui:textfield>
                    </td>
                </tr>
                <tr>
                    <td class="bd">变量二：</td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="paraname2" name="paraname2" width="150px"></ui:textfield>
                    </td>
                    <td style="padding-left:7px;">
                        <ui:textfield id="paravalue2" name="paravalue2" width="150px"></ui:textfield>
                    </td>
                </tr>
                <tr>
                    <td class="bd">测试1</td>
                    <td>
                            <%--<input name=iData size=10><input type=button onclick="showSel(true)">--%>
                    </td>
                </tr>
            </table>
        </div>
        <%--    <div align="center" style="padding-top:15px;">
            <sirmwf:processlist var="myworkflow1" type="1"/>
            <ui:select list="#attr.myworkflow1"></ui:select>
        </div>--%>
        <%--<div style="padding-top:15px;">
            <jsp:include page="/workflow/include/workflowcandidate.jsp" flush="true">
                <jsp:param name="syscode" value="55"></jsp:param>
                <jsp:param name="width" value="100px"></jsp:param>
                <jsp:param name="cadidatename" value="mytestid"></jsp:param>
                <jsp:param name="title" value="审批人"></jsp:param>
            </jsp:include>
        </div>--%>
        <%--<div style="padding-top:15px;">
            <table class="stk-form-ui-st1">
                <tr>
                    <jsp:include page="/workflow/include/workflowcandidate.jsp" flush="true">
                        <jsp:param name="syscode" value="55"></jsp:param>
                        <jsp:param name="width" value="120px"></jsp:param>
                        <jsp:param name="cadidatename" value="mytestid2"></jsp:param>
                        <jsp:param name="title" value="候选人"></jsp:param>
                        <jsp:param name="format" value="1"></jsp:param>
                        <jsp:param name="tdwidth1" value="70px"></jsp:param>
                        <jsp:param name="tdcolspan1" value="1"></jsp:param>
                        <jsp:param name="tdwidth2" value="auto"></jsp:param>
                        <jsp:param name="tdcolspan2" value="3"></jsp:param>
                    </jsp:include>
                </tr>
            </table>
        </div>--%>
        <div align="center" style="padding-top:15px;">
            <ui:button id="btsavestep" text="开启流程">
                <event:onclick>
                    $("#startprocessform").stk_submit("processstart", function(result) {
                        if (result != null) {
                            stk.alert(result);
                            return;
                        }
                        stk.alert("流程发起成功");
                        return;
                    });
                </event:onclick>
            </ui:button>
            <ui:button id="bttest" text="测试功能">
                <event:onclick>
                    $("#startprocessform").stk_submit("processtest", function(result) {
                    if (result != null) {
                    stk.alert(result);
                    return;
                    }
                    return;
                    })
                </event:onclick>
            </ui:button>
        </div>

    </ui:form>

    <table>
        <tr>
            <td>
                <ui:textfield id="openurl" width="500px"></ui:textfield>
            </td>
        </tr>
        <tr>
            <td>
                <ui:button text="打开页面">
                    <event:onclick>
                        $(document).stk_go(sirm.jsurl($("#openurl").stk_val()),"打开页面",{keyWithoutParams:true});
                    </event:onclick>
                </ui:button>
            </td>
        </tr>
    </table>


</sirm:body>
</html>