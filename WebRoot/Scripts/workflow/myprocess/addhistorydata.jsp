<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 13-3-15
  Time: 上午10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head>
    <title>Simple jsp page</title>
    <script type="text/javascript">
        function addhistorydata(type){
            stk.call({
                className: 'com.sinitek.sirm.web.workflow.myprocess.AddHistoryDataAction',
                method: 'addhistorydata',
                param: {addtype:type},
                callBack: function (result) {
                    stk.info(result);
                }
            });
        }
    </script>
</head>
<sirm:body>
    <form id="historyform">
        <input type="hidden" id="addtype" name="addtype"/>
        <table>
            <tr>
                <td>
                    <ui:button text="补充步骤CODE">
                        <event:onclick>
                            addhistorydata(1);
                            <%--$("#addtype").stk_val(1);--%>
                            <%--$("#historytable").stk_query();--%>
                        </event:onclick>
                    </ui:button>
                </td>
                <td>
                    <ui:button text="修改历史代理">
                        <event:onclick>
                            addhistorydata(2);
                            <%--$("#addtype").stk_val(2);--%>
                            <%--$("#historytable").stk_query();--%>
                        </event:onclick>
                    </ui:button>
                </td>
            </tr>
        </table>
        <ui:table id="historytable" queryForm="historyform" nowrap="true" allowInit="false"
                  actionClass="com.sinitek.sirm.web.workflow.myprocess.AddHistoryDataAction"
                  pageSize="10"></ui:table>
    </form>
</sirm:body>
</html>