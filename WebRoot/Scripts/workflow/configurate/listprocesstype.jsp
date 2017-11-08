<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-5-22
  Time: 下午3:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程状态配置</title>
    <script type="text/javascript">
        function buildprocesstype(key, objid, value, valueads) {
            var params = {type: key};
            stk.call({className: 'com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction', method: 'changeaction', param: params, callBack: function (result) {
                $("#valueads").empty();
                var select = $("#valueads");
                var option = $("<option value='0'>不使用执行</option>");
                option.appendTo(select);
                if (result != null) {
                    var option2 = $(result);
                    option2.appendTo(select);
                }
                $('#processlistid').stk_val(objid);
                $('#value').stk_val(value);
                $('#valueads').stk_val(0);
                $('#valueads').stk_val(valueads);
                $('#processtypewindow').stk_show();
            }
            });
        }
        function saveprocesstype() {
            $("#processtypeform").stk_submit("saveprocesstype", function (result) {
                if (result != null) {
                    stk.alert(result);
                    return;
                }
                $('#processtypewindow').stk_hide();
                $("#processtypetable").stk_query();
            })
        }

        function addparamnormalwindow() {
            var title = "添加参数模板";
            var text = "新建";
            $("#processlistid100").val(0);
            $("#name100").stk_val("");
            $("#value100").stk_val("");
            $("#key100").stk_val("");
            $("#valueads100").stk_val("");
            $("#sort100").stk_val("");
            $("#status100").stk_val("");
            $("#paramnormalbtn").stk_text(text);
            $("#paramnormalwindow").stk_show({title: title});
        }

        function editparamnormal(objid, name, value, key, status, valueads, sort) {
            var title = "编辑参数模板";
            var text = "保存";
            $("#processlistid100").val(objid);
            $("#name100").stk_val(name);
            $("#value100").stk_val(value);
            $("#key100").stk_val(key);
            $("#status100").stk_val(status);
            $("#valueads100").stk_val(valueads);
            $("#sort100").stk_val(sort);
            $("#paramnormalbtn").stk_text(text);
            $("#paramnormalwindow").stk_show({title: title});
        }

        function saveparamnormal() {
            $("#paramnormalform").stk_submit("saveparamnormal", function (result) {
                if (result != null) {
                    stk.alert(result);
                    return;
                }
                $('#paramnormalwindow').stk_hide();
                $("#parameternormaltable").stk_query();
            })
        }

        function deleteparameter(mark) {
            if (mark == 1) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin").stk_call({mark: '1'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameterurltable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 2) {
                if ($("#checkBoxPlugin2").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin2").stk_call({mark: '2'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameteriftypetable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 3) {
                if ($("#checkBoxPlugin3").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin3").stk_call({mark: '3'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parametertasktable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 4) {
                if ($("#checkBoxPlugin4").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin4").stk_call({mark: '4'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameterdealertable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 10) {
                if ($("#checkBoxPlugin10").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin10").stk_call({mark: '10'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameterdealtable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 50) {
                if ($("#checkBoxPlugin50").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin50").stk_call({mark: '50'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameterstagetable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 100) {
                if ($("#checkBoxPlugin100").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin100").stk_call({mark: '100'}, function (result) {
                            stk.alert(result, "提示");
                            $("#parameternormaltable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            }
        }
    </script>
</head>
<sirm:body>
    <%--<plugin:colLink id="buildprocesstype" dataVar="data" text="编辑">--%>
    <%--buildprocesstype(data.key,data.objid,data.value,data.valueads);--%>
    <%--</plugin:colLink>--%>
    <%--<ui:table id="processtypetable" nowrap="true" actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction" pageSize="10">--%>
    <%--<ui:col property="value" title="流程类型名称" align="left" width="200px" allowSort="false"></ui:col>--%>
    <%--<ui:col property="valueadsvalue" title="流程状态改变后执行" align="left" allowTip="true" width="100%" allowSort="false"></ui:col>--%>
    <%--<ui:col plugin="buildprocesstype" title="操作" width="80px" allowSort="false"></ui:col>--%>
    <%--</ui:table>--%>
    <form id="parameternormalform">
        <B>流程核心数据，非专业人员，严禁改动。</B>
        <plugin:colLink id="buildparamnormal" dataVar="data" text="编辑">
            editparamnormal(data.objid,data.name,data.value,data.key,data.status,data.valueads,data.sort);
        </plugin:colLink>
        <plugin:colCheckbox id="checkBoxPlugin100" name="check100" dataVar="data" checkedVar="checked">
        </plugin:colCheckbox>
        <ui:table id="parameternormaltable" queryForm="parameternormalform" nowrap="true" allowInit="true"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterNormalAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加参数">
                    <event:onclick>
                        addparamnormalwindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除参数">
                    <event:onclick>
                        deleteparameter(100);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <ui:col plugin="checkBoxPlugin100" width="20px" align="center"/>
            <ui:col property="value" title="参数值" align="left" allowTip="true" width="150px" allowSort="false"></ui:col>
            <ui:col property="name" title="参数名" align="left" width="120px" allowSort="false"></ui:col>
            <ui:col property="key" title="参数键" align="right" width="60px" allowSort="false"/>
            <ui:col property="status" title="参数状态" align="right" width="60px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="参数补充" align="lift" width="100%" allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildparamnormal" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
    <%--<layout:window id="processtypewindow" layout="row" title="编辑类型配置" width="320px" height="120px">--%>
    <%--<ui:form id="processtypeform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction" method="saveprocesstype">--%>
    <%--<input type="hidden" id="processlistid" name="processlistid" value="">--%>
    <%--<table>--%>
    <%--<tr style="height:30px">--%>
    <%--<td width="80px" align="right" style="padding-right:5px;">类型名称</td>--%>
    <%--<td><ui:textfield id="value" name="value" width="200px"></ui:textfield></td>--%>
    <%--<td>&nbsp;</td>--%>
    <%--</tr>--%>
    <%--<tr style="height:30px">--%>
    <%--<td width="80px" align="right" style="padding-right:5px;">类型执行</td>--%>
    <%--<td><ui:select id="valueads" name="valueads" headerKey="0" headerValue="不使用执行"--%>
    <%--list="#" listKey="key" listValue="value" width="180px"/></td>--%>
    <%--<td>&nbsp;</td>--%>
    <%--</tr>--%>
    <%--</table>--%>
    <%--<table>--%>
    <%--<tr style="height:50px">--%>
    <%--<td align="center" width="320px">--%>
    <%--<ui:button id="processtypebtn" text="保存">--%>
    <%--<event:onclick>--%>
    <%--saveprocesstype();--%>
    <%--</event:onclick>--%>
    <%--</ui:button>&nbsp;--%>
    <%--<ui:button text="关闭">--%>
    <%--<event:onclick>--%>
    <%--$('#processtypewindow').stk_hide();--%>
    <%--</event:onclick>--%>
    <%--</ui:button>--%>
    <%--</td>--%>
    <%--</tr>--%>
    <%--</table>--%>
    <%--</ui:form>--%>
    <%--</layout:window>--%>
    <layout:window id="paramnormalwindow" layout="row" title="添加参数模版" width="550px" height="280px">
        <ui:form id="paramnormalform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterNormalAction"
                 method="saveparamnormal">
            <input type="hidden" id="processlistid100" name="processlistid100" value="">
            <table>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">参数值</td>
                    <td><ui:textfield id="value100" name="value100" width="200px"></ui:textfield></td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">参数名</td>
                    <td><ui:textfield id="name100" name="name100" width="200px"></ui:textfield></td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">参数键</td>
                    <td><ui:textfield id="key100" name="key100" width="200px"></ui:textfield></td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">参数状态</td>
                    <td><ui:textfield id="status100" name="status100" width="200px"></ui:textfield></td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                    <td><ui:textfield id="sort100" name="sort100" width="200px"></ui:textfield></td>
                    <td>&nbsp;</td>
                </tr>
                <tr style="height:30px">
                    <td width="100px" align="right" style="padding-right:5px;">参数补充</td>
                    <td><ui:textarea rows="4" id="valueads100" name="valueads100" width="400px"></ui:textarea></td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <table>
                <tr style="height:50px">
                    <td align="center" width="500px">
                        <ui:button id="paramnormalbtn" text="新建">
                            <event:onclick>
                                saveparamnormal();
                            </event:onclick>
                        </ui:button>&nbsp;
                        <ui:button text="关闭">
                            <event:onclick>
                                $('#paramnormalwindow').stk_hide();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
            <func:checkers>
                <func:checker target="name100" allowBlank="false" blankText="参数名称不可以为空"/>
            </func:checkers>
        </ui:form>
    </layout:window>
</sirm:body>
</html>