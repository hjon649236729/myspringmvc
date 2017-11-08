<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-4-27
  Time: 上午9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
<title>Simple jsp page</title>
<script type="text/javascript">
function loadbody() {
    $("#parameterurltable").stk_query();
    $("#parameteriftypetable").stk_query();
    $("#parametertasktable").stk_query();
    $("#parameterdealertable").stk_query();
    $("#parameterdealtable").stk_query();
    $("#parameterstagetable").stk_query();
    $("#parameternormaltable").stk_query();
}

function addprocessurlwindow(type) {
    var title = "添加URL模板";
    var text = "新建";
    $("#processurlid").val(0);
    $("#name").stk_val("");
    $("#processtype").stk_val("1");
    $("#actionurl").stk_val("");
    $("#showurl").stk_val("");
    $("#sort").stk_val("");
    $("#processurlbtn").stk_text(text);
    $("#processurlwindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterUrlAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort").stk_val(result + 1);
        }
    });
}

function editprocessurl(processurlid, name, processtype, sort, actionurl, showurl, viewurl) {
    var title = "编辑URL模板";
    var text = "保存";
    $("#processurlid").val(processurlid);
    $("#name").stk_val(name);
    $("#processtype").stk_val(processtype);
    $("#sort").stk_val(sort);
    $("#actionurl").stk_val("");
    $("#actionurl").stk_val(actionurl);
    $("#showurl").stk_val("");
    $("#showurl").stk_val(showurl);
    $("#viewurl").stk_val("");
    $("#viewurl").stk_val(viewurl);
    $("#processurlbtn").stk_text(text);
    $("#processurlwindow").stk_show({title: title});
}

function saveprocessurl() {
    $("#processurlform").stk_submit("saveprocessurl", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#processurlwindow').stk_hide();
        $("#parameterurltable").stk_query();
    });
}

function addlinkiftypewindow() {
    var title = "添加条件模板";
    var text = "新建";
    $("#processlistid2").val(0);
    $("#name2").stk_val("");
    $("#processtype2").stk_val("");
    $("#valueads2").stk_val("");
    $("#sort2").stk_val("");
    $("#linkiftypebtn").stk_text(text);
    $("#linkiftypewindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterIftypeAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort2").stk_val(result + 1);
        }
    });
}

function editlinkiftype(objid, name, processtype, sort, valueads) {
    var title = "编辑条件模板";
    var text = "保存";
    $("#processlistid2").val(objid);
    $("#name2").stk_val(name);
    $("#processtype2").stk_val(processtype);
    $("#sort2").stk_val(sort);
    $("#valueads2").stk_val("");
    $("#valueads2").stk_val(valueads);
    $("#linkiftypebtn").stk_text(text);
    $("#linkiftypewindow").stk_show({title: title});
}

function savelinkiftype() {
    $("#linkiftypeform").stk_submit("savelinkiftype", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#linkiftypewindow').stk_hide();
        $("#parameteriftypetable").stk_query();
    })
}

function addspecialtaskwindow() {
    var title = "添加执行模板";
    var text = "新建";
    $("#processlistid3").val(0);
    $("#name3").stk_val("");
    $("#processtype3").stk_val("");
    $("#valueads3").stk_val("");
    $("#sort3").stk_val("");
    $("#specialtaskbtn").stk_text(text);
    $("#specialtaskwindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterTaskAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort3").stk_val(result + 1);
        }
    });
}

function editspecialtask(objid, name, processtype, sort, valueads) {
    var title = "编辑执行模板";
    var text = "保存";
    $("#processlistid3").val(objid);
    $("#name3").stk_val(name);
    $("#processtype3").stk_val(processtype);
    $("#sort3").stk_val(sort);
    $("#valueads3").stk_val("");
    $("#valueads3").stk_val(valueads);
    $("#specialtaskbtn").stk_text(text);
    $("#specialtaskwindow").stk_show({title: title});
}

function savespecialtask() {
    $("#specialtaskform").stk_submit("savespecialtask", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#specialtaskwindow').stk_hide();
        $("#parametertasktable").stk_query();
    })
}

function addstepdealerwindow() {
    var title = "添加处理人模板";
    var text = "新建";
    $("#processlistid4").val(0);
    $("#name4").stk_val("");
    $("#processtype4").stk_val("");
    $("#valueads4").stk_val("");
    $("#sort4").stk_val("");
    $("#stepdealerbtn").stk_text(text);
    $("#stepdealerwindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealerAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort4").stk_val(result + 1);
        }
    });
}

function editstepdealer(objid, name, processtype, sort, valueads) {
    var title = "编辑处理人模板";
    var text = "保存";
    $("#processlistid4").val(objid);
    $("#name4").stk_val(name);
    $("#processtype4").stk_val(processtype);
    $("#sort4").stk_val(sort);
    $("#valueads4").stk_val("");
    $("#valueads4").stk_val(valueads);
    $("#stepdealerbtn").stk_text(text);
    $("#stepdealerwindow").stk_show({title: title});
}

function savestepdealer() {
    $("#stepdealerform").stk_submit("savestepdealer", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#stepdealerwindow').stk_hide();
        $("#parameterdealertable").stk_query();
    })
}

function addresultdealwindow() {
    var title = "添加审批模板";
    var text = "新建";
    $("#processlistid10").val(0);
    $("#name10").stk_val("");
    $("#processtype10").stk_val("");
    $("#valueads10").stk_val("");
    $("#sort10").stk_val("");
    $("#resultdealbtn").stk_text(text);
    $("#resultdealwindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort10").stk_val(result + 1);
        }
    });
}

function editresultdeal(objid, name, processtype, sort, valueads) {
    var title = "编辑审批模板";
    var text = "保存";
    $("#processlistid10").val(objid);
    $("#name10").stk_val(name);
    $("#processtype10").stk_val(processtype);
    $("#sort10").stk_val(sort);
    $("#valueads10").stk_val("");
    $("#valueads10").stk_val(valueads);
    $("#resultdealbtn").stk_text(text);
    $("#resultdealwindow").stk_show({title: title});
}

function saveresultdeal() {
    $("#resultdealform").stk_submit("saveresultdeal", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#resultdealwindow').stk_hide();
        $("#parameterdealtable").stk_query();
    })
}

function addstepstagewindow() {
    var title = "添加阶段模板";
    var text = "新建";
    $("#processlistid50").val(0);
    $("#name50").stk_val("");
    $("#key50").stk_val("");
    $("#processtype50").stk_val("");
    $("#valueads50").stk_val("");
    $("#sort50").stk_val("");
    $("#stepstagebtn").stk_text(text);
    $("#stepstagewindow").stk_show({title: title});

    stk.call({
        className: "com.sinitek.sirm.web.workflow.configurate.ProcessParameterStageAction",
        method: 'getMaxSort',
        callBack: function (result) {
            $("#sort50").stk_val(result + 1);
        }
    });
}

function editstepstage(objid, name, processtype, sort, valueads, key) {
    var title = "编辑阶段模板";
    var text = "保存";
    $("#processlistid50").val(objid);
    $("#name50").stk_val(name);
    $("#key50").stk_val(key);
    $("#processtype50").stk_val(processtype);
    $("#sort50").stk_val(sort);
    $("#valueads50").stk_val("");
    $("#valueads50").stk_val(valueads);
    $("#stepstagebtn").stk_text(text);
    $("#stepstagewindow").stk_show({title: title});
}

function savestepstage() {
    $("#stepstageform").stk_submit("savestepstage", function (result) {
        if (result != null) {
            stk.alert(result);
            return;
        }
        $('#stepstagewindow').stk_hide();
        $("#parameterstagetable").stk_query();
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
function addProcessTypeWindow() {
    var title = "添加类型";
    var params = {type: 0};
    stk.call({className: 'com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction', method: 'changeaction', param: params, callBack: function (result) {
        $("#valueads_1").empty();
        var select = $("#valueads_1");
        var option = $("<option value='0'>不使用执行</option>");
        option.appendTo(select);
        if (result != null) {
            var option2 = $(result);
            option2.appendTo(select);
        }
        $('#processlistid_1').stk_val(0);
        $('#value_1').stk_val("");
        $('#valueads_1').stk_val(0);
        $('#key_1').stk_val("");
        $('#sort_1').stk_val("");
        $('#processtypewindow').stk_show({title: title});
    }
    });
}
function buildprocesstype(key, objid, value, valueads, sort) {
    var title = "编辑类型";
    var params = {type: key};
    stk.call({className: 'com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction', method: 'changeaction', param: params, callBack: function (result) {
        $("#valueads_1").empty();
        var select = $("#valueads_1");
        var option = $("<option value='0'>不使用执行</option>");
        option.appendTo(select);
        if (result != null) {
            var option2 = $(result);
            option2.appendTo(select);
        }
        $('#processlistid_1').stk_val(objid);
        $('#value_1').stk_val(value);
        $('#valueads_1').stk_val(0);
        $('#valueads_1').stk_val(valueads);
        $('#key_1').stk_val(key);
        $('#sort_1').stk_val(sort);
        $('#processtypewindow').stk_show({title: title});
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
        $("#processTypeTable").stk_query();
    })
}
$(document).ready(function () {
    loadbody();

    $("#searchurlname").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchurlname").stk_text())) {
            queryurl();
        }
    });

    $("#searchlinkifname").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchlinkifname").stk_text())) {
            querylinkif();
        }
    });

    $("#searchtaskname").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchtaskname").stk_text())) {
            querytask();
        }
    });

    $("#searchdealername").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchdealername").stk_text())) {
            querydealer();
        }
    });

    $("#searchdealname").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchdealname").stk_text())) {
            querydeal();
        }
    });

    $("#searchstagename").bind("input propertychange", function (event) {
        if (StringUtils.isBlank($("#searchstagename").stk_text())) {
            querystage();
        }
    });
});

function queryurl() {
    $("#parameterurltable").stk_query();
}
function querylinkif() {
    $("#parameteriftypetable").stk_query();
}
function querytask() {
    $("#parametertasktable").stk_query();
}
function querydealer() {
    $("#parameterdealertable").stk_query();
}
function querydeal() {
    $("#parameterdealtable").stk_query();
}
function querystage() {
    $("#parameterstagetable").stk_query();
}
</script>
</head>
<%--<body onload="javascript:loadbody()">--%>
<sirm:body>
<%
    try {
        List<Map> _processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
        pageContext.setAttribute("processtypelist", _processtypelist);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin2" name="check2" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin3" name="check3" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin4" name="check4" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin10" name="check10" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin50" name="check50" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<plugin:colCheckbox id="checkBoxPlugin100" name="check100" dataVar="data" checkedVar="checked">
</plugin:colCheckbox>
<layout:tabs id="parametertabs" width="100%" tabWidth="110px">
<layout:tab title="流程类型" id="processTypeTab">
    <form id="processTypeForm">
        <plugin:colLink id="buildProcessType" dataVar="data" text="编辑">
            buildprocesstype(data.key,data.objid,data.value,data.valueads,data.sort);
        </plugin:colLink>
        <ui:table id="processTypeTable" nowrap="true"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加类型">
                    <event:onclick>
                        addProcessTypeWindow();
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <ui:col property="value" title="类型名称" align="left" width="200px" allowSort="false"></ui:col>
            <ui:col property="key" title="KEY值" align="right" width="80px" allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="80px" allowSort="false"></ui:col>
            <ui:col property="valueadsvalue" title="流程状态改变后执行" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col plugin="buildProcessType" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="URL配置" id="processurltab">
    <form id="parameterurlform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>URL名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchurlname" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterUrlAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parameterurltable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchurlname_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parameterurltable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildprocessurl" dataVar="data" text="编辑">
            editprocessurl(data.objid,data.name,data.type,data.sort,data.actionurl,data.showurl,data.viewurl);
        </plugin:colLink>
        <ui:table id="parameterurltable" queryForm="parameterurlform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterUrlAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加URL">
                    <event:onclick>
                        addprocessurlwindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除URL">
                    <event:onclick>
                        deleteparameter(1);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
            <ui:col property="name" title="URL名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="actionurl" title="处理URL" align="left" allowTip="true" width="50%"
                    allowSort="false"></ui:col>
            <ui:col property="showurl" title="查看URL" align="left" allowTip="true" width="50%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildprocessurl" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="条件配置" id="linkiftypetab">
    <form id="parameteriftypeform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>条件名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchlinkifname" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterIftypeAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parameteriftypetable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchlinkifname_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parameteriftypetable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildlinkiftype" dataVar="data" text="编辑">
            editlinkiftype(data.objid,data.value,data.type,data.sort,data.valueads);
        </plugin:colLink>
        <ui:table id="parameteriftypetable" queryForm="parameteriftypeform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterIftypeAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加条件">
                    <event:onclick>
                        addlinkiftypewindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除条件">
                    <event:onclick>
                        deleteparameter(2);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <%--pl.key,pl.value,pl.objid,pl.type,pl.sort,pl.valueads,pl1.value as typevalue--%>
            <ui:col plugin="checkBoxPlugin2" width="20px" align="center"/>
            <ui:col property="value" title="条件名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="条件实现类名" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildlinkiftype" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="执行配置" id="specialtasktab">
    <form id="parametertaskform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>执行名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchtaskname" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterTaskAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parametertasktable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchtaskname_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parametertasktable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildspecialtask" dataVar="data" text="编辑">
            editspecialtask(data.objid,data.value,data.type,data.sort,data.valueads);
        </plugin:colLink>
        <ui:table id="parametertasktable" queryForm="parametertaskform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterTaskAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加执行">
                    <event:onclick>
                        addspecialtaskwindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除执行">
                    <event:onclick>
                        deleteparameter(3);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <%--pl.key,pl.value,pl.objid,pl.type,pl.sort,pl.valueads,pl1.value as typevalue--%>
            <ui:col plugin="checkBoxPlugin3" width="20px" align="center"/>
            <ui:col property="value" title="执行名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="执行实现类名" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildspecialtask" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="处理人配置" id="stepdealertab">
    <form id="parameterdealerform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>处理人名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchdealername" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealerAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parameterdealertable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchdealername_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parameterdealertable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildstepdealer" dataVar="data" text="编辑">
            editstepdealer(data.objid,data.value,data.type,data.sort,data.valueads);
        </plugin:colLink>
        <ui:table id="parameterdealertable" queryForm="parameterdealerform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealerAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加处理人">
                    <event:onclick>
                        addstepdealerwindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除处理人">
                    <event:onclick>
                        deleteparameter(4);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <%--pl.key,pl.value,pl.objid,pl.type,pl.sort,pl.valueads,pl1.value as typevalue--%>
            <ui:col plugin="checkBoxPlugin4" width="20px" align="center"/>
            <ui:col property="value" title="处理人名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="处理人实现类名" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildstepdealer" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="审批配置" id="resultdealtab">
    <form id="parameterdealform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>审批名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchdealname" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parameterdealtable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchdealname_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parameterdealtable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildresultdeal" dataVar="data" text="编辑">
            editresultdeal(data.objid,data.value,data.type,data.sort,data.valueads);
        </plugin:colLink>
        <ui:table id="parameterdealtable" queryForm="parameterdealform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加审批">
                    <event:onclick>
                        addresultdealwindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除审批">
                    <event:onclick>
                        deleteparameter(10);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <ui:col plugin="checkBoxPlugin10" width="20px" align="center"/>
            <ui:col property="value" title="审批名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="审批实现类名" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildresultdeal" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<layout:tab title="阶段配置" id="stepstagetab">
    <form id="parameterstageform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" nowrap="true"><ui:label>所属类型</ui:label></td>
                <td class="bd">
                    <ui:select name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value"
                               width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" nowrap="true"><ui:label>阶段名称</ui:label></td>
                <td class="bd">
                        <%--<ui:textfield name="searchname"></ui:textfield>--%>
                    <ui:autoComplete id="searchstagename" name="searchname"
                                     clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterStageAction"
                                     showOnFocus="false"
                                     emptyText="请输入名称或拼音首字母" icon="ui-icon-search"
                                     width="170px"
                                     selectWidth="180px">
                        <event:oniconclick>
                            $("#parameterstagetable").stk_query();
                        </event:oniconclick>
                    </ui:autoComplete>
                    <script type="text/javascript">
                        $("#searchstagename_icon").hide();
                    </script>
                </td>
                <td class="tit" nowrap="true"></td>
                <td>
                    <ui:button text="查询" icon="ui-icon-circle-zoomout">
                        <event:onclick>
                            $("#parameterstagetable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="buildstepstage" dataVar="data" text="编辑">
            editstepstage(data.objid,data.value,data.type,data.sort,data.valueads,data.key);
        </plugin:colLink>
        <ui:table id="parameterstagetable" queryForm="parameterstageform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterStageAction" pageSize="10">
            <layout:tableToolBar position="top">
                <ui:toolbarButton icon="ui-icon-plusthick" text="添加阶段">
                    <event:onclick>
                        addstepstagewindow();
                    </event:onclick>
                </ui:toolbarButton>
                <ui:toolbarButton icon="ui-icon-minusthick" text="删除阶段">
                    <event:onclick>
                        deleteparameter(50);
                    </event:onclick>
                </ui:toolbarButton>
            </layout:tableToolBar>
            <ui:col plugin="checkBoxPlugin50" width="20px" align="center"/>
            <ui:col property="value" title="阶段名称" allowTip="true" align="left" width="150px" allowSort="false"/>
            <ui:col property="key" title="阶段值" align="right" width="50px" allowSort="false"/>
            <ui:col property="typevalue" title="所属类型" align="left" width="100px" allowSort="false"></ui:col>
            <ui:col property="valueads" title="阶段标志" align="left" allowTip="true" width="100%"
                    allowSort="false"></ui:col>
            <ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>
            <ui:col plugin="buildstepstage" title="操作" width="80px" allowSort="false"></ui:col>
        </ui:table>
    </form>
</layout:tab>
<%--<layout:tab title="常规参数配置" id="paramnormaltab">--%>
<%--<form id="parameternormalform">--%>
<%--<B>流程核心数据，非专业人员，严禁改动。</B>--%>
<%--<plugin:colLink id="buildparamnormal" dataVar="data" text="编辑">--%>
<%--editparamnormal(data.objid,data.name,data.value,data.key,data.status,data.valueads,data.sort);--%>
<%--</plugin:colLink>--%>
<%--<ui:table id="parameternormaltable" queryForm="parameternormalform" nowrap="true" allowInit="false"--%>
<%--actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessParameterNormalAction" pageSize="10">--%>
<%--<layout:tableToolBar position="top">--%>
<%--<ui:toolbarButton icon="ui-icon-plusthick" text="添加参数">--%>
<%--<event:onclick>--%>
<%--addparamnormalwindow();--%>
<%--</event:onclick>--%>
<%--</ui:toolbarButton>--%>
<%--<ui:toolbarButton icon="ui-icon-minusthick" text="删除参数">--%>
<%--<event:onclick>--%>
<%--deleteparameter(100);--%>
<%--</event:onclick>--%>
<%--</ui:toolbarButton>--%>
<%--</layout:tableToolBar>--%>
<%--<ui:col plugin="checkBoxPlugin100" width="20px" align="center"/>--%>
<%--<ui:col property="value" title="参数值" align="left" allowTip="true" width="150px" allowSort="false"></ui:col>--%>
<%--<ui:col property="name" title="参数名" align="left" width="120px" allowSort="false"></ui:col>--%>
<%--<ui:col property="key" title="参数键" align="right" width="60px" allowSort="false"/>--%>
<%--<ui:col property="status" title="参数状态" align="right" width="60px" allowSort="false"></ui:col>--%>
<%--<ui:col property="valueads" title="参数补充" align="lift" width="100%" allowSort="false"></ui:col>--%>
<%--<ui:col property="sort" title="顺序" align="right" width="50px" allowSort="false"></ui:col>--%>
<%--<ui:col plugin="buildparamnormal" title="操作" width="80px" allowSort="false"></ui:col>--%>
<%--</ui:table>--%>
<%--</form>--%>
<%--</layout:tab>--%>
</layout:tabs>

<layout:window id="processtypewindow" layout="row" title="添加类型" width="550px" height="240px">
    <ui:form id="processtypeform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTypeTableAction"
             method="saveprocesstype">
        <input type="hidden" id="processlistid_1" name="processlistid" value="">
        <table class="stk-form-ui-st1" border="0">
            <tr>
                <td class="hd" width="80px">类型名称</td>
                <td class="bd" width="auto"><ui:textfield id="value_1" name="value" width="200px"></ui:textfield></td>
            </tr>
            <tr>
                <td class="hd" width="80px">KEY值</td>
                <td class="bd" width="auto"><ui:textfield id="key_1" name="key" width="200px"></ui:textfield></td>
            </tr>
            <tr>
                <td class="hd" width="80px">顺序</td>
                <td class="bd" width="auto"><ui:textfield id="sort_1" name="sort" width="200px"></ui:textfield></td>
            </tr>
            <tr>
                <td class="hd" width="80px">改变后执行</td>
                <td class="bd" width="auto"><ui:select id="valueads_1" name="valueads" headerKey="0" headerValue="不使用执行"
                               list="#" listKey="key" listValue="value" width="180px"/></td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="320px">
                    <ui:button id="processtypebtn" text="保存">
                        <event:onclick>
                            saveprocesstype();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#processtypewindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
    </ui:form>
</layout:window>
<layout:window id="processurlwindow" layout="row" title="添加URL模版" width="550px" height="240px">
    <ui:form id="processurlform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterUrlAction"
             method="saveprocessurl">
        <input type="hidden" id="processurlid" name="processurlid" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">URL名称</td>
                <td><ui:textfield id="name" name="name" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype" name="processtype" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort" name="sort" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">处理URL</td>
                <td><ui:textfield id="actionurl" name="actionurl" width="400px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">查看URL</td>
                <td><ui:textfield id="showurl" name="showurl" width="400px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="processurlbtn" text="新建">
                        <event:onclick>
                            saveprocessurl();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#processurlwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name" allowBlank="false" blankText="URL名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<layout:window id="linkiftypewindow" layout="row" title="添加条件模版" width="550px" height="240px">
    <ui:form id="linkiftypeform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterIftypeAction"
             method="savelinkiftype">
        <input type="hidden" id="processlistid2" name="processlistid2" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">条件名称</td>
                <td><ui:textfield id="name2" name="name2" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype2" name="processtype2" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort2" name="sort2" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">实现类名</td>
                <td><ui:textarea rows="4" id="valueads2" name="valueads2" width="400px"></ui:textarea></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="linkiftypebtn" text="新建">
                        <event:onclick>
                            savelinkiftype();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#linkiftypewindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name2" allowBlank="false" blankText="条件名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<layout:window id="specialtaskwindow" layout="row" title="添加执行模版" width="550px" height="240px">
    <ui:form id="specialtaskform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterTaskAction"
             method="savespecialtask">
        <input type="hidden" id="processlistid3" name="processlistid3" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">执行名称</td>
                <td><ui:textfield id="name3" name="name3" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype3" name="processtype3" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort3" name="sort3" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">实现类名</td>
                <td><ui:textarea rows="4" id="valueads3" name="valueads3" width="400px"></ui:textarea></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="specialtaskbtn" text="新建">
                        <event:onclick>
                            savespecialtask();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#specialtaskwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name3" allowBlank="false" blankText="执行名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<layout:window id="stepdealerwindow" layout="row" title="添加处理人模版" width="550px" height="240px">
    <ui:form id="stepdealerform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealerAction"
             method="savestepdealer">
        <input type="hidden" id="processlistid4" name="processlistid4" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">处理人名称</td>
                <td><ui:textfield id="name4" name="name4" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype4" name="processtype4" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort4" name="sort4" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">实现类名</td>
                <td><ui:textarea rows="4" id="valueads4" name="valueads4" width="400px"></ui:textarea></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="stepdealerbtn" text="新建">
                        <event:onclick>
                            savestepdealer();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#stepdealerwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name4" allowBlank="false" blankText="处理人名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<layout:window id="resultdealwindow" layout="row" title="添加审批模版" width="550px" height="240px">
    <ui:form id="resultdealform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterDealAction"
             method="saveresultdeal">
        <input type="hidden" id="processlistid10" name="processlistid10" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">审批名称</td>
                <td><ui:textfield id="name10" name="name10" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype10" name="processtype10" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort10" name="sort10" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">实现类名</td>
                <td><ui:textarea rows="4" id="valueads10" name="valueads10" width="400px"></ui:textarea></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="resultdealbtn" text="新建">
                        <event:onclick>
                            saveresultdeal();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#resultdealwindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name10" allowBlank="false" blankText="审批名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<layout:window id="stepstagewindow" layout="row" title="添加阶段模版" width="550px" height="240px">
    <ui:form id="stepstageform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessParameterStageAction"
             method="savestepstage">
        <input type="hidden" id="processlistid50" name="processlistid50" value="">
        <table>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">阶段名称</td>
                <td><ui:textfield id="name50" name="name50" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">阶段键值</td>
                <td><ui:textfield id="key50" name="key50" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">流程类型</td>
                <td><ui:select id="processtype50" name="processtype50" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="180px"/></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">显示排序</td>
                <td><ui:textfield id="sort50" name="sort50" width="200px"></ui:textfield></td>
                <td>&nbsp;</td>
            </tr>
            <tr style="height:30px">
                <td width="100px" align="right" style="padding-right:5px;">阶段标志</td>
                <td><ui:textarea rows="3" id="valueads50" name="valueads50" width="400px"></ui:textarea></td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table>
            <tr style="height:50px">
                <td align="center" width="500px">
                    <ui:button id="stepstagebtn" text="新建">
                        <event:onclick>
                            savestepstage();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $('#stepstagewindow').stk_hide();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="name50" allowBlank="false" blankText="阶段名称不可以为空"/>
            <func:checker target="key50" allowBlank="false" blankText="阶段键值不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
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