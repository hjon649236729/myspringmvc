<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="layout" uri="http://www.sinitek.com/spirit/taglib/layout" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-7
  Time: 下午5:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title>Simple jsp page</title>
    <%
        try {
            List<Map> _processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
            pageContext.setAttribute("processtypelist", _processtypelist);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
    <script type="text/javascript">
        function loadbody() {
            $("#unfinishtable").stk_query();
            $("#finishedtable").stk_query();
        }
        function showtask(showurl) {
            $(document).stk_go(showurl, "查看任务", {keyWithoutParams:true});
        }
        function changeprocessname(value, num) {
            var params = {type:value};
            stk.call({className:'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',method:'changeprocess',param:params,callBack:function(result) {
                var option = $("<option value='-1'>所有此类流程</option>");
                if (num == 1) {
                    $("#processname1").empty();
                    var select = $("#processname1");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname1').stk_val(-1);
                } else if (num == 2) {
                    $("#processname2").empty();
                    var select = $("#processname2");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname2').stk_val(-1);
                }
            }
            });
        }
        $(document).ready(function () {
            loadbody();
        });
    </script>
</head>
<sirm:body>
<layout:tabs id="demo" width="100%" tabWidth="110px">

<layout:tab title="我参与的工作流" id="finishedtab">
    <form id="finishedform">
        <plugin:colLink id="workflowmain1" dataVar="data">
            <%--$(document).stk_go("/workflow/applicate/showworkflow.action?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true}); --%>
            $(document).stk_go("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true,refresh:true});
        </plugin:colLink>
        <plugin:colLink id="condition1" dataVar="data" text="查看">
            if(data.showurl!=null&&data.showurl.length>0){
            $(document).stk_go(data.showurl2,"查看任务",{keyWithoutParams:true});
            }else{
            stk.alert("该任务没有配置查看URL");
            }
            <%--$(document).stk_go(data.showurl+"?exampleid=" + data.exampleid+"&examplestepid="+data.examplestepid+"&exampleownerid="+data.exampleownerid,"处理任务",{keyWithoutParams:true});--%>
        </plugin:colLink>
        <div class="search-params-bar">
            <table width="100%">
                <tr>
                    <td class="tit" width="200px;">
                        <label>流程类型</label>
                        <ui:select id="processtype2" name="processtype2" list="#attr.processtypelist" listKey="key"
                                   listValue="value" width="120px"   list="#{'-1':'所有此类流程'}"   defaultValue="-1">
                            <event:onchange valVar="value">
                                changeprocessname(value,2);
                            </event:onchange>
                        </ui:select>
                    </td>
                    <td class="tit" width="320px;">
                        <label>处理时间</label>
                        <ui:datefield id="starttime1" endDate="endtime1" name="starttime1" width="100px"/>
                        <label>至</label>
                        <ui:datefield id="endtime1" startDate="starttime1" name="endtime1" width="100px"/>
                    </td>
                    <td class="tit" width="170px;">
                        <label>流程描述</label>
                        <ui:textfield id="brief2" name="brief2" width="100px"/>
                    </td>
                    <td class="tit" width="60px;">
                        <ui:button text="查询">
                            <event:onclick>
                                $("#finishedtable").stk_query();
                            </event:onclick>
                        </ui:button>
                    </td>
                    <td class="tit"></td>
                </tr>
                <tr>
                    <td class="tit">
                        <label>流程名称</label>
                        <ui:select id="processname2" name="processname2" listKey="key" listValue="value"
                                   width="120px"   list="#{'-1':'所有此类流程'}"  defaultValue="-1"/>
                    </td>
                    <td class="tit">
                        <label>发起人</label>
                        <jsp:include page="/org/searchorg/searchuserinclude.jsp">
                            <jsp:param name="prefix" value="starter2"/>
                            <jsp:param name="showdiv" value="false"/>
                            <jsp:param name="relationDiv" value="indusryRelationDiv"/>
                            <jsp:param name="width" value="120px"/>
                        </jsp:include>
                        <ui:checkbox id="startertype2" name="startertype2" value="1">系统
                            <event:onclick checkedVar="value">
                                if(value==true){
                                $("#_starter2_searchUser").attr("disabled","true");
                                }else{
                                $("#_starter2_searchUser").removeAttr("disabled");
                                }
                            </event:onclick>
                        </ui:checkbox>
                    </td>
                    <td class="tit">
                    </td>
                    <td class="tit">
                    </td>
                    <td class="tit"></td>
                </tr>
            </table>
        </div>
        <ui:table id="finishedtable" queryForm="finishedform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.applicate.ManagerTaskTarkpartAction"
                  pageSize="10">
            <%--<ui:col property="processname" title="流程名称" align="left" width="120px" allowSort="false"></ui:col>--%>
            <ui:col property="processstepname" title="步骤名称" width="120px" align="left" allowTip="true"
                    allowSort="false"/>
            <%--<ui:col property="steptypevalue" title="步骤类型" width="60px" allowSort="false"></ui:col>--%>
            <%--<ui:col property="stepstatusvalue" title="步骤状态" width="60px" align="left" allowSort="false"></ui:col>--%>
            <%--<ui:col align="left" property="processbrief" title="描述" allowTip="true" allowSort="false"></ui:col>--%>
            <ui:col plugin="workflowmain1" align="left" property="processbrief" title="流程描述" allowTip="true"
                    allowSort="false"/>
            <%--<ui:col property="startername" title="发起人" align="left" width="60px" allowSort="false"></ui:col>--%>
            <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="60px"
                        allowSort="false"/>
            <ui:col property="processstatusvalue" title="流程状态" align="left" width="60px" allowSort="false"/>
            <%--<ui:col property="preownername" title="来源" align="left" width="80px" allowSort="false"></ui:col>--%>
            <%--<ui:colCust property="preownerid" method="getpreownername" align="left" title="来源" width="80px" allowSort="false"/>--%>
            <ui:colDate property="approvetime" title="处理时间" width="120px" format="yyyy-MM-dd HH:mm"
                        allowSort="false"/>
            <%--<ui:col plugin="condition1" title="操作" width="60px"></ui:col>--%>
            <ui:colCust method="changetask" title="操作" width="60px"/>
        </ui:table>
    </form>
</layout:tab>
<event:ontabselect tabVar="tab">
    if(tab.id=='unfinishtab'){
    $("#unfinishtable").stk_query();
    }else if(tab.id=='finishedtab'){
    $("#finishedtable").stk_query();
    }
</event:ontabselect>
</layout:tabs>
</sirm:body>
</html>