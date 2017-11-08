sirm.define('sirm.workflow.applicate.owner', {
//动态添加实际作者
    controlIds : "",
    controlDiv : "",
    readOnly : false,
    addAuthor:function(){
        var text = $("#"+sirm.workflow.applicate.owner.controlIds).stk_val();
//        alert(text);
//        alert("dsfasfas");
        if (text == null || "" == text || text == undefined)
            return;
        var authors = text.split(",");
        if(authors.length > 20){
            stk.alert("处理人最多只可以选择20个");
            var text1 = oldControlIds;
            var authors1 = text1.split(",");
            for(var i = 0 ; i < authors.length ; i++ ){
                var flag = 0;
                for(var j = 0 ; j < authors1.length ; j++ ){
                    if(authors1[j] == authors[i]){
                        flag = 1;
                        break;
                    }
                }
                if( flag == 0 ){
                    sirm.workflow.applicate.owner._user_removeTextContent(null, authors[i]+sirm.workflow.applicate.owner.controlIds, sirm.workflow.applicate.owner.controlIds);
                }
            }
            $("#"+sirm.workflow.applicate.owner.controlIds).stk_val(text1);
            return false;
        }
        var tableNode = $("#"+sirm.workflow.applicate.owner.controlDiv);
        $(tableNode).html("<table class='stk-table'>");
        $(tableNode).find("table").append("<tr><th class='stk-table-th' style='text-align:center;width: 80px;'>处理人</th><th class='stk-table-th' style='text-align:center;'>权重</th><th class='stk-table-th' style='text-align: center;width: 150px;' colspan='3'>通知方式</th>" + (sirm.workflow.applicate.owner.readOnly == true ? "" : "<th class='stk-table-th' style='text-align:center;width: 50px;'>操作</th>") + "</tr>");
        var trNode;
        var preId = sirm.workflow.applicate.owner.controlIds;
        $.each(authors, function(i, nn) {
            var author = nn.split(":");
            var flag = true;
            $.each($("#"+sirm.workflow.applicate.owner.controlDiv).find("input[type='hidden']"), function(i, n) {
                if ($(n).val() == author[0]) {
                    flag = false;
                }
            });
            var sort = 1;
            if (flag) {
                $("<tr id='tr"+author[0]+sirm.workflow.applicate.owner.controlIds+"' style='cursor:pointer;position:relative;' sort="+nn+">" +
                        "<td class='stk-table-td' width='80px' style='text-align: left;overflow-x: hidden; white-space: nowrap;' title='"+author[1]+"'>"+author[1]+"<input type='hidden' name='insort' value='"+sort+"'/></td>" +
                        "<td class='stk-table-td'>" +
                        "<input type='text' name='weight' size='5'/>%<input type='hidden' name='"+preId+author[0]+"' value='"+author[0]+"'/>" +
                        "</td>" +
                        "<td class='stk-table-td' width='50px'>" +
                        "<input type='checkbox' name='"+preId+author[0]+"_1' id='"+preId+author[0]+"_1'/>短信"+
                        "</td><td class='stk-table-td' width='50px'>" +
                        "<input type='checkbox' name='"+preId+author[0]+"_2' id='"+preId+author[0]+"_2'/>邮件"+
                        "</td><td class='stk-table-td' width='50px'>" +
                        "<input type='checkbox' name='"+preId+author[0]+"_3' id='"+preId+author[0]+"_3'/>系统"+
//                        "<input class='stk-button stk-button-st-3' type='button' style='cursor:pointer;width:30px;' name='up"+author[0]+"' onclick='sirm.workflow.applicate.owner.UpSequence(\"tr"+author[0]+sirm.workflow.applicate.owner.controlIds+"\",\""+sirm.workflow.applicate.owner.controlDiv+"\");' value='↑'/>" +
//                        "<input class='stk-button stk-button-st-3' type='button' style='cursor:pointer;width:30px;' name='down"+author[0]+"' onclick='sirm.workflow.applicate.owner.DownSequence(\"tr"+author[0]+sirm.workflow.applicate.owner.controlIds+"\",\""+sirm.workflow.applicate.owner.controlDiv+"\");' value='↓'/>" +
                        "</td>"+
                        (sirm.workflow.applicate.owner.readOnly == true ? "" :
                        "<td class='stk-table-td' style='text-align: center;' width='50px'>" +
                        "<a style='cursor:pointer;' id='btn"+author[0]+"' onclick='sirm.workflow.applicate.owner.removeTr(\""+author[0]+sirm.workflow.applicate.owner.controlIds+"\",\""+sirm.workflow.applicate.owner.controlIds+"\",\""+sirm.workflow.applicate.owner.controlDiv+"\");'>删除</a>" +
                        "</td>") +
                    "</tr>").appendTo($(tableNode).find("table"));
            }
            sort++;
        });
        $(tableNode).append("</table>");
        $($(tableNode).find("td")).each(function(index, n) {
            if ($(this).html() == "") {
                $(this).remove();
            }
        });
        $(tableNode).find("tr:eq(1)").find("input[name^='up']").hide();
        $(tableNode).find("tr:last").find("input[name^='down']").hide();
        //隐藏权重
        $(tableNode).find("tr").each(function(i,n){
            $(n).find("input[name='authorsort']").stk_val(i);
            $(n).find("td:eq(1)").stk_hide();
            $(n).find("th:eq(1)").stk_hide();
        });
        oldControlIds = text;
    },
    removeTr:function(id,ids,divs) {
        sirm.workflow.applicate.owner._user_removeTextContent(null, id, ids);
        var rid = "tr" + id;
        var tableNode = $("#"+divs);
        $(tableNode).find("#" + rid).remove();
        $($(tableNode).find("td")).each(function(index, n) {
            if ($(this).html() == "") {
                $(this).remove();
            }
        });
        $("#reportauthortd").css("vertical-align", "middle");
        if($(tableNode).find("tr").size()==1){
            $(tableNode).html("");
        }
        //sirm.workflow.applicate.owner.showandhide(divs);
    },
    _user_removeTextContent:function(id, key, hiddenId) {
        var hidden = document.getElementById(hiddenId);
        if (hidden.value != "") {
            var orgids = hidden.value;
            var text_codeList = orgids.split(",");
            var result = "";
            for (var i = 0; i < text_codeList.length; i++) {
                var text = text_codeList[i];
                var baseScode = text_codeList[i].split(":");
                //baseScode[0] ==
                if ( key.indexOf(baseScode[0])!=-1) {
                    continue;
                }
                if (result != "") {
                    result = result + "," + text;
                } else {
                    result = text;
                }
            }
        }
        if (id != null && id != "") {
            var obj = document.getElementById(id);
            obj.parentNode.removeChild(obj);
        }
        hidden.value = result;
    },
    UpSequence:function(ConfigName,divs) {
        var controlIds = divs.substring(0,divs.length-3)+'Ids';
        //把他的上一个往下排把他排上去如果是第一个就不让他往上排
        if ($("#" + ConfigName).prev().html() != null) {
            var checkedTR = $("#" + ConfigName).prev();
            checkedTR.insertAfter($("#" + ConfigName));
            var obj = $("#Sequence_" + ConfigName)
            obj.val(parseInt(obj.val()) - 1);
            var inputId = checkedTR.find("input[id^='Sequence_']"); //把他下面的那列的隐藏域的值加一
            inputId.val(parseInt(inputId.val()) + 1);
            sirm.workflow.applicate.owner.showandhide(divs);
//            sirm.rschreport.innerreport.author.orderbyauthor(sirm.rschreport.innerreport.author.controlIds,divs);//多个控件的话会有问题
            sirm.workflow.applicate.owner.orderbyauthor(controlIds,divs);
        }

    },
    DownSequence:function(ConfigName,divs) {
        var controlIds = divs.substring(0,divs.length-3)+'Ids';
        //把他的下一个往上排把他排下去如果是最后一个就不让他往下排
        if ($("#" + ConfigName).next().html() != null) {
            var checkedTR = $("#" + ConfigName).next();
            checkedTR.insertBefore($("#" + ConfigName));
            var obj = $("#Sequence_" + ConfigName)
            obj.val(parseInt(obj.val()) + 1);
            var inputId = checkedTR.find("input[id^='Sequence_']"); //把他下面的那列的隐藏域的值减一
            inputId.val(parseInt(inputId.val()) - 1);
            sirm.workflow.applicate.owner.showandhide(divs);
//            sirm.rschreport.innerreport.author.orderbyauthor(sirm.rschreport.innerreport.author.controlIds,divs);//多个控件的话会有问题
            sirm.workflow.applicate.owner.author.orderbyauthor(controlIds,divs);
        }
    },
    showandhide:function(divs){
        var controldiv = $("#"+divs);
        controldiv.find("input[name^='up']").show();
        controldiv.find("input[name^='down']").show();
        controldiv.find("tr:eq(1)").find("input[name^='up']").hide();
        controldiv.find("tr:last").find("input[name^='down']").hide();
    },
    orderbyauthor:function(resultids,divs){
        var resu='';
        var tableNode = $("#"+divs);
        var ind = 0;
        $(tableNode).find("tr").each(function(i,n){
            if($(n).attr("sort")!=undefined&&$(n).attr("sort").indexOf(":")!=-1){
                if(ind!=0){
                    resu += ","+$(n).attr("sort")
                }else{
                    resu += $(n).attr("sort");
                }
                ind++;
            }
        });
        $("#"+resultids).stk_val(resu);
    }

});