<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.awt.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.List" %>
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

        function showaddstepwindow(processid) {
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
                <%-- $(document).stk_navigate(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=" + ${processid} + "&stepid=" + result.substring(1,result.length)), "流程步骤编辑", {keyWithoutParams:true});--%>
                sirm.openTab(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=${processid}&stepid=" + result.substring(1,result.length)),
                        "新增流程步骤辑", {keyWithoutParams: true}, function () {
                            window.location.replace("/workflow/configurate/processstep.action?processid=${processid}");
                        });
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

        function rebuildstep(processid, stepid, name) {
//            $(document).stk_navigate(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=" + processid + "&stepid=" + stepid), "流程步骤编辑", {keyWithoutParams:true});
            sirm.openTab(sirm.jsurl("/workflow/configurate/configuratestep.action?processid=" + processid + "&stepid=" + stepid),
                    name + "-流程步骤编辑", {keyWithoutParams: true}, function () {
                        window.location.replace("/workflow/configurate/processstep.action?processid=" + processid);
                    });
        <%--window.open('${path}/workflow/configurate/configuratestep.action','_self');--%>
        }

    </script>
</head>
<sirm:body>
<%
    try {
        List<Map> _steptypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("StepType");
        pageContext.setAttribute("steptypelist", _steptypelist);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<form>
    <input type="hidden" id="processid" name="processid" defaultValue="${processid}"/>
    <div class="stk_component_wrap">
        <%--<table width="100%">--%>
        <%--<tr>--%>
            <%--<td class="tit" width="60px">--%>
                <%--<label>&nbsp;流程模板</label>--%>
            <%--</td>--%>
            <%--<td class="bd" width="120px">--%>
                <%--<ui:textfield id="processname" name="processname" defaultValue="" width="100px"/>--%>
            <%--</td>--%>
            <%--<td class="tit" width="60px">--%>
                <%--<label>&nbsp;流程类型</label>--%>
            <%--</td>--%>
            <%--<td class="bd" width="150px">--%>
                <%--<ui:textfield id="processtype" name="processtype" defaultValue="" disabled="true" width="100px"/>--%>
            <%--</td>--%>
            <%--<td class="tit" width="60px">--%>
                <%--<label>流程备注</label>--%>
            <%--</td>--%>
            <%--<td class="bd" width="150px">--%>
                <%--<ui:textfield id="searchstatus" name="searchstatus" defaultValue="" width="100px"/>--%>
            <%--</td>--%>
            <%--<td class="bd">--%>
                <%--<ui:button text="保存">--%>
                    <%--<event:onclick>--%>
                        <%--$("#processtable").stk_query();--%>
                    <%--</event:onclick>--%>
                <%--</ui:button>--%>
            <%--</td>--%>
            <%--<td>--%>
            <%--</td>--%>
        <%--</tr>--%>
        <%--</table>--%>
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
        </div>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: hidden;">
            <table id="templatesteptable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <th class="stk-table-th" align="center" width="4%">
                        <input type="checkbox" id="allStep" name="allStep" onclick="selectallstep(this);">
                    </th>
                    <th class="stk-table-th" width="10%">步骤名称</th>
                    <th class="stk-table-th" width="8%">步骤类型</th>
                    <th class="stk-table-th" width="8%">步骤阶段</th>
                    <th class="stk-table-th" width="8%">处理策略</th>
                    <th class="stk-table-th" width="8%">被处理人</th>
                    <th class="stk-table-th" width="12%">处理条件</th>
                    <th class="stk-table-th" width="12%">处理人</th>
                    <th class="stk-table-th" width="12%">判定条件</th>
                    <th class="stk-table-th" width="10%">目标步骤</th>
                    <th class="stk-table-th" width="8%">操作</th>
                </tr>
                <c:forEach items="${steplist}" var="stepmain"  varStatus="status">
                    <tr class="${status.index%2==0 ?"stk-table-tr-odd":"stk-table-tr-even"}">
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="4%">
                            <input type="checkbox" name="subStep" value="${stepmain['objid']}" onclick="selectmainstep();" >
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">${stepmain['name']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['steptypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['pointtypename']}</td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">${stepmain['acrosstype']}</td>
                        <c:choose>
                            <c:when test="${empty stepmain['ownerlinklist']}">
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">${stepmain['conditonowners']}</td>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <%--新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增--%>
                                    <c:when test="${stepmain['ownerlinklistsize']=='1'}">
                                        <c:forEach items="${stepmain['ownerlinklist']}" var="ownerlinkmap">
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['linkleafname']}
                                                </div>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['ownerstartershow']}
                                                </div>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                        ${ownerlinkmap['ownerendershow']}
                                                </div>
                                            </td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="padding:0;" colspan="3">
                                            <table style="width: 100%;height:100%;padding: 0;">
                                                <c:forEach items="${stepmain['ownerlinklist']}" var="ownerlinkmap">
                                                    <s:if test="${stepmain['whichislower']=='ownheight'}">
                                                        <tr style="height: ${stepmain['htmlheight']}px">
                                                    </s:if>
                                                    <s:if test="${stepmain['whichislower']!='ownheight'}">
                                                        <tr>
                                                    </s:if>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="8%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                ${ownerlinkmap['linkleafname']}
                                                            </div>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                ${ownerlinkmap['ownerstartershow']}
                                                            </div>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${ownerlinkmap['ownerendershow']}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                            <%----%>
                        <c:choose>
                            <c:when test="${empty stepmain['linklist']}">
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%"></td>
                                <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%"></td>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <%--新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增新增--%>
                                    <c:when test="${stepmain['linklistsize']=='1'}">
                                        <c:forEach items="${stepmain['linklist']}" var="linkmap">
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                                    <div style='padding-left:7px;padding-top:5px;'>
                                                        ${linkif['ifshow']}
                                                    </div>
                                                </c:forEach>
                                            </td>
                                            <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">
                                                <div style='padding-left:7px;padding-top:5px;'>
                                                    ${linkmap['aftstepname']}
                                                </div>
                                            </td>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <td style="padding:0;" colspan="2">
                                            <table class="stk-table-td" style="width: 100%;height:100%;padding: 0;border: none;">
                                                <c:forEach items="${stepmain['linklist']}" var="linkmap">
                                                    <s:if test="${stepmain['whichislower']=='linkheight'}">
                                                        <tr style="height: ${stepmain['htmlheight']}px">
                                                    </s:if>
                                                    <s:if test="${stepmain['whichislower']!='linkheight'}">
                                                        <tr>
                                                    </s:if>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="12%">
                                                            <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                                                <div style='padding-left:7px;padding-top:5px;'>
                                                                    ${linkif['ifshow']}
                                                                </div>
                                                            </c:forEach>
                                                        </td>
                                                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;" width="10%">
                                                            <div style='padding-left:7px;padding-top:5px;'>
                                                                ${linkmap['aftstepname']}
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </table>
                                        </td>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;" align="center" width="8%">
                            <ui:a href="javascript:rebuildstep('${processid}','${stepmain['objid']}','${stepmain['name']}')">编辑</ui:a>
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

<layout:window id="addstepwindow" layout="row" title="添加流程步骤" width="450px" height="150px">
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
            <layout:boxcell width="270px" align="center">
                <ui:button id="btaddstep" text="新建">
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