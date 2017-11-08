<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="com.sinitek.sirm.common.web.RequestContext" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-4-10
  Time: 上午9:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/framework/include/head.jsp" %>
<%
    String _empid = RequestContext.getCurrentUser().getOrgId();
    List<Map> myTaskList = WorkflowServiceFactory.getWorkflowSupportService().getHomePageTasks(_empid);
    pageContext.setAttribute("mytasklist", myTaskList);
%>
<script type="text/javascript">
    sirm.define('sirm.workflow.hpmanagetask', {
        dealtask:function (exampleownerid, actionurl, actionurl2, anow) {
            if (actionurl != null && actionurl.length > 0) {
//                $(document).stk_go(actionurl2, "处理任务", {keyWithoutParams:true});
                var params = {exampleownerid:exampleownerid};
                stk.call({className:'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',method:'judgetask',param:params,callBack:function(result) {
                    if (result == null) {
                        sirm.openTab(actionurl2, "处理任务", {keyWithoutParams:true}, function() {
//                    refresh(this);
                            refresh($(anow).parents('.J_drag_column.index-drag-box').find('b.common-bg-icon.refresh'));
//                    alert(this.parents.parents.('.J_drag_column.index-drag-box').find('b.common-bg-icon.refresh'));
//                    refresh(this.parents.parents.parents.parents.parents.parents.parents('.J_drag_column.index-drag-box').find('b.common-bg-icon.refresh'));
                        });
                    } else {
                        stk.alert(result, "提示");
                        refresh($(anow).parents('.J_drag_column.index-drag-box').find('b.common-bg-icon.refresh'));
                    }
                }
                });
            }
            else {
                stk.alert("该任务没有配置处理URL");
            }
        },
        showprocess:function (exampleid) {
            $(document).stk_go("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + exampleid, "流程详细列表", {keyWithoutParams:true});
//            $(document).stk_go("/workflow/applicate/showworkflow.action?exampleid=" + exampleid, "流程详细列表", {keyWithoutParams:true});
        }
    });
</script>

<ul class="rep-list-ul">
    <c:forEach items="${mytasklist}" var="mytask">
        <li>
            <p style="display:inline-block;padding-right:45px">
                    <%--<a href="javascript:void(0)" onclick="sirm.workflow.hpmanagetask.showprocess(${mytask.exampleid});">--%>
                    ${mytask.showmain}
                    <%--</a>--%>
            </p>
                <%--${mytask.showmain}--%>
                <%--<span class="name">--%>
            <span style="position:absolute;right:10px;top:3px;">
            <a href="javascript:void(0)"
               onclick="sirm.workflow.hpmanagetask.dealtask(${mytask.exampleownerid},'${mytask.actionurl}','${mytask.actionurl2}',this);">处理
            </a>
            </span>
        </li>
    </c:forEach>
</ul>