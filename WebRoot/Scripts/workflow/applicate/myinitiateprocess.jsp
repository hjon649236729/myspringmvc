<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 13-11-11
  Time: 上午9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title>我发起的流程</title>
    <script type="text/javascript">
        function terminateProcess(data) {
//            stk.debug(data);
            var esoids = new Array();
            for (var i = 0; i < data.ownerlist.length; i++) {
                var _owner = data.ownerlist[i];
                esoids.push(_owner.exampleownerid);
            }

            stk.confirm("确认撤回吗？", function() {
                stk.call({
                    className:"com.sinitek.sirm.web.workflow.applicate.MyInitiateProcessAction",
                    method:'recoverprocess',
                    param:{'exampleid':data.exampleid,'examplestepid':data.examplestepid,'exampleowners':esoids.toString()},
                    callBack:function (result) {
                        stk.alert(data.processbrief + result, "提示");
                        $("#myinitiatetable").stk_query();
                    }
                });
            });
        }
    </script>
</head>
<sirm:body>
<layout:tabs>
    <layout:tab id="myinitiatetab" title="可撤回">

    <form id="myinitiateform">
        <table class="search-params-bar">
            <tr>
                <td class="tit" width="170px;">
                    <label>流程描述</label>
                    <ui:textfield id="brief" name="brief" width="100px"/>
                </td>
                <td class="tit" width="320px;">
                    <label>开始时间</label>
                    <ui:datefield id="starttime" endDate="endtime" name="starttimestart" width="100px"/>
                    <label>至</label>
                    <ui:datefield id="endtime" startDate="starttime" name="starttimeend" width="100px"/>
                </td>
                <td class="tit" width="60px;">
                    <ui:button text="查询" icon="ui-icon-search">
                        <event:onclick>
                            $("#myinitiatetable").stk_query();
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>

        <plugin:colLink id="workflowmain" dataVar="data">
            $(document).stk_go("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true});
        </plugin:colLink>
        <plugin:colLink id="condition" dataVar="data" text="撤回">
            terminateProcess(data);
        </plugin:colLink>
        <ui:table id="myinitiatetable" queryForm="myinitiateform" nowrap="true"
                  actionClass="com.sinitek.sirm.web.workflow.applicate.MyInitiateProcessAction"
                  pageSize="10">
            <%--<ui:col plugin="checkBoxPlugin" show="false" width="0px" align="center"/>--%>
            <ui:col property="processname" title="流程名称" align="left" width="100px" allowSort="false" allowTip="true"></ui:col>
            <ui:col property="processstatusvalue" title="流程状态" align="left" width="60px" allowSort="false"></ui:col>
            <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="80px" allowSort="false"/>
            <ui:col plugin="workflowmain" align="left" property="processbrief" allowTip="true" title="流程描述" width="50%" allowSort="false"></ui:col>
            <ui:col property="processstepname" title="步骤名称" align="left" width="80px" allowSort="false" allowTip="true"></ui:col>
            <ui:colDate property="stepstarttime" title="开始时间" width="120px" format="yyyy-MM-dd HH:mm" allowSort="false"></ui:colDate>
            <ui:col property="ownernames" title="处理人" align="left" width="50%" allowSort="false" allowTip="true"></ui:col>
            <ui:col plugin="condition" title="操作" width="60px"></ui:col>
        </ui:table>
    </form>
    </layout:tab>

    <layout:tab id="myrecovertab" title="已撤回">
        <form id="myrecoverform">
            <table class="search-params-bar">
                <tr>
                    <td class="tit" width="170px;">
                        <label>流程描述</label>
                        <ui:textfield id="brief2" name="brief" width="100px"/>
                    </td>
                    <td class="tit" width="320px;">
                        <label>开始时间</label>
                        <ui:datefield id="starttime2" endDate="endtime2" name="starttimestart" width="100px"/>
                        <label>至</label>
                        <ui:datefield id="endtime2" startDate="starttime2" name="starttimeend" width="100px"/>
                    </td>
                    <td class="tit" width="60px;">
                        <ui:button text="查询" icon="ui-icon-search">
                            <event:onclick>
                                $("#myrecovertable").stk_query();
                            </event:onclick>
                        </ui:button>
                    </td>
                </tr>
            </table>

            <plugin:colLink id="workflowmain2" dataVar="data">
                $(document).stk_go("/workflow/applicate/showcolorworkflow.jsp?exampleid=" + data.exampleid,"流程详细列表",{keyWithoutParams:true});
            </plugin:colLink>
            <ui:table id="myrecovertable" queryForm="myrecoverform" nowrap="true"
                      actionClass="com.sinitek.sirm.web.workflow.applicate.MyRecoverProcessAction"
                      pageSize="10">
                <%--<ui:col plugin="checkBoxPlugin" show="false" width="0px" align="center"/>--%>
                <ui:col property="processname" title="流程名称" align="left" width="100px" allowSort="false" allowTip="true"></ui:col>
                <ui:col property="processstatusvalue" title="流程状态" align="left" width="60px" allowSort="false"></ui:col>
                <ui:colCust property="starterid" method="getstartername" title="发起人" align="left" width="80px" allowSort="false"/>
                <ui:col plugin="workflowmain2" align="left" property="processbrief" allowTip="true" title="流程描述" width="50%" allowSort="false"></ui:col>
                <ui:col property="processstepname" title="步骤名称" align="left" width="80px" allowSort="false" allowTip="true"></ui:col>
                <ui:colDate property="stepstarttime" title="开始时间" width="120px" format="yyyy-MM-dd HH:mm" allowSort="false"></ui:colDate>
                <ui:col property="ownernames" title="处理人" align="left" width="50%" allowSort="false" allowTip="true"></ui:col>
                <%--<ui:col plugin="condition2" title="操作" width="60px"></ui:col>--%>
            </ui:table>
        </form>
    </layout:tab>

    <event:ontabselect tabVar="tab">
        if(tab.id=='myinitiatetab'){
            $("#myinitiatetable").stk_query();
        }else if(tab.id=='myrecovertab'){
            $("#myrecovertable").stk_query();
        }
    </event:ontabselect>
</layout:tabs>
</sirm:body>
</html>