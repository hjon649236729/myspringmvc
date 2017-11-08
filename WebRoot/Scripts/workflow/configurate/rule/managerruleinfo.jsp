<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-10-22
  Time: 下午2:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../include/workflowinclude.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ruleName").stk_checkInputContent(20);
            $("#info").stk_checkInputContent(1000);
        });

        function saveObject() {
            if($("#objectForm").stk_checkForm()){
                $("#objectForm").stk_submit("saveObject", function(result) {
                    if (result != null) {
                        stk.alert(result);
                        return;
                    }
                    $('#objectWindow').stk_hide();
                    $("#objectTable").stk_query();
                });
            }
        }

        function openWindow() {
            $("#ruleName").stk_val("");
            $("#ruleName").stk_checkerReset();
            $("#info").stk_val("");
            $("#info").stk_checkerReset();
            $("#objectWindow").stk_show();
        }

        function buildObject(ruleName, info) {
            $("#ruleName").stk_val(ruleName);
            $("#ruleName").stk_checkerReset();
            $("#info").stk_val(info);
            $("#info").stk_checkerReset();
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
                    stk.alert("请选中要删除的规则模板", "提示");
                }
            }
        }
    </script>
</head>
<sirm:body>
    <form id="searchForm" class="search-params-bar">
        <table width="100%">
            <tr>
                <td class="tit" width="60px"><label>模板名称</label></td>
                <td class="bd" width="110px">
                    <ui:textfield id="searchRuleName" name="searchRuleName" width="100px"/>
                </td>
                <td class="tit" width="60px"><label>规则信息</label></td>
                <td class="bd" width="110px">
                    <ui:textfield id="searchInfo" name="searchInfo" width="100px"/>
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

    <ui:table id="objectTable" nowrap="true" queryForm="searchForm" pageSize="10"
              actionClass="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleInfoAction">
        <plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"/>
        <layout:tableToolBar position="top">
            <ui:toolbarButton icon="ui-icon-plusthick" text="添加模板">
                <event:onclick>
                    openWindow();
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-minusthick" text="删除模板">
                <event:onclick>
                    changeStatus(0);
                </event:onclick>
            </ui:toolbarButton>
        </layout:tableToolBar>

        <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
        <ui:col property="rulename" title="模板名称" width="120px" align="left" allowTip="true" allowSort="false"/>
        <ui:colCust method="getRuleType" title="模板类型" width="120px" align="center" allowTip="true" allowSort="false"/>
        <ui:col property="info" title="规则信息" align="left" allowSort="false"/>
        <ui:colCust method="change" title="操作" width="100px"  allowSort="false"/>
    </ui:table>

    <layout:window id="objectWindow" layout="row" title="编辑规则模版" width="450px">
        <ui:form id="objectForm" clazz="com.sinitek.sirm.web.workflow.configurate.rule.ManagerRuleInfoAction" method="saveObject">
            <input type="hidden" id="objid" name="objid" value="">
            <table class="stk-form-ui-st1">
                <tr>
                    <td class="hd" width="80px">模板名称<em>*</em></td>
                    <td class="bd" width="auto">
                        <ui:textfield id="ruleName" name="ruleName" width="200px"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">模板类型</td>
                    <td class="bd" width="auto">
                        <input type="hidden" id="ruleType" name="ruleType" value="1">
                        <label>任务通过默认意见</label>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">规则信息</td>
                    <td class="bd" width="auto">
                        <ui:textarea id="info" name="info" rows="5" width="300px"/>
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
            <func:checkers>
                <func:checker target="ruleName" allowBlank="false" blankText="模板名称不能为空!"/>
            </func:checkers>
        </ui:form>
    </layout:window>
</sirm:body>
</html>