<%--
  Created by IntelliJ IDEA.
  User: HF.fay
  Date: 14-5-20
  Time: 15:10
  To change this template use File | Settings | File Templates.
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<sirm:page clazz="com.sinitek.sirm.web.workflow.include.ShowDrawflowAction"/>


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

<link type="text/css" href="${contextPath}/workflow/configurate/drawprocess/myflow.css" rel="stylesheet"/>
<script type="text/javascript" src="${contextPath}/workflow/configurate/drawprocess/lib/raphael-min.js"></script>
<script type="text/javascript" src="${contextPath}/workflow/configurate/drawprocess/myflow.js"></script>
<script type="text/javascript" src="${contextPath}/workflow/configurate/drawprocess/myflow.jpdl4.js"></script>
<script type="text/javascript" src="${contextPath}/workflow/configurate/drawprocess/myflow.editors.js"></script>


<script type="text/javascript">
    var _isfirst = true;
    $(document).ready(function () {

        if(_isfirst == true) {
            $('#myflow').myflow({
                processtype: "${processtype}",
                currentname: "${currentname}",
                currenttype: "${currenttype}",
                showtype: true,
                editable: false,
                basePath: "${path}",
                restore: eval(${flowdata}),
                tools: {
                    save: {
                        onclick: function (data) {
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
            _isfirst = false;
        }

        if(${not empty svgwidth && not empty svgheight}){
            $("#myflow").children().first().width(Number(${svgwidth})).height(Number(${svgheight}));
        }

        $("#pointer").click();

        $("#myflow").click(function () {
            $("#pointer").click();
        });

        stretchHeight($("#showdrawflowdiv"), 60);
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

</script>


<%--<div id="myflow_tools" class="ui-widget-content">--%>
<%--<div id="myflow_tools_handle" class="ui-widget-header">工具集</div>--%>

<%--<div class="node" id="myflow_save"><img src="img/save.gif"/><span>保存</span></div>--%>
<%--<div>--%>
<%--<hr/>--%>
<%--</div>--%>
<%--<div class="node selectable" id="pointer"><img src="img/select16.gif"/><span>选择</span></div>--%>
<%--<div class="node selectable" id="path"><img src="img/16/flow_sequence.png"/><span>指向</span></div>--%>
<%--<div>--%>
<%--<hr/>--%>
<%--</div>--%>
<%--<div class="node state" id="start" type="start"><img src="img/16/start_event_empty.png"/><span>开始</span></div>--%>
<%--<div class="node state" id="submit" type="submit"><img src="img/16/task_yellow.png"/><span>提交</span></div>--%>
<%--<div class="node state" id="judge" type="judge"><img src="img/16/task_empty.png"/><span>处理</span></div>--%>
<%--<div class="node state" id="state" type="state"><img src="img/16/task_empty2.png"/><span>条件</span></div>--%>
<%--<div class="node state" id="end" type="end"><img src="img/16/end_event_terminate.png"/><span>结束</span></div>--%>
<%--<div>--%>
<%--<hr/>--%>
<%--</div>--%>
<%--<div style="text-align: center"></div>--%>
<%--</div>--%>




<div id="showdrawflowdiv" style="padding-top:0px; overflow: scroll" class="myflow_bg">
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
            <button id="myflow_save_bt" class="stk-button stk-button-st-3">关闭</button>
        </div>
    </div>

    <div id="myflow"></div>
</div>



