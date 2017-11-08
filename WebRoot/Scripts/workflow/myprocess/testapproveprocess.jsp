<%@ taglib prefix="ui" uri="http://www.sinitek.com/spirit/taglib/ui" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-7-31
  Time: 下午4:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript">
        function subProcessStep() {
            var approveopinion = $("#approveopinion").stk_val();
            var condition = $("#condition").val();
            var aftstepid="";
            var returntargetstepid="";
            if(condition=='2')
            {
                aftstepid=$("#aftstep").stk_val();
                if($("#returntargetstep").stk_checked()==true)
                    returntargetstepid=$("#returntargetstep").val();
            }
            stk.call({
                className: "com.sinitek.sirm.busin.workflow.support.action.WorkflowActionTest2",
                method: "subProcessStep",
                param: {exampleid: '${param.exampleid}', examplestepid: '${param.examplestepid}', exampleownerid: '${param.exampleownerid}'
                    , approveopinion: approveopinion, condition: condition
                    , returntargetstepid:returntargetstepid,aftstepid:aftstepid},
                callBack: function (result) {
                    alert(result);
                }
            });
        }
    </script>
</head>
<body>
<input type="hidden" id="condition" name="condition">
<input type="hidden" id="returntargetstepid" name="returntargetstepid">
<input type="hidden" id="aftstepid" name="aftstepid">
<div>
    <table class="stk-form-ui-st1">
        <tr>
            <td width="80px" class="hd">处理意见</td>
            <td class="bd" colspan="3" style="text-align:left;" width="auto">
                <ui:textarea width="100%" rows="8" id="approveopinion"
                             name="approveopinion">${param.approveopinion}</ui:textarea>
            </td>
        </tr>
    </table>
</div>
<ui:button text="通过">
    <event:onclick>
        $("#condition").stk_val(1)
        subProcessStep()
    </event:onclick>
</ui:button>
<ui:button text="驳回">
    <event:onclick>
        $("#window").stk_show()
    </event:onclick>
</ui:button>
<layout:window id="window" name="window" title="驳回方案选择">
    <jsp:include page="/workflow/include/workflowoncelink.jsp" flush="true">
        <jsp:param name="exampleid" value="${param.exampleid}"></jsp:param>
        <jsp:param name="examplestepid" value="${param.examplestepid}"></jsp:param>
        <jsp:param name="aftstepid" value="aftstepid"></jsp:param>
        <jsp:param name="returntargetstepid" value="returntargetstepid"></jsp:param>
    </jsp:include>
    <table>
        <tr>
            <td style="width: 100px">

            </td>
            <td>
                <ui:button text="确定">
                    <event:onclick>
                        $("#condition").stk_val(2)
                        subProcessStep()
                    </event:onclick>
                </ui:button>
                <ui:button text="取消">
                    <event:onclick>
                        $("#window").stk_hide()
                    </event:onclick>
                </ui:button>
            </td>
        </tr>
    </table>
</layout:window>

<jsp:include page="/workflow/include/showworkflowhistory.jsp" flush="true">
    <jsp:param name="exampleid" value="${param.exampleid}"></jsp:param>
</jsp:include>
</body>
</html>