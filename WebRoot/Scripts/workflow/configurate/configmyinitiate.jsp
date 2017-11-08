<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sinitek.sirm.web.workflow.configurate.ConfigMyInitiateAction" %>
<%--
  Created by IntelliJ IDEA.
  User: sq.fu
 * Date: 13-12-3
 * Time: 上午9:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<%
    List<Map> typelist = ConfigMyInitiateAction.getConfigTypeList();
    pageContext.setAttribute("typelist", typelist);
    Map map1_00=new HashMap();
    map1_00.put("key",-1);
    map1_00.put("value","不允许");
    Map map1_0=new HashMap();
    map1_0.put("key",0);
    map1_0.put("value","全部流程");
    Map map1_1=new HashMap();
    map1_1.put("key",1);
    map1_1.put("value","发起状态流程");
    Map map1_2 = new HashMap();
    map1_2.put("key",2);
    map1_2.put("value","执行中状态流程");//任务有自己，处理步骤
    List<Map> list1 = new ArrayList<Map>();
    list1.add(map1_00);
    list1.add(map1_0);
    list1.add(map1_1);
    list1.add(map1_2);
    Map map2_0 = new HashMap();
    map2_0.put("key", 0);
    map2_0.put("value", "撤回流程");
    Map map2_1 = new HashMap();
    map2_1.put("key", 1);
    map2_1.put("value", "跳转至发起");
    List<Map> list2 = new ArrayList<Map>();
    list2.add(map2_0);
    list2.add(map2_1);
    Map map3_0 = new HashMap();
    map3_0.put("key", 0);
    map3_0.put("value", "无操作");
    Map map3_1 = new HashMap();
    map3_1.put("key", 1);
    map3_1.put("value", "撤回流程");
    Map map3_2 = new HashMap();
    map3_2.put("key", 2);
    map3_2.put("value", "终止流程");
    Map map3_3 = new HashMap();
    map3_3.put("key", 3);
    map3_3.put("value", "异常流程");
    List<Map> list3 = new ArrayList<Map>();
    list3.add(map3_0);
    list3.add(map3_1);
    list3.add(map3_2);
    list3.add(map3_3);
    pageContext.setAttribute("list1", list1);
    pageContext.setAttribute("list2", list2);
    pageContext.setAttribute("list3", list3);
%>
<head>
    <title>工作流撤回配置</title>
</head>
<sirm:body>
    <ui:form id="configform" clazz="com.sinitek.sirm.web.workflow.configurate.ConfigMyInitiateAction">
        <div align="left" style="padding-top:3px;padding-left:7px;">
            <ui:button id="btsave" text="保存配置">
                <event:onclick>
                    $("#configform").stk_submit("saveconfig", function(result) {
                        if (result != null) {
                            stk.alert(result);
                            return;
                        }
                        stk.info("保存成功");
                        return;
                    })
                </event:onclick>
            </ui:button>
        </div>
        <div align="left" style="padding-top:3px;padding-left:7px;">
            <table id="configtable" class="stk-table" width="600px;" style="min-height: 30px; table-layout: fixed;">
                <tr>
                    <th class="stk-table-th" width="150px;">流程类型</th>
                    <th class="stk-table-th" width="34%;">允许撤回</th>
                    <th class="stk-table-th" width="33%;">撤回作用</th>
                    <th class="stk-table-th" width="33%;">撤回失败后</th>
                </tr>
                <c:forEach items="${typelist}" var="typemain">
                    <tr>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                            ${typemain['value']}
                            <input type="hidden" id="typeid_${typemain['0']}" name="typeid_${typemain['0']}" value="${typemain['-1']}">
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                            <ui:select id="typeads1_${typemain['0']}" name="typeads1_${typemain['0']}" list="#attr.list1"
                                       width="120px" listKey="key" listValue="value" defaultValue="${typemain['1']}"/>
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                            <c:if test="${typemain['0'] == 3 || typemain['0'] == 9}">
                                <ui:select id="typeads2_${typemain['0']}" name="typeads2_${typemain['0']}"
                                           list="#{'0':'撤回流程'}" width="120px" defaultValue="${typemain['2']}"/>
                            </c:if>
                            <c:if test="${typemain['0'] != 3 && typemain['0'] != 9}">
                                <ui:select id="typeads2_${typemain['0']}" name="typeads2_${typemain['0']}" list="#attr.list2"
                                           width="120px" listKey="key" listValue="value" defaultValue="${typemain['2']}"/>
                            </c:if>
                        </td>
                        <td class="stk-table-td" style="border:1px #BBBBBB solid;padding-left:7px;">
                            <ui:select id="typeads3_${typemain['0']}" name="typeads3_${typemain['0']}" list="#attr.list3"
                                       width="120px" listKey="key" listValue="value" defaultValue="${typemain['3']}"/>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </ui:form>
</sirm:body>
</html>