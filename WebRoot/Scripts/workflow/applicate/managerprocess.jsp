<%@ page import="com.sinitek.sirm.busin.workflow.service.WorkflowServiceFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.sinitek.sirm.busin.workflow.enumerate.WorkflowStepOwnerStatus" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 12-2-16
  Time: 上午10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@ taglib prefix="org" uri="http://www.sinitek.com/sirm/org/tag" %>
<html>
<head><title>Simple jsp page</title>
    <%
        try {
            List<Map> _processtypelist = WorkflowServiceFactory.getWorkflowBaseService().findParaListByName("ProcessType");
            pageContext.setAttribute("processtypelist", _processtypelist);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    %>
    <%
        String statusinfo = WorkflowStepOwnerStatus.WF_OWNER_PEND.getEnumItemInfo();
    %>
    <script type="text/javascript">
        function loadbody() {
            $("#unfinishtable").stk_query();
            $("#finishedtable").stk_query();
        }
        function terminateProcess(data) {
            stk.confirm("确认终止吗？", function() {
//                $("#checkBoxPlugin").stk_call({type:'1',exampleid:data.exampleid}, function(result) {
//                    stk.alert(data.processbrief + result, "提示");
//                    $("#unfinishtable").stk_query();
//                    $("#finishedtable").stk_query();
//                });
                stk.call({
                    className:'com.sinitek.sirm.web.workflow.applicate.ManagerProcessAction',
                    method:'endExample',
                    param:{exampleid:data.exampleid},
                    callBack:function(result) {
                        stk.alert(data.processbrief + result, "提示");
                        $("#unfinishtable").stk_query();
                        $("#finishedtable").stk_query();
                    }
                });
            });
        }
        function changeprocessname(value, num) {
            jQuery.ajax({
                url:"${contextPath}/workflow/applicate/getprocessname.action?type="+value,
                cache:false,
                success:function (result) {
                    var option = $("<option value='-1'>所有此类流程</option>");
                    if (num == 1) {
                        $("#processname1").empty();
                        var select = $("#processname1");
                        option.appendTo(select);
                        if (result != null) {
                            var option2 = $(result);
                            option2.appendTo(select);
                        }
                        $('#processname1').stk_val(-1);
                    } else if (num == 2) {
                        $("#processname2").empty();
                        var select = $("#processname2");
                        option.appendTo(select);
                        if (result != null) {
                            var option2 = $(result);
                            option2.appendTo(select);
                        }
                        $('#processname2').stk_val(-1);
                    }
                },
                error:function (a, b, c) {
                }
            });
        }
        function changeprocessname2(value, num) {
            var params = {type:value};
            stk.call({className:'com.sinitek.sirm.web.workflow.applicate.ManagerTaskAction',method:'changeprocess',param:params,callBack:function(result) {
                var option = $("<option value='-1'>所有此类流程</option>");
                if (num == 1) {
                    $("#processname1").empty();
                    var select = $("#processname1");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname1').stk_val(-1);
                } else if (num == 2) {
                    $("#processname2").empty();
                    var select = $("#processname2");
                    option.appendTo(select);
                    if (result != null) {
                        var option2 = $(result);
                        option2.appendTo(select);
                    }
                    $('#processname2').stk_val(-1);
                }
            }
            });
        }
        function editTransferInfo(data) {
            var _ownernames = data.ownernames;
//            stk.alert(_ownernames);
            stk.debug(data);
        }
        $(document).ready(function () {
//            loadbody();
        });
        function convertprocesswindow(ownername, ownerstatusvalue, exampleownerid, exampleid, examplestepid) {
            var title = "处理人转移";
            var finalname = "";
            var finalstatus = "";
            var finalid = "";
            var copyname = ownername;
            var copystatus = ownerstatusvalue;
            var copyid = exampleownerid;
//            alert("copyname = "+copyname+"  copystatus = "+copystatus+"  copyid = "+copyid);
            var stat = "<%=statusinfo%>";
            var i = 1;
            for (var j = 1; j <= 20; j++) {
                $("#oldname" + j).stk_hide();
                $("#newname" + j).stk_hide();
            }
            while (copyname.indexOf("*") > 0) {
                var nowname = copyname.substring(0, copyname.indexOf("*"));
                var nowstatus = copystatus.substring(0, copystatus.indexOf("*"));
                var nowid = copyid.substring(0, copyid.indexOf("*"));
//                alert("nowname = "+nowname+"  status = "+nowstatus+"  id = "+nowid);
                if (nowstatus.indexOf(stat) < 0) {
//                    alert(nowstatus);
                    i -= 1;
                }
                else {
//                    alert("正确");
                    finalname = finalname == "" ? nowname : finalname + "," + nowname;
                    finalstatus = finalstatus == "" ? nowstatus : finalstatus + "," + nowstatus;
                    finalid = finalid == "" ? nowid : finalid + "," + nowid;
//                    alert("finalname = "+finalname+"  finalstatus = "+finalstatus+"  finalid = "+finalid);
                    $("#oldname" + i).stk_show();
                    $("#newname" + i).stk_show();
                    $("#oldname" + i).stk_val(nowname);
                    sirm.org.searchorg.owner1SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner2SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner3SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner4SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner5SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner6SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner7SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner8SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner9SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner10SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner11SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner12SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner13SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner14SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner15SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner16SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner17SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner18SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner19SearchUser._user_emptyContent();
                    sirm.org.searchorg.owner20SearchUser._user_emptyContent();
                }

                copyname = copyname.substring(copyname.indexOf("*") + 1, copyname.length);
                copystatus = copystatus.substring(copystatus.indexOf("*") + 1, copystatus.length);
                copyid = copyid.substring(copyid.indexOf("*") + 1, copyid.length);
                i += 1;
//                alert("copyname = "+copyname+"  copystatus = "+copystatus+"  copyid = "+copyid);
            }
            var count = finalname.match(/,/g) == null ? 0 : finalname.match(/,/g).length + 1;
//            alert("count = " + count);
            i = 1;

            $("#examplestepid").val(examplestepid);
            $("#exampleid").val(exampleid);
            $("#examplestepownerid").val(finalid);
            $("#transferwindow").stk_show({title:title});
        }
        function transfer() {
            $("#transferform").stk_submit("dotransfer", function(result) {
                if (result == null) {
                    stk.alert("没有将任何一个任务转移，请重新选择转移人");
                    return;
                }
                stk.alert(result);
                $('#transferwindow').stk_hide();
                $("#unfinishtable").stk_query();
            })
        }
        function showprocess(exampleid){
            var params = {exampleid:exampleid};
            stk.call({className:'com.sinitek.sirm.web.workflow.applicate.ManagerProcessDbHistoryAction',method:'showprocess',param:params,callBack:function(result) {
                if(result==null){
                    stk.alert("该任务没有配置查看URL");
                }else{
                    $(document).stk_go(result,"查看任务",{keyWithoutParams:true});
                }
            }});
        }


        // **********************   调整处理人     **********************

        function addOwner(owner){
//            stk.debug(owner);
            _user_emptyValue("addowner");

            var ownerarr = owner.split(":");
            if(ownerarr.length == 3){
                if(document.getElementById("tr_addowner" + ownerarr[0])){
                    return;
                }

                var _table = $("#stepownertable3");
                var _tr = $("<tr id=\"tr_addowner" + ownerarr[0] + "\" name=\"tr_addowner\" ownerid=\"" + ownerarr[0] + "\"></tr>");
                var _td = $("<td style='padding-top: 2px'></td>");
                _td.appendTo(_tr);
                _td.append("<laber></laber>").append(ownerarr[1]);
                _td.append("&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"$(this).parent().parent().remove()\">删除</a>");
                _tr.appendTo(_table);
            }

        }
        function changeOwner(exampleownerid, ownername){
            $("#changeownerwindow").stk_show();
            $("#oldowner").stk_text(ownername);
            _user_emptyValue("newowner");
            $("#tmpexampleownerid").stk_val(exampleownerid);
        }
        function deleteOwner(obj, exampleownerid, ownername){
            $(obj).parent().parent().remove();
            var _deleteownerids = $("#deleteownerids").stk_val();
            _deleteownerids += StringUtils.isBlank(_deleteownerids)?exampleownerid:","+exampleownerid;
            $("#deleteownerids").stk_val(_deleteownerids);
        }
        function adjustExampleOwner(data){
//            stk.debug(data);
            $("#adjustownerwindow").stk_show();
            $("#stepname").stk_text(data.processstepname);
            $("#stepownertable3").empty();
            $("#examplestepid").stk_val(data.examplestepid);

            _user_emptyValue("addowner");

            var _undotable = $("#stepownertable").empty();
            var _doneownerstr = new Array();
            var _ownerlist = data.ownerlist;
            for(var i = 0;i<_ownerlist.length;i++){
                var _owner = _ownerlist[i];
                var _tr = $("<tr id=\"tr_owner" + _owner.exampleownerid + "\"></tr>");
                var _td = $("<td></td>");
                _td.appendTo(_tr);
                _td.append("<label id=\"_label" + _owner.exampleownerid + "\"></label>");
                _td.append("<input type=\"hidden\" id=\"_changeownerid" + _owner.exampleownerid + "\" exampleownerid=\"" + _owner.exampleownerid + "\"/>");
                if(_owner.ownerstatusvalue == "待处理" || _owner.ownerstatusvalue == "正在处理"){
                    _td.append("&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"changeOwner('" + _owner.exampleownerid + "','" + _owner.ownername + "')\">转移</a>");
//                    _td.append("&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\"javascript:void(0)\" onclick=\"deleteOwner(this,'" + _owner.exampleownerid + "','" + _owner.ownername + "')\">删除</a>");
                    _tr.appendTo(_undotable);
                    $("#_label" + _owner.exampleownerid).stk_text(_owner.ownername);
                }else{
                    _doneownerstr.push(_owner.ownername);
                }
            }
            $("#stepownertable2").stk_text(_doneownerstr.toString());

            $("#newownerids").stk_val("");
            $("#deleteownerids").stk_val("");
        }

        function saveExampleOwner(){
            var newownerArray = new Array();
//            $("#stepownertable3 tr").each(function(){
//                var ownerid = $(this).attr("ownerid");
//                newownerArray.push(ownerid);
//            });
            var _addowners = $("#_addowner_candidateHidden").stk_val();
            if(StringUtils.isNotBlank(_addowners)){
                var _ownersArr = _addowners.split(",");
                for(var i = 0; i < _ownersArr.length; i++){
                    var _owner = _ownersArr[i];
                    var _ownerArr = _owner.split(":");
                    if(_ownerArr.length == 3){
                        newownerArray.push(_ownerArr[0]);
                    }
                }
            }
            $("#newownerids").stk_val(newownerArray.toString());

            var changeownerArray = new Array();
            $("#stepownertable input").each(function(){
                var ownerid = $(this).attr("exampleownerid");
                if(StringUtils.isNotBlank($(this).stk_val())){
                    changeownerArray.push(ownerid);
                }
            });
            $("#changeownerids").stk_val(changeownerArray.toString());

            stk.confirm("确定调整？", function(){
                $("#adjustexampleownerform").stk_submit("adjustExampleOwner", function(result){
                    if(StringUtils.isNotBlank(result)){
                        stk.alert(result);
                    }else{
                        stk.alert("调整成功","提示");
                        $('#adjustownerwindow').stk_hide();
                        $("#unfinishtable").stk_query();
                    }
                });
            });
        }
    </script>
</head>
<sirm:body>
<div align="center">
    <layout:tabs id="demo" width="100%" tabWidth="110px">
        <layout:tab title="未完成" id="unfinishtab">
            <form id="unfinishform">
                <plugin:colLink id="workflowmain2" dataVar="data">
                    <%--$(document).stk_go("/workflow/applicate/showworkflow.action?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true});    --%>
                    $(document).stk_go(sirm.jsurl("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid),"流程详细列表",{keyWithoutParams:true,refresh:true});
                </plugin:colLink>
                <plugin:colLink id="condition2" dataVar="data" text="终止">
                    terminateProcess(data);
                </plugin:colLink>
                <plugin:colLink id="condition4" dataVar="data" text="转移">
                    <%--convertprocesswindow(data.ownername,data.ownerstatusvalue,data.exampleownerid,data.exampleid,data.examplestepid);--%>
                    adjustExampleOwner(data);
                </plugin:colLink>
                <plugin:colLink id="condition1" dataVar="data" text="查看">
                    if(data.showurl!=null&&data.showurl.length>0){
                    $(document).stk_go(sirm.jsurl(data.showurl2),"查看任务",{keyWithoutParams:true});
                    }else{
                    stk.alert("该任务没有配置查看URL");
                    }
                    <%--$(document).stk_go(data.showurl+"?exampleid=" + data.exampleid+"&examplestepid="+data.examplestepid+"&exampleownerid="+data.exampleownerid,"处理任务",{keyWithoutParams:true});--%>
                </plugin:colLink>
                <%--<plugin:colCheckbox id="checkBoxPlugin" name="check" dataVar="data" checkedVar="checked"/>--%>
                <div class="search-params-bar">
                <table width="100%">
                    <tr>
                        <td class="tit" width="200px;">
                            <label>流程类型</label>
                            <ui:select id="processtype1" name="processtype1" list="#attr.processtypelist"
                                       listKey="key" listValue="value" width="120px"
                                       headerKey="-1" headerValue="所有流程类型" defaultValue="-1">
                                <event:onchange valVar="value">
                                    changeprocessname(value,1);
                                </event:onchange>
                            </ui:select>
                        </td>
                        <td class="tit" width="320px;">
                            <label>开始时间</label>
                            <ui:datefield id="starttime" endDate="endtime" name="starttime" width="100px"/>
                            <label>到</label>
                            <ui:datefield id="endtime" startDate="starttime" name="endtime" width="100px"/>
                        </td>
                        <td class="tit" width="170px;">
                            <label>流程描述</label>
                            <ui:textfield id="brief1" name="brief1" width="100px"/>
                        </td>
                        <td class="tit" width="60px;">
                            <ui:button text="查询">
                                <event:onclick>
                                    $("#unfinishtable").stk_query();
                                </event:onclick>
                            </ui:button>
                        </td>
                        <td class="tit"></td>
                    </tr>
                    <tr>
                        <td class="tit">
                            <label>流程名称</label>
                            <ui:select id="processname1" name="processname1" listKey="key" listValue="value"
                                       width="120px"
                                       headerKey="-1" headerValue="所有此类流程" defaultValue="-1"/>
                        </td>
                        <td class="tit">
                            <label>发起人</label>
                            <jsp:include page="/org/searchorg/searchuserinclude.jsp">
                                <jsp:param name="prefix" value="starter1"/>
                                <jsp:param name="showdiv" value="false"/>
                                <jsp:param name="relationDiv" value="indusryRelationDiv"/>
                                <jsp:param name="width" value="120px"/>
                            </jsp:include>
                            <ui:checkbox id="startertype1" name="startertype1" value="1">系统
                                <event:onclick checkedVar="value">
                                    if(value==true){
                                    $("#_starter1_searchUser").attr("disabled","true");
                                    }else{
                                    $("#_starter1_searchUser").removeAttr("disabled");
                                    }
                                </event:onclick>
                            </ui:checkbox>
                        </td>
                        <td class="tit">
                        </td>
                        <td class="tit">
                        </td>
                        <td class="tit">
                        </td>
                    </tr>
                </table>
                </div>
                <ui:table id="unfinishtable" queryForm="unfinishform" nowrap="true" allowInit="true"
                          actionClass="com.sinitek.sirm.web.workflow.applicate.ManagerProcessAction"
                          pageSize="10">
                    <%--<ui:col plugin="checkBoxPlugin" show="false" width="0px" align="center"/>--%>
                    <ui:col property="processname" title="流程名称" align="left" width="100px" allowSort="false"
                            allowTip="true"/>
                    <ui:col property="processstatusvalue" title="流程状态" align="left" width="60px" allowSort="false"/>
                    <%--<ui:col property="startername" title="发起人" align="left" width="80px" allowSort="false"/>  --%>
                    <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="80px"
                                allowSort="false"/>
                    <ui:col plugin="workflowmain2" align="left" property="processbrief" allowTip="true" title="流程描述"
                            width="50%" allowSort="false"/>
                    <ui:col property="processstepname" title="步骤名称" align="left" width="80px" allowSort="false"
                            allowTip="true"/>
                    <ui:col property="steptypevalue" title="步骤类型" width="60px" allowSort="false"/>
                    <ui:colDate property="stepstarttime" title="开始时间" width="120px" format="yyyy-MM-dd HH:mm"
                                allowSort="false"/>
                    <ui:col property="ownernames" title="处理人" align="left" width="30%" allowSort="false"
                            allowTip="true"/>
                    <%--<ui:colCust property="ownerids" method="getownernames" title="处理人" width="50%" allowSort="false"/>--%>
                    <ui:col plugin="condition2,condition4,condition1" property="ownerlist" title="操作" allowSort="false" width="120px"/>
                    <%--<ui:col plugin="condition2" property="ownerlist" title="操作" width="100px"/>--%>
                </ui:table>
            </form>
        </layout:tab>
        <layout:tab title="已完成" id="finishedtab">
            <form id="finishedform">
                <plugin:colLink id="workflowmain1" dataVar="data">
                    <%--$(document).stk_go("/workflow/applicate/showworkflow.action?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true});--%>
                    $(document).stk_go(sirm.jsurl("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid),"流程详细列表",{keyWithoutParams:true,refresh:true});
                </plugin:colLink>
                <plugin:colLink id="condition3" dataVar="data" text="查看">
                    <%--if(data.showurl!=null&&data.showurl.length>0){--%>
                    <%--$(document).stk_go(data.showurl2,"查看任务",{keyWithoutParams:true});--%>
                    <%--}else{--%>
                    <%--stk.alert("该任务没有配置查看URL");--%>
                    <%--}--%>
                    showprocess(data.exampleid);
                    <%--$(document).stk_go(data.showurl+"?exampleid=" + data.exampleid+"&examplestepid="+data.examplestepid+"&exampleownerid="+data.exampleownerid,"处理任务",{keyWithoutParams:true});--%>
                </plugin:colLink>
                <div class="search-params-bar">
                <table width="100%">
                    <tr>
                        <td class="tit" width="200px;">
                            <label>流程类型</label>
                            <ui:select id="processtype2" name="processtype2" list="#attr.processtypelist"
                                       listKey="key" listValue="value" width="120px"
                                       headerKey="-1" headerValue="所有流程类型" defaultValue="-1">
                                <event:onchange valVar="value">
                                    changeprocessname(value,2);
                                </event:onchange>
                            </ui:select>
                        </td>
                        <td class="tit" width="320px;">
                            <label>开始时间</label>
                            <ui:datefield id="starttime1" endDate="endtime1" name="starttime1" width="100px"/>
                            <label>到</label>
                            <ui:datefield id="endtime1" startDate="starttime1" name="endtime1" width="100px"/>
                        </td>
                        <td class="tit" width="320px;">
                            <label>结束时间</label>
                            <ui:datefield id="starttime2" endDate="endtime2" name="starttime2" width="100px"/>
                            <label>到</label>
                            <ui:datefield id="endtime2" startDate="starttime2" name="endtime2" width="100px"/>
                        </td>
                        <td class="tit" width="60px;">
                            <ui:button text="查询">
                                <event:onclick>
                                    $("#finishedtable").stk_query();
                                </event:onclick>
                            </ui:button>
                        </td>
                        <td class="tit"></td>
                    </tr>
                    <tr>
                        <td class="tit">
                            <label>流程名称</label>
                            <ui:select id="processname2" name="processname2" listKey="key" listValue="value"
                                       width="120px"
                                       headerKey="-1" headerValue="所有此类流程" defaultValue="-1"/>
                        </td>
                        <td class="tit">
                            <label>发起人</label>
                            <jsp:include page="/org/searchorg/searchuserinclude.jsp">
                                <jsp:param name="prefix" value="starter2"/>
                                <jsp:param name="showdiv" value="false"/>
                                <jsp:param name="relationDiv" value="indusryRelationDiv"/>
                                <jsp:param name="width" value="120px"/>
                            </jsp:include>
                            <ui:checkbox id="startertype2" name="startertype2" value="1">系统
                                <event:onclick checkedVar="value">
                                    if(value==true){
                                    $("#_starter2_searchUser").attr("disabled","true");
                                    }else{
                                    $("#_starter2_searchUser").removeAttr("disabled");
                                    }
                                </event:onclick>
                            </ui:checkbox>
                        </td>
                        <td class="tit">
                            <label>流程描述</label>
                            <ui:textfield id="brief2" name="brief2" width="100px"/>
                        </td>
                        <td class="tit">
                        </td>
                        <td class="tit"></td>
                    </tr>
                </table>
                </div>
                <ui:table id="finishedtable" queryForm="finishedform" nowrap="true" allowInit="false"
                          actionClass="com.sinitek.sirm.web.workflow.applicate.ManagerProcessDbHistoryAction"
                          pageSize="10">
                    <ui:col property="processname" title="流程名称" align="left" width="120px" allowSort="false"
                            allowTip="true"/>
                    <ui:col property="processstatusvalue" title="流程状态" width="60px" align="left" allowSort="false"/>
                    <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="80px"
                                allowSort="false"/>
                    <ui:col plugin="workflowmain1" align="left" property="processbrief" title="流程描述" allowTip="true"
                            allowSort="false"/>
                    <ui:colCust property="exampleid" method="getstarttime" title="开始时间" width="120px"
                                allowSort="false"/>
                    <ui:colCust property="exampleid" method="getendtime" title="结束时间" width="120px"
                                allowSort="false"/>
                    <ui:col plugin="condition3" property="ownerlist" title="操作"  allowSort="false"  width="60px"/>
                </ui:table>
            </form>
        </layout:tab>
        <event:ontabselect tabVar="tab">
            if(tab.id=='unfinishtab'){
            $("#unfinishtable").stk_query();
            }else if(tab.id=='finishedtab'){
            $("#finishedtable").stk_query();
            }
        </event:ontabselect>
    </layout:tabs>
</div>


<layout:window id="adjustownerwindow" title="处理人调整" width="400px">
    <ui:form id="adjustexampleownerform" method="adjustExampleOwner"
             clazz="com.sinitek.sirm.web.workflow.applicate.ManagerProcessAction">
        <input type="hidden" id="examplestepid"/>
        <input type="hidden" id="deleteownerids"/>
        <input type="hidden" id="newownerids"/>
        <input type="hidden" id="changeownerids"/>
        <table class="stk-form-ui-st1">
            <tr>
                <td class="hd" width="80px">步骤名称</td>
                <td class="bd">
                    <ui:label id="stepname"/>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">待处理人</td>
                <td class="bd">
                    <table id="stepownertable"></table>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px" nowrap="true">已处理人</td>
                <td class="bd">
                    <ui:label id="stepownertable2"></ui:label>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">新增处理人</td>
                <td class="bd">
                    <%--<table>--%>
                        <%--<tr>--%>
                            <%--<td width="150px">--%>
                                <org:SelectOrg prefix="addowner" mode="user" multi="true" width="100px"/>
                            <%--</td>--%>
                            <%--<td style="padding-top: 10px">--%>
                                <%--<ui:button id="cb_addstepowner" name="cb_addstepowner" text="添加">--%>
                                    <%--<event:onclick>--%>
                                        <%--var _addowner = $("#_addowner_candidateHidden").stk_val();--%>
                                        <%--if(StringUtils.isNotBlank(_addowner)){--%>
                                        <%--addOwner(_addowner);--%>
                                        <%--}else{--%>
                                        <%--stk.alert("请选择要添加的人员");--%>
                                        <%--}--%>
                                    <%--</event:onclick>--%>
                                <%--</ui:button>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                        <%--<tr>--%>
                            <%--<td>--%>
                                <%--<table id="stepownertable3"></table>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                    <%--</table>--%>
                </td>
            </tr>
        </table>
        <div style="padding:10px 0 5px 130px">
            <ui:button text="确定">
                <event:onclick>
                    saveExampleOwner();
                </event:onclick>
            </ui:button>&nbsp;
            <ui:button text="关闭">
                <event:onclick>
                    $('#adjustownerwindow').stk_hide();
                </event:onclick>
            </ui:button>
        </div>
    </ui:form>
</layout:window>

<layout:window id="changeownerwindow" layout="row" title="更换处理人" width="350px">
    <ui:form id="changeownerform">
        <input type="hidden" id="tmpexampleownerid"/>
        <table class="stk-form-ui-st1">
            <tr>
                <td class="hd" width="80px">原处理人</td>
                <td class="bd">
                    <ui:label id="oldowner"></ui:label>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">新处理人<em>*</em></td>
                <td class="bd">
                    <org:SelectOrg prefix="newowner" mode="user" multi="false" width="120px"/>
                </td>
            </tr>
        </table>
        <div style="padding:10px 0 5px 130px">
            <ui:button text="确定">
                <event:onclick>
                    if($("#changeownerform").stk_checkForm()){
                        var _exampleownerid = $("#tmpexampleownerid").stk_val();
                        var _oldowner = $("#oldowner").stk_text();
                        var _newowner = $("#_newowner_candidateHidden").stk_val().split(":");
                        $("#_label" + _exampleownerid).stk_text(_oldowner + " -> " + _newowner[1]);
                        $("#_changeownerid" + _exampleownerid).stk_val(_newowner[0]);
                        $('#changeownerwindow').stk_hide();
                    }
                </event:onclick>
            </ui:button>&nbsp;
            <ui:button text="关闭">
                <event:onclick>
                    $('#changeownerwindow').stk_hide();
                </event:onclick>
            </ui:button>
        </div>
        <func:checkers>
            <func:checker target="_newowner_candidateHidden" allowBlank="false" blankText="请选择新处理人"/>
        </func:checkers>
    </ui:form>
</layout:window>


<%--<layout:window id="transferwindow" layout="row" title="任务转移" width="350px" height="200px">--%>
    <%--<ui:form id="transferform" clazz="com.sinitek.sirm.web.workflow.applicate.ManagerProcessDbAction"--%>
             <%--method="dotransfer">--%>
        <%--<input type="hidden" id="exampleid" name="exampleid">--%>
        <%--<input type="hidden" id="examplestepid" name="examplestepid">--%>
        <%--<input type="hidden" id="examplestepownerid" name="examplestepownerid">--%>
        <%--<table style="margin-left: 20px;">--%>
            <%--<tr>--%>
                <%--<td>原处理人</td>--%>
                <%--<td>新处理人</td>--%>
            <%--</tr>--%>
            <%--<c:forEach begin="1" end="20" var="status">--%>
                <%--<tr>--%>
                    <%--<td width="150px">--%>
                        <%--<ui:textfield readOnly="true" hidden="true" id="oldname${status}" name="oldname${status}"--%>
                                      <%--width="120px"/>--%>
                    <%--</td>--%>
                    <%--<td width="150px">--%>
                        <%--<ui:label hidden="true" id="newname${status}" name="newname${status}">--%>
                            <%--<jsp:include page="/org/searchorg/searchuserinclude.jsp">--%>
                                <%--<jsp:param name="prefix" value="owner${status}"/>--%>
                                <%--<jsp:param name="showdiv" value="false"/>--%>
                                <%--<jsp:param name="relationDiv" value="indusryRelationDiv"/>--%>
                                <%--<jsp:param name="width" value="120px"/>--%>
                            <%--</jsp:include>--%>
                        <%--</ui:label>--%>
                    <%--</td>--%>
                <%--</tr>--%>
            <%--</c:forEach>--%>
            <%--<tr>--%>
                <%--<td colspan="2" align="center" style="padding-top:5px;">--%>
                    <%--<ui:button id="fntbtn" text="转移">--%>
                        <%--<event:onclick>--%>
                            <%--transfer();--%>
                        <%--</event:onclick>--%>
                    <%--</ui:button>&nbsp;--%>
                    <%--<ui:button text="关闭">--%>
                        <%--<event:onclick>--%>
                            <%--$('#transferwindow').stk_hide();--%>
                        <%--</event:onclick>--%>
                    <%--</ui:button>--%>
                <%--</td>--%>
            <%--</tr>--%>
        <%--</table>--%>
    <%--</ui:form>--%>
<%--</layout:window>--%>
</sirm:body>
</html>