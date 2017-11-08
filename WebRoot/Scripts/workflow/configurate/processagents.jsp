<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-16
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@ taglib prefix="org" uri="http://www.sinitek.com/sirm/org/tag" %>

<html>
<head>
    <title>代理人配置</title>
    <%
        try {
            List<Map> _processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
            pageContext.setAttribute("processtypelist", _processtypelist);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
    <script type="text/javascript">

        function changeprocessname(value) {
//            if (value == 0) value = -1;
            var params = {type: value};
            stk.call({
                className: 'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',
                method: 'changeprocess',
                param: params,
                callBack: function (result) {
                    var option = $("<option value='0'>所有此类流程</option>");
                    $("#processname").empty();
                    var select = $("#processname");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname').stk_val(0);

                    changeprocessstepname(0);
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
                    var option = $("<option value='0'>所有流程步骤</option>");
                    $("#processstepname").empty();
                    var select = $("#processstepname");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processstepname').stk_val(0);
                }
            });
        }


        function showaddagentwindow() {
            $("#addagentform").stk_reset();
            $("#addagentwindow").stk_show();

            $("#processtype").stk_val(0);
            changeprocessname(0);
            $("#processname").stk_val(0);
            changeprocessstepname(0);
            $("#processstepname").stk_val(0);
            $("#starttime").stk_val("");
            $("#endtime").stk_val("");
            _user_updateValue('agent', []);
        }

        function showsaveagentwindow(map) {
            $("#saveagentform").stk_reset();
            $("#saveagentwindow").stk_show();

            $("#saveagentformid").stk_val(map.objid);
            $("#processtypevalue2").stk_text(map.processtypevalue);
            $("#processtype2").stk_val(map.processtype);
            $("#processname2").stk_text(map.processname);
            $("#processid2").stk_val(map.processid);
            $("#stepname2").stk_text(map.stepname);
            $("#stepid2").stk_val(map.stepid);
            $("#starttime2").stk_val(map.starttime2);
            $("#endtime2").stk_val(map.endtime2);
            _user_updateValue('agent2', [map.agentsid]);
        }

        function saveprocessagent() {
            if ($("#addagentform").stk_checkForm()) {
                $("#addagentform").stk_submit("saveprocessagent", function (result) {
                    if (result != null) {
                        stk.alert(result);
                        return;
                    }
                    $('#addagentwindow').stk_hide();
                    $("#agentstable").stk_query();
                });
            }
        }
        function savestepagent() {
            if ($("#saveagentform").stk_checkForm()) {
                $("#saveagentform").stk_submit("savestepagent", function (result) {
                    if (result != null) {
                        stk.alert(result);
                        return;
                    }
                    $('#saveagentwindow').stk_hide();
                    $("#agentstable").stk_query();
                });
            }
        }

        function changeagentstatus(mark) {
            if (mark == 1) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认启用吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '1'}, function (result) {
                            stk.alert(result, "提示");
                            $("#agentstable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要启用的代理", "提示");
                }
            } else if (mark == 2) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认停用吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '2'}, function (result) {
                            stk.alert(result, "提示");
                            $("#agentstable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要停用的代理", "提示");
                }
            } else if (mark == 100) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '100'}, function (result) {
                            stk.alert(result, "提示");
                            $("#agentstable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的代理", "提示");
                }
            }
        }
    </script>
</head>
<sirm:body>

    <plugin:colLink text="编辑" id="buildstepagent" dataVar="data">
        showsaveagentwindow(data);
    </plugin:colLink>
    <plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"></plugin:colCheckbox>

    <ui:table id="agentstable" nowrap="true" actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessAgentsAction"
              pageSize="10">
        <layout:tableToolBar position="top">
            <ui:toolbarButton icon="ui-icon-plusthick" text="添加代理">
                <event:onclick>
                    showaddagentwindow();
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-minusthick" text="删除代理">
                <event:onclick>
                    changeagentstatus(100);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-check" text="启用代理">
                <event:onclick>
                    changeagentstatus(1);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-cancel" text="停用代理">
                <event:onclick>
                    changeagentstatus(2);
                </event:onclick>
            </ui:toolbarButton>
        </layout:tableToolBar>
        <ui:col plugin="checkBoxPlugin" width="4%" align="center"/>
        <ui:col property="processtypevalue" title="流程类型" width="100px" align="left" allowSort="false"></ui:col>
        <ui:col property="processname" title="流程名称" width="100px" allowTip="true" align="left"
                allowSort="false"></ui:col>
        <ui:col property="stepname" title="步骤名称" width="100px" allowTip="true" align="left" allowSort="false"></ui:col>
        <ui:col property="agentsname" title="代理人" width="80px" allowTip="true" align="left" allowSort="false"/>
        <ui:col property="starttime2" title="起始时间" width="50%" align="center" allowSort="false"></ui:col>
        <ui:col property="endtime2" title="结束时间" width="50%" align="center" allowSort="false"></ui:col>
        <ui:colCust property="status" method="getstatusname" title="状态" width="40px" allowSort="false"/>
        <ui:col plugin="buildstepagent" title="操作" width="60px" allowSort="false"></ui:col>
    </ui:table>

    <layout:window id="addagentwindow" layout="row" title="添加流程代理" width="320px">
        <ui:form id="addagentform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessAgentsAction"
                 method="saveprocessagent">
            <div style="width:320px">
                <div>
                    <table class="stk-form-ui-st1">
                        <tr>
                            <td class="hd" width="100px">流程类型</td>
                            <td class="bd" width="auto">
                                <ui:select id="processtype" name="processtype" list="#attr.processtypelist"
                                           listKey="key"
                                           listValue="value" width="120px"
                                           headerKey="0" headerValue="所有流程类型" defaultValue="0">
                                    <event:onchange valVar="value">
                                        changeprocessname(value);
                                    </event:onchange>
                                </ui:select>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">流程名称</td>
                            <td class="bd" width="auto" nowrap>
                                <ui:select id="processname" name="processname" listKey="key"
                                           listValue="value" width="120px"
                                           headerKey="0" headerValue="所有此类流程" defaultValue="0">
                                    <event:onchange valVar="value">
                                        changeprocessstepname(value);
                                    </event:onchange>
                                </ui:select>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">步骤名称</td>
                            <td class="bd" width="auto" nowrap>
                                <ui:select id="processstepname" name="processstepname" listKey="key"
                                           listValue="value" width="120px"
                                           headerKey="0" headerValue="所有流程步骤" defaultValue="0"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">开始时间<em>*</em></td>
                            <td class="bd" width="auto">
                                <ui:datefield id="starttime" name="starttime" type="date" endDate="endtime"
                                              width="90px"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">结束时间<em>*</em></td>
                            <td class="bd" width="auto">
                                <ui:datefield id="endtime" name="endtime" type="date" startDate="starttime"
                                              width="90px"/>
                            </td>
                        <tr>
                            <td class="hd" width="100px">代理人<em>*</em></td>
                            <td class="bd" width="auto">
                                <org:SelectOrg prefix="agent" multi="false" mode="user" width="120px"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="padding:10px 0 5px 110px">
                    <ui:button id="btaddstep" text="添加">
                        <event:onclick>
                            saveprocessagent();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#addagentwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </div>
            </div>
            <func:checkers>
                <func:checker target="starttime" allowBlank="false" blankText="请选择代理开始时间"/>
                <func:checker target="endtime" allowBlank="false" blankText="请选择代理结束时间"/>
                <func:checker target="_agent_candidateHidden" allowBlank="false" blankText="请选择代理人"/>
            </func:checkers>
        </ui:form>
    </layout:window>

    <layout:window id="saveagentwindow" layout="row" title="编辑流程代理" width="320px">
        <ui:form id="saveagentform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessAgentsAction"
                 method="savestepagent">
            <input type="hidden" id="saveagentformid" name="saveagentformid">

            <div style="width:320px">
                <div>
                    <table class="stk-form-ui-st1">
                        <tr>
                            <td class="hd" width="100px">流程类型</td>
                            <td class="bd" width="auto">
                                <ui:label id="processtypevalue2"></ui:label>
                                <input type="hidden" id="processtype2" name="processtype2">
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">流程名称</td>
                            <td class="bd" width="auto">
                                <ui:label id="processname2"></ui:label>
                                <input type="hidden" id="processid2" name="processid2">
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">步骤名称</td>
                            <td class="bd" width="auto">
                                <ui:label id="stepname2"></ui:label>
                                <input type="hidden" id="stepid2" name="stepid2">
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">开始时间<em>*</em></td>
                            <td class="bd" width="auto">
                                <ui:datefield id="starttime2" name="starttime2" type="date" endDate="endtime2"
                                              width="90px"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">结束时间<em>*</em></td>
                            <td class="bd" width="auto">
                                <ui:datefield id="endtime2" name="endtime2" type="date" startDate="starttime2"
                                              width="90px"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="100px">代理人<em>*</em></td>
                            <td class="bd" width="auto">
                                <org:SelectOrg prefix="agent2" multi="false" mode="user" width="120px"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="padding:10px 0 5px 120px">
                    <ui:button text="保存">
                        <event:onclick>
                            savestepagent();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#saveagentwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </div>
            </div>
            <func:checkers>
                <func:checker target="starttime2" allowBlank="false" blankText="请选择代理开始时间"/>
                <func:checker target="endtime2" allowBlank="false" blankText="请选择代理结束时间"/>
                <func:checker target="_agent2_candidateHidden" allowBlank="false" blankText="请选择代理人"/>
            </func:checkers>
        </ui:form>
    </layout:window>

</sirm:body>
</html>