<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: HF.fay
  Date: 14-5-6
  Time: 9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程模板管理</title>
    <script type="text/javascript">
        $(document).ready(function(){
            $("#name").stk_checkInputContent(30);
        });

        function addtemplatewindow(type) {
            var title = "添加流程模板";
            var text = "新建";
            $("#templateform").stk_reset();
            $("#processid").val(0);
            $("#name").val("");
            $("#name").stk_checkerReset();
            $("#processcode").val("");
            $("#phoneshow").val(0);
            $("#processbrief").val("");
            $("#fntbtn").stk_text(text);
            $("#processtype").val("");
            $("#processtype").stk_show();
            $("#processtypevalue2").stk_hide();
            $("#templatewindow").stk_show({title:title});
            $("#_td1_processtype").show();
            $("#_td2_processtype").hide();
        }

        function showtemplatewindow(name,processcode,objid,processtype,processbrief,phoneshow) {
            $("#templateform").stk_reset();
            var title = "修改流程模板";
            $("#processid").val(0);
            text = "修改";
            $("#name").val(name);
            $("#name").stk_checkerReset();
            $("#processcode").val(processcode);
            $("#processid").val(objid);
            $("#processtype").val(processtype);
            $("#phoneshow").stk_val(phoneshow);
            $("#processbrief").val(processbrief);
            $("#fntbtn").stk_text(text);
            $("#processtype").stk_hide();
            $("#processtypevalue").stk_val($("#processtype").stk_text());
            $("#processtypevalue2").stk_text($("#processtype").stk_text());
            $("#processtypevalue2").stk_show();
            $("#templatewindow").stk_show({title:title});
            $("#_td1_processtype").hide();
            $("#_td2_processtype").show();
        }

        function savetemplate() {
            if($("#processcode").val() != ""&&$("#processcode").stk_val().trim()==""){
                $("#processcode").val("");
            }
            if($("#templateform").stk_checkForm()){
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
                    stk.alert("请选中要删除的流程", "提示");
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
            }else if (mark == 22) {
                if ($("#checkBoxPlugin").hasSelect()) {
                    stk.confirm("确认发布吗？", function () {
                        $("#checkBoxPlugin").stk_call({type: '22'}, function (result) {
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
        function historytemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/listprocesshistory.jsp?processid=" + objid),"流程历史列表",{keyWithoutParams:true});
        }
        function historytemplate_new(objid) {
            $(document).stk_go(sirm.jsurl("/workflow/configurate/listprocesshistory.jsp?processid=" + objid + "&prefix=_new"), "流程历史列表", {keyWithoutParams: true});
        }

        //----------------------- 新的方法 ---------------------
        function drawtemplate(objid, processname){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/drawprocess/drawprocess.jsp?processid=" + objid + "&type=EDIT"),processname,{keyWithoutParams:true});
        }
        function showtemplate_new(objid, processname){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/drawprocess/drawprocess.jsp?processid=" + objid +"&type=SHOW"),processname,{keyWithoutParams:true});
        }
        function freshtemplate_new(objid){
            $("#freshinfo").val(objid);
            $("#freshtype").val(1);
            $("#freshtemplateform").stk_submit("freshtemplate_new", function(result) {
                $("#processtable").stk_query();
            });
        }
        function exporttemplate_new(objid){

            stk.confirm("确认要导出吗？", function() {
                var url = sirm.jsurl("/workflow/configurate/exporttemplate_new.action?id=" + objid);
                if (url != "") {
                    window.open(url, "_blank");
                }
            });
        }

        //------------------------- 旧的方法 -----------------------
        function buildtemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid),"流程步骤列表",{keyWithoutParams:true});
        }
        function showtemplate(objid){
            $(document).stk_go(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + objid +"&type=1"),"流程步骤查看",{keyWithoutParams:true});
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
            $("#importprocesswindow").stk_show();
            $("#importprocessform").stk_reset();
            $('#importprocessmsg').stk_text("");
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


    <%--查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询查询--%>
    <form id="searchform" class="search-params-bar">
        <table width="100%">
            <tr>
                <td class="tit" width="60px"><label>&nbsp;流程类型</label></td>
                <td class="bd" width="150px">
                    <ui:select id="searchtype" name="searchtype" list="#attr.processtypelist" listKey="key" listValue="value" width="120px"
                               headerKey="-1" headerValue="所有流程类型" defaultValue="-1"/>
                </td>
                <td class="tit" width="60px"><label>流程名称</label></td>
                <td class="bd" width="120px">
                    <ui:textfield id="searchname" name="searchname" width="100px"/>
                </td>
                <td class="tit" width="60px"><label>流程状态</label></td>
                <td class="tit" width="100px">
                    <ui:select id="searchstatus" name="searchstatus" list="#attr.searchprocesslist" listKey="key" listValue="value" width="70px"
                               headerKey="-1" headerValue="全部" defaultValue="-1"/>
                </td>
                <td class="tit">
                    <ui:button text="查询" icon="ui-icon-search">
                        <event:onclick>
                            $("#processtable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
    </form>


    <ui:table id="processtable" nowrap="true" queryForm="searchform" actionClass="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" pageSize="10">
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
                    <%--changestatus(2);--%>
                    changestatus(22);
                </event:onclick>
            </ui:toolbarButton>
            <ui:toolbarButton icon="ui-icon-arrowreturnthick-1-s" text="导入流程">
                <event:onclick>
                    importtemplate();
                </event:onclick>
            </ui:toolbarButton>
        </layout:tableToolBar>

        <ui:col plugin="checkBoxPlugin" width="20px" align="center"/>
        <ui:col property="name" title="流程名称" width="150px" align="left" allowTip="true" allowSort="false"/>
        <ui:col property="processcode" title="流程Code" width="120px" align="left" allowTip="true" allowSort="false"/>
        <ui:col property="sysversion" title="版本号" width="40px" align="right" allowSort="false"/>
        <ui:col property="statusname" title="流程状态" width="60px" allowSort="false"/>
        <ui:col property="processtypename" title="流程类型" align="left" width="80px" allowSort="false"/>
        <ui:colCust method="getphoneshow" property="phoneshow" title="手机展示" width="80px"  allowSort="false"/>
        <ui:col property="processbrief" title="流程备注" align="left" width="100%" allowTip="true" allowSort="false"/>
        <ui:colCust method="changeprocess_new" title="操作" width="250px"  allowSort="false"/>
    </ui:table>

    <layout:window id="templatewindow" layout="row" title="添加流程模版" width="450px">
        <ui:form id="templateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" method="savetemplate">
            <input type="hidden" id="processid" name="processid" value="">
            <table class="stk-form-ui-st1">
                <tr>
                    <td class="hd" width="80px">流程名称<em>*</em></td>
                    <td class="bd" width="auto">
                        <ui:textfield id="name" name="name" width="200px"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">流程Code</td>
                    <td class="bd" width="auto">
                        <ui:textfield id="processcode" name="processcode" width="200px"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px" id="_td1_processtype">流程类型<em>*</em></td>
                    <td class="hd" width="80px" id="_td2_processtype">流程类型</td>
                    <td class="bd" width="auto">
                        <ui:select id="processtype" name="processtype" list="#attr.processtypelist"
                                   headerKey="" headerValue="-请选择-" listKey="key" listValue="value" width="100%"/>
                        <input type="hidden" id="processtypevalue" name="processtypevalue"/>
                        <ui:label id="processtypevalue2" hidden="true"></ui:label>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">手机展示</td>
                    <td class="bd" width="auto">
                        <ui:select id="phoneshow" name="phoneshow" list="#{0:'禁止展示', 1:'允许展示'}" width="150px"/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="80px">流程备注</td>
                    <td class="bd" width="auto">
                        <ui:textarea id="processbrief" name="processbrief" rows="5" width="300px"/>
                    </td>
                </tr>
            </table>

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

            <func:checkers>
                <func:checker target="name" allowBlank="false" blankText="请填写流程名称!"/>
                <func:checker target="processtype" allowBlank="false" blankText="请选择流程类型!"/>
            </func:checkers>
        </ui:form>
    </layout:window>



    <layout:window id="importprocesswindow" layout="row" title="流程导入" width="400px">
        <ui:form id="importprocessform" clazz="com.sinitek.sirm.web.workflow.configurate.ImportProcessAction" method="importProcess_new" allowFileUpload="true">
            <table class="stk-form-ui-st1" border="0">
                <tr>
                    <td class="hd" width="80px"><label>流程模板<em>*</em></label></td>
                    <td class="bd" width="auto">
                        <sirm:fileuploader name="uploadDataFile" id="uploadDataFile" extensions="text/xml" flash="false" multi="false"></sirm:fileuploader>
                    </td>
                </tr>
            </table>
            <table>
                <tr>
                    <td class="tit" width="80px"></td>
                    <td class="bd" width="auto">
                        <div style="color:#c83d42;font:normal;vertical-align:middle;" id="messageDiv">
                            <label id="importprocessmsg"></label>
                        </div>
                    </td>
                </tr>
            </table>
            <layout:boxcell width="380px" align="center">
                <ui:button text="提交">
                    <event:onclick>
                        if($("#importprocessform").stk_checkForm()){
                            $('#importprocessform').stk_submit(function(result) {
                                if (result != null) {
                                    $('#importprocessmsg').stk_text(result);
                                    return;
                                }else{
                                    $('#importprocessmsg').stk_text("导入成功");
                                    $("#processtable").stk_query();
                                    return;
                                }
                            });
                        }
                    </event:onclick>
                </ui:button>&nbsp;
                <ui:button text="关闭">
                    <event:onclick>
                        $('#importprocesswindow').stk_hide();
                    </event:onclick>
                </ui:button>
            </layout:boxcell>

            <func:checkers>
                <func:checker target="uploadDataFile" allowBlank="false" blankText="请选择流程模板"/>
            </func:checkers>
        </ui:form>
    </layout:window>

    <ui:form id="freshtemplateform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessTableAction" method="freshtemplate">
        <input type="hidden" id="freshinfo" name="freshinfo">
        <input type="hidden" id="freshtype" name="freshtype">
    </ui:form>
</sirm:body>
</html>
