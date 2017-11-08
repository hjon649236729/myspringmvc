<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-1-16
  Time: 上午10:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程模板管理</title>
    <script type="text/javascript">
        function addtemplatewindow(type) {
            var title = "添加流程模板";
            var text = "新建";
            $("#processid").val(0);
            $("#name").val("");
            $("#processcode").val("");
            $("#processbrief").val("");
            $("#fntbtn").stk_text(text);
            $("#processtype").stk_show();
            $("#processtypevalue").stk_hide();
            $("#templatewindow").stk_show({title:title});
        }

        function showtemplatewindow(name,processcode,objid,processtype,processbrief) {
            var title = "修改流程模板";
            $("#processid").val(0);
            text = "修改";
            $("#name").val(name);
            $("#processcode").val(processcode);
            $("#processid").val(objid);
            $("#processtype").val(processtype);
            $("#processbrief").val(processbrief);
            $("#fntbtn").stk_text(text);
            $("#processtype").stk_hide();
            $("#processtypevalue").stk_val($("#processtype").stk_text());
            $("#processtypevalue").stk_show();
            $("#templatewindow").stk_show({title:title});
        }

        function savetemplate() {
            if ($("#name").val() == "" || $("#name").stk_val().trim()=="") {
                stk.alert("模板名称不可为空", "提示");
                return;
            }
            if($("#processcode").val() != ""&&$("#processcode").stk_val().trim()==""){
                $("#processcode").val("");
            }
            $("#templateform").stk_submit("savetemplate", function(result) {
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
                    stk.confirm("确认删除吗？", function() {
                        $("#checkBoxPlugin").stk_call({type:'0'}, function(result) {
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
                    stk.confirm("取消发布吗？", function() {
                        $("#checkBoxPlugin").stk_call({type:'1'}, function(result) {
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
                    stk.confirm("确认发布吗？", function() {
                        $("#checkBoxPlugin").stk_call({type:'2'}, function(result) {
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
        function buildtemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid),"流程步骤列表",{keyWithoutParams:true});
        }
        function showtemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid +"&type=1"),"流程步骤查看",{keyWithoutParams:true});
        }
        function historytemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/listprocesshistory.jsp?processid=" + objid),"流程历史列表",{keyWithoutParams:true});
        }
        function freshtemplate(objid){
            $("#freshinfo").val(objid);
            $("#freshtype").val(1);
            $("#freshtemplateform").stk_submit("freshtemplate", function(result) {
                $("#processtable").stk_query()
            });
        }
        function exporttemplate(objid){
            stk.confirm("确认要导出吗？", function() {
                window.location.href = sirm.jsurl("/workflow/configurate/exporttemplate.action?id=" + objid);
            });
        }
        function importtemplate(){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/importprocess.jsp"),"流程导入",{keyWithoutParams:true});
        }
    </script>
</head>
<sirm:body>
<%
    try {
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
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<plugin:colLink text="修改" id="changeprocessmain" dataVar="data">
    showtemplatewindow(2,data);
</plugin:colLink>
<plugin:colLink text="定义步骤" id="changeprocessstep" dataVar="data">
    $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + data.objid),"流程步骤列表",{keyWithoutParams:true});
</plugin:colLink>
<plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"/>

<%--查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询--%>
<form id="searchform">
<table width="100%">
    <tr>
        <td class="tit" width="60px">
            <label>&nbsp;流程类型</label>
        </td>
        <td class="bd" width="150px">
            <ui:select id="searchtype" name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value" width="120px"
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
            <ui:select id="searchstatus" name="searchstatus" list="#attr.searchprocesslist" listKey="key" listValue="value" width="70px"
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
            <%--<input type="file" id="uploadDataFile" class="stk-input" style=" height:20px;width:230px" name="uploadDataFile" contenteditable="false" title="选择模板">--%>
            <%--<div id="uploader"></div>--%>
        </td>
    </tr>
</table>
</form>
    <br/>



<ui:table id="processtable" nowrap="true" queryForm="searchform" actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" pageSize="10">
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
        <ui:toolbarButton icon="ui-icon-arrowreturnthick-1-s" text="导入流程">
            <event:onclick>
                importtemplate();
            </event:onclick>
        </ui:toolbarButton>
    </layout:tableToolBar>

    <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
    <ui:col property="name" title="流程名称" width="120px" align="left" allowTip="true" allowSort="false"/>
    <ui:col property="processcode" title="流程Code" width="120px" align="left" allowTip="true" allowSort="false"/>
    <ui:col property="sysversion" title="版本号" width="40px" align="right" allowSort="false"/>
    <ui:col property="statusname" title="流程状态" width="60px" allowSort="false"/>
    <ui:col property="processtypename" title="流程类型" align="left" width="80px" allowSort="false"/>
    <ui:col property="processbrief" title="流程备注" align="left" width="100%" allowTip="true" allowSort="false"/>
    <ui:colCust method="changeprocess" title="操作" width="240px"  allowSort="false"/>
    <%--<c:if test="${status eq 1)}">--%>
    <%--<ui:col plugin="changeprocessmain,changeprocessstep" title="操作" width="100px"/>--%>
    <%--</c:if>--%>
    <%--<c:if test="${(status eq 2)}">--%>
    <%--<ui:col plugin="changeprocessmain" title="操作" width="100px"/>--%>
    <%--</c:if>--%>
</ui:table>

<layout:window id="templatewindow" layout="row" title="添加流程模版" width="450px" height="180px">
    <ui:form id="templateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" method="savetemplate">
        <input type="hidden" id="processid" name="processid" value="">
        <layout:box layout="row" cellHeight="30px">
            <layout:boxcell label="流程名称" width="400px">
                <ui:textfield id="name" name="name" width="200px"/> &nbsp;30个汉字以内
            </layout:boxcell>
            <layout:boxcell label="流程Code" width="400px">
                <ui:textfield id="processcode" name="processcode" width="200px"/> &nbsp;
            </layout:boxcell>
            <layout:boxcell label="流程类型" width="270px">
                <ui:select id="processtype" name="processtype" list="#attr.processtypelist" listKey="key" listValue="value" width="100%"/>
                <input type="text" readonly="true" id="processtypevalue" name="processtypevalue" style="width:120px;"/>
            </layout:boxcell>
            <%--<layout:boxcell label="消息提醒" width="270px">--%>
                <%--<ui:select list="#attr.messagemap" id="messagetype" name="messagetype" headerKey="" width="100%" headerValue="无提醒"/>--%>
            <%--</layout:boxcell>--%>
            <layout:boxcell label="流程备注" width="400px">
                <ui:textarea id="processbrief" name="processbrief" rows="3" width="200px"/> &nbsp;
            </layout:boxcell>
            <layout:boxcell width="400px" align="center">
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
            </layout:boxcell>
        </layout:box>
        <func:checkers>
            <func:checker target="name" allowBlank="false" blankText="步骤名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
<ui:form id="freshtemplateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" method="freshtemplate">
    <input type="hidden" id="freshinfo" name="freshinfo">
    <input type="hidden" id="freshtype" name="freshtype">
</ui:form>
</sirm:body>
</html>