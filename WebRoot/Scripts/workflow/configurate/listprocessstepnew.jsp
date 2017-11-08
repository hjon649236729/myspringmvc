<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.IWorkflowAchieveService" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.IWorkflowBaseService" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-1-16
  Time: 上午10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程步骤列表</title>
    <script type="text/javascript">
        function fleshMain() {
            window.document.location.reload();
        }

        function showaddstepwindow(){
            $("#addstepwindow").stk_show();
        }
        function showaddstepwindow(processid) {
            $("#addstepwindow").stk_show();
            $("#processid2").stk_val(processid);
        }
        function showeditstepwindow(processid,name,steptypename,pointtypename,acrosstype){
            $("#addstepwindow").stk_show();
            $("#processid2").stk_val(processid);
        }

        function addstep() {
            if ($("#stepname").val() == "" || $("#stepname").val().trim() == "") {
                stk.alert("步骤名称不可为空", "提示");
                return;
            }
            $("#addstepform").stk_submit("addstep", function(result) {

                if (result.substring(0,1)!='#') {
                    stk.alert(result);
                    return;
                }
                $("#stepname").val("");
                $('#addstepwindow').stk_hide();
//                $("#processtable").stk_query();
//                fleshMain();
                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=" + ${processid} + "&stepid=" + result.substring(1,result.length)), "流程步骤编辑", {keyWithoutParams:true});
            });
        }

        function deletestep(deleteinfo){
            stk.confirm("确认删除吗？", function() {
                $("#deleteinfo").stk_val(deleteinfo);
                $("#deletestepform").stk_submit("deletestep", function(result) {
                    if (result != null) {
                        var s = {"确认" : function() {
                            fleshMain();
                        }
                        };
                        stk.alert(result, "警告", s);
//                        alert(result);
                    } else {
                        fleshMain();
                    }
                });
            });
        }

        function selectallstep(obj) {
            if ($(obj).attr("checked")) {
                $("input[name='subStep']").attr("checked", true);
            } else {
                $("input[name='subStep']").attr("checked", false);
            }
        }

        function selectmainstep(){
            var checkmark = 1;
            $("input[name='subStep']").each(function() {
                if (!$(this).attr("checked")) {
                    checkmark = 0;
                }
            });
            if(checkmark==1){
                $("input[name='allStep']").attr("checked",true);
            } else {
                $("input[name='allStep']").attr("checked",false);
            }
        }

        function rebuildstep(processid, stepid) {
            $(document).stk_navigate(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=" + processid + "&stepid=" + stepid), "流程步骤编辑", {keyWithoutParams:true});
        <%--window.open('${path}/workflow/configurate/configuratestep.action','_self');--%>
        }

    </script>
</head>
<sirm:body>
<%
    try {
        IWorkflowBaseService _workbase = WorkflowServiceFactory.getWorkflowBaseService();
        List<Map> _steptypelist = _workbase.findParaListByName("StepType");
        pageContext.setAttribute("steptypelist", _steptypelist);
//        List<Map> _judgetypelist = _workbase.findParaListByName("JudgeType");
//        pageContext.setAttribute("judgetypelist", _judgetypelist);
        Map map3 = new HashMap();
        Map map4 = new HashMap();
        map3.put("key","抢占审批");
        map3.put("value","抢占审批");
        map4.put("key","投票审批");
        map4.put("value","投票审批");
        List<Map> _judgetypelist = new ArrayList<Map>();
        _judgetypelist.add(map3);
        _judgetypelist.add(map4);
        pageContext.setAttribute("judgetypelist",_judgetypelist);
        List<Map> _coojudgelist = _workbase.findParaListByName("CooJudge");
        pageContext.setAttribute("coojudgelist", _coojudgelist);
        
        Map map1 = new HashMap();
        Map map2 = new HashMap();
        map1.put("key","重新开始");
        map1.put("value","重新开始");
        map2.put("key","继续流程");
        map2.put("value","继续流程");
        List<Map> overrulelist = new ArrayList<Map>();
        overrulelist.add(map1);
        overrulelist.add(map2);
        pageContext.setAttribute("overrulelist",overrulelist);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<form>
    <input type="hidden" id="processid" name="processid" defaultValue="${processid}"/>
    <div class="stk_component_wrap">
        <div class="stk-ui-bar stk-table-opt-bar">
            <ui:button icon="ui-icon-plusthick" text="添加">
                <event:onclick>
                    <%--showaddstepwindow($('#processid').val());--%>
                    showaddstepwindow(${processid});
                </event:onclick>
            </ui:button>
            <ui:button icon="ui-icon-minusthick" text="删除">
                <event:onclick>
                    var steplist="";
                    $("input[name='subStep']").each(function() {
                    if($(this).attr("checked") == true){
                    steplist += $(this).val()+",";
                    }
                    });
                    if(steplist.length==0){
                    stk.alert("请选择要删除的步骤");
                    }else{
                    deletestep(steplist);
                    }
                </event:onclick>
            </ui:button>
            <ui:button text="生成模板">
                <event:onclick>

                </event:onclick>
            </ui:button>
        </div>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto;">
            <table id="templatesteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <th class="stk-table-th" align="center" width="4%">
                        <input type="checkbox" id="allStep" name="allStep" onclick="selectallstep(this);">
                    </th>
                    <th class="stk-table-th" width="10%">步骤名称</th>
                    <th class="stk-table-th" width="8%">步骤类型</th>
                    <th class="stk-table-th" width="8%">步骤阶段</th>
                    <th class="stk-table-th" width="8%">审批规则</th>
                    <th class="stk-table-th" width="8%">驳回后操作</th>
                    <%--<th class="stk-table-th" width="8%">被处理人</th>--%>
                    <%--<th class="stk-table-th" width="12%">处理条件</th>--%>
                    <%--<th class="stk-table-th" width="12%">处理人</th>--%>
                    <%--<th class="stk-table-th" width="12%">判定条件</th>--%>
                    <%--<th class="stk-table-th" width="10%">目标步骤</th>--%>
                    <th class="stk-table-th" width="8%">操作</th>
                </tr>
                <c:forEach items="${steplist}" var="stepmain">
                    <tr>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="4%">
                            <input type="checkbox" name="subStep" value="${stepmain['objid']}" onclick="selectmainstep();" >
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">${stepmain['name']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['steptypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['pointtypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['acrosstype']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">重新审批</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="8%">
                            <%--<ui:a href="javascript:showeditstepwindow(${processid},${stepmain['name']},${stepmain['steptypename']},${stepmain['pointtypename']},${stepmain['acrosstype']})">编辑</ui:a>--%>
                            <ui:a href="javascript:showaddstepwindow(${processid})">编辑</ui:a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</form>
${stepmain['whichislower']}
<ui:form id="deletestepform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessStepTableAction" method="deletestep">
    <input type="hidden" id="deleteinfo" name="deleteinfo">
</ui:form>

<layout:window id="addstepwindow" layout="row" title="添加流程步骤" width="450px" height="230px">
    <ui:form id="addstepform" clazz="com.sinitek.sirm.web.workflow.configurate.ProcessStepTableAction" method="addstep">
        <input type="hidden" id="processid2" name="processid2">
        <layout:box layout="row" cellHeight="45px">
            <layout:boxcell label="步骤名称" width="400px">
                <ui:textfield id="stepname" name="stepname" width="200px"></ui:textfield> &nbsp;30个汉字以内
            </layout:boxcell>
            <layout:boxcell label="步骤类型" width="400px">
                <ui:select id="steptype" name="steptype" list="#attr.steptypelist" listKey="key" listValue="value" />
                            <%--headerKey="" headerValue="--请选择--" defaultValue="-1"/>--%>
            </layout:boxcell>
            <layout:boxcell label="审批规则" width="400px">
                <table width="300px">
                    <tr>
                        <td style="width: 30%">
                            <ui:select id="judgetype" name="judgetype" list="#attr.judgetypelist" listKey="key" listValue="value" >
                                <event:onchange>
                                    var judgetype=$("#judgetype").val();
                                    if(judgetype=="抢占审批"){
                                    $("#coojudge").stk_hide();
                                    $("#coojudgeads").stk_hide();
                                    }else if(judgetype=="投票审批"){
                                    $("#coojudge").stk_show();
                                    $("#coojudgeads").stk_show();
                                    }
                                </event:onchange>
                            </ui:select>
                        </td>
                        <td style="width: 40%">
                            <ui:select hidden="true" id="coojudge" name="coojudge" list="#attr.coojudgelist" width="115px"
                                       listKey="key" listValue="value" defaultValue="${steptypeads['coojudge']}"/>
                        </td>
                        <td style="width: 30%">
                            <ui:textfield hidden="true" id="coojudgeads" name="coojudgeads" width="80px" defaultValue="${steptypeads['coojudgeads']}"></ui:textfield>
                            <%--headerKey="" headerValue="--请选择--" defaultValue="-1"/>--%>
                        </td>
                    </tr>
                </table>
            </layout:boxcell>
            <layout:boxcell label="驳回后操作" width="400px">
                <ui:select id="overrule" name="overrule" list="#attr.overrulelist" listKey="key" listValue="value" />
            </layout:boxcell>
            <layout:boxcell width="270px" align="center">
                <ui:button id="btaddstep1" text="保存">
                    <event:onclick>
                        addstep();
                        showaddstepwindow();
                    </event:onclick>
                </ui:button>&nbsp;
                <ui:button id="btaddstep2" text="保存并关闭">
                    <event:onclick>
                        addstep();
                    </event:onclick>
                </ui:button>&nbsp;
                <ui:button text="关闭">
                    <event:onclick>
                        $('#addstepwindow').stk_hide();
                    </event:onclick>
                </ui:button>
            </layout:boxcell>
        </layout:box>
        <func:checkers>
            <func:checker target="stepname" allowBlank="false" blankText="步骤名称不可以为空"/>
        </func:checkers>
    </ui:form>
</layout:window>
</sirm:body>
</html>