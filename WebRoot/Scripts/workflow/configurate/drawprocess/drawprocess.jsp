<%--
  Created by IntelliJ IDEA.
  User: HF.fay
  Date: 14-4-15
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<sirm:page clazz="com.sinitek.sirm.web.workflow.configurate.drawprocess.DrawProcessAction"/>

<html>
<head>
    <title>流程配置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <script type="text/javascript">
//        初始化数据， 从服务器获取。

//----------------  selectEditor  ----------------
var _specialtaskList = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getSpecialTaskList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _specialtaskList = eval(data);
        }
    }
});
var _pointtypelist = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getPointtypeList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _pointtypelist = eval(data);
        }
    }
});
var _processurllist = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getProcessUrlList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _processurllist = eval(data);
        }
    }
});
var _submitownerlist = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getSubmitOwnerList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _submitownerlist = eval(data);
        }
    }
});
var _stepdealerlist = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getStepDealerList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _stepdealerlist = eval(data);
        }
    }
});
var _messageremindlist = "";
$.ajax({
    type: "POST",
    url: "${path}/workflow/configurate/drawprocess/getMessageRemindList.action?processtype=${processtype}",
    async: false,
    success: function (data) {
        var _opts = eval(data);
        if(_opts && _opts.length) {
            _messageremindlist = eval(data);
        }
    }
});

//------------------------------------------------
        var _stepconditionlist = "";
        $.ajax({
            type: "POST",
            url: "${path}/workflow/configurate/drawprocess/getStepConditionList.action?processtype=${processtype}",
            async: false,
            success: function (data) {
                var _opts = eval(data);
                if(_opts && _opts.length) {
                    _stepconditionlist = eval(data);
                }
            }
        });

        var _judgetypeList = "";
        $.ajax({
            type: "POST",
            url: "${path}/workflow/configurate/drawprocess/getJudgeTypeList.action?processtype=${processtype}",
            async: false,
            success: function (data) {
                var _opts = eval(data);
                if(_opts && _opts.length) {
                    _judgetypeList = eval(data);
                }
            }
        });

        var _messagenoticelist = "";
        $.ajax({
            type: "POST",
            url: "${path}/workflow/configurate/drawprocess/getMessageNoticeList.action?processtype=${processtype}",
            async: false,
            success: function (data) {
                var _opts = eval(data);
                if(_opts && _opts.length) {
                    _messagenoticelist = eval(data);
                }
            }
        });

        var _ownerlink = "";
        $.ajax({
            type: "POST",
            url: "${path}/workflow/configurate/drawprocess/getOwnerLinkOriginListJSON.action",
            async: false,
            success: function (data) {
                var _opts = eval(data);
                if(_opts && _opts.length) {
                    _ownerlink = eval(data)[0];
                }
            }
        });
    </script>

    <link type="text/css" href="myflow.css" rel="stylesheet"/>
    <script type="text/javascript" src="lib/raphael-min.js"></script>
    <script type="text/javascript" src="myflow.js"></script>
    <script type="text/javascript" src="myflow.jpdl4.js"></script>
    <script type="text/javascript" src="myflow.editors.js"></script>


    <script type="text/javascript">

        $(document).ready(function () {

            $('#myflow').myflow({
                processtype: "${processtype}",
                showtype: false,
                editable: ${editable},
                basePath: "${path}",
                restore: eval(${flowdata}),
                iscancel: false,
                tools: {
                    save: {
                        onclick: function (data) {
//                            stk.debug(data);
                            saveMyflow(data);
                        }
                    },
                    showorg: {
                        onclick: function (relationDiv, hiddenname) {
                            show("user", relationDiv, hiddenname, "wwww", "");
                        }
                    }
                }
            });

            if(${not empty svgwidth && not empty svgheight}){
                $("#myflow").children().first().width(Number(${svgwidth})).height(Number(${svgheight}));
                $("#setSvgSizeForm").find("input[name='svgwidth']").val(Number(${svgwidth}));
                $("#setSvgSizeForm").find("input[name='svgheight']").val(Number(${svgheight}));
            }


            $("#pointer").click();

            $("#myflow").click(function () {
                $("#pointer").click();
            });

            stretchHeight($("#showdrawflowdiv"), 30);

            $('#myflow_props').show();
            stretchHeight($("#myflow_props_table"), 100);
            $('#myflow_props').hide();
        });

        var stretchHeight = function (targetobj, delta) {
            var sf = function () {
                var tableWrap = $(targetobj);
                var tableOffset = tableWrap.offset();
                var documentHeight = $(window).height();
                var tableHeight = documentHeight - tableOffset.top - (delta == undefined ? 0 : delta);
                tableWrap.css("max-height", tableHeight);
            };
            sf();
            $(window).resize(function () {
                sf();
            });
        };

        function saveMyflow(_flowData) {
            stk.call({
                className: "com.sinitek.sirm.web.workflow.configurate.drawprocess.DrawProcessAction",
                method: 'saveMyflow',
                param: {
                    myflow: _flowData,
                    processid: '${processid}'
                },
                callBack: function (result) {
                    if (StringUtils.isNotBlank(result)) {
                        stk.alert(result);
                        return;
                    }
                    stk.alert("保存成功", "提示");
                },
                exceptionHandler: function (message, e) {
                    stk.error(message)
                }
            })
        }

    </script>
</head>
<sirm:body >

<div id="showdrawflowdiv" style="padding-top:0px; overflow: scroll" class="myflow_bg">

    <jsp:include page="/org/searchorg/selectorginclude.jsp"></jsp:include>

    <div id="myflow_tools" class="ui-widget-content">
        <div id="myflow_tools_handle" class="ui-widget-header">工具集</div>

        <div class="node" id="myflow_save"><img src="img/save.gif"/><span>保存</span></div>
        <div>
            <hr/>
        </div>
        <div class="node selectable" id="pointer"><img src="img/select16.gif"/><span>选择</span></div>
        <div class="node selectable" id="path"><img src="img/16/flow_sequence.png"/><span>指向</span></div>
            <%--<div class="node selectable" id="line"><img src="img/16/flow_line.png"/><span>关联</span></div>--%>
        <div>
            <hr/>
        </div>
        <div class="node state" id="start" type="start"><img src="img/16/start_event_empty.png"/><span>开始</span></div>
        <div class="node state" id="submit" type="submit"><img src="img/16/task_yellow.png"/><span>提交</span></div>
        <div class="node state" id="judge" type="judge"><img src="img/16/task_empty2.png"/><span>处理</span></div>
            <%--<div class="node state" id="linkif" type="linkif"><img src="img/16/gateway_parallel.png"/><span>条件</span></div>--%>
        <div class="node state" id="state" type="state"><img src="img/16/task_empty.png"/><span>条件</span></div>
            <%--<div class="node state" id="task" type="task"><img src="img/16/task_java.png"/><span>任务</span></div>--%>
        <div class="node state" id="end" type="end"><img src="img/16/end_event_terminate.png"/><span>结束</span></div>
            <%--<div>--%>
            <%--<hr/>--%>
            <%--</div>--%>
            <%--<div class="node state" id="fork" type="fork"><img src="img/16/gateway_parallel.png"/><span>分支</span></div>--%>
            <%--<div class="node state" id="join" type="join"><img src="img/16/gateway_parallel.png"/><span>合并</span></div>--%>
            <%--<div class="node state" id="end-cancel" type="end-cancel"><img src="img/16/end_event_cancel.png"/><span>取消</span></div>--%>
            <%--<div class="node state" id="end-error" type="end-error"><img src="img/16/end_event_error.png"/><span>错误</span></div>--%>
        <div>
            <hr/>
        </div>
        <div style="text-align: center">
            <c:if test="${editable}">
                <button type="button" onclick="$('#setSvgSizeWindow').stk_show();" class="stk-button stk-button-st-3">
                    <span>面板大小</span>
                </button>
            </c:if>
        </div>
    </div>


    <div id="myflow_props" class="ui-widget-content">
        <div id="myflow_props_handle" class="ui-widget-header">
            <span>属性</span>
            <b class="closeicon" onclick="$('#myflow_close_bt').click();"></b>
        </div>
        <div id="myflow_props_table" style="overflow-y: auto;overflow-x: hidden;">
            <table class="stk-form-ui-st1">
            </table>
        </div>
        <div style="padding-top: 2px; text-align: center;">
            <c:if test="${editable}">
                <button id="myflow_save_bt" class="stk-button stk-button-st-3">确定</button>
                &nbsp;&nbsp;
            </c:if>
            <button id="myflow_close_bt" class="stk-button stk-button-st-3">${editable==true? "取消":"关闭"}</button>
        </div>
    </div>


    <div id="myflow"></div>

</div>
    <script type="text/javascript">
        function saveSvgSize() {
            if ($("#setSvgSizeForm").stk_checkForm()) {
            $("#setSvgSizeForm").stk_submit(function (result){
                if(result != null){
                    stk.alert(result);
                    return;
                }
                var width = $("#setSvgSizeForm").find("input[name='svgwidth']").val();
                var height = $("#setSvgSizeForm").find("input[name='svgheight']").val();
                $("#myflow").children().first().width(Number(width)).height(Number(height));
                $("#setSvgSizeWindow").stk_hide();
            });
            }
        }
    </script>
    <layout:window id="setSvgSizeWindow" width="300px" title="设置面板大小">
        <ui:form id="setSvgSizeForm" clazz="com.sinitek.sirm.web.workflow.configurate.drawprocess.DrawProcessAction"
                 method="saveSvgSize">
            <input type="hidden" name="processid" value="${processid}">

            <div style="width:100%">
                <div>
                    <table class="stk-form-ui-st1">
                        <tr>
                            <td class="hd" width="80px">宽度：</td>
                            <td class="bd" width="auto">
                                <ui:textfield name="svgwidth" width="150px" defaultValue="3000"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="hd" width="80px">高度：</td>
                            <td class="bd" width="auto">
                                <ui:textfield name="svgheight" width="150px" defaultValue="1000"/>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="padding:3px 0 3px 80px">
                    <ui:button text="保存">
                        <event:onclick>
                            saveSvgSize();
                        </event:onclick>
                    </ui:button>&nbsp;
                    <ui:button text="关闭">
                        <event:onclick>
                            $("#setSvgSizeWindow").stk_hide();
                        </event:onclick>
                    </ui:button>
                </div>
            </div>
            <func:checkers>
                <func:checker target="svgwidth" allowBlank="false" blankText="请输入宽度" regex="^[0-9]*$"
                              regexText="宽度必须为整数"/>
                <func:checker target="svgheight" allowBlank="false" blankText="请输入高度" regex="^[0-9]*$"
                              regexText="高度必须为整数"/>
            </func:checkers>
        </ui:form>
    </layout:window>


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
        $("input[name='ownerlink']").each(function () {
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

    function deleteOwnerLink() {
        var checkCount = 0;
        $("input[name='ownerlink']").each(function () {
            if ($(this).attr("checked") == true) {
                checkCount++;
            }
        });
        if (checkCount == 0) {
            stk.alert("请选择要删除的项");
            return;
        } else {
            stk.confirm("确认删除吗？", function () {
                $("input[name='ownerlink']").each(function () {
                    if ($(this).attr("checked") == true) {
                        $(this).parent().parent().remove();
                    }
                });
                $("#ownerCheckbox").attr("checked", false);
            });
        }
    }

    function editOwnerLinkInfo(startowner, endowner, linkmark, linkoriginid, autoskip) {
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

    function refreshOwnerLinkTable(startowner, endowner, preownerlinkid, linkorigin, linkoriginid, ownerautoskip) {
        var table = $("#ownerlinktable");
        var linkmark = preownerlinkid;
        var tr;
        if (linkmark == 0) {
            linkmark = $("#ownerlinkmark").val();
            $("#ownerlinkmark").val(linkmark - 1);
            tr = $("<tr class=\"ownerlinktr\" id=\"ownerlink" + linkmark + "\"></tr>");
        } else {
            var tr0 = $("#ownerlink" + linkmark);
            tr0.html("");
            tr = tr0;
        }

        var td0 = $("<td class='stk-table-td' align='center' width='4%' style='border:1px #BBBBBB solid;'>" +
                "<input type='checkbox' id='" + linkmark + "' name='ownerlink' value=" + linkmark + " onclick=\"selectmainownerlink();\"></td>");
        var td1 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
        var td2 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
        var td3 = $("<td class='stk-table-td' style='border:1px #BBBBBB solid;'></td>");
        var param = "<a href='javascript:void(0)' onclick=\"editOwnerLinkInfo('" + startowner + "','" + endowner + "'," + linkmark + "," + linkoriginid + "," + ownerautoskip + ");\">编辑</a>";
        var tdInfo = "<td align='center' class='stk-table-td' style='border:1px #BBBBBB solid;'>" + param + "</td>";
        var td4 = $(tdInfo);
        var td5 = $("<td class='stk-table-td' align='center' style='border:1px #BBBBBB solid;'>" +
                "<input type='hidden' id='autoskip" + linkmark + "' name='autoskip" + linkmark + "' value='" + ownerautoskip + "'/>" +
                "<a href='javascript:void(0)' onclick='moveOwnerUp(this)'><b class=\"icon-st16\"></b></a>&nbsp;|&nbsp;" +
                "<a href='javascript:void(0)' onclick='moveOwnerDown(this)'><b class=\"icon-st17\"></a>" + "</td>");

        $("<div style='padding-left:7px;padding-top:5px;'>" + linkorigin + "</div>" +
                "<input type='hidden' id='ownertype" + linkmark + "' name='ownertype" + linkmark + "' value='" + linkoriginid + "'/>").appendTo(td1);

        if (startowner != null && startowner.length != 0) {
            var starter = "";
            var starterArr = startowner.split(",");
            for (var i = 0; i < starterArr.length; i++) {
                var starterArrArr = starterArr[i].split(":");
                starter += starterArrArr[1] + "，";
            }
            $("<div style='padding-left:7px;padding-top:5px;'>" + starter.substring(0, starter.length - 1) + "</div>" +
                    "<input type='hidden' id='ownerstarter" + linkmark + "' name='ownerstarter" + linkmark + "' value='" + startowner + "'>").appendTo(td2);
        }
        if (endowner != null && endowner.length != 0) {
            var ender = "";
            var enderArr = endowner.split(",");
            for (var i = 0; i < enderArr.length; i++) {
                var enderArrArr = enderArr[i].split(":");
                ender += enderArrArr[1] + "，";
            }
            $("<div style='padding-left:7px;padding-top:5px;'>" + ender.substring(0, ender.length - 1) + "</div>" +
                    "<input type='hidden' id='ownerender" + linkmark + "' name='ownerender" + linkmark + "' value='" + endowner + "'>").appendTo(td3);
        }

        td0.appendTo(tr);
        td1.appendTo(tr);
        td2.appendTo(tr);
        td3.appendTo(tr);
        td4.appendTo(tr);
        td5.appendTo(tr);
        if (preownerlinkid == 0) {
            tr.appendTo(table);
        }
    }

    function saveOwnerLink() {
        var ownerlinkIds = new Array();
        var ownertypes = new Array();
        var ownerstarters = "";
        var ownerenders = "";
        var autoskips = new Array();
        $("input[name='ownerlink']").each(function (i) {
            var _ownerlinkid = $(this).val();
            var _ownertype = $("#ownertype" + _ownerlinkid).val();
            var _ownerstarter = $("#ownerstarter" + _ownerlinkid).val() == undefined ? "" : $("#ownerstarter" + _ownerlinkid).val();
            var _ownerender = $("#ownerender" + _ownerlinkid).val() == undefined ? "" : $("#ownerender" + _ownerlinkid).val();
            var _autoskip = $("#autoskip" + _ownerlinkid).val();
            ownerlinkIds.push(_ownerlinkid);
            ownertypes.push(_ownertype);
            ownerstarters += i == 0 ? "" : ";";
            ownerenders += i == 0 ? "" : ";";
            ownerstarters += _ownerstarter;
            ownerenders += _ownerender;
            autoskips.push(_autoskip);
        });
        $("#ownerlinkIds").stk_val(ownerlinkIds.toString());
        $("#ownertypes").stk_val(ownertypes.toString());
        $("#ownerstarters").stk_val(ownerstarters);
        $("#ownerenders").stk_val(ownerenders);
        $("#autoskips").stk_val(autoskips.toString());
        $("#managerownerlinkwindow").stk_hide();
    }
    </script>

    <layout:window id="managerownerlinkwindow" width="650px" title="编辑目标处理">
        <ui:form>
            <div class="stk_component_wrap" style="margin:5px;">
                <table>
                    <tr>
                        <td>
                            <ui:button icon="ui-icon-plusthick" text="添加">
                                <event:onclick>
                                    showaddownerlinkwindow(0);
                                </event:onclick>
                            </ui:button>&nbsp;&nbsp;
                            <ui:button icon="ui-icon-minusthick" text="删除">
                                <event:onclick>
                                    deleteOwnerLink();
                                </event:onclick>
                            </ui:button>&nbsp;&nbsp;
                            <ui:button icon="ui-icon-disk" text="保存">
                                <event:onclick>
                                    saveOwnerLink();
                                </event:onclick>
                            </ui:button>&nbsp;&nbsp;
                            <ui:button icon="ui-icon-closethick" text="关闭">
                                <event:onclick>
                                    $("#managerownerlinkwindow").stk_hide();
                                </event:onclick>
                            </ui:button>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-top: 5px">
                            <table id="ownerlinktable" class="stk-table" width="100%"
                                   style="min-height: 30px; table-layout: fixed;">
                                <input type="hidden" name="ownerlinkmark" id="ownerlinkmark" value="-1">
                                <input type="hidden" name="ownerlinkIds" id="ownerlinkIds" value="">
                                <input type="hidden" name="ownertypes" id="ownertypes" value="">
                                <input type="hidden" name="ownerstarters" id="ownerstarters" value="">
                                <input type="hidden" name="ownerenders" id="ownerenders" value="">
                                <input type="hidden" name="autoskips" id="autoskips" value="">
                                <tr>
                                    <th class="stk-table-th" align="center" width="4%">
                                        <input type="checkbox" id="ownerCheckbox" name="ownerCheckbox"
                                               onclick="selectallownerlink(this);">
                                    </th>
                                    <th class="stk-table-th" align="center" width="100px">来源种类</th>
                                    <th class="stk-table-th" align="center">来源范围</th>
                                    <th class="stk-table-th" align="center">处理人员</th>
                                    <th class="stk-table-th" align="center" width="60px">操作</th>
                                    <th class="stk-table-th" align="center" width="80px">移动</th>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </ui:form>
    </layout:window>

    <layout:window id="addownerlinkwindow" layout="row" title="编辑处理人" width="500px">
        <ui:form id="addownerform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigStepAction" method="addowner">
            <input type="hidden" id="preownerlinkid" name="preownerlinkid">
            <table class="stk-form-ui-st1" style="margin:4px;">
                <tr>
                    <td class="hd" width="100px" align="right"><label width="100%"><span
                            style="font-weight:bold;">所属人类型</span></label></td>
                    <td class="bd">
                        <ui:select list="#attr.ownerlinkoriginlist" name="ownerlinkorigin" id="ownerlinkorigin"
                                   width="100px" listKey="key" listValue="value">
                        </ui:select>
                    </td>
                    <td class="bd">
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="100px" align="right"><label width="100%"><span
                            style="font-weight:bold;">所属人范围</span></label></td>
                    <td class="bd" colspan="2">
                        <ui:button text="选择范围">
                            <event:onclick>
                                show('user','startowners','startowner','wwww');
                            </event:onclick>
                        </ui:button>
                        <div id="startowners" name="startowners"></div>
                        <input type="hidden" id="startowner" name="startowner" value=""/>
                    </td>
                </tr>
                <tr>
                    <td class="hd" width="100px" rowspan="2"><label width="100%"><span
                            style="font-weight:bold;">处理人范围</span></label></td>
                    <td class="bd">
                        <ui:button text="选择范围">
                            <event:onclick>
                                show('user','endowners','endowner','wwww');
                            </event:onclick>
                        </ui:button>
                    </td>
                    <td class="bd">
                        <ui:select list="#attr.autoskiplist" name="ownerautoskip" id="ownerautoskip" width="100px"
                                   listKey="key" listValue="value">
                        </ui:select>
                    </td>
                </tr>
                <tr>
                    <td class="bd" colspan="2">
                        <div id="endowners" name="endowners"></div>
                        <input type="hidden" id="endowner" name="endowner" value=""/>
                    </td>
                </tr>
            </table>
            <div style="padding:4px 0 5px 200px; ">
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
            </div>
        </ui:form>
    </layout:window>

    <layout:window id="showownerlinkwindow" width="650px" title="编辑目标处理">
        <ui:form>
            <div class="stk_component_wrap" style="margin:5px;">
                <table>
                    <tr>
                        <td style="padding-top: 5px">
                            <table id="showownerlinktable" class="stk-table" width="100%"
                                   style="min-height: 30px; table-layout: fixed;">
                                <tr>
                                    <th class="stk-table-th" align="center" width="100px">来源种类</th>
                                    <th class="stk-table-th" align="center">来源范围</th>
                                    <th class="stk-table-th" align="center">处理人员</th>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </ui:form>
    </layout:window>

</sirm:body>
</html>
