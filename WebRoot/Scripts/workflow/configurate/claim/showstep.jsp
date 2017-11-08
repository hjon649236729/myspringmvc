<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 14-8-5
  Time: 下午1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<sirm:page clazz="com.sinitek.sirm.web.workflow.configurate.claim.ClaimStepAction"/>
<html>
<head>
    <title></title>
</head>
<sirm:body>
    <div class="stk_component_wrap" style="width:90%;">
        <table class="stk-form-ui-st1" border="0">
            <tr>
                <td class="hd" width="80px">流程名称</td>
                <td class="bd" width="auto">
                    <label>${subject.name}</label>
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
                    <label>${editUrlName}</label>
                </td>
            </tr>
            <tr>
                <td class="hd" width="80px">流程备注</td>
                <td class="bd" width="auto">
                    <label>${subject.brief}</label>
                </td>
            </tr>
        </table>
    </div>
    <div class="stk_component_wrap" style="width:90%; margin-top:20px;">
        <div style="border-style: solid; border-bottom: 1px solid rgb(187, 187, 187); border-color: rgb(187, 187, 187); clear: both; overflow: auto; width: 100%;">
            <table id="stepTable" class="stk-table" width="100%" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <th class="stk-table-th" align="center" width="120px">步骤名称</th>
                    <th class="stk-table-th" align="center" width="100px">处理类型</th>
                    <th class="stk-table-th" align="center">处理人员</th>
                    <th class="stk-table-th" align="center" width="160px">处理页面</th>
                </tr>
                <c:forEach items="${stepList}" var="stepMap">
                    <tr id="stepId${stepMap.stepId}">
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.name}</div>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.judgeTypeS}</div>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.ownerName}</div>
                        </td>
                        <td class='stk-table-td' style='border:1px #BBBBBB solid;'>
                            <div style='padding-left:7px;padding-top:5px;'>${stepMap.urlName}</div>
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
</sirm:body>
</html>

<%--<div id="SQConfirmWindow"--%>
     <%--style="border-style:solid;border-width:2px 1px 1px; border-color:#b83a3b #d3d6d9 #d3d6d9;--%>
             <%--background:#f1f1f1;position:absolute;z-index:10001;visibility:hidden;--%>
     <%--&lt;%&ndash;left:100px;top:75px;">&ndash;%&gt;--%>
             <%--left:50%;top:50%;width: 200px;margin-left: -100px;margin-top: -50px;">--%>
    <%--<div onmousedown="onMouseDownById(event,'SQConfirmWindow');"--%>
         <%--style="background:#ffffff;height:25px;padding-left: 8px;padding-top: 5px;">--%>
        <%--提示--%>
<%--<span onClick="SQConfirmWindowHide();"--%>
      <%--style="float:right;display:inline;cursor:hand;font-size:130%;padding-right: 6px;">×</span>--%>
    <%--</div>--%>
    <%--<div style="padding-left: 8px;">--%>
        <%--<div id="SQConfirmMessage" align="center" style="padding-top: 5px;"></div>--%>
        <%--<div align="center" style="padding-top: 5px;">--%>
            <%--<input type="button" value="确定" id="SQConfirmBt"/>--%>
            <%--<input type="button" value="取消" onclick="SQConfirmWindowHide();"/>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>