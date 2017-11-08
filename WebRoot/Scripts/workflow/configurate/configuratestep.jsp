<%@ page import="com.sinitek.sirm.busin.workflow.entity.IWorkflowProcess" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.IWorkflowBaseService" %>
<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="com.sinitek.sirm.common.CommonServiceFactory" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-1-17
  Time: 下午1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>流程步骤编辑</title>
<%
    try {
        IWorkflowBaseService _workbase = WorkflowServiceFactory.getWorkflowBaseService();
        String _processid = request.getParameter("processid");
        List<Map> _steplist = _workbase.getProcessStepList(Integer.parseInt(_processid));
        pageContext.setAttribute("steplist", _steplist);
        IWorkflowProcess _process = _workbase.loadProcess(Integer.parseInt(_processid));
        List<Map> _pointtypelist = _workbase.findParaListByNameAndType("StepStage", _process.getProcessType());
        pageContext.setAttribute("pointtypelist", _pointtypelist);
        List<Map> _judgetypelist = _workbase.findParaListByName("JudgeType");
        pageContext.setAttribute("judgetypelist", _judgetypelist);
        List<Map> _submitownerlist = _workbase.findParaListByName("SubmitOwner");
        pageContext.setAttribute("submitownerlist", _submitownerlist);
        List<Map> _stepdealerlist = _workbase.findParaListByNameAndType("StepDealer", _process.getProcessType());
        pageContext.setAttribute("stepdealerlist", _stepdealerlist);
        List<Map> _mathmarklist = _workbase.findParaListByName("MathMark");
        pageContext.setAttribute("mathmarklist", _mathmarklist);
        pageContext.setAttribute("mathmarklistjson", new JSONArray(_mathmarklist).toString());
        List<Map> _specialmarklist = _workbase.findParaListByName("SpecialMark");
        pageContext.setAttribute("specialmarklist", _specialmarklist);
        pageContext.setAttribute("specialmarklistjson", new JSONArray(_specialmarklist).toString());
        List<Map> _linkiftypelist = _workbase.findParaListByNameAndType("LinkIfType", _process.getProcessType());
        pageContext.setAttribute("linkiftypelist", _linkiftypelist);
        List<Map> _judgeresultlist = _workbase.findParaListByName("JudgeResult");
        pageContext.setAttribute("judgeresultlist", _judgeresultlist);
        pageContext.setAttribute("judgeresultlistjson", new JSONArray(_judgeresultlist).toString());
        List<Map> _specialresultlist = _workbase.findParaListByName(_process.getProcessType() + "SpecialResult");
        pageContext.setAttribute("specialresultlist", _specialresultlist);
        pageContext.setAttribute("specialresultlistjson", new JSONArray(_specialresultlist).toString());
        List<Map> _specialtasklist = _workbase.findParaListByNameAndType("SpecialTask", _process.getProcessType());
        pageContext.setAttribute("specialtasklist", _specialtasklist);
        List<Map> _coojudgelist = _workbase.findParaListByName("CooJudge");
        pageContext.setAttribute("coojudgelist", _coojudgelist);
        List<Map> _resultdeal = _workbase.findParaListByNameAndType("ResultDeal", _process.getProcessType());
        pageContext.setAttribute("resultdeal", _resultdeal);
        List<Map> _ownerlinkoriginlist = _workbase.findParaListByName("OwnerLinkOrigin");
        pageContext.setAttribute("ownerlinkoriginlist", _ownerlinkoriginlist);
        List<Map> _workflowagentlist = _workbase.findParaListByName("WorkflowAgent");
        pageContext.setAttribute("workflowagentlist", _workflowagentlist);
        List<Map> _autoskiplist = _workbase.findParaListByName("AutoSkip");
        pageContext.setAttribute("autoskiplist", _autoskiplist);
        Map _messagemap = CommonServiceFactory.getMessageService().findAlltemp();
        pageContext.setAttribute("messagemap", _messagemap);

        List<Map> _processurllist = _workbase.getProcessUrlListByType(_process.getProcessType());
        pageContext.setAttribute("processurllist", _processurllist);
//    <ui:select list="#attr.templatemap" id="MEETING_TEMPLATECODE" name="MEETING_TEMPLATECODE" headerKey="" width="100%" headerValue="--请选择--">
//                </ui:select>
        List<Map> _linkifresultlist = _workbase.findParaListByName("LinkIfResult");
        pageContext.setAttribute("linkifresult", _linkifresultlist);

        Map map1 = new HashMap();
        Map map2 = new HashMap();
        Map map3 = new HashMap();
        Map map4 = new HashMap();
        Map map5 = new HashMap();
        map1.put("key", "基本处理");
        map1.put("value", "基本处理");
        map2.put("key", "特殊处理");
        map2.put("value", "特殊审批");
        map3.put("key", "<");
        map3.put("value", "<");
        map4.put("key", ">=");
        map4.put("value", ">=");
        map5.put("key", "<=");
        map5.put("value", "<=");
        List<Map> testlist = new ArrayList<Map>();
        testlist.add(map1);
        testlist.add(map2);
        pageContext.setAttribute("testlist", testlist);
    } catch (Exception ex) {
        ex.printStackTrace();
    }
%>
<script type="text/javascript">
function selectallownerlink(obj) {
    if ($(obj).attr("checked") == true) {
        $("input[name='ownerlink']").attr("checked", true);
    } else {
        $("input[name='ownerlink']").attr("checked", false);
    }
}

function selectmainownerlink() {
    var checkmark = 1;
    $("input[name='ownerlink']").each(function() {
        if ($(this).attr("checked") == false) {
            checkmark = 0;
        }
    });
    if (checkmark == 1) {
        $("input[name='ownerCheckbox']").attr("checked", true);
    } else {
        $("input[name='ownerCheckbox']").attr("checked", false);
    }
}

function statusOwnerLinkWindow() {
    $("#startowners").stk_html("");
    $("#startowner").stk_val("");
    $("#endowners").stk_html("");
    $("#endowner").stk_val("");
}

function showaddownerlinkwindow(linkid) {
    statusOwnerLinkWindow();
    $("#addownerlinkwindow").stk_show();
    $("#preownerlinkid").stk_val(linkid);
    $("#ownerautoskip").stk_val(1);
    $("#ownerlinkorigin").stk_val(1);
}

function hideownerlinkwindow() {
    statusOwnerLinkWindow();
    $("#addownerlinkwindow").stk_hide();
}

function selectalllink(obj) {
    if ($(obj).attr("checked") == true) {
        $("input[name='link']").attr("checked", true);
    } else {
        $("input[name='link']").attr("checked", false);
    }
}

function selectmainlink() {
    var checkmark = 1;
    $("input[name='link']").each(function() {
        if ($(this).attr("checked") == false) {
            checkmark = 0;
        }
    });
    if (checkmark == 1) {
        $("input[name='linkCheckbox']").attr("checked", true);
    } else {
        $("input[name='linkCheckbox']").attr("checked", false);
    }
}

function statusLinkWindow() {
    var status = $("#stepifnum").stk_val();
    for (var i = 1; i <= status; i++) {
        $("#stepifmain" + i).parent().parent().parent().stk_hide();
        $("#stepifmain" + i).stk_hide();
        $("#stepifand" + i).stk_hide();
        $("#stepif2ads" + i).stk_hide();
//                fleshStepIf(i, 0);
    }
    var status2 = $("#stepdonum").stk_val();
    for (var i = 1; i <= status2; i++) {
        $("#stepdomain" + i).parent().parent().parent().stk_hide();
        $("#stepdomain" + i).stk_hide();
    }
    $("#stepifnum").stk_val(0);
    $("#stepdonum").stk_val(0);
}

function hideLinkWindow() {
    statusLinkWindow();
    $('#addlinkwindow').stk_hide();
}

function showaddlinkwindow(linkid) {
    statusLinkWindow();
    for (var i = 1; i <= 20; i++) {
        $("#stepifmain" + i).val(2);
    }
    $("#addlinkwindow").stk_show();
    $("#prelinkid").stk_val(linkid);
}

function addoptionsmain(status) {
//    var text = document.getElementById("stepifmain"+status);
//    text.value = "审批状态";
    if ($("#stepifmain" + status).val() == 1) {
        var listarr = $.parseJSON('${specialmarklistjson}');
        var lian = $("#stepifand" + status);
//                stk.alert($(lian).html());
        $(lian).html("");
        for (var i = 0; i < listarr.length; i++) {
            $(lian).append($('<option value=' + listarr[i].key + '>' + listarr[i].value + '</option>'));
        }
        var listarr2 = $.parseJSON('${specialresultlistjson}');
        var lian2 = $("#stepif2ads" + status);
        $(lian2).html("");
        for (var i = 0; i < listarr2.length; i++) {
            $(lian2).append($('<option value=' + listarr2[i].key + '>' + listarr2[i].value + '</option>'));
        }
        lian.stk_show();
        lian2.stk_show();
    } else if ($("#stepifmain" + status).val() == 2) {
        var listarr = $.parseJSON('${mathmarklistjson}');
        var lian = $("#stepifand" + status);
        $(lian).html("");
        for (var i = 0; i < listarr.length; i++) {
            $(lian).append($('<option value=' + listarr[i].key + '>' + listarr[i].value + '</option>'));
        }
        var listarr2 = $.parseJSON('${judgeresultlistjson}');
        var lian2 = $("#stepif2ads" + status);
        var lian3 = $("#stepif3ads" + status);
        $(lian2).html("");
        for (var i = 0; i < listarr2.length; i++) {
            $(lian2).append($('<option value=' + listarr2[i].key + '>' + listarr2[i].value + '</option>'));
        }
        lian.stk_show();
        lian2.stk_show();
        lian3.stk_hide();
    } else if ($("#stepifmain" + status).val() >= 100000) {
        var lian = $("#stepifand" + status);
        lian.stk_hide();
        var lian2 = $("#stepif2ads" + status);
        lian2.stk_hide();
        var lian3 = $("#stepif3ads" + status);
        lian3.stk_show();
    }
}

function deleteOwnerLink() {
    var checkCount = 0;
    $("input[name='ownerlink']").each(function() {
        if ($(this).attr("checked") == true) {
            checkCount ++;
        }
    });
    if (checkCount == 0) {
        stk.alert("请选择要删除的项");
        return;
    } else {
        stk.confirm("确认删除吗？", function() {
            $("input[name='ownerlink']").each(function() {
                if ($(this).attr("checked") == true) {
                    $(this).parent().parent().remove();
                }
            });
            $("#ownerCheckbox").attr("checked", false);
        });
    }
}

function deleteLink() {
    var checkCount = 0;
    $("input[name='link']").each(function() {
        if ($(this).attr("checked") == true) {
            checkCount ++;
        }
    });
    if (checkCount == 0) {
        stk.alert("请选择要删除的项");
        return;
    } else {
        stk.confirm("确认删除吗？", function() {
            $("input[name='link']").each(function() {
                if ($(this).attr("checked") == true) {
                    $(this).parent().parent().remove();
                }
            });
            $("#linkCheckbox").attr("checked", false);
        });
    }
}

function refreshOwnerLinkTable(startowner, endowner, preownerlinkid, linkorigin, linkoriginid, ownerautoskip) {
    var table = $("#ownerlinktable");
    var linkmark = preownerlinkid;
    if (linkmark == 0) {
        linkmark = $("#ownerlinkmark").val();
        $("#ownerlinkmark").val(linkmark - 1);
    } else {
        var tr0 = $("#ownerlink" + linkmark);
        tr0.remove();
    }
    var tr = $("<tr id='ownerlink" + linkmark + "'></tr>");
    var td0 = $("<td class='stk-table-td' align='center' width='8%' style='border:1px #BBBBBB solid;'><input type='checkbox' id='" + linkmark + "' name='ownerlink' value=" + linkmark + " onclick=\"selectmainownerlink();\"></td>");
    var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
    var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
    var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
    var param = "<a href='#' onclick=\"editOwnerLinkInfo('" + startowner + "','" + endowner + "'," + linkmark + "," + linkoriginid+ "," + ownerautoskip + ");\">编辑</a>";
    var tdInfo = "<td align='center' class='stk-table-td' style='border:1px #BBBBBB solid;'>" + param + "</td>";
    var td4 = $(tdInfo);
    var td5 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'><a href='#' onclick='moveOwnerUp(this)'>上移</a>&nbsp;|&nbsp;<a href='#' onclick='moveOwnerDown(this)'>下移</a>"+"<input type='hidden' id='autoskip" + linkmark + "' name='autoskip" + linkmark + "' value='" + ownerautoskip + "'/>"+"</td>");

    $("<div style='padding-left:7px;padding-top:5px;'>" + linkorigin + "</div><input type='hidden' id='ownertype" + linkmark + "' name='ownertype" + linkmark + "' value='" + linkoriginid + "'/>").appendTo(td1);
//    $("<input type='hidden' id='autoskip" + linkmark + "' name='autoskip" + linkmark + "' value='" + ownerautoskip + ">").appendTo(td1);
    if (startowner != null && startowner.length != 0) {
        var starter = "";
        var starterArr = startowner.split(",");
        for (var i = 0; i < starterArr.length; i++) {
            var starterArrArr = starterArr[i].split(":");
            starter += starterArrArr[1] + "，";
        }
        $("<div style='padding-left:7px;padding-top:5px;'>" + starter.substring(0, starter.length - 1) + "</div><input type='hidden' id='ownerstarter" + linkmark + "' name='ownerstarter" + linkmark + "' value='" + startowner + "'>").appendTo(td2);
    }
    if (endowner != null && endowner.length != 0) {
        var ender = "";
        var enderArr = endowner.split(",");
        for (var i = 0; i < enderArr.length; i++) {
            var enderArrArr = enderArr[i].split(":");
            ender += enderArrArr[1] + "，";
        }
        $("<div style='padding-left:7px;padding-top:5px;'>" + ender.substring(0, ender.length - 1) + "</div><input type='hidden' id='ownerender" + linkmark + "' name='ownerender" + linkmark + "' value='" + endowner + "'>").appendTo(td3);
    }

    td0.appendTo(tr);
    td1.appendTo(tr);
    td2.appendTo(tr);
    td3.appendTo(tr);
    td4.appendTo(tr);
    td5.appendTo(tr);
    tr.appendTo(table);
}

function editOwnerLinkInfo(startowner, endowner, linkmark, linkoriginid,autoskip) {
    statusOwnerLinkWindow();
    $("#addownerlinkwindow").stk_show();
    $("#ownerlinkorigin").val(linkoriginid);
    $("#preownerlinkid").stk_val(linkmark);
    $("#ownerautoskip").stk_val(autoskip);
    if (startowner != null && startowner.length > 0) {
        showframe("user", "startowners", "startowner", "www", startowner);
    }
    if (endowner != null && endowner.length > 0) {
        showframe("user", "endowners", "endowner", "www", endowner);
    }
}

function refreshTable(conditionArray, conditionMarkArray, autoTaskArray, autoTaskMarkArray, target, targetId, linkId) {
    var table = $("#linktable");
    var linkmark = linkId;
    if (linkmark == 0) {
        linkmark = $("#linkmark").val();
        $("#linkmark").val(linkmark - 1);
    } else {
        var tr0 = $("#link" + linkmark);
        tr0.remove();
    }

    var tr = $("<tr id='link" + linkmark + "'></tr>");
    var td0 = $("<td class='stk-table-td' align='center' width='8%' style='border:1px #BBBBBB solid;'><input type='checkbox' id='" + linkmark + "' name='link' value=" + linkmark + " onclick=\"selectmainlink()\"></td>");
    var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
    var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
    var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;padding-left:7px;'>" + target + "<input type='hidden' id='linktarget" + linkmark + "' name='linktarget" + linkmark + "' value='" + targetId + "'></td>");
    var param = "<a href='#' onclick=\"editLinkInfo('" + conditionMarkArray + "','" + autoTaskMarkArray + "'," + targetId + "," + linkmark + ");\">编辑</a>";
    var tdInfo = "<td align='center' class='stk-table-td' style='border:1px #BBBBBB solid;'>" + param + "</td>";
    var td4 = $(tdInfo);
    var td5 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'><a href='#' onclick='moveUp(this)'>上移</a>&nbsp;|&nbsp;<a href='#' onclick='moveDown(this)'>下移</a></td>");
    for (var i = 0; i < conditionArray.length; i++) {
        $("<div style='padding-left:7px;padding-top:5px;'>" + conditionArray[i] + "</div>").appendTo(td1);
    }
    if (conditionArray.length > 0) {
        $("<input type='hidden' id='linkif" + linkmark + "' name='linkif" + linkmark + "' value='" + conditionMarkArray + "'>").appendTo(td1);
    }
    for (var i = 0; i < autoTaskArray.length; i++) {
        $("<div style='padding-left:7px;padding-top:5px;'>" + autoTaskArray[i] + "</div>").appendTo(td2);
    }
    if (autoTaskArray.length > 0) {
        $("<input type='hidden' id='linkdo" + linkmark + "' name='linkdo" + linkmark + "' value='" + autoTaskMarkArray + "'>").appendTo(td2);
    }

    td0.appendTo(tr);
    td1.appendTo(tr);
    td2.appendTo(tr);
    td3.appendTo(tr);
    td4.appendTo(tr);
    td5.appendTo(tr);
    tr.appendTo(table);
}

function editLinkInfo(conditionMarkArray, autoTaskMarkArray, targetId, linkMark) {
    statusLinkWindow();
    var i,j;
    for (var i = 1; i <= 20; i++) {
        $("#stepifmain" + i).val(2);
    }
    $("#addlinkwindow").stk_show();
    $("#prelinkid").val(linkMark);
    if (conditionMarkArray != "") {
        var conditionArrArr = conditionMarkArray.split(",");
        $("#stepifnum").val(conditionArrArr.length);
        for (i = 0,j = 1; i < conditionArrArr.length; i++,j++) {
            var conditionMark = conditionArrArr[i];
            var conditionArr = conditionMark.split(" ");
            $("#stepifmain" + j).parent().parent().parent().stk_show();
            $("#stepifmain" + j).stk_show();
            $("#stepifmain" + j).stk_val(conditionArr[0]);
            $("#stepifand" + j).stk_show();
            $("#stepif2ads" + j).stk_show();
            addoptionsmain(j);//这里加入列表的加载
            $("#stepifand" + j).stk_val(conditionArr[1]);
            $("#stepif2ads" + j).stk_val(conditionArr[2]);
            $("#stepif3ads" + j).stk_val(conditionArr[2]);
        }
    }
    if (autoTaskMarkArray != "") {
        var autoTaskArrArr = autoTaskMarkArray.split(",");
        $("#stepdonum").val(autoTaskArrArr.length);
        for (i = 0,j = 1; i < autoTaskArrArr.length; i++,j++) {
            var autoTaskMark = autoTaskArrArr[i];
            $("#stepdomain" + j).parent().parent().parent().stk_show();
            $("#stepdomain" + j).stk_show();
            $("#stepdomain" + j).stk_val(autoTaskMark);
        }
    }
    $("#targetstep").stk_val(targetId);
}

function moveUp(obj) {
    var rowCount = $("#linktable tr").size();
    var curRow = $(obj).parent().parent().prevAll().length;
    if (rowCount == 2) {
        stk.alert("不可以移动当前行");
    } else if (curRow == 1) {
        stk.alert("第一行不可以上移");
    } else {
        var curTr = $(obj).parent().parent();
        var preTr = curTr.prev();
        var preTrClone = preTr.clone(true);
        curTr.after(preTrClone);
        preTr.remove();
    }
}

function moveDown(obj) {
    var rowCount = $("#linktable tr").size();
    var curRow = $(obj).parent().parent().prevAll().length + 1;
    var count = rowCount - curRow;
    if (rowCount == 2) {
        stk.alert("不可以移动当前行");
    } else if (count == 0) {
        stk.alert("最后一行不可以下移");
    } else {
        var curTr = $(obj).parent().parent();
        var nextTr = curTr.next();
        var curTrClone = curTr.clone(true);
        nextTr.after(curTrClone);
        curTr.remove();
    }
}

function moveOwnerUp(obj) {
    var rowCount = $("#ownerlinktable tr").size();
    var curRow = $(obj).parent().parent().prevAll().length;
    if (rowCount == 2) {
        stk.alert("不可以移动当前行");
    } else if (curRow == 1) {
        stk.alert("第一行不可以上移");
    } else {
        var curTr = $(obj).parent().parent();
        var preTr = curTr.prev();
        var preTrClone = preTr.clone(true);
        curTr.after(preTrClone);
        preTr.remove();
    }
}

function moveOwnerDown(obj) {
    var rowCount = $("#ownerlinktable tr").size();
    var curRow = $(obj).parent().parent().prevAll().length + 1;
    var count = rowCount - curRow;
    if (rowCount == 2) {
        stk.alert("不可以移动当前行");
    } else if (count == 0) {
        stk.alert("最后一行不可以下移");
    } else {
        var curTr = $(obj).parent().parent();
        var nextTr = curTr.next();
        var curTrClone = curTr.clone(true);
        nextTr.after(curTrClone);
        curTr.remove();
    }
}

function loadbody() {
    if (${(stepmain['steptypeid'] eq 3)}) {
        if (${steptypeads['judgetype'] eq 2}) {
            $("#coojudge").stk_show();
            $("#coojudgeads").stk_show();
        } else if (${steptypeads['judgetype'] eq 100}) {
            $("#resultdeal").stk_show();
        }
    }
    var assignee = "${conditionowners}";
    if (assignee.length > 0) {
        showframe("user", "conditionowners", "conditionowner", "www", assignee);
    }
    var noticeowner = "${stepcondition['noticeowner']}";
    if (noticeowner.length > 0) {
        showframe("user", "noticeowners", "noticeowner", "www", noticeowner);
    }
    var candidates = "${candidates}";
    if (candidates.length > 0) {
        showframe("user", "candidates", "candidate", "www", candidates);
    }
}

$(document).ready(function () {
    loadbody();
});
</script>
</head>
<sirm:body>
<ui:form id="configstepform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigStepAction" method="savestepall">
<input type="hidden" id="processid" name="processid" value="${processid}">
<input type="hidden" id="stepid" name="stepid" value="${stepid}">

<div style="padding-top:7px;">
    <table>
        <tr>
            <td class="bd" width="60px">步骤名称</td>
            <td style="padding-left:7px;">
                <ui:textfield id="stepname" name="stepname" width="200px"
                              defaultValue="${stepmain['name']}"></ui:textfield>&nbsp;30个汉字以内
            </td>
        </tr>
        <tr>
            <td class="bd" width="60px" style="padding-top:5px;">步骤类型</td>
            <td style="padding-left:7px;padding-top:5px;">
                <ui:textfield id="steptype" name="steptype" width="150px" readOnly="true"
                              defaultValue="${stepmain['steptypename']}" disabled="true"></ui:textfield>
                <input type="hidden" id="steptypeid" name="steptypeid" value="${stepmain['steptypeid']}">
            </td>
        </tr>
        <tr>
            <td class="bd" width="60px" style="padding-top:5px;">步骤阶段</td>
            <td style="padding-left:7px;padding-top:5px;">
                <ui:select id="pointtypeid" name="pointtypeid" list="#attr.pointtypelist" width="150px" headerKey="0"
                           headerValue="无"
                           listKey="key" listValue="value" defaultValue="${stepmain['pointtypeid']}"/>
            </td>
        </tr>
        <tr>
            <td class="bd" width="60px" style="padding-top:5px;">处理页面</td>
            <td style="padding-left:7px;padding-top:5px;">
                <ui:select id="processurl" name="processurl" list="#attr.processurllist" width="150px" headerKey="0"
                           headerValue="无"
                           listKey="key" listValue="name" defaultValue="${stepmain['urlmark']}"/>
            </td>
        </tr>
    </table>
    <table id="ownertable">
        <c:if test="${(stepmain['steptypeid'] eq 3)}">
            <tr>
                <td class="bd" style="padding-top:5px;" width="60px">处理类型</td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="judgetype" name="judgetype" list="#attr.judgetypelist" width="150px"
                               listKey="key" listValue="value" defaultValue="${steptypeads['judgetype']}">
                        <event:onchange>
                            var judgetype=$("#judgetype").val();
                            if(judgetype==1){
                            $("#coojudge").stk_hide();
                            $("#coojudgeads").stk_hide();
                            $("#resultdeal").stk_hide();
                            }else if(judgetype==2){
                            $("#coojudge").stk_show();
                            $("#coojudgeads").stk_show();
                            $("#resultdeal").stk_hide();
                            }else if(judgetype==100){
                            $("#coojudge").stk_hide();
                            $("#coojudgeads").stk_hide();
                            $("#resultdeal").stk_show();
                            }
                        </event:onchange>
                    </ui:select>
                        <%--<ui:select id="submitowner" name="submitowner" list="#attr.testlist" width="80px"--%>
                        <%--listKey="key" listValue="value"/>--%>
                </td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select hidden="true" id="coojudge" name="coojudge" list="#attr.coojudgelist" width="120px"
                               listKey="key" listValue="value" defaultValue="${steptypeads['coojudge']}"/>
                    <ui:textfield hidden="true" id="coojudgeads" name="coojudgeads" width="80px"
                                  defaultValue="${steptypeads['coojudgeads']}"></ui:textfield>
                    <ui:select hidden="true" id="resultdeal" name="resultdeal" list="#attr.resultdeal" width="160px"
                               headerKey="0" headerValue="请选择审批模式"
                               listKey="key" listValue="value" defaultValue="${steptypeads['resultdeal']}"/>
                </td>
            </tr>
            <tr>
                <td style="padding-top:5px;">
                    <ui:button text="选择处理人">
                        <event:onclick>
                            show('user','conditionowners','conditionowner','wwww');
                        </event:onclick>
                    </ui:button>
                </td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="stepdealer" name="stepdealer" list="#attr.stepdealerlist" width="150px" headerKey="0"
                               headerValue="无特殊逻辑"
                               listKey="key" listValue="value" defaultValue="${stepdealer}"/>
                </td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="workflowagent" name="workflowagent" list="#attr.workflowagentlist" width="150px"
                               listKey="key" listValue="value" defaultValue="${workflowagent}"/>
                </td>
            </tr>
        </c:if>
        <c:if test="${(stepmain['steptypeid'] eq 7)}">
            <tr>
                <td class="bd" style="padding-top:5px;" width="60px">处理类型</td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="submitowner" name="submitowner" list="#attr.submitownerlist" width="150px"
                               listKey="key" listValue="value" defaultValue="${steptypeads['judgetype']}"/>
                </td>
            </tr>
            <tr>
                <td style="padding-top:7px;">
                    <ui:button text="选择处理人">
                        <event:onclick>
                            show('user','conditionowners','conditionowner','wwww');
                        </event:onclick>
                    </ui:button>
                </td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="stepdealer2" name="stepdealer2" list="#attr.stepdealerlist" width="150px"
                               headerKey="0" headerValue="无特殊逻辑"
                               listKey="key" listValue="value" defaultValue="${stepdealer}"/>
                </td>
                <td style="padding-left:7px;padding-top:5px;">
                    <ui:select id="workflowagent2" name="workflowagent2" list="#attr.workflowagentlist" width="150px"
                               listKey="key" listValue="value" defaultValue="${workflowagent}"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td colspan="3">
                <div id="conditionowners" name="conditionowners"></div>
                <input type="hidden" id="conditionowner" name="conditionowner"/>
            </td>
        </tr>
    </table>
</div>
<c:if test="${(stepmain['steptypeid'] eq 3)}">
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div class="stk-ui-bar stk-table-opt-bar">
            <table width="80%" style="cellspacing:1px; bordercolor:black;">
                <tr>
                    <td>
                        <ui:button icon="ui-icon-plusthick" text="添加目标处理">
                            <event:onclick>
                                showaddownerlinkwindow(0);
                            </event:onclick>
                        </ui:button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <ui:button icon="ui-icon-minusthick" text="删除目标处理">
                            <event:onclick>
                                deleteOwnerLink();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
        </div>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table id="ownerlinktable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <input type="hidden" name="ownerlinkmark" id="ownerlinkmark" value="-1">
                <input type="hidden" name="ownerlinkIds" id="ownerlinkIds">
                <tr>
                    <th class="stk-table-th" align="center" width="8%">
                        <input type="checkbox" id="ownerCheckbox" name="ownerCheckbox"
                               onclick="selectallownerlink(this);">
                    </th>
                    <th class="stk-table-th" align="center" width="120px">来源种类</th>
                    <th class="stk-table-th" align="center">来源范围</th>
                    <th class="stk-table-th" align="center">处理人员</th>
                    <th class="stk-table-th" align="center" width="60px">操作</th>
                    <th class="stk-table-th" align="center" width="120px">移动</th>
                </tr>
                <c:forEach items="${ownerlinklist}" var="ownerlinkmap">
                    <tr id="ownerlink${ownerlinkmap['objid']}">
                        <td class='stk-table-td' align='center' width='8%' style='border:1px #BBBBBB solid;'>
                            <input type='checkbox' id='${ownerlinkmap['objid']}' name='ownerlink'
                                   value="${ownerlinkmap['objid']}" onclick="selectmainownerlink();">
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['linkleafname']}</div>
                            <input type='hidden' id='ownertype${ownerlinkmap['objid']}'
                                   name='ownertype${ownerlinkmap['objid']}' value='${ownerlinkmap['linkleaf']}'>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['ownerstartershow']}</div>
                            <input type='hidden' id='ownerstarter${ownerlinkmap['objid']}'
                                   name='ownerstarter${ownerlinkmap['objid']}' value='${ownerlinkmap['ownerstarter']}'>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${ownerlinkmap['ownerendershow']}</div>
                            <input type='hidden' id='ownerender${ownerlinkmap['objid']}'
                                   name='ownerender${ownerlinkmap['objid']}' value='${ownerlinkmap['ownerender']}'>
                        </td>
                        <td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>
                            <a href='#'
                               onclick="editOwnerLinkInfo('${ownerlinkmap['ownerstarter']}','${ownerlinkmap['ownerender']}',${ownerlinkmap['objid']},${ownerlinkmap['linkleaf']},${ownerlinkmap['linkroot']});">编辑</a>
                        </td>
                        <td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>
                            <a href="#" onclick="moveOwnerUp(this)">上移</a>&nbsp;|&nbsp;<a href="#"
                                                                                          onclick="moveOwnerDown(this)">下移</a>
                            <input type='hidden' id='autoskip${ownerlinkmap['objid']}'
                                   name='autoskip${ownerlinkmap['objid']}' value='${ownerlinkmap['linkroot']}'>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</c:if>
<c:if test="${!(stepmain['steptypeid'] eq 2)}">
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div class="stk-ui-bar stk-table-opt-bar">
            <table width="90%" style="cellspacing:1px; bordercolor:black;">
                <tr>
                    <td>
                        <ui:button icon="ui-icon-plusthick" text="添加目标步骤">
                            <event:onclick>
                                showaddlinkwindow(0);
                            </event:onclick>
                        </ui:button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <ui:button icon="ui-icon-minusthick" text="删除目标步骤">
                            <event:onclick>
                                deleteLink();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
        </div>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table id="linktable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <input type="hidden" name="linkmark" id="linkmark" value="-1">
                <input type="hidden" name="linkIds" id="linkIds">
                <tr>
                    <th class="stk-table-th" align="center" width="8%">
                        <input type="checkbox" id="linkCheckbox" name="linkCheckbox" onclick="selectalllink(this);">
                    </th>
                    <th class="stk-table-th" align="center">条件</th>
                    <th class="stk-table-th" align="center">执行</th>
                    <th class="stk-table-th" align="center">目标步骤</th>
                    <th class="stk-table-th" align="center">操作</th>
                    <th class="stk-table-th" align="center">移动</th>
                </tr>
                <c:forEach items="${linklist}" var="linkmap">
                    <tr id="link${linkmap['objid']}">
                        <td class='stk-table-td' align='center' width='8%' style='border:1px #BBBBBB solid;'>
                            <input type='checkbox' id='${linkmap['objid']}' name='link' value="${linkmap['objid']}"
                                   onclick="selectmainlink()">
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <c:forEach items="${linkmap['linkiflist']}" var="linkif">
                                <div style='padding-left:7px;padding-top:5px;'>${linkif['ifshow']}</div>
                            </c:forEach>
                            <input type='hidden' id='linkif${linkmap['objid']}' name='linkif${linkmap['objid']}'
                                   value="${linkmap['linkifs']}">
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <c:forEach items="${linkmap['linkdolist']}" var="linkdo">
                                <div style='padding-left:7px;padding-top:5px;'>${linkdo['doshow']}</div>
                            </c:forEach>
                            <input type='hidden' id='linkdo${linkmap['objid']}' name='linkdo${linkmap['objid']}'
                                   value="${linkmap['linkdos']}">
                        </td>
                        <td class='stk-table-td'
                            style='border:1px #BBBBBB solid;padding-left:7px;'>${linkmap['aftstepname']}
                            <input type='hidden' id='linktarget${linkmap['objid']}' name='linktarget${linkmap['objid']}'
                                   value='${linkmap['aftstepid']}'>
                        </td>
                        <td align='center' class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <a href='#'
                               onclick="editLinkInfo('${linkmap['linkifs']}','${linkmap['linkdos']}',${linkmap['aftstepid']},${linkmap['objid']});">编辑</a>
                        </td>
                        <td class="stk-table-td" align="center" style="border:1px #BBBBBB solid;">
                            <a href="#" onclick="moveUp(this)">上移</a>&nbsp;|&nbsp;<a href="#" onclick="moveDown(this)">下移</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
</c:if>
<c:if test="${!(stepmain['steptypeid'] eq 2)}">
    <div style="padding-top:20px;">
    <c:if test="${(stepmain['steptypeid'] eq 3) or (stepmain['steptypeid'] eq 7)}">
        <table width="90%">
            <tr>
                <td class="bd" width="60px">任务提醒</td>
                <td style="padding-left:7px;" width="270px">
                    <ui:select list="#attr.messagemap" id="messageremind" name="messageremind" headerKey="" width="100%"
                               headerValue="无提醒"
                               defaultValue="${stepcondition['messageremind']}"/>
                </td>
                <td style="padding-left:7px;"></td>
            </tr>
        </table>
        </div>
        <div style="padding-top:5px;">
    </c:if>
    <table width="90%">
        <tr>
            <td class="bd" width="60px">消息通知</td>
            <td style="padding-left:7px;" width="270px">
                <ui:select list="#attr.messagemap" id="messagenotice" name="messagenotice" headerKey="" width="100%"
                           headerValue="无提醒"
                           defaultValue="${stepcondition['messagenotice']}"/>
            </td>
            <td style="padding-left:7px;" width="100px">
                <ui:button text="选择通知人">
                    <event:onclick>
                        show('user','noticeowners','noticeowner','wwww');
                    </event:onclick>
                </ui:button>
            </td>
            <td style="padding-left:7px;" width="270px">
                <ui:select id="specialnoticer" name="specialnoticer" list="#attr.stepdealerlist" width="150px"
                           headerKey="0" headerValue="无特殊逻辑"
                           listKey="key" listValue="value" defaultValue="${stepcondition.specialnoticer}"/>
            </td>
            <td style="padding-left:7px;"></td>
        </tr>
        <tr>
            <td colspan="5">
                <div id="noticeowners" name="noticeowners"></div>
                <input type="hidden" id="noticeowner" name="noticeowner"/>
            </td>
        </tr>
            <%--多消息提醒 <c:forEach begin="1" end="10" var="nctnum">
                <tr>
                    <td class="bd" width="60px">&nbsp</td>
                    <td style="padding-left:7px;" width="270px">
                        <ui:select list="#attr.messagemap" id="messagenotice${nctnum}" name="messagenotice${nctnum}" headerKey="" width="100%" headerValue="无提醒"
                               defaultValue="${stepcondition['messagenotice'${nctnum}]}"/>
                    </td>
                    <td style="padding-left:7px;" width="100px">
                        <ui:button text="选择通知人">
                            <event:onclick>
                                &lt;%&ndash;show('user','noticeowners${nctnum}','noticeowner${nctnum}','wwww');&ndash;%&gt;
                            </event:onclick>
                        </ui:button>
                    </td>
                    <td style="padding-left:7px;" width="270px">
                        <ui:select id="specialnoticer${nctnum}" name="specialnoticer${nctnum}" list="#attr.stepdealerlist" width="150px" headerKey="0" headerValue="无特殊逻辑"
                                   listKey="key" listValue="value" defaultValue="${stepcondition['specialnoticer'${nctnum}]}"/>
                    </td>
                    <td style="padding-left:7px;"></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <div id="noticeowners${nctnum}" name="noticeowners${nctnum}"></div>
                        <input type="hidden" id="noticeowner${nctnum}" name="noticeowner${nctnum}"/>
                    </td>
                </tr>
            </c:forEach>--%>
    </table>
    </div>

    <div style="padding-top:5px;">
        <table width="90%">
            <tr>
                <td style="padding-left:7px;">
                    <ui:button text="配置候选人">
                        <event:onclick>
                            show('user','candidates','candidate','wwww');
                        </event:onclick>
                    </ui:button>
                </td>
                <td style="padding-left:7px;"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <div id="candidates" name="candidates"></div>
                    <input type="hidden" id="candidate" name="candidate"/>
                </td>
            </tr>
        </table>
    </div>
</c:if>
<div align="center" style="padding-top:15px;">
    <c:if test="${typemark eq 0}">
        <ui:button id="btsavestep" text="保存">
            <event:onclick>
                var ownerlinkIds = "";
                $("input[name='ownerlink']").each(function(){
                ownerlinkIds = ownerlinkIds +","+$(this).val();
                });
                $("#ownerlinkIds").stk_val(ownerlinkIds);

                var linkIds = "";
                $("input[name='link']").each(function() {
                linkIds = linkIds + "," + $(this).val();
                });
                $("#linkIds").stk_val(linkIds);

                $("#configstepform").stk_submit("savestepall", function(result) {
                if (result != null) {
                stk.alert(result);
                return;
                }
                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + ${processid}), "流程步骤列表", {keyWithoutParams:true,refresh:true});
                });
            </event:onclick>
        </ui:button>
        <ui:button id="btcanclestep" text="取消">
            <event:onclick>
                <%--window.opener.location.reload();--%>
                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + ${processid}), "流程步骤列表", {keyWithoutParams:true,refresh:true});
                <%--window.location.href = "/workflow/configurate/configuratestep.action?processid=" + ${processid}+"&stepid="+${stepid};--%>
            </event:onclick>
        </ui:button>
    </c:if>
    <c:if test="${typemark eq 1}">
        <ui:button id="btreturnstep" text="返回">
            <event:onclick>
                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/processstep.action?processid=" + ${processid}+"&type=1"), "流程步骤列表", {keyWithoutParams:true,refresh:true});
            </event:onclick>
        </ui:button>
    </c:if>
</div>
</ui:form>

<layout:window id="addownerlinkwindow" layout="row" title="编辑处理人" width="500px" height="300px">
    <ui:form id="addownerform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigStepAction" method="addowner">
        <input type="hidden" id="preownerlinkid" name="preownerlinkid">
        <table style="margin-top:4px;margin-left:10px;">
            <tr>
                <td width="100px" align="right"><label width="100%"><span style="font-weight:bold;">所属人类型</span></label>
                </td>
                <td style="padding-left:60px;" width="100px">
                    <ui:select list="#attr.ownerlinkoriginlist" name="ownerlinkorigin" id="ownerlinkorigin"
                               width="100px"
                               listKey="key" listValue="value">
                    </ui:select>
                </td>
                <td width="200px">
                </td>
            </tr>
        </table>
        <table style="margin-top:4px;margin-left:10px;">
            <tr>
                <td width="100px" align="right"><label width="100%"><span style="font-weight:bold;">所属人范围</span></label>
                </td>
                <td style="padding-left:60px;" width="100px">
                    <ui:button text="选择范围">
                        <event:onclick>
                            show('user','startowners','startowner','wwww');
                        </event:onclick>
                    </ui:button>
                </td>
                <td width="200px">
                </td>
            </tr>
            <tr>
                <td style="padding:0px;padding-left:30px;" colspan="3">
                    <div id="startowners" name="startowners"></div>
                    <input type="hidden" id="startowner" name="startowner" value=""/>
                </td>
            </tr>
        </table>
        <table style="margin-top:4px;margin-left:10px;">
            <tr>
                <td width="100px" align="right"><label width="100%"><span style="font-weight:bold;">处理人范围</span></label>
                </td>
                <td style="padding-left:60px;" width="100px">
                    <ui:button text="选择范围">
                        <event:onclick>
                            show('user','endowners','endowner','wwww');
                        </event:onclick>
                    </ui:button>
                </td>
                <td width="200px">
                    <ui:select list="#attr.autoskiplist" name="ownerautoskip" id="ownerautoskip" width="100px"
                               listKey="key" listValue="value">
                    </ui:select>
                </td>
            </tr>
            <tr>
                <td style="padding:0px;padding-left:30px;" colspan="3">
                    <div id="endowners" name="endowners"></div>
                    <input type="hidden" id="endowner" name="endowner" value=""/>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td style="padding-top:4px;padding-left:200px;">
                    <ui:button text="确定">
                        <event:onclick>
                            <%--stk.alert($("#endowner").stk_val());--%>
                            var preownerlinkid = $("#preownerlinkid").stk_val();
                            var linkorigin = $("#ownerlinkorigin").find("option:selected").text();
                            var linkoriginid = $("#ownerlinkorigin").find("option:selected").val();
                            var startowner = $("#startowner").stk_val();
                            var endowner = $("#endowner").stk_val();
                            var ownerautoskip = $("#ownerautoskip").stk_val();
                            hideownerlinkwindow();
                            refreshOwnerLinkTable(startowner,endowner,preownerlinkid,linkorigin,linkoriginid,ownerautoskip);
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="取消">
                        <event:onclick>
                            hideownerlinkwindow();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
    </ui:form>
</layout:window>

<layout:window id="addlinkwindow" layout="row" title="编辑步骤链接" width="500px" height="300px">
    <ui:form id="addlinkform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigStepAction" method="addlink">
        <input type="hidden" id="prelinkid" name="prelinkid">
        <table width="100%" id="stepConditionTable" style="margin-bottom:4px;">
            <tr>
                <td width="120px" align="right"><label width="100%"><span style="font-weight:bold;">步骤条件</span></label>
                </td>
                <td style="padding-left:140px;">
                        <%--type="hidden"--%>
                    <input type="hidden" id="stepifnum" name="stepifnum" value="${empty stepifnum ? 0 : stepifnum}">
                    <ui:button icon="ui-icon-plusthick" text="添加">
                        <event:onclick>
                            $("#stepCondition").stk_show();
                            if($("#stepifnum").stk_val()==20){
                            stk.alert("条件数量已达最大限制，添加失败！");
                            }else{
                            $("#stepifnum").stk_val(parseInt($("#stepifnum").stk_val())+1);
                            $("#stepifmain"+$("#stepifnum").stk_val()).parent().parent().parent().stk_show();
                            $("#stepifmain"+$("#stepifnum").stk_val()).stk_show();
                            $("#stepifand"+$("#stepifnum").stk_val()).stk_show();
                            <%--var select = $("#stepifand"+$("#stepifnum").stk_val());--%>
                            <%--var option1 = $("<option value='1'>=</option>");--%>
                            <%--var option2 = $("<option value='6'>!=</option>");--%>
                            <%--option1.appendTo(select);--%>
                            <%--option2.appendTo(select);--%>
                            $("#stepif2ads"+$("#stepifnum").stk_val()).stk_show();
                            $("#stepif3ads"+$("#stepifnum").stk_val()).stk_hide();
                            }
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button icon="ui-icon-minusthick" text="删除">
                        <event:onclick>
                            if($("#stepifnum").stk_val()==0){
                            stk.alert("已无可删除的条件，删除失败！");
                            }else{
                            $("#stepifmain"+$("#stepifnum").stk_val()).parent().parent().parent().stk_hide();
                            $("#stepifmain"+$("#stepifnum").stk_val()).stk_hide();
                            <%--$("#stepifmain"+$("#stepifnum").stk_val()).stk_val(0);--%>
                            $("#stepifmain"+$("#stepifnum").stk_val()).find('option').first().attr('selected','selected');
                            $("#stepifand"+$("#stepifnum").stk_val()).stk_hide();
                            <%--$("#stepifand"+$("#stepifnum").stk_val()).stk_val(-1);--%>
                            $("#stepifand"+$("#stepifnum").stk_val()).find('option').first().attr('selected','selected');
                            <%--fleshStepIf(parseInt($("#stepifnum").stk_val()),0);--%>
                            $("#stepif2ads"+$("#stepifnum").stk_val()).stk_hide();
                            $("#stepifnum").stk_val(parseInt($("#stepifnum").stk_val())-1);
                            }
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <table>
            <c:forEach begin="1" end="20" var="status">
                <tr style="display:none;">
                    <td style="padding-left:70px;padding-top:2px;">
                        <ui:select hidden="true" list="#attr.linkiftypelist" name="stepifmain${status}"
                                   id="stepifmain${status}"
                                   defaultValue="2" listKey="key" listValue="value" width="100px">
                            <event:onchange valVar="value">
                                addoptionsmain(${status});
                            </event:onchange>
                        </ui:select>
                    </td>
                        <%--specialmarklist--%>
                    <td style="padding-left:7px;padding-top:2px;">
                        <ui:select hidden="true" list="#attr.mathmarklist" name="stepifand${status}"
                                   id="stepifand${status}" defaultValue="1"
                                   listKey="key" listValue="value" width="60px">
                        </ui:select>

                        <ui:select hidden="true" list="#attr.linkifresult" name="stepif3ads${status}"
                                   id="stepif3ads${status}"
                                   listKey="key" listValue="value" defaultValue="0" width="60px">
                        </ui:select>
                    </td>
                    <td style="padding-left:7px;padding-top:2px;">
                        <ui:textfield hidden="true" id="stepif1ads${status}" name="stepif1ads${status}" width="100px;"
                                      defaultValue="${stepif1ads[status]}"/>
                        <ui:select hidden="false" list="#attr.judgeresultlist" name="stepif2ads${status}"
                                   id="stepif2ads${status}"
                                   listKey="key" listValue="value" defaultValue="1" width="100px">
                        </ui:select>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <table width="100%" id="stepConditionTable" style="margin-bottom:4px;">
            <tr>
                <td width="120px" align="right"><label width="100%"><span style="font-weight:bold;">步骤执行</span></label>
                </td>
                <td style="padding-left:140px;">
                        <%--type="hidden"--%>
                    <input type="hidden" id="stepdonum" name="stepdonum" value="${empty stepdonum ? 0 : stepdonum}">
                    <ui:button icon="ui-icon-plusthick" text="添加">
                        <event:onclick>
                            $("#stepCondition").stk_show();
                            if($("#stepdonum").stk_val()==20){
                            stk.alert("执行数量已达最大限制，添加失败！");
                            }else{
                            $("#stepdonum").stk_val(parseInt($("#stepdonum").stk_val())+1);
                            $("#stepdomain"+$("#stepdonum").stk_val()).parent().parent().parent().stk_show();
                            $("#stepdomain"+$("#stepdonum").stk_val()).stk_show();
                            }
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button icon="ui-icon-minusthick" text="删除">
                        <event:onclick>
                            if($("#stepdonum").stk_val()==0){
                            stk.alert("已无可删除的执行，删除失败！");
                            }else{
                            $("#stepdomain"+$("#stepdonum").stk_val()).parent().parent().parent().stk_hide();
                            $("#stepdomain"+$("#stepdonum").stk_val()).stk_hide();
                            $("#stepdomain"+$("#stepdonum").stk_val()).find('option').first().attr('selected','selected');
                            $("#stepdonum").stk_val(parseInt($("#stepdonum").stk_val())-1);
                            }
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <table>
            <c:forEach begin="1" end="20" var="status">
                <tr style="display:none;">
                    <td style="padding-left:70px;padding-top:2px;">
                        <ui:select hidden="true" list="#attr.specialtasklist" name="stepdomain${status}"
                                   id="stepdomain${status}"
                                   listKey="key" listValue="value" width="100px">
                        </ui:select>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <table style="margin-top:4px;">
            <tr>
                <td width="120px" align="right"><label width="100%"><span style="font-weight:bold;">链接目标</span></label>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td style="padding-left:70px;">
                    <ui:select list="#attr.steplist" name="targetstep" id="targetstep" width="100px"
                               listKey="objid" listValue="name" defaultValue="${stepid}">
                    </ui:select>
                </td>
            </tr>
            <tr>
                <td style="padding-top:4px;padding-left:200px;">
                    <ui:button text="确定">
                        <event:onclick>
                            var conditionNum = $("#stepifnum").stk_val();
                            var conditionArray = new Array();
                            var conditionMarkArray = new Array();
                            for(var i=1;i<=conditionNum;i++) {
                            var condition = $("#stepifmain" + i).find("option:selected").text();
                            var conditionId = $("#stepifmain" + i).find("option:selected").val();
                            var choice="";
                            var state="";
                            if(conditionId<100000){
                            choice = $("#stepifand" + i).find("option:selected").text();
                            state = $("#stepif2ads" + i).find("option:selected").text();
                            }
                            else if(conditionId>=100000){
                            state = $("#stepif3ads" + i).find("option:selected").text();
                            }
                            var choiceId = $("#stepifand" + i).find("option:selected").val();
                            var stateId = $("#stepif2ads" + i).find("option:selected").val();
                            if(conditionId>=100000){
                            stateId = $("#stepif3ads" + i).find("option:selected").val();
                            }
                            <%--stk.alert(conditionNum+":"+condition+" "+conditionId+";"+choice+" "+choiceId+";"+state+" "+stateId);--%>
                            var conditionDesc = "";
                            conditionDesc = condition + "&nbsp;" + choice + "&nbsp;" + state;
                            conditionArray.push(conditionDesc);
                            var conditionMarkDesc = conditionId + " " + choiceId + " " + stateId ;
                            conditionMarkArray.push(conditionMarkDesc);
                            }

                            var autotaskNum = $("#stepdonum").stk_val();
                            <%--alert(autotaskNum);--%>
                            var autotaskArray = new Array();
                            var autotaskMarkArray = new Array();
                            for(var i=1;i<=autotaskNum;i++) {
                            var autotask = $("#stepdomain" + i).find("option:selected").text();
                            var autotaskId = $("#stepdomain" + i).find("option:selected").val();
                            var autotaskDesc = autotask;
                            autotaskArray.push(autotask);
                            var autotaskMarkDesc = autotaskId;
                            autotaskMarkArray.push(autotaskId);
                            }

                            var target = $("#targetstep").find("option:selected").text();
                            var targetId = $("#targetstep").find("option:selected").val();
                            var linkId = $("#prelinkid").val();
                            <%--alert(linkId);--%>
                            hideLinkWindow();
                            refreshTable(conditionArray,conditionMarkArray,autotaskArray,autotaskMarkArray,target,targetId,linkId);
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="取消">
                        <event:onclick>
                            hideLinkWindow();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
    </ui:form>
</layout:window>

<jsp:include page="/org/searchorg/selectorginclude.jsp"></jsp:include>

</sirm:body>
</html>