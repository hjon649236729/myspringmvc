<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-7-23
  Time: 下午4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../include/workflowinclude.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#name").stk_checkInputContent(30);
            $("#processbrief").stk_checkInputContent(60);
        });
        function addtemplatewindow(type) {
            var title = "添加流程模板";
            var text = "新建";
            $("#processid").val(0);
            $("#name").val("");
            $("#name").stk_checkerReset();
//            $("#processcode").val("");
            $("#processbrief").val("");
            $("#processbrief").stk_checkerReset();
            $("#fntbtn").stk_text(text);
            $("#processtype").stk_show();
            $("#processtypevalue").stk_hide();
            $("#templatewindow").stk_show({title: title});
        }

        function showtemplatewindow(name, processcode, objid, processtype, processbrief) {
            var title = "修改流程模板";
            $("#processid").val(0);
            text = "修改";
            $("#name").val(name);
            $("#name").stk_checkerReset();
//            $("#processcode").val(processcode);
            $("#processid").val(objid);
            $("#processtype").val(processtype);
            $("#processbrief").val(processbrief);
            $("#processbrief").stk_checkerReset();
            $("#fntbtn").stk_text(text);
            $("#processtype").stk_hide();
            $("#processtypevalue").stk_text($("#processtype").stk_text());
            $("#processtypevalue").stk_show();
            $("#templatewindow").stk_show({title: title});
        }

        function savetemplate() {
            if ($("#name").val() == "" || $("#name").stk_val().trim() == "") {
                stk.alert("模板名称不可为空", "提示");
                return;
            }
//            if ($("#processcode").val() != "" && $("#processcode").stk_val().trim() == "") {
//                $("#processcode").val("");
//            }
            $("#templateform").stk_submit("savetemplate", function (result) {
                if (result != null) {
                    stk.alert(result);
                    return;
                }
                $("#name").val("");
                $('#templatewindow').stk_hide();
                $("#processtable").stk_query();
            });
        }

        function changestatus(mark) {
            if (mark == 0) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认删除吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '0'}, function (result) {
                            stk.alert(result, "提示");
                            $("#processtable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要删除的数据", "提示");
                }
            } else if (mark == 1) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("取消发布吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '1'}, function (result) {
                            stk.alert(result, "提示");
                            $("#processtable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要取消发布的流程", "提示");
                }
            } else if (mark == 2) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认发布吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '2'}, function (result) {
                            stk.alert(result, "提示");
                            $("#processtable").stk_query();
                        });
                    });
                }
                else {
                    stk.alert("请选中要发布的流程", "提示");
                }
            }
        }
        function buildtemplate(objid) {
//            $(document).stk_go(("claimstep.jsp?processid=" + objid), "流程详细配置", {keyWithoutParams: true});
            $(document).stk_go(sirm.jsurl("/workflow/configurate/claim/claimstep.jsp?processid=" + objid), "流程详细配置", {keyWithoutParams: true});
        }
        function showtemplate(objid) {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid + "&type=1"), "流程步骤查看", {keyWithoutParams: true});
        }
        function historytemplate(objid) {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/listprocesshistory.jsp?processid=" + objid), "流程历史列表", {keyWithoutParams: true});
        }
        function freshtemplate(objid) {
            $("#freshinfo").val(objid);
            $("#freshtype").val(1);
            $("#freshtemplateform").stk_submit("freshtemplate", function (result) {
                $("#processtable").stk_query()
            });
        }
        function exporttemplate(objid) {
            stk.confirm("确认要导出吗？", function () {
                window.location.href = sirm.jsurl("/workflow/configurate/exporttemplate.action?id=" + objid);
            });
        }
        function importtemplate() {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/importprocess.jsp"), "流程导入", {keyWithoutParams: true});
        }
    </script>
</head>
<%
    List<Map> _processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
    pageContext.setAttribute("processtypelist", _processtypelist);

    List<Map> _isprocess = new ArrayList<Map>();
    Map map1 = new HashMap();
    Map map2 = new HashMap();
    map1.put("key","2");
    map1.put("value","已发布");
    map2.put("key","1");
    map2.put("value","未发布");
    _isprocess.add(map1);
    _isprocess.add(map2);
    pageContext.setAttribute("searchprocesslist",_isprocess);
%>
<sirm:body>
    <form id="searchform">
        <input type="hidden" name="claimType" value="1">
        <table width="100%">
            <tr>
                <td class="tit" width="60px">
                    <label>&nbsp;流程类型</label>
                </td>
                <td class="bd" width="150px">
                    <ui:select id="searchtype" name="searchtype" list="#attr.processtypelist" listKey="key"
                               listValue="value" width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" width="60px">
                    <label>流程名称</label>
                </td>
                <td class="bd" width="120px">
                    <ui:textfield id="searchname" name="searchname" width="100px"/>
                </td>
                <td class="tit" width="60px">
                    <label>流程状态</label>
                </td>
                <td class="bd" width="150px">
                    <ui:select id="searchstatus" name="searchstatus" list="#attr.searchprocesslist" listKey="key"
                               listValue="value" width="70px"
                               headerKey="-1" headerValue="全部" defaultValue="-1"/>
                </td>
                <td class="bd">
                    <ui:button text="查询">
                        <event:onclick>
                            $("#processtable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
                <td>
                </td>
            </tr>
        </table>
    </form>
    <br/>

    <ui:table id="processtable" nowrap="true" queryForm="searchform"
              actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" pageSize="10">
        <plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"/>
        <layout:tableToolBar position="top">
            <ui:toolbarButton icon="ui-icon-plusthick" text="添加流程">
                <event:onclick>
                    addtemplatewindow(1);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-minusthick" text="删除流程">
                <event:onclick>
                    changestatus(0);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-check" text="发布流程">
                <event:onclick>
                    changestatus(2);
                </event:onclick>
            </ui:toolbarButton>
        </layout:tableToolBar>

        <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
        <ui:col property="name" title="流程名称" width="120px" align="left" allowTip="true" allowSort="false"/>
        <ui:col property="sysversion" title="版本号" width="40px" align="right" allowSort="false"/>
        <ui:col property="statusname" title="流程状态" width="60px" allowSort="false"/>
        <ui:col property="processtypename" title="流程类型" align="left" width="80px" allowSort="false"/>
        <ui:col property="processbrief" title="流程备注" align="left" width="100%" allowTip="true" allowSort="false"/>
        <ui:colCust method="changeprocess" title="操作" width="240px" allowSort="false"/>
    </ui:table>
    <layout:window id="templatewindow" layout="row" title="添加流程模版" width="450px" height="240px">
        <ui:form id="templateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction"
                 method="savetemplate">
            <input type="hidden" id="processid" name="processid" value="">
            <input type="hidden" name="spType" value="1">
            <table class="stk-form-ui-st1" border="0">
                <tr>
                    <td class="hd" width="80px">流程名称<em>*</em></td>
                    <td class="bd" width="auto">
                        <ui:textfield id="name" name="name" width="200px"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">流程类型</td>
                    <td class="bd" width="auto">
                        <ui:select id="processtype" name="processtype" list="#attr.processtypelist" listKey="key" listValue="value" width="100%"/>
                        <label id="processtypevalue" name="processtypevalue"></label>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">流程备注</td>
                    <td class="bd" width="auto">
                        <ui:textarea id="processbrief" name="processbrief" rows="3" width="200px"/>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td style="padding-top:4px;padding-left:200px;">
                        <ui:button id="fntbtn" text="新建">
                            <event:onclick>
                                savetemplate();
                            </event:onclick>
                        </ui:button>&nbsp;
                        <ui:button text="关闭">
                            <event:onclick>
                                $('#templatewindow').stk_hide();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
            <func:checkers>
                <func:checker target="name" allowBlank="false" blankText="流程名称不可以为空"/>
            </func:checkers>
        </ui:form>
    </layout:window>
    <ui:form id="freshtemplateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction"
             method="freshtemplate">
        <input type="hidden" id="freshinfo" name="freshinfo">
        <input type="hidden" id="freshtype" name="freshtype">
    </ui:form>
</sirm:body>
</html>