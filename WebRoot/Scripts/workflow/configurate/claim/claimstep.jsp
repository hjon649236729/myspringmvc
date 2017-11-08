<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-7-23
  Time: 下午4:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<sirm:page clazz="com.sinitek.sirm.web.workflow.configurate.claim.ClaimStepAction"/>
<html>
<head>
    <title>流程步骤列表</title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#name").stk_checkInputContent(30);
            $("#name").stk_val("${subject.name}");
            $("#name").stk_checkerReset();
            $("#stepName").stk_checkInputContent(30);
            $("#processBrief").stk_checkInputContent(60);
            $("#processBrief").stk_val("${subject.brief}");
            $("#processBrief").stk_checkerReset();
        });
        function selectAllStep(obj) {
            if ($(obj).attr("checked") == true) {
                $("input[name='stepBox']").attr("checked", true);
            } else {
                $("input[name='stepBox']").attr("checked", false);
            }
        }
        function selectMainStep() {
            var checkmark = 1;
            $("input[name='stepBox']").each(function () {
                if ($(this).attr("checked") == false) {
                    checkmark = 0;
                }
            });
            if (checkmark == 1) {
                $("input[name='stepsBox']").attr("checked", true);
            } else {
                $("input[name='stepsBox']").attr("checked", false);
            }
        }
        function moveStepUp(obj) {
            var rowCount = $("#stepTable tr").size();
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
        function moveStepDown(obj) {
            var rowCount = $("#stepTable tr").size();
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
        function deleteStep() {
            var checkCount = 0;
            $("input[name='stepBox']").each(function () {
                if ($(this).attr("checked") == true) {
                    checkCount++;
                }
            });
            if (checkCount == 0) {
                stk.alert("请选择要删除的项");
                return;
            } else {
                stk.confirm("确认删除吗？", function () {
                    $("input[name='stepBox']").each(function () {
                        if ($(this).attr("checked") == true) {
                            $(this).parent().parent().remove();
                        }
                    });
                    $("#stepsBox").attr("checked", false);
                });
            }
        }
        function showEditStepWindow() {
//            alert(1);
            $("#preStepId").stk_val(0);
            $("#stepName").stk_val("");
            $("#stepName").stk_checkerReset();
            $("#dealOwners").stk_html("");
            $("#dealOwner").stk_val("");
            $("#judgeType").stk_val(1);
            $("#cooJudge").stk_val(1);
            $("#cooJudgeAds").stk_val("");
            $("#cooJudge").stk_hide();
            $("#cooJudgeAds").stk_hide();
            $("#editStepWindow").stk_show();
        }
        function showEditStepWindow2(stepMark, stepName, judgeTypeId, judgeUrlId, dealOwner) {
            showEditStepWindow();
            $("#preStepId").stk_val(stepMark);
            $("#stepName").stk_val(stepName);
            $("#stepName").stk_checkerReset();
            var judgeTypeArr = judgeTypeId.split(" ");
            $("#judgeType").stk_val(judgeTypeArr[0]);
            if (judgeTypeArr[0] == 1) {
                $("#cooJudge").stk_hide();
                $("#cooJudgeAds").stk_hide();
            } else if (judgeTypeArr[0] == 2) {
                $("#cooJudge").stk_val(judgeTypeArr[1]);
                $("#cooJudgeAds").stk_val(judgeTypeArr[2]);
                $("#cooJudge").stk_show();
                $("#cooJudgeAds").stk_show();
            }
            $("#judgeUrl").stk_val(judgeUrlId);
            if (dealOwner != null && dealOwner.length > 0) {
                showframe("user", "dealOwners", "dealOwner", "www", dealOwner);
            }
        }
        function hideEditStepWindow() {
            $("#editStepWindow").stk_hide();
        }
        function freshStepTable(preStepId, stepName, judgeType, judgeTypeId, judgeUrl, judgeUrlId, dealOwner) {
            var table = $("#stepTable");
            var stepMark = preStepId;
            var tr;
            if (stepMark == 0) {
                stepMark = $("#stepMark").val();
                $("#stepMark").val(stepMark - 1);
                tr = $("<tr id='stepId" + stepMark + "'></tr>");
                tr.appendTo(table);
            } else {
                var tr = $("#stepId" + stepMark);
                tr.html("");
            }
            var td0 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'></td>");
            var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
            var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
            var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
            var td4 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
            var td5 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'></td>");
            var td6 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'></td>");

            var div0 = $("<input type='checkbox' id='" + stepMark + "' name='stepBox' value=" + stepMark + " onclick=\"selectMainStep();\">");
            div0.appendTo(td0);
            var div1 = $("<div style='padding-left:7px;padding-top:5px;'>" + stepName + "</div>");
            var hid1 = $("<input type='hidden' name='stepName" + stepMark + "' value='" + stepName + "'>");
            div1.appendTo(td1);
            hid1.appendTo(td1);
            var div2 = $("<div style='padding-left:7px;padding-top:5px;'>" + judgeType + "</div>");
            var hid2 = $("<input type='hidden' name='judgeType" + stepMark + "' value='" + judgeTypeId + "'>");
            div2.appendTo(td2);
            hid2.appendTo(td2);

            var dealer = "";
            if (dealOwner != null && dealOwner.length != 0) {
                var dealerArr = dealOwner.split(",");
                for (var i = 0; i < dealerArr.length; i++) {
                    var dealerArrArr = dealerArr[i].split(":");
                    dealer += dealerArrArr[1] + "，";
                }
            } else {
                dealer = "  ";
            }
            var div3 = $("<div style='padding-left:7px;padding-top:5px;'>" + dealer.substring(0, dealer.length - 1) + "</div>");
            var hid3 = $("<input type='hidden' name='dealOwner" + stepMark + "' value='" + dealOwner + "'>");
            div3.appendTo(td3);
            hid3.appendTo(td3);
            var div4 = $("<div style='padding-left:7px;padding-top:5px;'>" + judgeUrl + "</div>");
            var hid4 = $("<input type='hidden' name='judgeUrl" + stepMark + "' value='" + judgeUrlId + "'>");
            div4.appendTo(td4);
            hid4.appendTo(td4);
            var div5 = $("<a href='#' onclick=\"showEditStepWindow2(" + stepMark + ",'" + stepName + "','" + judgeTypeId + "'," + judgeUrlId + ",'" + dealOwner + "');\">编辑</a>");
            div5.appendTo(td5);
            var div6 = $("<a href='#' onclick='moveStepUp(this)'>上移</a>&nbsp;|&nbsp;<a href='#' onclick='moveStepDown(this)'>下移</a>");
            div6.appendTo(td6);

            td0.appendTo(tr);
            td1.appendTo(tr);
            td2.appendTo(tr);
            td3.appendTo(tr);
            td4.appendTo(tr);
            td5.appendTo(tr);
            td6.appendTo(tr);
        }
    </script>
</head>
<sirm:body>
<ui:form id="processForm" clazz="com.sinitek.sirm.web.workflow.configurate.claim.ClaimStepAction" method="saveSteps">
    <input type="hidden" id="processId" name="processId" value="${subject.processId}">

    <div class="stk_component_wrap" style="width:90%;">
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
                    <label>${processType}</label>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">修改页面</td>
                <td class="bd" width="auto">
                    <ui:select id="editUrl" name="editUrl" list="#attr.processUrlList" width="200px"
                               listKey="key" listValue="name" defaultValue="${subject.editUrl}"/>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">流程备注</td>
                <td class="bd" width="auto">
                    <ui:textarea id="processBrief" name="processBrief" rows="3" width="200px" defaultValue="${subject.brief}"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div class="stk-ui-bar stk-table-opt-bar">
            <table width="80%" style="cellspacing:1px; bordercolor:black;">
                <tr>
                    <td>
                        <ui:button icon="ui-icon-plusthick" text="添加步骤">
                            <event:onclick>
                                showEditStepWindow();
                            </event:onclick>
                        </ui:button>&nbsp;&nbsp;&nbsp;&nbsp;
                        <ui:button icon="ui-icon-minusthick" text="删除步骤">
                            <event:onclick>
                                deleteStep();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
        </div>
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table id="stepTable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <input type="hidden" name="stepMark" id="stepMark" value="-1">
                <input type="hidden" name="stepIds" id="stepIds">
                <tr>
                    <th class="stk-table-th" align="center" width="8%">
                        <input type="checkbox" id="stepsBox" name="stepsBox"
                               onclick="selectAllStep(this);">
                    </th>
                    <th class="stk-table-th" align="center" width="120px">步骤名称</th>
                    <th class="stk-table-th" align="center" width="160px">处理类型</th>
                    <th class="stk-table-th" align="center">处理人员</th>
                    <th class="stk-table-th" align="center" width="160px">处理页面</th>
                    <th class="stk-table-th" align="center" width="60px">操作</th>
                    <th class="stk-table-th" align="center" width="120px">移动</th>
                </tr>
                <c:forEach items="${stepList}" var="stepMap">
                    <tr id="stepId${stepMap.stepId}">
                        <td class='stk-table-td' align='center' width='8%' style='border:1px #BBBBBB solid;'>
                            <input type='checkbox' id='${stepMap.stepId}' name='stepBox'
                                   value="${stepMap.stepId}" onclick="selectMainStep();">
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.name}</div>
                            <input type='hidden' name='stepName${stepMap.stepId}' value='${stepMap.name}'>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.judgeTypeS}</div>
                            <input type='hidden' name='judgeType${stepMap.stepId}' value='${stepMap.judgeType}'>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.ownerName}</div>
                            <input type='hidden' name='dealOwner${stepMap.stepId}' value='${stepMap.owner}'>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.urlName}</div>
                            <input type='hidden' name='judgeUrl${stepMap.stepId}' value='${stepMap.url}'>
                        </td>
                        <td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>
                            <a href='#'
                               onclick="showEditStepWindow2(${stepMap.stepId},'${stepMap.name}','${stepMap.judgeType}',${stepMap.url},'${stepMap.owner}');">编辑</a>
                        </td>
                        <td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>
                            <a href="#" onclick="moveStepUp(this)">上移</a>&nbsp;|&nbsp;<a href="#"
                                                                                         onclick="moveStepDown(this)">下移</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div style="border-style: solid; border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table>
                <tr>
                    <td style="padding-top:4px;padding-left:200px;">
                        <ui:button text="确定">
                            <event:onclick>
                                if($("#processForm").stk_checkForm()){
                                var stepIds = "";
                                $("input[name='stepBox']").each(function(){
                                stepIds = stepIds +","+$(this).val();
                                });
                                $("#stepIds").stk_val(stepIds);
                                $("#processForm").stk_submit("saveSteps", function(result) {
                                if (result != "") {
                                stk.alert(result);
                                return;
                                }
                                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/claim/claimprocess.jsp"), "串行流程配置", {keyWithoutParams: true});
                                });
                                }
                            </event:onclick>
                        </ui:button>&nbsp;
                        <ui:button text="返回">
                            <event:onclick>
                                $(document).stk_navigate(sirm.jsurl("/workflow/configurate/claim/claimprocess.jsp"), "串行流程配置", {keyWithoutParams: true});
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <func:checkers>
        <func:checker target="name" allowBlank="false" blankText="流程名称不可以为空"/>
    </func:checkers>
</ui:form>
<layout:window id="editStepWindow" layout="row" title="编辑步骤" width="500px" height="300px">
    <ui:form id="stepForm">
        <input type="hidden" id="preStepId" name="preStepId">
        <table class="stk-form-ui-st1" border="0">
            <tr>
                <td class="hd" width="80px">步骤名称<em>*</em></td>
                <td class="bd" width="auto">
                    <ui:textfield id="stepName" name="stepName" width="200px"/>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">处理类型</td>
                <td class="bd" width="auto">
                    <table>
                        <tr>
                            <td>
                                <ui:select id="judgeType" name="judgeType" list="#attr.judgeTypeList" width="120px"
                                           listKey="key" listValue="value">
                                    <event:onchange>
                                        var judgetype=$("#judgeType").val();
                                        if(judgetype==1){
                                        $("#cooJudge").stk_hide();
                                        $("#cooJudgeAds").stk_hide();
                                        }else if(judgetype==2){
                                        $("#cooJudge").stk_show();
                                        $("#cooJudgeAds").stk_show();
                                        }
                                    </event:onchange>
                                </ui:select>
                            </td>
                            <td style="padding-left: 5px;">
                                <ui:select hidden="true" id="cooJudge" name="cooJudge" list="#attr.cooJudgeList"
                                           width="120px"
                                           listKey="key" listValue="value"/>
                            </td>
                            <td style="padding-left: 5px;">
                                <ui:textfield hidden="true" id="cooJudgeAds" name="cooJudgeAds"
                                              width="80px"></ui:textfield>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">处理页面</td>
                <td class="bd" width="auto">
                    <ui:select id="judgeUrl" name="judgeUrl" list="#attr.processUrlList" width="200px"
                               listKey="key" listValue="name"/>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">处理人员</td>
                <td class="bd" width="auto">
                    <ui:button text="选择范围">
                        <event:onclick>
                            show('user','dealOwners','dealOwner','wwww');
                        </event:onclick>
                    </ui:button>
                    <div id="dealOwners" name="dealOwners"></div>
                    <input type="hidden" id="dealOwner" name="dealOwner" value=""/>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td style="padding-top:4px;padding-left:200px;">
                    <ui:button text="确定">
                        <event:onclick>
                            if($("#stepForm").stk_checkForm()){
                            var preStepId = $("#preStepId").stk_val();
                            var stepName = $("#stepName").stk_val();
                            var judgeType = $("#judgeType").find("option:selected").text();
                            var judgeTypeId = $("#judgeType").find("option:selected").val();
                            if(judgeTypeId==2){
                            judgeType += "&nbsp;" + $("#cooJudge").find("option:selected").text();
                            judgeType += "&nbsp;" + $("#cooJudgeAds").val();
                            judgeTypeId += " " + $("#cooJudge").find("option:selected").val();
                            judgeTypeId += " " + $("#cooJudgeAds").val();
                            }
                            var judgeUrl = $("#judgeUrl").find("option:selected").text();
                            var judgeUrlId = $("#judgeUrl").find("option:selected").val();
                            var dealOwner = $("#dealOwner").stk_val();
                            hideEditStepWindow();
                            freshStepTable(preStepId,stepName,judgeType,judgeTypeId,judgeUrl,judgeUrlId,dealOwner);
                            }
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="取消">
                        <event:onclick>
                            hideEditStepWindow();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <func:checkers>
            <func:checker target="stepName" allowBlank="false" blankText="步骤名称不可以为空"/>
            <func:checker target="dealOwner" allowBlank="false" blankText="处理人员不可以没有"/>
        </func:checkers>
    </ui:form>
</layout:window>

<jsp:include page="/org/searchorg/selectorginclude.jsp"></jsp:include>
</sirm:body>
</html>