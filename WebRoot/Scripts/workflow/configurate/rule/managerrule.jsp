<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleInfoAction" %>
<%@ page import="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleAction" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-10-17
  Time: 下午1:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../include/workflowinclude.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function saveObject() {
//            if ($("#objectForm").stk_checkForm()) {
                $("#objectForm").stk_submit("saveObject", function (result) {
                    if (result != null) {
                        stk.alert(result);
                        return;
                    }
                    $('#objectWindow').stk_hide();
                    $("#objectTable").stk_query();
                });
//            }
        }

        function openWindow() {
            $("#objid").stk_val(0);
            $("#targetType").stk_val("");
            $("#processtype").stk_val(0);
            changeprocessname(0);
            $("#processname").stk_val(0);
            changeprocessstepname(0);
            $("#processstepname").stk_val(0);
            $("#processNameTr").hide();
            $("#stepNameTr").hide();
            $("#ruleId").stk_val(0);
            $("#objectWindow").stk_show();
        }

        function changeStatus(mark) {
            if (mark == 0) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认删除吗？", function() {
                        $("#checkBoxPlugin").stk_call({type:'0'}, function(result) {
                            stk.alert(result, "提示");
                            $("#objectTable").stk_query();
                        });
                    });
                } else {
                    stk.alert("请选中要删除的规则", "提示");
                }
            }
        }

        function changeTarget(value) {
            if (value == "ProcessType") {
                $("#processNameTr").hide();
                $("#stepNameTr").hide();
            } else if (value == "ProcessMain") {
                $("#processNameTr").show();
                changeprocessname($("#processtype").val());
                $("#stepNameTr").hide();
            } else if (value == "ProcessStep") {
                $("#processNameTr").show();
                changeprocessname($("#processtype").val());
                $("#stepNameTr").show();
                changeprocessstepname($("#processname").val());
            }
        }

        function changeprocessname(value) {
//            if (value == 0) value = -1;
            var params = {type: value};
            stk.call({
                className: 'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',
                method: 'changeprocess',
                param: params,
                callBack: function (result) {
//                    var option = $("<option value='0'>所有此类流程</option>");
                    $("#processname").empty();
                    var select = $("#processname");
//                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname').stk_val(0);
                    changeprocessstepname($('#processname').stk_val());
                }
            });
        }

        function changeprocessname2(value, processId, stepId) {
//            if (value == 0) value = -1;
            var params = {type: value};
            stk.call({
                className: 'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',
                method: 'changeprocess',
                param: params,
                callBack: function (result) {
//                    var option = $("<option value='0'>所有此类流程</option>");
                    $("#processname").empty();
                    var select = $("#processname");
//                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname').stk_val(processId);
                    changeprocessstepname(processId);
                    $('#processstepname').stk_val(stepId);
                }
            });
        }

        function changeprocessstepname(value) {
            if (value == 0) value = -1;
            var params = {processid: value};
            stk.call({
                className: 'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',
                method: 'changeprocessstep',
                param: params,
                callBack: function (result) {
//                    var option = $("<option value='0'>所有流程步骤</option>");
                    $("#processstepname").empty();
                    var select = $("#processstepname");
//                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processstepname').stk_val(0);
                }
            });
        }

        function managerRuleInfo() {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/rule/managerruleinfo.jsp"), "规则模板管理", {keyWithoutParams: true});
        }

        function buildObject(objid, targetType, processType, processName, stepName, ruleId) {
            $("#objid").stk_val(objid);
            $("#targetType").stk_val(targetType);
//            changeTarget(targetType);
            if (targetType == "ProcessType") {
                $("#processNameTr").hide();
                $("#stepNameTr").hide();
            } else if (targetType == "ProcessMain") {
                $("#processNameTr").show();
                $("#stepNameTr").hide();
            } else if (targetType == "ProcessStep") {
                $("#processNameTr").show();
                $("#stepNameTr").show();
            }
            $("#processtype").stk_val(processType);
//            alert(processType + "," + $("#processtype").stk_val())
//            changeprocessname(processType);
//            $("#processname").stk_val(processName);
//            changeprocessstepname(processName);
            changeprocessname2(processType, processName,stepName);
//            $("#stepname").stk_val(stepName);
            $("#ruleId").stk_val(ruleId);
            $("#objectWindow").stk_show();
        }
    </script>
</head>
<%
    List<Map<String, String>> targetTypeList = ManagerRuleAction.getTargetTypeList();
    pageContext.setAttribute("targetTypeList", targetTypeList);
    List<Map> processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
    pageContext.setAttribute("processtypelist", processtypelist);
    List<Map> ruleInfoList = ManagerRuleInfoAction.findRuleInfoList();
    pageContext.setAttribute("ruleInfoList", ruleInfoList);
%>
<sirm:body>
    <form id="searchForm" class="search-params-bar">
        <table width="100%">
            <tr>
                <td class="tit" width="60px"><label>目标类型</label></td>
                <td class="bd" width="110px">
                    <ui:select id="searchTargetType" name="searchTargetType" list="#attr.targetTypeList" listKey="key"
                               listValue="value" width="100px" headerKey="" headerValue=" " defaultValue=""/>
                </td>
                <%--<td class="tit" width="60px"><label>作用目标</label></td>--%>
                <%--<td class="bd" width="110px">--%>
                    <%--<ui:textfield id="searchTarget" name="searchTarget" width="100px"/>--%>
                <%--</td>--%>
                <td class="tit" width="60px"><label>使用规则</label></td>
                <td class="tit" width="210px">
                    <ui:select id="searchRuleId" name="searchRuleId" list="#attr.ruleInfoList"
                               listKey="objid" listValue="rulename" width="200px"  headerKey="" headerValue=" " defaultValue=""/>
                </td>
                <td class="tit">
                    <ui:button text="查询" icon="ui-icon-search">
                        <event:onclick>
                            $("#objectTable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
    </form>

    <ui:table id="objectTable" nowrap="true" queryForm="searchForm"
              actionClass="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleAction" pageSize="10">
        <plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"/>
        <layout:tableToolBar position="top">
            <ui:toolbarButton icon="ui-icon-plusthick" text="添加规则">
                <event:onclick>
                    openWindow();
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-minusthick" text="删除规则">
                <event:onclick>
                    changeStatus(0);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-check" text="规则模板管理">
                <event:onclick>
                    managerRuleInfo();
                </event:onclick>
            </ui:toolbarButton>
        </layout:tableToolBar>

        <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
        <ui:colCust method="getTargetType" property="targettype" title="目标类型" width="120px" align="center" allowTip="true" allowSort="false"/>
        <ui:colCust method="getTarget" property="targetid" title="作用目标" align="left" allowTip="true" allowSort="false"/>
        <ui:col property="rulename" title="使用规则" align="left" allowSort="false"/>
        <ui:colCust method="change" title="操作" width="100px"  allowSort="false"/>
    </ui:table>

    <layout:window id="objectWindow" layout="row" title="添加规则" width="450px">
        <ui:form id="objectForm" clazz="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleAction"
           method="saveObject">
            <input type="hidden" id="objid" name="objid" value="">
            <table class="stk-form-ui-st1">
                <tr>
                    <td class="hd" width="80px">目标类型</td>
                    <td class="bd" width="auto">
                        <ui:select id="targetType" name="targetType" list="#attr.targetTypeList"
                                   listKey="key" listValue="value" width="200px">
                            <event:onchange valVar="value">
                                changeTarget(value);
                            </event:onchange>
                        </ui:select>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">作用目标</td>
                    <td class="bd" width="auto">
                        <table class="stk-form-ui-st1">
                            <tr>
                                <td class="bd">
                                    <ui:select id="processtype" name="processtype" list="#attr.processtypelist"
                                               listKey="key" listValue="value" width="120px"
                                               headerKey="0" headerValue="所有流程类型" defaultValue="0">
                                        <event:onchange valVar="value">
                                            changeprocessname(value);
                                        </event:onchange>
                                    </ui:select>
                                </td>
                            </tr>
                            <tr id="processNameTr">
                                <td class="bd">
                                    <ui:select id="processname" name="processname" listKey="key"
                                               listValue="value" width="120px"
                                               headerKey="0" headerValue="所有此类流程" defaultValue="0">
                                        <event:onchange valVar="value">
                                            changeprocessstepname(value);
                                        </event:onchange>
                                    </ui:select>
                                </td>
                            </tr>
                            <tr id="stepNameTr">
                                <td class="bd">
                                    <ui:select id="processstepname" name="processstepname" listKey="key"
                                               listValue="value" width="120px"
                                               headerKey="0" headerValue="所有流程步骤" defaultValue="0"/>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="targetId" name="targetId"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">使用规则</td>
                    <td class="bd" width="auto">
                        <ui:select id="ruleId" name="ruleId" list="#attr.ruleInfoList"
                                   listKey="objid" listValue="rulename" width="200px"/>
                    </td>
                </tr>
            </table>

            <layout:boxcell width="400px" align="center">
                <ui:button id="fntbtn" text="新建">
                    <event:onclick>
                        saveObject();
                    </event:onclick>
                </ui:button>&nbsp;
                <ui:button text="关闭">
                    <event:onclick>
                        $('#objectWindow').stk_hide();
                    </event:onclick>
                </ui:button>
            </layout:boxcell>
        </ui:form>
    </layout:window>

</sirm:body>
</html>