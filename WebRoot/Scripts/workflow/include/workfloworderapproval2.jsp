<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 13-8-19
  Time: 上午11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<script type="text/javascript">
    var ${param.prefix}approvers=[];
    function draw${param.prefix}approvertable(){
        var _html = [];
        var approverids="";
        _html.push("<table border='0' cellpadding='1' cellspacing='1' class='stk-table stk-table-bbline'>");
        _html.push("<tr>");
        _html.push("<th class='stk-table-th' width='120px'>名称</th>");
        _html.push("<th class='stk-table-th' width='120px'>顺序</th>");
        _html.push("<th class='stk-table-th' width='50px' align='center' >操作</th>");
        _html.push("</tr>");
        for (var i = 0; i < ${param.prefix}approvers.length; i++) {
            var approver = ${param.prefix}approvers[i];
            _html.push("<tr id='${param.prefix}approvers_tr_" + i + "'>");
            _html.push("<td class='stk-table-td'>" + approver["name"] + "</td>");
            _html.push("<td class='stk-table-td'>");
            _html.push("<a href=\"javascript:${param.prefix}up("+i+")\"><b  class=\"icon-st16\"></b></a>")
            _html.push("<a href=\"javascript:${param.prefix}down("+i+")\"><b  class=\"icon-st17\"></b></a>")
            _html.push("</td>")
            _html.push("<td class='stk-table-td' align='center'><a href='javascript:delete${param.prefix}approver(" + i + ")' >删除</a></td>");
            _html.push("</tr>");

            if(approverids!="")
                approverids+=",";
            approverids+="${param.prefix}"+":"+approver["id"]+":${param.orderapprovetype}";
        }
        _html.push("</table>");
        $("#"+"${param.prefix}approverdiv").html(_html.join("\n"));
        if("${param.hiddenid}"!="")
           $("#"+"${param.hiddenid}").val(approverids);
    }
    function add${param.prefix}approver(){
        var approvers=$("#org_"+"${param.hiddenid}").val();
        ${param.prefix}approvers=[];
        for(var i=0:i<approvers.split(",").length;i++)
        {
            var str_approver=approvers.split(",")[i];
            alert(str_approver);
            if(str_approver.split(":").length==3)
            {
                var approver={};
                approver["name"]=str_approver.split(":")[1];
                approver["id"]=str_approver.split(":")[0];
                approver["prefix"]="${param.prefix}approver";
                ${param.prefix}approvers.push(approver)
            }
        }
        draw${param.prefix}approvertable()
    }
    function delete${param.prefix}approver(i){
        ${param.prefix}approvers.splice(i, 1);
        draw${param.prefix}approvertable()
    }
    function ${param.prefix}up(i){
        var approver=${param.prefix}approvers[i];
        if(i>0){
            ${param.prefix}approvers.splice(i, 1);
            ${param.prefix}approvers.splice(i-1, 0,approver);
            draw${param.prefix}approvertable()
        }
    }
    function ${param.prefix}down(i){
        var approver=${param.prefix}approvers[i];
        if(i<approvers.length-1){
            ${param.prefix}approvers.splice(i, 1);
            ${param.prefix}approvers.splice(i+1, 0,approver);
            draw${param.prefix}approvertable()
        }
    }

</script>
<input id="org_${param.hiddenid}" name="org_${param.hiddenid}">
<org:SelectOrg prefix="${param.prefix}" multi="true" mode="ORG"
               hiddenId="_${param.hiddenid}" callbackfn="add${param.prefix}approver"  />
<div id="${param.prefix}approverdiv">

</div>