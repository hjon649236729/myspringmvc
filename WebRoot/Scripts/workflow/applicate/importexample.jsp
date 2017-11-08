<%--
  Created by IntelliJ IDEA.
  User: sq.fu
  Date: 13-1-18
  Time: 下午2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/workflow/include/workflowinclude.jsp" %>
<html>
<head><title>历史数据导入</title>
    <script type="text/javascript">
        function submitProcessForm(){
            var uploadFile = $('#uploadDataFile');
//            alert(uploadFile.stk_val());
            if(uploadFile.stk_val()==''){
                 $('#messageDiv').stk_html('请选择需要导入的数据');
            }else{
                var typeArray = new Array("xls");
                var ext =uploadFile.stk_val().slice(uploadFile.stk_val().lastIndexOf('.')+1).toLowerCase();
                var allowSubmit=false;
                for (var i = 0; i < typeArray.length; i++) {
                    if (typeArray[i] == ext) {
                        allowSubmit = true; break;
                    }
                }
                if(!allowSubmit){
                    $('#messageDiv').stk_html('只允许上传xls类型的文件');
                }else{
                    $('#processform').submit();
//                    $('#processform').stk_submit("importprocess", function(result) {
//                        if (result != null) {
//                            $('#messageDiv').stk_html(result);
//                            return;
//                        }
//                    });
                }
            }
        }
        </script>
</head>
<sirm:body>
    <%--<input type="file" id="uploadDataFile" class="stk-input" style=" height:20px;width:230px" name="uploadDataFile"--%>
           <%--contenteditable="false" title="选择模板">--%>
    <form id="processform" action="/workflow/applicate/importexample.action" method="post" enctype="multipart/form-data">
    <%--<ui:form id="processform" clazz="com.sinitek.sirm.web.workflow.configurate.ImportProcessAction" method="importprocess">--%>
     <table class="stk-form-ui-st1" border="0">
        <tr>
            <td class="hd" width="120px" id="td1">
                <label>上传模板<em>*</em></label>
            </td>
            <td class="bd">
                <input type="file" id="uploadDataFile" class="stk-input" style=" height:20px;width:230px" name="uploadDataFile" contenteditable="false" title="选择模板">
            </td>
            <td class="bd" colspan="2">&nbsp;</td>
        </tr>
    </table>
    <div style="color:#c83d42;font:normal;vertical-align:middle;" id="messageDiv">
        ${msg}
    </div>
    <div class="submit-btn-bar">
        <ui:button type="button" text="提交" id="submitButton">
            <event:onclick>
                submitProcessForm();
            </event:onclick>
        </ui:button>&nbsp;&nbsp;
    </div>
    </form>
        <%--</ui:form>--%>
</sirm:body>
</html>